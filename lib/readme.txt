The BooleanZipper library provides functions to compress and decompress arrays of Boolean values into arrays of 16-bit integers, for more efficient storage. In addition, it offers functions to read, write, and change the boolean values at specific positions in compressed arrays.
The compression factor is 1/8 + 16 bits, which means that each boolean that is compressed originally weighs 8 bits and in the compressed version only occupies 1 bit. The extra 16 bits correspond to the first uint16 of the compressed array, which represents the length of the original array.

zipArray - Takes an array of boolean values and returns an array of 16-bit integers representing the zipped boolean values. Input parameters: _values (array of bool), Output parameters: array of uint16.

unZipArray Takes an array of 16-bit integers representing zipped boolean values and returns an array of unzipped boolean values. Input parameters: array of uint16, Output parameters: array of bool.

readPosition Takes an array of 16-bit integers representing compressed boolean values and a position in that array, and returns the boolean value at that position. Input Parameters: _data (uint16 array), _pos (position in array), Output Parameters: bool value.

writePosition Takes an array of 16-bit integers representing compressed boolean values, a boolean value, and a position in that array, and updates the boolean value at that position. Input parameters: _data (uint16 array), _value (bool value), _pos (position in array), Output parameters: uint16 array.

tooglePosition Takes an array of 16-bit integers representing compressed boolean values and a position in that array, and changes the boolean value at that position from true to false or vice versa. Input Parameters: _data (uint16 array), _pos (position in array), Output Parameters: uint16 array.