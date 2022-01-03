%{
#include <stdio.h>
#include "main.tab.h"
%}
%option noyywrap
%%

"{" 					{ return STARTBLOCK; }
"}"                                     { return ENDBLOCK; }
"["                                     { return LEFTBRACKET; }
"]"                                     { return RIGHTBRACKET; }
"("                                     { return LEFTPAR; }
")"                                     { return RIGHTPAR; }
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
"print"					{return PRINT;}
"void"					{return VOID;}
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
"true"|"false"                            { return BOOL; }
[0-9]+|([0-9]*\.[0-9]*)			{return NUMBER;}
[a-z|A-Z][a-z|A-Z|0-9|_]*               { return ID; }
[ \t] ;
\n 				{yylineno++;}
. 				{return yytext[0];}





