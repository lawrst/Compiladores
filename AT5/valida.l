%{
#include "valida.tab.h"
%}

%option noyywrap

%%
"true"|"false"|"null"        { return RESERVADA; }
-?(0|[1-9][0-9]*)(\.[0-9]+)? { return NUMERO; }
\"[^\"\n]*\"                 { return STRING; }

[ \t\r\n]+                   { /* ignora espacos */ }
.                            { return yytext[0]; }
%%