Let's get started.

## Prepare our tests

Before we start to understand the potential pitfalls and ask clarifying questions, let's define the signature of our solution.

The palindrome check is going to take a `String` as input and return a `bool` as output. Dart is very versatile, so there are many ways to solve this, but the simplest is using a function.

I find the alternatives worse and unnecessarily verbose, but hey, people with a different background than mine might find one of those solutions more idiomatic and if the problem was more complicated, a simple function might not cut it. The reason why I mention this is because there are always many ways to solve a problem and you can also provide your solution using different programming styles. One way could be:

```dart
abstract class PalindromeContainer {
  const PalindromeContainer(this.input);
  final String input;
  bool isPalindrome();
}

class IterativePalindromeContainer implements PalindromeContainer {
  const IterativePalindromeContainer(this.input);
  
  @override
  final String input;

  @override
  bool isPalindrome() {
    // Implement method here.
    return true; // TODO
  }
}
```

Let's stick with functions for now, as I'm against over-engineering solutions and premature generalization and I'll always favor the simple way of solving things, whenever possible. Also good to keep in mind that in Dart, you can absolutely use functions instead of classes, so there's that (some languages require you to wrap everything in a class).

So let's write our first test.

```dart

import 'package:test/test.dart';

import 'palindrome_string_check.dart';

void main() {
  test('is palindrome', () {
    expect(isPalindrome('madam'), true);
  });
}
```

We get a compiler error, so add a function to make this test pass:

```dart
bool isPalindrome(String input) {
  return false;
}
```

And let's run the tests

```
pub run test .
00:01 +1: All tests passed!
```

And there you go, our palindrome check is ready! Huh? Not so fast, let's write another test to make sure it works.

```dart
test('is palindrome', () {
  expect(isPalindrome('madam'), true);
});
test('is not palindrome', () {
  expect(isPalindrome('sir'), false);
});
```

```
$ pub run test .
00:01 +1 -1: ./palindrome_string_check/palindrome_string_check_test.dart: is not palindrome [E]
  Expected: <false>
    Actual: <true>

  package:test_api                                                expect
  palindrome_string_check/palindrome_string_check_test.dart 10:5  main.<fn>

00:01 +1 -1: Some tests failed
```

When you start running tests, it's important to remember: never trust a test until you haven't seen it fail. We just have, so now, we trust our tests.

## Clarify

Now is time to ask clarifying questions about the programming challenge at hand and write our test cases.

Keep in mind that your interviewer might define different rules for the palindrome check problem, and this might make the solution more difficult.

### Spaces

> Can we ignore spaces in the string? For example, should our function return `true` or `false` for `'taco cat'`?

Spaces are significant, so for `taco cat` the solution should return false as `'taco cat' != 'tac ocat'`.

```dart
test('spaces are significant', () {
  expect(isPalindrome('taco cat'), false);
});
```

### Letter case

> Can we consider uppercase and lowercase versions of the same letters as equal?

