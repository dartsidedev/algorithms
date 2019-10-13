import 'package:test/test.dart';

import 'palindrome_string_check.dart';

void main() {
  solutions.forEach(testSolution);
}

void testSolution(Solution solution) {
  final PalindromeCheck isPalindrome = solution.fn;

  test('returns true for palindromes', () {
    expect(isPalindrome('madam'), true);
  });
  test('returns false for strings that are not palindromes', () {
    expect(isPalindrome('sir'), false);
  });

  test('white spaces are significant', () {
    expect(isPalindrome('taco cat'), false);
    expect(isPalindrome('  '), true);
    expect(isPalindrome('   '), true);
    expect(isPalindrome('\nabc\tcba\n'), true);
    expect(isPalindrome('\nabc\tcba '), false);
  });

  test('letter case matters', () {
    expect(isPalindrome('Abba'), false);
  });

  test('punctuation cannot be ignored', () {
    expect(isPalindrome('Was it a car or a cat I saw?'), false);
  });

  test('empty string is an invalid input', () {
    expect(() => isPalindrome(''), throwsArgumentError);
  });

  test('non-ASCII', () {
    expect(isPalindrome('neuquén'), false);
    expect(isPalindrome('rör'), true);
    expect(isPalindrome('röor'), false);
  });

  test('supports emojis', () {
    expect(isPalindrome('🍎'), true);
    expect(isPalindrome('🍎🍏'), false);
    expect(isPalindrome('🍎🍎'), true);
    expect(isPalindrome('🍎🍏🍎'), true);
    expect(isPalindrome('🍎🍏🐛'), false);
    expect(isPalindrome('🍎🍏🍏🍎'), true);
    expect(isPalindrome('🍎🍏🍎🍏'), false);
    expect(isPalindrome('abc✅📍✅cba'), true);
    expect(isPalindrome('a🐣b🐦c💪💪c🐦b🐣a'), true);
  });

  test('supports surrogate pairs', () {
    expect(isPalindrome('a🐣b🐦c👨🏻‍💼c🐦b🐣a'), true);
  }, skip: true);

  test('\\n new line and \\t tabs are valid input', () {
    expect(isPalindrome('\nabc\tcba\n'), true);
    expect(isPalindrome('\nabc\tcba '), false);
  });

  test('length == 1 is always palindrome', () {
    expect(isPalindrome('a'), true);
    expect(isPalindrome('á'), true);
    expect(isPalindrome('Á'), true);
  });

  test('mixed strings', () {
    expect(isPalindrome(' abcABC😀🔗🔧@%\n \t X \t \n%@🔧🔗😀CBAcba '), true);
    expect(
        isPalindrome('XXX abcABC😀🔗🔧@%\n \t X \t \n%@🔧🔗😀CBAcba '), false);
  });
}
