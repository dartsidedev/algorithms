import 'package:meta/meta.dart';

const String _empty = 'Empty string is invalid input';

bool _iterativeWithRunes(String s) {
  if (s.isEmpty) {
    throw ArgumentError(_empty);
  }
  final List<int> runes = s.runes.toList();
  for (int i = 0; i < runes.length / 2; i++) {
    if (runes[i] != runes[runes.length - i - 1]) {
      return false;
    }
  }
  return true;
}

bool _reverseRunesAndCompare(String s) {
  if (s.isEmpty) {
    throw ArgumentError(_empty);
  }
  final String reversed = String.fromCharCodes(s.runes.toList().reversed);
  return reversed == s;
}

// bool _reverseStringAndCompare(String s) {
//   if (s.isEmpty) {
//     throw ArgumentError(_empty);
//   }
//   final String reversed = s.split('').toList().reversed.join('');
//   return reversed == s;
// }

/// The signature in wich we expect the palindrome check solutions.
typedef PalindromeCheck = bool Function(String);

/// Class representing a palindrome check solution and its limitations
class Solution {
  const Solution({
    @required this.name,
    @required this.fn,
    @required this.unicode,
    @required this.surrogatePairs,
  });

  /// Algorithm checking whether a string is a palindrome or not.
  final PalindromeCheck fn;

  /// Name of the solution.
  ///
  /// Used for prettier output in unit tests.
  final String name;

  /// Supports unicode strings.
  final bool unicode;

  /// Supports surrogate pairs.
  final bool surrogatePairs;
}

const List<Solution> solutions = <Solution>[
  Solution(
    name: 'Iterative with runes',
    fn: _iterativeWithRunes,
    unicode: true,
    surrogatePairs: false,
  ),
  Solution(
    name: 'Reverse runes and compare',
    fn: _reverseRunesAndCompare,
    unicode: true,
    surrogatePairs: false,
  ),
  // Solution(
  //   name: 'Reverse string and compare',
  //   fn: _reverseStringAndCompare,
  //   unicode: false,
  //   surrogatePairs: false,
  // ),
];
