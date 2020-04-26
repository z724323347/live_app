import 'dart:convert';
import 'dart:typed_data';

class Aes {
  const Aes._();

  static const Map<String, String> _charMap = {
    "a": "v",
    "b": "g",
    "c": "O",
    "d": "1",
    "e": "2",
    "f": "c",
    "g": ",",
    "h": "a",
    "i": "G",
    "j": "-",
    "k": "C",
    "l": "=",
    "m": "y",
    "n": "e",
    "o": "9",
    "p": "0",
    "q": "R",
    "r": "E",
    "s": "t",
    "t": "j",
    "u": "V",
    "v": "W",
    "w": "A",
    "x": "q",
    "y": "D",
    "z": "P",
    "A": "L",
    "B": "K",
    "C": "x",
    "D": "N",
    "E": "4",
    "F": "s",
    "G": "F",
    "H": "l",
    "I": "m",
    "J": "b",
    "K": "H",
    "L": "M",
    "M": "Y",
    "N": "Z",
    "O": "}",
    "P": "T",
    "Q": "X",
    "R": "+",
    "S": "[",
    "T": "{",
    "U": "7",
    "V": "p",
    "W": "r",
    "X": "J",
    "Y": "h",
    "Z": "\/",
    "1": "I",
    "2": "z",
    "3": "w",
    "4": "Q",
    "5": "d",
    "6": "*",
    "7": "]",
    "8": "n",
    "9": "i",
    "0": "S",
    "+": "o",
    "=": "8",
    "-": "B",
    "*": "k",
    "\/": "5",
    "{": "3",
    "}": "f",
    "[": "U",
    "]": "u",
    ",": "\"",
    "\"": "6"
  };

  static final Map<String, String> _charMapInvert =  _charMap.map((key, value) => MapEntry(value, key));

  /// 加密
  static String encrypt(String message) => base64Encode(message.split('').map((c) => _charMap[c] ?? c).join(''));

  /// 解密
  static String decrypt(String message) => base64Decode(message).split('').map((c) => _charMapInvert[c] ?? c).join('');

  /// Converts a string to base64.
  static base64Encode(String string) {
    if (string == null) throw new ArgumentError("The argument is null");

    // get a base64 encoder instance.
    var encoder = new Base64Encoder();

    // utf8 encoding.
    var list = utf8.encode(string);
    // encode a string to Base64.
    var encodedString = encoder.convert(list);

    return encodedString;
  }

  /// Converts a base64 encoded string to a string or a `Uint8List`.
  static base64Decode(String encodedString, {bool createUint8List = false}) {
    if (encodedString == null) throw new ArgumentError("encodedString is null");

    // get a base64 decoder instance.
    var decoder = Base64Decoder();

    // decode a base64 encoded string to a List of bytes.
    var bytes = decoder.convert(encodedString);

    if (createUint8List) {
      return createUint8ListFromList(bytes);
    }

    var output = utf8.decode(bytes);

    return output;
  }

  /// Creates a `Uint8List` by a list of bytes.
  static Uint8List createUint8ListFromList(List<int> elements) {
    return new Uint8List.fromList(elements);
  }
}