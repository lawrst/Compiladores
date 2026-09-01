%{
#include <stdio.h>
#include <math.h>

int  yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

%}

%union {
    double val;
}

%token <val> NUM
%token MAIS MENOS VEZES DIVISAO ABRE_PAREN FECHA_PAREN POT
%type  <val> expr

%left  MAIS MENOS
%left  VEZES DIVISAO
%right POT

%%
entrada : 
        | entrada expr '\n'    { printf("= %g\n", $2); }
        ;

expr : NUM                          { $$ = $1;          }
     | expr MAIS expr               { $$ = $1 + $3;     }
     | expr MENOS expr              { $$ = $1 - $3;     }
     | expr VEZES expr              { $$ = $1 * $3;     }
     | expr DIVISAO expr            { $$ = $1 / $3;     }
     | expr POT expr                { $$ = pow($1, $3); }
     | MENOS expr                   { $$ = -$2;         }
     | ABRE_PAREN expr FECHA_PAREN  { $$ = $2;          }
     ;
%%

void yyerror(const char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv)
{
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Erro ao abrir o arquivo");
            return 1;
        }
        yyin = file;
    }

    return yyparse();
}