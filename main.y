%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;


//i only copy this things from professor's file, you can delete them if you want
union value{
	int intVal;
	float floatVal;
	char strVal[101]:
	char charVal;
};

struct variable{
	char name;
	char *type;
	int val;
}vars[100];

int noVars = 0;

char *type;
char params[100];
int insertVar(char *name, char *type){
	int i = 0;
	for (i = 0; i < noVars; i++){
		if(strcmp(vars[i].name, name) == 0)
			return 2;
	}
	strcpy(vars[noVars].name, name);
	strcpy[vars[noVars].type, type);

	noVars++;
	return 0;
}




int existVar(char *s){
	int i = 0;
	for(i = 0; i < noVars; i++){
		if(strcmp(s, vars[i].name) == 0)
			return i;
	}
	return -1;
}
%union{
int intval;
char* strval;
}

//create insertFct and existFct

%union {
    void* pointer_type;
    int int_type;
    double double_type;
    char* string_type;
    struct 
    { 
        int int_var; 
        double double_var; 
        char* string_var;
        char* var_name; 
    }var_type;
}

%}

%start progr
%token RETURN MAIN LOG REL DOUBLEOPER ASSIGN IF ELSE WHILE FOR OPER 
%token<pointer_type> TIP STRING BOOL 
%token FNCT 
%token NUMBER
%token ID
%token CTE
%token PRINT
%token VOID

%%
/*
things that  are not working: const int a = 3; int function(){}; ...
things that i didnt implement: classes (i dont know how)
*/

progr : all_vars functions MAIN  block;

all_vars:  var | all_vars var;

var: decl_var | decl_var_array | init_var | init_var_array | init_cte | init_cte_array ;


functions:  decl_function | functions decl_function;



block: '{' inside_block '}' ;

inside_block: statement | inside_block statement;

//int person(...) block
decl_function: FNCT return_type ID '(' parameters ')' block {insertFct($2, params);}
        | FNCT return_type ID '(' parameters ')' '{' inside_block RETURN ID ';' '}' {insertFct($2, params);}
        | FNCT return_type ID '(' parameters ')' ';' ;

//what the function returns
return_type: TIP | VOID ;
  
//parameters in declaration function  ->  int a, char b
parameters: TIP ID  {strcpy(params, $1),  strcat(params, $2), strcat(params, " ");}
	| TIP ID ',' parameters {strcat(params, $1),strcat(params, $2), strcat(params, " ");} ;//confict here

//call a funcion -> person(...);
function: ID '(' arguments ')' ';';

//arguments in call function -> a,b
arguments: ID | arguments ',' arguments;


/*int a;*/
decl_var : TIP ID ';' {insertVar($2, $1);} ;
//int a[];
decl_var_array : TIP ID '[' NUMBER ']' ';' ;
// a = 9; or a = 1+2; 
init_var: ID ASSIGN id_constant ';'  | ID ASSIGN math ';' ;
//  a = [...];
init_var_array: ID ASSIGN '[' inside_array ']' ';' ;
//9, a, "hello" !!??
inside_array: id_constant | id_constant ',' inside_array;

//const int a = 9; or int a = 1+2;
init_cte: CTE TIP ID ASSIGN id_constant  ';' | CTE TIP ID ASSIGN math  ';'  ;
//const int a[] = [...];
init_cte_array: CTE TIP ID '[' ']' ASSIGN '[' inside_array ']' ';' ;




statement: function | print_function | all_vars | if_statement | for_statement | while_statement ;

// if(a == 9) block else
if_statement: IF '(' id_constant REL id_constant ')' block else_statement ;



id_constant : ID|NUMBER|BOOL|STRING ;

number_id : NUMBER | ID

else_statement: ELSE block ;

// for () block
for_statement: FOR '(' for_condition ')' block ;

//a = 1; a < 5; a++
for_condition: ID ASSIGN NUMBER ';' ID REL NUMBER ';' ID DOUBLEOPER ;

//while() block
while_statement: WHILE '(' condition ')' block ;

//a < 9
condition: boolean | id_constant | id_constant REL id_constant ;


//print("....", a);
print_function: PRINT '(' STRING ',' ID  ')' ';';

//1+a;
math: number_id OPER number_id ;  

//a or b
boolean: ID LOG ID ;



%%
void yyerror(char * s){
  printf("error: %s in line:%d\n",s,yylineno);
}

int main(int argc, char** argv){
  yyin=fopen(argv[1],"r");
  yyparse();
}
