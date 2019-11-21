/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 2000 Gerwin Klein <lsf@jflex.de>                          *
 * All rights reserved.                                                    *
 *                                                                         *
 * Thanks to Larry Bell and Bob Jam/home/kmq5044/Desktop/proj1-minc-lexer-startup/Lexer.flexison for suggestions and comments.      *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%%

%class Lexer
%byaccj

%{
  // HashMap Declaration
  java.util.HashMap<String, Integer> map = new java.util.HashMap<>();
  public int      val = 0;
  
  public Parser   yyparser;
  public int      lineno;

  public Lexer(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
    this.lineno   = 1;
  }


%}

int        = [0-9]+
float	   = [0-9]+(.[0-9]+)?(E[+-]?[0-9]+)?
identifier = [A-Za-z][A-Za-z0-9]*
newline    = \n
whitespace = [ \t\r]+
comment    = "//".*

%%

"main"                      { yyparser.yylval = new ParserVal(null            ); return Parser.MAIN  		; }
"print"                     { yyparser.yylval = new ParserVal(null            ); return Parser.PRINT    	; }
"bool"                      { yyparser.yylval = new ParserVal(null            ); return Parser.BOOLEAN  	; }
"int"                       { yyparser.yylval = new ParserVal(null            ); return Parser.INT   		; }
"float"                     { yyparser.yylval = new ParserVal(null            ); return Parser.FLOAT  		; }
"record"                    { yyparser.yylval = new ParserVal(null            ); return Parser.RECORD 		; }
"size"                      { yyparser.yylval = new ParserVal(null            ); return Parser.SIZE		; }
"new"                       { yyparser.yylval = new ParserVal(null            ); return Parser.NEW		; }
"while"                     { yyparser.yylval = new ParserVal(null            ); return Parser.WHILE		; }
"if"                        { yyparser.yylval = new ParserVal(null            ); return Parser.IF  		; }
"else"                      { yyparser.yylval = new ParserVal(null            ); return Parser.ELSE  		; }
"return"                    { yyparser.yylval = new ParserVal(null            ); return Parser.RETURN  		; }
"break"                     { yyparser.yylval = new ParserVal(null            ); return Parser.BREAK  		; }
"continue"                  { yyparser.yylval = new ParserVal(null            ); return Parser.CONTINUE  	; }
"and"                       { yyparser.yylval = new ParserVal(null            ); return Parser.AND  		; }
"or"                        { yyparser.yylval = new ParserVal(null            ); return Parser.OR  		; }
"not"                       { yyparser.yylval = new ParserVal(null            ); return Parser.NOT  		; }
"true"                      { yyparser.yylval = new ParserVal(null            ); return Parser.bTRUE  		; }
"false"                     { yyparser.yylval = new ParserVal(null            ); return Parser.bFALSE  		; }

"{"                         { yyparser.yylval = new ParserVal(null            ); return Parser.BEGIN 		; }
"}"                         { yyparser.yylval = new ParserVal(null            ); return Parser.END    		; }
"&"                         { yyparser.yylval = new ParserVal(null            ); return Parser.AMPERSAND   	; }
"("                         { yyparser.yylval = new ParserVal(null            ); return Parser.LPAREN 		; }
")"                         { yyparser.yylval = new ParserVal(null            ); return Parser.RPAREN 		; }
"["                         { yyparser.yylval = new ParserVal(null            ); return Parser.LBRACKET 	; }
"]"                         { yyparser.yylval = new ParserVal(null            ); return Parser.RBRACKET 	; }

"="                         { yyparser.yylval = new ParserVal(null            ); return Parser.ASSIGN 		; }
"<"                         { yyparser.yylval = new ParserVal(null            ); return Parser.LESSTHAN		; }
">"                         { yyparser.yylval = new ParserVal(null            ); return Parser.GREATERTHAN 	; }
"+"                         { yyparser.yylval = new ParserVal(null            ); return Parser.PLUS   		; }
"-"                         { yyparser.yylval = new ParserVal(null            ); return Parser.MINUS   		; }
"*"                         { yyparser.yylval = new ParserVal(null            ); return Parser.MUL    		; }
"/"                         { yyparser.yylval = new ParserVal(null            ); return Parser.DIVIDE   	; }
"%"                         { yyparser.yylval = new ParserVal(null            ); return Parser.PERCENT  	; }

";"                         { yyparser.yylval = new ParserVal(null            ); return Parser.SEMI   		; }
","                         { yyparser.yylval = new ParserVal(null            ); return Parser.COMMA   		; }
"."                         { yyparser.yylval = new ParserVal(null            ); return Parser.DOT   		; }
"=="                        { yyparser.yylval = new ParserVal(null            ); return Parser.EQUAL	   	; }
"!="                        { yyparser.yylval = new ParserVal(null            ); return Parser.NOTEQUAL  	; }
"<="                        { yyparser.yylval = new ParserVal(null            ); return Parser.LESSOREQUAL   	; }
">="                        { yyparser.yylval = new ParserVal(null            ); return Parser.GREATEROREQUAL   ; }

{int}			    { System.out.print("<INT_VALUE, "   + yytext() + " :" + lineno + ">"); 
			      yyparser.yylval = new ParserVal((Object)yytext()); return Parser.INT_LIT      	; }

{float}                     { System.out.print("<FLOAT_VALUE, " + yytext() + " :" + lineno + ">"); 
 			      yyparser.yylval = new ParserVal((Object)yytext()); return Parser.FLOAT_LIT  	; }

{identifier}                { if(map.containsKey(yytext())) {
                              		System.out.print("<ID, " + map.get(yytext()) + " :" + lineno + ">");}
                              else {
                                        map.put(yytext(), val);		val++;
                                        System.out.print("<< add " + yytext() + " into symbol table at " + map.get(yytext()) 
					+ " >><ID, " + map.get(yytext()) + " :" + lineno + ">");
                                   }
                              yyparser.yylval = new ParserVal((Object)yytext()); return Parser.IDENT		; }
                                    
{comment}                   { System.out.print  (yytext()); 		}
{newline}                   { System.out.println(yytext());   lineno++; }
{whitespace}                { System.out.print  (yytext()); 		}


\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }
