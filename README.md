# [`dartsidedev/algorithms`](https://github.com/dartsidedev/algorithms)

**Solutions to various algorithms using the Dart programming language.**

> by [Vince Varga](https://github.com/vargavince91)

## What to expect

I decided to implement various algorithms, solve programming challenges and problems, all the while I'm learnign to write idiomatic [Dart](http://dart.dev) code and get better at testing in Dart. I used to test everything thoroughly in JavaScript, but didn't really learn the testing libraries in Dart yet.

Based on the things I'm learning here, I write a Dart package for all things data structures and common algorithms. Go to [`dartsidedev/pop_dart`](https://github.com/dartsidedev/pop_dart) to figure out where we stand on library front today.

## Development

### Formatting

This project uses [`dartfmt`](https://dart.dev/tools/dartfmt) to idiomatically format Dart source code.

Run `dartfmt -w .` before committing to make sure every Dart file is properly formatted.

```
## Format and fix issues.
$ dartfmt -w .

## Command running in CI.
$ dartfmt -n --set-exit-if-changed .
## See return value of dartfmt. If equals to 1, the build will fail.
$ echo $?
```

### Static analysis and linter

We use [`dartanalyzer`](https://dart.dev/tools/dartanalyzer) to run static analysis and a linter on this project.

```
## Run analyzer and see any issues.
$ dartanalyzer .

## Command running in CI.
$ dartanalyzer --fatal-infos --fatal-warnings .
## See return value of dartanalyzer. If equals to 1, the build will fail.
$ echo $?
```

This project's [`analysis_options.yaml`](./analysis_options.yaml) file is taken from the [`flutter/flutter`](https://github.com/flutter/flutter/blob/master/analysis_options.yaml) project.

### Tests

Run all tests in the project by executing `pub run test .` command.

### Continuous Integration

We use Travis CI to check our code on every push.

[![Travis CI Build Status](https://travis-ci.com/dartsidedev/algorithms.svg?branch=master)](https://travis-ci.com/dartsidedev/algorithms)

### Run all commands locally

```
bash check
```