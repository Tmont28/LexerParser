
  %%

  %byaccj

  %{
  /* store a reference to the parser object */
    private Parser yyparser;

    /* constructor taking an additional parser object */
    public Yylex(java.io.Reader r, Parser yyparser) {
      this(r);
      this.yyparser = yyparser;
    }
    %}

    %%

  "("                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                          return Parser.OPEN_PAREN; }
  ")"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                          return Parser.CLOSE_PAREN; }
  "["                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                          return Parser.OPEN_QUADRE; }
  "]"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                          return Parser.CLOSE_QUADRE; }
  [a-z]+            	  { yyparser.yylval = new ParserVal(yytext());
                          return Parser.SKIP; }
  [A-Z][A-Z][a-z]+	    { yyparser.yylval = new ParserVal(yytext().substring(2));
                          if(yycharat(0) == yycharat(1))  
                            return Parser.SKIP;
                          else 
                            return Parser.SKIP_ERR; }
  :+[a-z]+			        { int c=0;
                          for(int i=0; i < yytext().length(); i++) 
                            if(yycharat(i) == ':')
                              c++;

                              if(c%2 == 0)
                            yyparser.yylval = new ParserVal(yytext().substring(c));
                            else
                            yyparser.yylval = new ParserVal(yytext().substring(c-1));
                          return Parser.SKIP; }


[^] {} /*butta il resto*/
