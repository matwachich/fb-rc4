fb-rc4
======

Very simple RC4 stream-cipher implementation in FreeBASIC, and based on this: http://bradconte.com/rc4_c

This library contains only 2 main functions, and 2 helper functions:
- rc4_init: used to initialise a keystream array used to cipher/decipher your data
- rc4_do: will apply the keystream to the data supplied. If the data is clear, it will be ciphered, if it's ciphered data, it will be deciphered

The 2 helper functions are used to convert between binary/hex string
