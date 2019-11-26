# Lexical-Analyzer

1. Clone this into your "src" directory

2. download jflex-1.X.X.jar from https://jflex.de/download.html and place it in the "source" directory.

3 Open your terminal and cd to your "src" directory.

4. compile Lexer.jflex as follows, make sure your jflex number is the same as the one you downloaded:

    java -jar jflex-1.X.X.jar Lexer.flex

4. compile all java files using the following:

    javac *.java

5. run program and capture its output as follows:

    java Program test1.minc > solu1.txt
