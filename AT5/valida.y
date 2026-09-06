%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s) { }
extern FILE *yyin;
%}

%token STRING NUMERO RESERVADA

%%
valor: STRING 
     | NUMERO 
     | RESERVADA 
     | objeto 
     | array 
     ;

objeto: '{' '}' 
      | '{' pares '}' 
      ;

pares: par 
     | pares ',' par 
     ;

par: STRING ':' valor 
   ;

array: '[' ']' 
     | '[' itens ']' 
     ;

itens: valor 
     | itens ',' valor 
     ;
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            printf("JSON COM ERRO\n");
            return 1;
        }
    }

    if (yyparse() == 0) {
        printf("JSON OK\n");
    } else {
        printf("JSON COM ERRO\n");
    }

    return 0;
}