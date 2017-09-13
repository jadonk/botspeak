%option outfile="botspeak-pru-lexer.c" header-file="botspeak-pru-lexer.h"
%option noyywrap
%option caseless

%{
#include "botspeak-pru-parser.h"
%}

LBRACKET	"{"
RBRACKET	"}"
LSQBRACKET	"["
RSQBRACKET	"]"
LPAREN	"("
RPAREN	")"
COMMA	","
NEWLINE	[ \r\t]*"\n"[ \r\t\n]*

SCRIPT	"SCRIPT"
ENDSCRIPT	"ENDSCRIPT"
ADD	"ADD"
SUB	"SUB"
MUL	"MUL"
DIV	"DIV"
MOD	"MOD"
AND	"AND"
OR	"OR"
NOT	"NOT"
EQL	"EQL"
GRT	"GRT"
GRE	"GRE"
LET	"LET"
LEE	"LEE"
BSL	"BSL"
BSR	"BSR"
GOTO	"GOTO"
WAIT	"WAIT"
GET	"GET"
SET	"SET"
IF	"IF"
RUN	"RUN"
RUN_WAIT	"RUN&WAIT"
DEBUG	"DEBUG"
LBL	"LBL"

DIO	"DIO"

IDENT	[A-Za-z_][A-Za-z0-9_]*
NUM	[0-9][\.0-9]*
WHITESPC	[ \r\t]*
COMMENTS	"#"[^\n\r]*

%%

{LBRACKET}	{ return TOKEN_LBRACKET; }
{RBRACKET}	{ return TOKEN_RBRACKET; }
{LSQBRACKET}	{ return TOKEN_LSQBRACKET; }
{RSQBRACKET}	{ return TOKEN_RSQBRACKET; }
{LPAREN}	{ return TOKEN_LPAREN; }
{RPAREN}	{ return TOKEN_RPAREN; }
{COMMA}	{ return TOKEN_COMMA; }
{NEWLINE}	{ return TOKEN_NEWLINE; }

{SCRIPT}	{ return TOKEN_SCRIPT; }
{ENDSCRIPT}	{ return TOKEN_ENDSCRIPT; }
{ADD}	{ return TOKEN_ADD; }
{SUB}	{ return TOKEN_SUB; }
{MUL}	{ return TOKEN_MUL; }
{DIV}	{ return TOKEN_DIV; }
{MOD}	{ return TOKEN_MOD; }
{AND}	{ return TOKEN_AND; }
{OR}	{ return TOKEN_OR; }
{NOT}	{ return TOKEN_NOT; }
{EQL}	{ return TOKEN_EQL; }
{GRT}	{ return TOKEN_GRT; }
{GRE}	{ return TOKEN_GRE; }
{LET}	{ return TOKEN_LET; }
{LEE}	{ return TOKEN_LEE; }
{BSL}	{ return TOKEN_BSL; }
{BSR}	{ return TOKEN_BSR; }
{GOTO}	{ return TOKEN_GOTO; }
{WAIT}	{ return TOKEN_WAIT; }
{GET}	{ return TOKEN_GET; }
{SET}	{ return TOKEN_SET; }
{IF}	{ return TOKEN_IF; }
{RUN}	{ return TOKEN_RUN; }
{RUN_WAIT}	{ return TOKEN_RUN_WAIT; }
{DEBUG}	{ return TOKEN_DEBUG; }
{LBL}	{ return TOKEN_LBL; }

{DIO}	{ return TOKEN_DIO; }

{IDENT}	{
		size_t len = strlen(yytext);
		yylval.ident = malloc(len + 1);
		strcpy(yylval.ident, yytext);
		return TOKEN_IDENT;
	}
{NUM}	{
		sscanf(yytext, "%f", &yylval.num);
		return TOKEN_NUM;
	}
{WHITESPC} { }
{COMMENTS} { }

%%

int yyerror(const char* msg)
{
    fprintf(stderr, "botspeak-pru-lexer error: %s\n", msg);
    return 0;
}
