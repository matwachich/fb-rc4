#ifndef __RC4_BI__
#define __RC4_BI__

#inclib "rc4"

declare sub rc4_init overload (key as zstring, key_len as uinteger, keystream() as ubyte, size as uinteger)
declare sub rc4_init overload (byref key as const string, keystream() as ubyte, size as uinteger)

declare sub rc4_do overload (keystream() as ubyte, buffer as ubyte ptr, buffer_len as uinteger)
declare sub rc4_do overload (keystream() as ubyte, byref buffer as string)

declare function rc4_bin2hex overload (buffer as ubyte ptr, buffer_len as uinteger) as string
declare function rc4_bin2hex overload (byref buffer as const string) as string
declare function rc4_hex2bin overload (buffer as zstring, buffer_len as uinteger) as string
declare function rc4_hex2bin overload (byref buffer as const string) as string

#endif ' __RC4_BI__