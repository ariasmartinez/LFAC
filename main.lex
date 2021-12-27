%option yylineno
%option noyywrap
%{
	//#include "tabla.h"
	#include "y.tab.h"
%}
int acarrero = 1;
%%
[ \n\t] {}
"{"                                     { return STARTBLOCK; }
"}"                                     { return ENDBLOCK; }
"["                                     { return LEFTBRACKET; }
"]"                                     { return RIGHTBRACKET; }
"("                                     { return LEFTPAR; }
")"                                     { return RIGHTPAR; }
";"                                     { return DAC; }
","                                     { return COMMA; }
"="                                     { return ASIGN; }
"return"                                { return RETURN; }
"main"                                  { return MAIN; }
"int"                                   { return PRIMITIVE; }
"float"                                 { return PRIMITIVE; }
"char"                                  { return PRIMITIVE; }
"bool"					{ return PRIMITIVE;}
"if"                                    { return IF; }
"while"                                 { return WHILE; }
"else"                                  { return ELSE; }
"*"|"/"                                 {return OPER;}
"%"|"^"                                 {return OPER;}
"=="|"!="                               {return REL;}

"and"                                   {return LOG;}
"or"                                    {return LOG;}

"<"|">"|"<="|">="                       {return REL;}
"--"                                    {return DOUBLEOPER; }
"++"                                    {return DOUBLEOPER; }
"+"|"-"                                   {return OPER;}
\"[^\"]*\"                              {return STRING; }
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'                              { return CONSTANT; }
[a-z|A-Z][a-z|A-Z|0-9|_]*                                                            { return ID; }

<*>.|\n                            { printf("Error in line %d.  %s is not recognizable.\n", yylineno, yytext); }
%%
/*
    int main (){
    int val;
    val = yylex();
    while (val != 0){
      printf("%d\n", val);
      val = yylex();
    }
    exit(0);
}
*/
