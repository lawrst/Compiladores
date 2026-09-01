%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int  yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

typedef struct {
    char *name;
    double val;
} Var;

Var vars[1000];
int var_count = 0;

void set_var(char *name, double val) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(vars[i].name, name) == 0) {
            vars[i].val = val;
            free(name);
            return;
        }
    }
    vars[var_count].name = name;
    vars[var_count].val = val;
    var_count++;
}

double get_var(char *name) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(vars[i].name, name) == 0) {
            double val = vars[i].val;
            free(name);
            return val;
        }
    }
    free(name);
    return 0.0;
}

void print_vars() {
    for (int i = 0; i < var_count; i++) {
        printf("%s >>> %g\n", vars[i].name, vars[i].val);
    }
}
%}

%union {
    double val;
    char *str;
}

%token <val> NUM
%token <str> ID
%token ATRIBUICAO PRINTAR_VARIAVEIS
%token MAIS MENOS VEZES DIVISAO ABRE_PAREN FECHA_PAREN POT

%type <val> expr

%left MAIS MENOS
%left VEZES DIVISAO
%right POT
%right UMINUS

%%
entrada : 
        | entrada comando '\n'
        | entrada '\n'
        ;

comando : ID ATRIBUICAO expr { set_var($1, $3); }
        | expr               { printf("= %g\n", $1); }
        | PRINTAR_VARIAVEIS  { print_vars(); }
        ;

expr : NUM                          { $$ = $1; }
     | ID                           { $$ = get_var($1); }
     | expr MAIS expr               { $$ = $1 + $3; }
     | expr MENOS expr              { $$ = $1 - $3; }
     | expr VEZES expr              { $$ = $1 * $3; }
     | expr DIVISAO expr            { $$ = $1 / $3; }
     | expr POT expr                { $$ = pow($1, $3); }
     | MENOS expr %prec UMINUS      { $$ = -$2; }
     | ABRE_PAREN expr FECHA_PAREN  { $$ = $2; }
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
        if (!file) return 1;
        yyin = file;
    }
    return yyparse();
}