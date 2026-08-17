%{
#include <stdio.h>
%}

%%
[ \t\n]+                { /* ignora espacos, tabulacoes e quebras de linha */ }
"//".*                  { /* descarta comentarios de linha */ }
"if"                    { printf("IF\n"); }
"else"                  { printf("ELSE\n"); }
"while"                 { printf("WHILE\n"); }
"return"                { printf("RETURN\n"); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?       { printf("NUMBER %s\n", yytext); }
.                       { printf("SIMBOLO %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() { return 1; }