#include "rc4.bi"

print "=== Simple Test ==="
print "Encrypt and decrypt ""FreeBASIC rocks!"" with password ""matwachich"" and 16 bytes length keystream"
print
scope

' Init the keystream array, used to encrypt/decrypt
dim as ubyte keystream()
rc4_init("matwachich", keystream(), 16)

' Encrypt
dim as string data_ = "FreeBASIC rocks!"
rc4_do(keystream(), data_)
print "Encrypted: &h"; rc4_bin2hex(data_)

' Decrypt
rc4_do(keystream(), data_)
print "Decrypted: "; data_

end scope
print
scope

print "=== Benchmarks ==="
print "Encrypt 1048576 bytes (1MB) of data with various keystreams length"
print

' Init the data (1024 bytes)
dim as string data_ = string(1048576, " ")

dim as ubyte keystream()
dim as double t

' Benchmarks
for i as integer = 4 to 128 step 4
	print "Keystream length: ";i
	t = timer()
	rc4_init("matwachich", keystream(), i)
	t = timer() - t
	print "	rc4_init: ";(t * 1000);" ms"
	
	t = timer()
	rc4_do(keystream(), data_)
	t = timer() - t
	print "	rc4_do: ";(t * 1000);" ms"
	print
next

end scope
print "END"
