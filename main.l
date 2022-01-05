%{
#include <stdio.h>
#include "main.tab.h"
%}
%option noyywrap
%%


"="                                     { return ASSIGN; }
"return"                                { return RETURN; }
"main"                                  { return MAIN; }
"int"                                   {strcpy(yylval.strval,yytext); return TIP; }
"float"                                 { strcpy(yylval.strval,yytext); return TIP; }
"char"                                  { strcpy(yylval.strval,yytext); return TIP; }
"bool"					                {strcpy(yylval.strval,yytext); return TIP;}
"if"                                    { return IF; }
"while"                                 { return WHILE; }
"else"                                  { return ELSE; }
"print"					                {return PRINT;}
"void"					                {return VOID;}
"for"					                {return FOR;}
"*"|"/"                                 {return OPER;}
"%"|"^"                                 {OPER return;}
"+"|"-"                                 {OPER return;}
"=="|"!="                               {return REL;}
"<"|">"|"<="|">="                       {return REL;}
"and"                                   {return LOG;}
"or"                                    {return LOG;}
"--"                                    {return DOUBLEOPER; }
"++"                                    {return DOUBLEOPER; }
"const"					                {return CTE;}
"function"                              {return FNCT;}
\"[^\"]*\"                              {return STRING; }
"true"|"false"                          {return BOOL; }
[0-9]+			        {yylval.intval = atoi(yytext); return NUMBER;}
[a-z|A-Z][a-z|A-Z|0-9|_]*               {strcpy(yylval.strval,yytexy); return ID; }
[ \t] ;
\n 				{yylineno++;}
. 				{return yytext[0];}





