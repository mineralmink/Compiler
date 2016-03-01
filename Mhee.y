%{
	#include<stdio.h>
	#include<math.h>
	#include<stdlib.h>
	#define YYSTYPE int
	typedef struct {
		int data;
		int next;
	} Stack;
	Stack stack;
	int er;
%}
/*token*/
%token CONSTANT
%left OR
%left AND
%left '-' '+'
%left '*' '/' '\\'
%right NEG NOT
%right '^'

%%
input :	 | input line 
line :		'\n' | exp '\n'	{printf("%d\n",$1);}
			| error '\n'					{yyerrok;}
exp :	  CONSTANT {$$ = $1;}
		| exp OR exp	{$$ = $1 | $3;}
		| exp AND exp	{$$ = $1 & $3;}
		| NOT exp	{$$ = ~$2;}
		| exp '+' exp	{$$ = $1 + $3;}
		| exp '-' exp	{$$ = $1 - $3;}
		| exp '*' exp	{$$ = $1 * $3;}
		| exp '/' exp	{ if($3==0)
		{yyerror("Can't divide by 0."); er=1;}
		else $$ = $1 / $3;}
		| exp '\\' exp	{ if($3==0)
		{yyerror("Can't divide by 0."); er=1;}
		else
		$$ = $1 % $3;}
		| '-' exp %prec NEG	{$$ = -$2;}
		| exp '^' exp	{$$ = pow($1,$3);}
		| '(' exp ')'	{$$ = $2;}
%%

void yyerror(char const *str) {
	printf("\tError just happened.\n ");
}
int main() {
	yyparse();
	return 0;
}
