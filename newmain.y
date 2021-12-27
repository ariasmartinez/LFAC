%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void yyerror( const char * msg );

#define YYERROR_VERBOSE
%}

%start programm
%token global_var
%token decl_init
%token local_var
%token functions
%token block
%token inside_block
%token decl_var
%token decl_var_array
%token init_var
%token init_var_array
%token inside_array
%token init_cte
%token init_cte_array
%token decl_function
%token return_type
%token parameters
%token function
%token arguments
%token statements
%token statement
%token if_statement
%token id_constant
%token else_statement
%token for_statement
%token for_condition
%token while_statement
%token condition
%token math
%token boolean
%token print_function
%%
global_var: global_var global_var | decl_init | %empty

decl_init: decl_var | decl_var_array | init_var | init_var_array | init_cte | init_cte_array

local_var : local_var local_var | decl_init | %empty

functions: functions decl_functions | decl_functions | %empty

programm: global_var functions MAIN LEFTPAR RIGHTPAR block

block: STARTBLOCK inside_block ENDBLOCK

inside_block: inside_block inside_block | local_var | statements | print_function | function



//declaration var
decl_var : PRIMITIVE ID DAC
//declaration var array
decl_var_array : PRIMITIVE LEFTBRACKET RIGHTBRACKET  ID DAC
//initialization var
init_var: ID ASIGN CONSTANT
//initialization var array
init_var_array: ID ASIGN LEFTBRACKET inside_array RIGHT_BRACKET
//array, used in init_var
inside_array: inside_array COMMA inside_array | CONSTANT

//initialization cte
init_cte: CTE PRIMITIVE ID ASIGN CONSTANT
//initialization cte array
init_cte_array: CTE PRIMITIVE ID LEFTBRACKET RIGHTBRACKET ASSIGN LEFTBRACKET inside_array RIGHTBRACKET

//declaration function
decl_function: return_type ID LEFTPAR parameters RIGHTPAR LEFTBRACKET block RETURN ENDLINE RIGHTBRACKET

//what the function returns
return_type: PRIMITIVE | VOID

//parameters in declaration function
parameters: parameters COMMA parameters | PRIMITIVE ID

//call a funcion
function: ID LEFTPAR ARGUMENTS RIGHTPAR DAC

arguments: arguments COMMA arguments | ID

statements: statements statement | %empty

statement: if_statement | for_statement | while_statement

if_statement: IF LEFTPAR id_constant REL  id_constant RIGHTPAR block else_statement

id_constant = ID|CONSTANT

else_statement: ELSE block


for_statement: FOR LEFTPAR for_condition RIGHTPAR block

for_condition: ID ASSIGN NUMBER DAC ID REL DAC ID DOUBLEOPER

while_statement: WHILE LEFTPAR condition RIGHTPAR block

condition: id_constant REL id_constant



print_function: PRINT LEFTPAR STRING COMMA ID


math: id_constant OPER id_constant   //we have to use it

boolean: ID LOG ID // we have to use it






