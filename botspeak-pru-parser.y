%error-verbose

%{
#include <stdio.h>
#include "botspeak-pru-lexer.h"
int yylex(void);
void yyerror(const char*);
%}

%union {
	float	num;
	char *	cmd;
	char *	ident;
	struct arg *	arg;
}

%token TOKEN_LBRACKET
%token TOKEN_RBRACKET
%token TOKEN_LSQBRACKET
%token TOKEN_RSQBRACKET
%token TOKEN_LPAREN
%token TOKEN_RPAREN
%token TOKEN_COMMA
%token TOKEN_NEWLINE
%token TOKEN_SCRIPT
%token TOKEN_ENDSCRIPT
%token TOKEN_ADD
%token TOKEN_SUB
%token TOKEN_MUL
%token TOKEN_DIV
%token TOKEN_MOD
%token TOKEN_AND
%token TOKEN_OR
%token TOKEN_NOT
%token TOKEN_EQL
%token TOKEN_GRT
%token TOKEN_GRE
%token TOKEN_LET
%token TOKEN_LEE
%token TOKEN_BSL
%token TOKEN_BSR
%token TOKEN_GOTO
%token TOKEN_WAIT
%token TOKEN_GET
%token TOKEN_SET
%token TOKEN_IF
%token TOKEN_RUN
%token TOKEN_RUN_WAIT
%token TOKEN_DEBUG
%token TOKEN_LBL
%token TOKEN_SYSTEM
%token TOKEN_DIO

%token <num>	TOKEN_NUM
%token <ident>	TOKEN_IDENT

%%

programs
	: programs program
	| program;
	;

program
	: command
		{
			printf("command\n");
		}
	| script
		{
			printf("script\n");
		}
	;

script
	: TOKEN_SCRIPT commands TOKEN_ENDSCRIPT
	;

commands 
	: commands command
	| command
	;

command
	: TOKEN_ADD lval TOKEN_COMMA value eol
		{
			printf("add\n");
		}
	| TOKEN_SUB lval TOKEN_COMMA value eol
		{
			printf("sub\n");
		}
	| TOKEN_MUL lval TOKEN_COMMA value eol
	| TOKEN_DIV lval TOKEN_COMMA value eol
	| TOKEN_MOD lval TOKEN_COMMA value eol
	| TOKEN_AND lval TOKEN_COMMA value eol
	| TOKEN_OR  lval TOKEN_COMMA value eol
	| TOKEN_NOT lval TOKEN_COMMA value eol
	| TOKEN_EQL lval TOKEN_COMMA value eol
	| TOKEN_GRT lval TOKEN_COMMA value eol
	| TOKEN_GRE lval TOKEN_COMMA value eol
	| TOKEN_LET lval TOKEN_COMMA value eol
	| TOKEN_LEE lval TOKEN_COMMA value eol
	| TOKEN_BSL lval TOKEN_COMMA value eol
	| TOKEN_BSR lval TOKEN_COMMA value eol
	| TOKEN_GOTO value eol
		{
			printf("goto\n");
		}
	| TOKEN_WAIT value eol
		{
			printf("wait\n");
		}
	| TOKEN_GET value eol
	| TOKEN_SET lval TOKEN_COMMA value eol
		{
			printf("set\n");
		}
	| TOKEN_IF expression TOKEN_GOTO TOKEN_NUM eol
	| TOKEN_SYSTEM numbers eol
	| TOKEN_RUN value eol
		{
			printf("run\n");
		}
	| TOKEN_RUN_WAIT value eol
	| TOKEN_DEBUG value eol
	| TOKEN_LBL lval eol
	| eol
		{
			printf("dummy\n");
		}
	;

expression
	: TOKEN_LPAREN TOKEN_NUM TOKEN_RPAREN
	;

numbers
	: numbers TOKEN_COMMA TOKEN_NUM
	| TOKEN_NUM TOKEN_COMMA TOKEN_NUM
	;

value
	: TOKEN_NUM
	;

lval
	: TOKEN_IDENT
	| TOKEN_DIO TOKEN_LSQBRACKET TOKEN_NUM TOKEN_RSQBRACKET
	;

eol
	: TOKEN_NEWLINE
	;

%%

int main(int argc, char* argv[])
{
	int i = 0;
	i = yyparse();
	return i;
}

