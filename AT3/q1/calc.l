%{
#include "calc.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%%
"printar_variaveis"    { return PRINTAR_VARIAVEIS; }
">>>"                  { return ATRIBUICAO; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }

[0-9]+(\.[0-9]+)?      { yylval.val = atof(yytext); return NUM; }
"**"                   { return POT;         }
"+"                    { return MAIS;        }
"-"                    { return MENOS;       }
"*"                    { return VEZES;       }
"/"                    { return DIVISAO;     }
"("                    { return ABRE_PAREN;  }
")"                    { return FECHA_PAREN; }
[ \t\r]+               { }
\n                     { return '\n'; }
.                      { return yytext[0]; }
%%