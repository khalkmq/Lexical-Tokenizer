# Lexical-Tokenizer

## Description:
A Lexical Tokenizer is the first step in the construction of a Syntax Checker. It converts a sequence of characters into a sequence of tokens that can later be analyzed. This particular implementation attempts to do this for a minified version of the C Language (Mini-C).

It does so by:
1) Taking a program source code as an input stream. 
2) Breaks the source into the sequence of lexemes that are meaningful units of words for tokens given regular definitions. 
3) Generates tokens, each of which is a pair of a token name and its attribute.
4) Passes them to its caller (parser here) repeatedly.

## How it works:

1. Clone this into your source directory

2. Download jflex-1.X.X.jar from https://jflex.de/download.html and place it in the source directory.

3. Open your terminal and cd to your source directory.

4. Compile Lexer.jflex as follows, make sure your jflex number is the same as the one you downloaded:
```
java -jar jflex-1.X.X.jar Lexer.flex
```
4. Compile all java files using the following:
```
javac *.java
```
5. Place your test files, or the files provided in this repo into the source directory.

6. Run program and capture its output as follows:
```
java Program test1.minc > solu1.txt
```

## Related Repos:
[Lexical-Tokenizer](https://github.com/khalkmq/Lexical-Tokenizer)

[Lexical-Analyzer](https://github.com/khalkmq/Lexical-Analyzer)

[Syntax Checker]()
