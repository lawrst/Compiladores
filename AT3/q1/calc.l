%{
#include "calc.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%
[0-9]+(\.[0-9]+)?  { yylval.val = atof(yytext); return NUM; }
"**"               { return POT;         }
"+"                { return MAIS;        }
"-"                { return MENOS;       }
"*"                { return VEZES;       }
"/"                { return DIVISAO;     }
"("                { return ABRE_PAREN;  }
")"                { return FECHA_PAREN; }
[ \t]+             { }
\n                 { return '\n'; }
.                  { return yytext[0]; }
%%