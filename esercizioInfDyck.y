%{
  import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token <sval> SKIP;
%token <sval> SKIP_ERR;
%token OPEN_QUADRE;
%token CLOSE_QUADRE;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN
		| OPEN_QUADRE s CLOSE_QUADRE
		| OPEN_QUADRE CLOSE_QUADRE
		
exp     : parens

exps    : exp SKIP { System.out.println($2); }
        | exp

	
s       : SKIP { System.out.println($1); }
		| SKIP_ERR { System.out.println("Err: "+$1); }
        | exps
        | s exps

%%

void yyerror(String s)
{
 System.out.println("err:"+s);
 System.out.println("   :"+yylval.sval);
}

static Yylex lexer;
int yylex()
{
 try {
  return lexer.yylex();
 }
 catch (IOException e) {
  System.err.println("IO error :"+e);
  return -1;
 }
}

public static void main(String args[])
{
 System.out.println("[Quit with CTRL-D]");
 Parser par = new Parser();
 lexer = new Yylex(new InputStreamReader(System.in), par);
 par.yyparse();
}
