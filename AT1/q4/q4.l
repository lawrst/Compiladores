%{
#include <stdio.h>
#include <stdlib.h>
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

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Erro: Arquivo nao informado. Passe o arquivo como argumento.\n");
        return 1;
    }
    
    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo indicado (%s).\n", argv[1]);
        return 1;
    }
    
    yyin = arquivo;
    yylex();
    
    fclose(arquivo);
    return 0;
}

int yywrap() { return 1; }