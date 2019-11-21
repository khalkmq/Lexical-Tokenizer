public class Parser
{
    public static final int MAIN        = 10;
    public static final int PRINT       = 11;
    public static final int BOOLEAN     = 12;
    public static final int INT         = 13;
	// Double?
    public static final int FLOAT       = 14;
    public static final int RECORD      = 15;
    public static final int SIZE        = 16;
    public static final int NEW         = 17;
    public static final int WHILE       = 18;
    public static final int IF          = 19;
    public static final int ELSE        = 20;
    public static final int RETURN      = 21;
    public static final int BREAK       = 22;
    public static final int CONTINUE    = 23;
    public static final int AND         = 24;
    public static final int OR          = 25;
    public static final int NOT         = 26;
    public static final int bTRUE       = 27;
    public static final int bFALSE      = 28;
	
    public static final int BEGIN       = 30;
    public static final int END         = 31;
    public static final int AMPERSAND   = 32;
    public static final int LPAREN      = 33;
    public static final int RPAREN      = 34;
    public static final int LBRACKET    = 35;
    public static final int RBRACKET    = 36;
	
    public static final int ASSIGN      = 38;
    public static final int LESSTHAN    = 39;
    public static final int GREATERTHAN = 40;
    public static final int PLUS        = 41;
    public static final int MINUS	= 42;
    public static final int MUL         = 43;
    public static final int DIVIDE      = 44;
    public static final int PERCENT     = 45;
	
    public static final int SEMI            = 47;
    public static final int COMMA           = 48;
    public static final int DOT             = 49;
    public static final int EQUAL           = 50;
    public static final int NOTEQUAL        = 51;
    public static final int LESSOREQUAL     = 52;
    public static final int GREATEROREQUAL  = 53;

    public static final int INT_LIT     = 55;
    public static final int FLOAT_LIT   = 56;
    public static final int IDENT       = 58;

    public Parser(java.io.Reader r) throws java.io.IOException
    {
        this.lexer    = new Lexer(r, this);
    }

    Lexer   lexer;
    public ParserVal yylval;
    
    // Output Simple Tokens
    public void outputFormat(String tVal, int lineNum){
	System.out.print("<" + tVal + " :" + lineNum + ">");
    }

    // Processing cases in chunks
    public boolean caseInRange(int x, int low, int high){
	return low <= x && x<= high;
    }

    public int yyparse() throws java.io.IOException
    {
	//System.out.println("Hello from parser");

        while ( true )
        {
	    // Get the token           
	    int token = lexer.yylex();
            
	    // EOF is reached
	    if (token == 0) 	{return 0;}

	    // Error
            if(token == -1)	{return -1;}

	    // Get the attribute
            Object attr = yylval.obj;
            
            /*############# Handle different tokens differently: #############*/

	    // main | print | bool | int | float | record | size | new | while |
	    //  if | else | return | break | continue | and | or | not
  	    if 	     (caseInRange(token, 10, 26))
		outputFormat(lexer.yytext().toUpperCase(),lexer.lineno);

            // bTRUE | bFALSE
	    else if  (caseInRange(token, 27, 28))
		outputFormat("BOOL_VALUE, " + lexer.yytext(),lexer.lineno);
	    
	    // {  |  }  |  &  |  (  |  )  |  [  |  ]
	    // =  |  <  |  >  |  +  |  -  |  *  |  /  | %
            // ;  |  ,  |  .  |  == |  != |  <= | >=
	    else if  (caseInRange(token, 30, 53))
		outputFormat(lexer.yytext(),lexer.lineno);
	    
	    //
	    else if  (caseInRange(token, 55, 58))
		{/* Nothing Happens */}

	    else{
		//Debugger - These shouldnt occur
		//System.out.print("<token-id:" + token + ", token-attr:" + attr + ", lineno:" + lexer.lineno + ">");	
		}

        }
    }
}
