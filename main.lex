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
";"                                     { return ENDLINE; }
","                                     { return COMMA; }
"="                                     { return ASIGN; }
"input "                                { return INPUT; }
"output"                                { return OUTPUT; }
"return"                                { return RETURN; }
"var"                                   { return VAR; }
"main"                                  { return MAIN; }
"int"                                   { return PRIMITIVE; }
"float"                                 { return PRIMITIVE; }
"char"                                  { return PRIMITIVE; }
"bool"                                  { return PRIMITIVE; }
"list of"                               { return ESTRUCTURE; }
"if"                                    { return IF; }
"while"                                 { return WHILE; }
"else"                                  { return ELSE; }
">>"|"<<"                               {return OPERLIST;}
"*"|"/"                                 {return MULDIV;}
"%"|"^"                                 {return PORPOW;}
"=="|"!="                               {return EQN;}
%"**"                                    {return PORPOR;} ??
"and"                                   {return ANDLOG;}
"or"                                    {return ORLOG;}
"xor"                                   {return XOR;}
"<"|">"|"<="|">="                       {return REL;}
"--"                                    {return MINUSMINUS; }
"++"                                    {return OPERPLUSPLUS; }
"+"|"-"                                   {return PLUSMINUS;}
"//*"                                    {return COMMENT; }
"?"                                     {return QUESTION; }
"not"                                   {return NOT; }
%"$"                                     {return DOLLAR; }
\"[^\"]*\"                              {return STRING; }
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'                              { return CONSTANT; }
[a-z|A-Z][a-z|A-Z|0-9|_]*                                                            { return ID; }
<*>.|\n                            { printf("Error en la línea %d. Lexema %s no reconocible.\n", yylineno, yytext); }
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
