#include "rc4.bi"

sub rc4_init overload (key as zstring, key_len as uinteger, keystream() as ubyte, size as uinteger)
	dim as ubyte state(0 to 255)
	' Key Scheduling Algorithm
	scope
		for i as integer = 0 to 255
			state(i) = i
		next
		dim as integer j = 0, t
		for i as integer = 0 to 255
			j = (j + state(i) + cast(integer, key[i mod key_len])) mod 256
			t = state(i)
			state(i) = state(j)
			state(j) = t
		next
	end scope
	' ---
	redim keystream(0 to size - 1)
	' ---
	' Pseudo-Random Generator Algorithm
	dim as integer i = 0, j = 0, t
	' Discarding first 512 bytes
	for x as integer = 1 to 512
		i = (i + 1) mod 256
		j = (j + state(i)) mod 256
		t = state(i)
		state(i) = state(j)
		state(j) = t
	next
	' ---
	for x as integer = 0 to size - 1
		i = (i + 1) mod 256
		j = (j + state(i)) mod 256
		t = state(i)
		state(i) = state(j)
		state(j) = t
		' ---
		keystream(x) = state((state(i) + state(j)) mod 256)
	next
end sub

sub rc4_init overload (byref key as const string, keystream() as ubyte, size as uinteger)
	rc4_init(*strptr(key), len(key), keystream(), size)
end sub

' ---------------------------------------------------------------------------- '

sub rc4_do overload (keystream() as ubyte, buffer as ubyte ptr, buffer_len as uinteger)
	for i as uinteger = 0 to buffer_len - 1
		for j as uinteger = lbound(keystream) to ubound(keystream)
			buffer[i] xor= keystream(j)
		next
	next
end sub

sub rc4_do overload (keystream() as ubyte, byref buffer as const string)
	for i as uinteger = 0 to len(buffer) - 1
		for j as uinteger = lbound(keystream) to ubound(keystream)
			*cast(ubyte ptr, strptr(buffer) + i) xor= keystream(j)
		next
	next
end sub

' ---------------------------------------------------------------------------- '

function rc4_bin2hex overload (buffer as ubyte ptr, buffer_len as uinteger) as string
	dim as string s
	for i as uinteger = 0 to buffer_len - 1
		s += lcase(hex(buffer[i], 2))
	next
	return s
end function

function rc4_bin2hex overload (byref buffer as const string) as string
	dim as string s
	dim as ubyte ptr p = strptr(buffer)
	for i as uinteger = 0 to len(buffer) - 1
		s += lcase(hex(p[i], 2))
	next
	return s
end function

function rc4_hex2bin overload (buffer as zstring, buffer_len as uinteger) as string
	if buffer_len mod 2 <> 0 then return ""
	dim as string s
	for i as uinteger = 1 to buffer_len step 2
		s += chr(valint("&H" + mid(buffer, i, 2)))
	next
	return s
end function

function rc4_hex2bin overload (byref buffer as const string) as string
	if len(buffer) mod 2 <> 0 then return ""
	dim as string s
	for i as uinteger = 1 to len(buffer) step 2
		s += chr(valint("&H" + mid(buffer, i, 2)))
	next
	return s
end function
