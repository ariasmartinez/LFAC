%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}


%start programm
%token STARTBLOCK
%token ENDBLOCK
%token LEFTBRACKET
%token RIGHTBRACKET
%token LEFTPAR
%token RIGHTPAR
%token DAC
%token COMMA
%token ASSIGN
%token RETURN
%token MAIN
%token TIP
%token IF 
%token WHILE
%token ELSE
%token FOR
%token OPER
%token REL
%token LOG
%token DOUBLEOPER
%token STRING
%token CONSTANT
%token ID
%token CTE
%token NUMBER
%token PRINT
%token VOID
%%
global_var: global_var global_var | decl_init ;

decl_init: decl_var | decl_var_array | init_var | init_var_array | init_cte | init_cte_array ;

local_var : local_var local_var | decl_init ;

functions: functions decl_function | decl_function  ;

programm: global_var functions MAIN LEFTPAR RIGHTPAR block ;

block: STARTBLOCK inside_block ENDBLOCK ;

inside_block: inside_block inside_block | local_var | statements | print_function | function ;



//declaration var
decl_var : TIP ID DAC ;
//declaration var array
decl_var_array : TIP LEFTBRACKET RIGHTBRACKET  ID DAC ;
//initialization var
init_var: ID ASSIGN CONSTANT ;
//initialization var array
init_var_array: ID ASSIGN LEFTBRACKET inside_array RIGHTBRACKET ;
//array, used in init_var
inside_array: inside_array COMMA inside_array | CONSTANT ;

//initialization cte
init_cte: CTE TIP ID ASSIGN CONSTANT ;
//initialization cte array
init_cte_array: CTE TIP ID LEFTBRACKET RIGHTBRACKET ASSIGN LEFTBRACKET inside_array RIGHTBRACKET ;

//declaration function
decl_function: return_type ID LEFTPAR parameters RIGHTPAR LEFTBRACKET block RETURN DAC RIGHTBRACKET ;

//what the function returns
return_type: TIP | VOID ;

//parameters in declaration function
parameters: parameters COMMA parameters | TIP ID ;

//call a funcion
function: ID LEFTPAR arguments RIGHTPAR DAC ;

arguments: arguments COMMA arguments | ID ;

statements: statements statement  ;

statement: if_statement | for_statement | while_statement ;

if_statement: IF LEFTPAR id_constant REL  id_constant RIGHTPAR block else_statement ;

id_constant : ID|CONSTANT ;

else_statement: ELSE block ;


for_statement: FOR LEFTPAR for_condition RIGHTPAR block ;

for_condition: ID ASSIGN NUMBER DAC ID REL DAC ID DOUBLEOPER ;

while_statement: WHILE LEFTPAR condition RIGHTPAR block ;

condition: id_constant REL id_constant  ;



print_function: PRINT LEFTPAR STRING COMMA ID ;


math: id_constant OPER id_constant ;  //we have to use it

boolean: ID LOG ID ;// we have to use it


%%
void yyerror(char * s){
  printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
  yyin=fopen(argv[1],"r");
  yyparse();
} 



