import java.io.IOException;
import java.util.ArrayList;

public class Lexer
{
    private static final char EOF        =  0;

    private Parser         yyparser; // parent parser object
    private java.io.Reader reader;   // input stream
    public int             lineno;   // line number

    public Lexer(java.io.Reader reader, Parser yyparser) throws java.io.IOException
    {
        this.reader   = reader;
        this.yyparser = yyparser;
        lineno = -123;
    }

    public char NextChar() throws IOException
    {
        // http://tutorials.jenkov.com/java-io/readers-writers.html
        int data = reader.read();
        if(data == -1)
        {
            return EOF;
        }
        return (char)data;
    }
    public int Fail()
    {
        return -1;
    }

    public int yylex() throws java.io.IOException
    {
        int state = 0;

        while(true)
        {
            char c;
            switch(state)
            {
                case 0:
                    c = NextChar();
                    if(c == ';') { state= 1; continue; }
                    if(c == EOF) { state=99; continue; }
                    // return Fail();
                case 1:
                    yyparser.yylval = new ParserVal((Object)";");   // set token-attribute to yyparser.yylval
                    return Parser.SEMI;                             // return token-name
                case 99:
                    return EOF;                                     // return end-of-file symbol
            }
        }
    }
}