No, let's not do that, `'Abba' != 'abbA'`, so therefore `isPalindrome('Abba'')` must return `false`.


### Punctuation

> Are letter casing and punctuation significant in deciding whether a string is a palindrome or not? What should our function return for `'Was it a car or a cat I saw?'`

Punctuation and capital letters matter, so `'a' != 'A'` and `'ab!'  != 'ab'`, therefore the function should return `false`.

```dart
test('punctuation cannot be ignored', () {
  expect(isPalindrome('was it a car or a cat I saw?'), false);
});
```

### Empty strings

> What should the function do when it receives an empty string as input? Throw? Return `true`? Return `false`?

To make things more interesting and learn more about the Dart `test` package, our requirements say the function should throw. To be honest, we could have also set the requirements to consider empty strings palindrome, but where's the fun in that?


```dart
test('empty string is an invalid input', () {
  expect(() => isPalindrome(''), throwsArgumentError);
});
```

## Non-ASCII characters

> Does our function need to handle special letters (that are not part of the English alphabet)?

Yes, yes, yes. The function should be able to handle all kinds of letters, it should not abort or should crash the app. Also, don't coerce non-ascii characters to ascii characters, so `isPalindrome('neuquén')` should return false as `'e' != 'é'`.

```dart
test('non-ASCII', () {
  expect(isPalindrome('rör'), true);
  expect(isPalindrome('röor'), false);
  expect(isPalindrome('neuquén'), false);
});
```

### Emojis

> What's with emojis? Can we expect emojis as input?

Yes, we all love emojis, so why shouldn't our function support that? Let's write more expectation in this test case, just for the hell of it. 

Depending on your programming language, dealing with emojis could be more difficult, but worry not, it's not going to make much difference in Dart.

```dart
test('supports emojis', () {
  expect(isPalindrome('🍎'), true);
  expect(isPalindrome('🍎🍏'), false);
  expect(isPalindrome('🍎🍎'), false);
  expect(isPalindrome('🍎🍏🍎'), true);
  expect(isPalindrome('🍎🍏🍎'), true);
  expect(isPalindrome('🍎🍏🍏🍎'), true);
  expect(isPalindrome('🍎🍏🍎🍏'), false);
});
```

Well, I'm a little paranoid, so let's add a different test for a mix of emojis and normal characters.

```dart
expect(isPalindrome('abc🐦⛅️🐦cba'), true);
```

### MOAR Test cases

As part of the clarifying questions, we already defined a couple of test cases. Those test cases are based on the *question*, now let's define a couple of test cases for *common programming errors*: potential difference for strings with odd and even length, strings with length of 1 long strings, spaces, tabs, mix of weird letters, capital letters, etc...

I consider unit tests to be cheap as they run very fast compared to typical integration and end-to-end tests. In less than a second, you can run hundreds of unit tests to help you verify that your code works and there are no bugs in your code even with strange inputs. So let's add a couple of more assertions to our tests.

Of course, if you are working on a real app, you might want to be more picky about what kinds of test cases you execute, as it can add up and can make your pipeline run slower or could be annoying to maintain. I'd still start with plenty of test cases, then remove them if you "proved" it's too slow and it's not worth the price.

```dart
// only spaces (length odd and even)
expect(isPalindrome('  '), true);
expect(isPalindrome('   '), true);
// \n new lines and \t tabs are valid input
expect(isPalindrome('\nabc\tcba\n'), true);
expect(isPalindrome('\nabc\tcba '), false);
// length 1 words are always palindrome
expect(isPalindrome('a'), true);
expect(isPalindrome('á'), true);
expect(isPalindrome('Á'), true);
// mixed strings
expect(isPalindrome(' abcABC😀🔗🔧@%\n \t X \t \n%@🔧🔗😀CBAcba '), true);
```

## Are our tests clean?

Well, you might notice some issues with our tests. We repeat code a lot and the tests require too much typing. Wouldn't it be nicer if we could just write something like:

```
// NOT ACTUAL DART CODE YET
// C magically runs all expectations and function calls in the background.
C('abba', true),
C('Abba', false)
C('baba', false),
...
```

Well, hell yeah, it would! We will come back to cleaning up our unit tests later. We will also refactor the tests to support multiple solutions easily.

# Solve the problem

Oh, finally, we can start working on a solution. On *solutions*, plural!

## Compare characters

Let's just think a bit about what we really need to do in order to determine whether a string is palindrome or not.

What we need to do is check whether the first and last string match. Then we compare the second letter with the penultimate letter. And continue until we get to the middle of the string.

It's a good example that real life problem-solving does not always match the tutorials. In tutorials, people always start with the solution that performs the worst. Then, they show you a slight improvement over that solution. Then, you prepare to have your mind blown, and read the last solution that you never would have thought of, and realize it's blazingly fast. In real life, sometimes your first instinct is right, and the simplest approach provides the fastest solution. You think more about the issue, find another possible solutions, and yet, still your first approach is the best.

I like this solution as it's very simple, matches how I think about the problem, doesn't require additional data structures and it's fast: both for short strings and assymptotically.

### Compare characters - show the code

We need to loop over the characters.

Getting the range right requires some thought, so let's be careful not to overlook things.

For odd lengths:


* length = 1, it's automatically palindrome
* length = 3, check range (index): 0
* length = 5, check range: 0-1
* length = 7, check range: 0-2
* ...

For even lengths:

* length = 0, throw exception
* length = 2, check range: 0
* length = 4, check range: 0-1
* length = 6, check range: 0-2
* ...

Let's write the `for` loop

TODO: write code with strings first

https://medium.com/@hvost/why-you-should-not-use-emojis-in-your-passwords-b8db0607e169#.ee3f1qr43
https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/
https://blog.jonnew.com/posts/poo-dot-length-equals-two

TODO: Write code with runes

TODO: HOW TO SUPPORT SURROGATE PAIRS?

TODO: Solution class. Rethink naming. ASCII, NON ASCII, EMOJI, UNICODE, SURROGATE PAIRS...




```dart
bool isPalindrome(String input) {
  for ()
}
```


For odd numbers, we

Before we continue, let's codify the limitations of some of the limitations that we found out about the algorithms.




## Reverse and compare

// TODO: mention there are many ways to reverse...

### Reverse by creating way too many strings

### Reverse by splitting the strings, reversing the array, then converting the array back to a string

### Reverse the string by using Dart's `reverse` method on the `String` class

## Recursive

# What else?

TODO: How else could we make it more complicated? Support arrays. Support byte arrays. Support integers. Support doubles. Ignore letter casing, white spaces and punctuation, so that we can verify palindrome sentences.
