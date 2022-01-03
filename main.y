%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%start progr
%token STARTBLOCK
%token ENDBLOCK
%token LEFTBRACKET
%token RIGHTBRACKET
%token LEFTPAR
%token RIGHTPAR
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
%token BOOL
%token ID
%token CTE
%token NUMBER
%token PRINT
%token VOID
%%


progr : all_vars functions MAIN  block ;

all_vars: all_vars var | var ;

var: decl_var | decl_var_array | init_var | init_var_array | init_cte | init_cte_array ;


functions: functions decl_function | decl_function  ;



block: STARTBLOCK inside_block ENDBLOCK ;

inside_block: inside_block statement | statement ;

//int person(...) block
decl_function: return_type ID LEFTPAR parameters RIGHTPAR STARTBLOCK inside_block RETURN ID ';' ENDBLOCK 
		| return_type ID LEFTPAR parameters RIGHTPAR block;

//what the function returns
return_type: TIP | VOID ;
  
//parameters in declaration function  ->  int a, char b
parameters: parameters COMMA parameters | TIP ID ;

//call a funcion -> person(...);
function: ID LEFTPAR arguments RIGHTPAR ';';

//arguments in call function -> a,b
arguments: arguments COMMA arguments | ID ;


/*int a;*/
decl_var : TIP ID ';' ;
//int a[];
decl_var_array : TIP ID LEFTBRACKET RIGHTBRACKET ';' ;
// a = 9; or a = 1+2;
init_var: ID ASSIGN id_constant ';'  | ID ASSIGN math ';' ;
//  a = [...];
init_var_array: ID ASSIGN LEFTBRACKET inside_array RIGHTBRACKET ';' ;
//9, a, "hello"
inside_array: inside_array COMMA inside_array | id_constant | ID | STRING ;

//const int a = 9; or int a = 1+2;
init_cte: CTE TIP ID ASSIGN id_constant  ";" | CTE TIP ID ASSIGN math  ';'  ;
//const int a[] = [...];
init_cte_array: CTE TIP ID LEFTBRACKET RIGHTBRACKET ASSIGN LEFTBRACKET inside_array RIGHTBRACKET ';' ;




statement: if_statement | for_statement | while_statement | all_vars | print_function | function;

// if(a == 9) block else
if_statement: IF LEFTPAR id_constant REL id_constant RIGHTPAR block else_statement ;



id_constant : ID|NUMBER|BOOL|STRING ;

number_id : NUMBER | ID

else_statement: ELSE block ;

// for () block
for_statement: FOR LEFTPAR for_condition RIGHTPAR block ;

//a = 1; a < 5; a++
for_condition: ID ASSIGN NUMBER ';' ID REL NUMBER ';' ID DOUBLEOPER ;

//while() block
while_statement: WHILE LEFTPAR condition RIGHTPAR block ;

//a < 9
condition: id_constant REL id_constant | id_constant | boolean   ;


//print("....", a);
print_function: PRINT LEFTPAR STRING COMMA ID  RIGHTPAR ';';

//1+a;
math: number_id OPER number_id ;  

//a or b
boolean: ID LOG ID ;


%%
void yyerror(char * s){
  printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
  yyin=fopen(argv[1],"r");
  yyparse();
} 



