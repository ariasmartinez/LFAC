%{
#include <stdio.h>
#include "main.tab.h"
%}
%option noyywrap
%%
[ \n\t] {}
"{" { return STARTBLOCK; }
"}"                                     { return ENDBLOCK; }
"["                                     { return LEFTBRACKET; }
"]"                                     { return RIGHTBRACKET; }
"("                                     { return LEFTPAR; }
")"                                     { return RIGHTPAR; }
";"                                     { return DAC; }
","                                     { return COMMA; }
"="                                     { return ASSIGN; }
"return"                                { return RETURN; }
"main"                                  { return MAIN; }
"int"                                   { return TIP; }
"float"                                 { return TIP; }
"char"                                  { return TIP; }
"bool"					{ return TIP;}
"if"                                    { return IF; }
"while"                                 { return WHILE; }
"else"                                  { return ELSE; }
"for"					{return FOR;}
"*"|"/"                                 {return OPER;}
"%"|"^"                                 {return OPER;}
"+"|"-"                                 {return OPER;}
"=="|"!="                               {return REL;}
"<"|">"|"<="|">="                       {return REL;}
"and"                                   {return LOG;}
"or"                                    {return LOG;}
"--"                                    {return DOUBLEOPER; }
"++"                                    {return DOUBLEOPER; }
"const"					{return CTE;}
\"[^\"]*\"                              {return STRING; }
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'                              { return CONSTANT; }
[0-9]+					{return NUMBER;}
[a-z|A-Z][a-z|A-Z|0-9|_]*                                                            { return ID; }
"print"					{return PRINT;}
"void"					{return VOID;}
<*>.|\n                            { printf("Error in line %d.  %s is not recognizable.\n", yylineno, yytext); }




