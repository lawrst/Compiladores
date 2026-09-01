%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

char vars[1000][100];
int var_count = 0;

char current_type[50];

void add_var(char *name) {
    int declarada = 0;
    
    for (int i = 0; i < var_count; i++) {
        if (strcmp(vars[i], name) == 0) {
            declarada = 1;
            break;
        }
    }

    if (declarada) {
        printf("erro: %s ja foi declarada\n", name);
    } else {
        strcpy(vars[var_count], name);
        var_count++;
        printf("%s %s\n", current_type, name);
    }
    free(name); 
}
%}

%union {
    char *str;
}

%token <str> TIPO ID
%token VIRGULA PONTO_VIRGULA

%%
programa :
         | programa declaracao
         ;

declaracao : TIPO { strcpy(current_type, $1); free($1); } lista_ids PONTO_VIRGULA
           ;

lista_ids : ID                  { add_var($1); }
          | lista_ids VIRGULA ID { add_var($3); }
          ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro sintatico: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Erro ao abrir arquivo");
            return 1;
        }
        yyin = file;
    }

    yyparse();

    printf("+++++ %d variaveis declaradas\n", var_count);
    
    return 0;
}