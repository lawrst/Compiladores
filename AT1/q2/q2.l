%{
#include <stdio.h>
%}

%%
[ \t]+                  { /* ignora espacos e tabulacoes */ }
\n                      { printf("NEWLINE\n"); }
"+"                     { printf("PLUS\n"); }
"-"                     { printf("MINUS\n"); }
"*"                     { printf("TIMES\n"); }
"/"                     { printf("DIVIDE\n"); }
"|"                     { printf("ABS\n"); }
"("                     { printf("LPAREN\n"); }
")"                     { printf("RPAREN\n"); }
"%"                     { printf("MOD\n"); }
"^"                     { printf("POWER\n"); }
"<="|">="|"=="|"!="     { printf("REL_OP %s\n", yytext); }
"<"|">"                 { printf("REL_OP %s\n", yytext); }
[0-9]+                  { printf("NUMBER %s\n", yytext); }
.                       { printf("Mystery character %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() { return 1; }