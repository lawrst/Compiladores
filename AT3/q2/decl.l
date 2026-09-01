%{
#include "decl.tab.h"
#include <string.h>
%}

%option noyywrap

%%
"int"|"double"|"char"  { yylval.str = strdup(yytext); return TIPO; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
","                    { return VIRGULA; }
";"                    { return PONTO_VIRGULA; }
[ \t\r\n]+             { }
.                      {  }
%%