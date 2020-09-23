%{
/* Lab2 Attention: You are only allowed to add code in this file and start at Line 26.*/
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"

int charPos=1;

int yywrap(void)
{
 charPos=1;
 return 1;
}

void adjust(void)
{
 EM_tokPos=charPos;
 charPos+=yyleng;
}

/*
* Please don't modify the lines above.
* You can add C declarations of your own below.
*/

/* @function: getstr
 * @input: a string literal
 * @output: the string value for the input which has all the escape sequences 
 * translated into their meaning.
 */
char *getstr(const char *str)
{
	//optional: implement this function if you need it
  char *result;
  int i, j;
  int len = strlen(str);
  if (len == 2) {
    result = "(null)";
    return result;
  }

  result = malloc(1024);
  i = 1;
  j = 0;
  while (i<len-1) {
    if (i<len-2 && str[i] == '\\') {
      if (str[i+1] == 'n') {
        result[j] = '\n';
        i += 2;
      } else if (str[i+1] == 't') {
        result[j] = '\t';
        i += 2;
      } else if (str[i+1] == '\\') {
        result[j] = '\\';
        i += 2;
      } else if (str[i+1] == '^') {
        result[j] = str[i+2] - 'A' + 1;
        i += 3;
      } else if (str[i+1]>='0' && str[i+1]<='9') {
        char c = (str[i+1] - '0')*10*10 + (str[i+2] - '0')*10 + (str[i+3] - '0');
        result[j] = c;
        i += 4; 
      } else if (str[i+1] == '\"') {
        result[j] = '\"';
        i += 2;
      } else {
        i++;
        while (i<len && str[i] != '\\') i++;
        i++;
        j--;
      }
    } else {
      result[j] = str[i];
      i++;
    }
    j++;
  }
  result[j] = '\0';
  
	return result;
}

int commentLevel=0;

%}
  /* You can add lex definitions here. */

%Start COMMENT
%%
  /* 
  * Below is an example, which you can wipe out
  * and write reguler expressions and actions of your own.
  */ 
[ \t]+ {adjust();}
"\n"	    {adjust(); EM_newline();}

<INITIAL>","  {adjust(); return COMMA;}
<INITIAL>":"  {adjust(); return COLON;}
<INITIAL>";"  {adjust(); return SEMICOLON;}
<INITIAL>"("  {adjust(); return LPAREN;}
<INITIAL>")"  {adjust(); return RPAREN;}
<INITIAL>"["  {adjust(); return LBRACK;}
<INITIAL>"]"  {adjust(); return RBRACK;}
<INITIAL>"{"  {adjust(); return LBRACE;}
<INITIAL>"}"  {adjust(); return RBRACE;}
<INITIAL>"+"  {adjust(); return PLUS;}
<INITIAL>"-"  {adjust(); return MINUS;}
<INITIAL>"*"  {adjust(); return TIMES;}
<INITIAL>"/"  {adjust(); return DIVIDE;}
<INITIAL>"="  {adjust(); return EQ;}
<INITIAL>"<"  {adjust(); return LT;}
<INITIAL>">"  {adjust(); return GT;}
<INITIAL>"<=" {adjust(); return LE;}
<INITIAL>">=" {adjust(); return GE;}
<INITIAL>"<>" {adjust(); return NEQ;}
<INITIAL>"."  {adjust(); return DOT;}
<INITIAL>"&"  {adjust(); return AND;}
<INITIAL>"|"  {adjust(); return OR;}
<INITIAL>":=" {adjust(); return ASSIGN;}

<INITIAL>while    {adjust(); return WHILE;}
<INITIAL>for  	  {adjust(); return FOR;}
<INITIAL>to       {adjust(); return TO;}
<INITIAL>break    {adjust(); return BREAK;}
<INITIAL>let      {adjust(); return LET;}
<INITIAL>in       {adjust(); return IN;}
<INITIAL>end      {adjust(); return END;}
<INITIAL>function {adjust(); return FUNCTION;}
<INITIAL>var      {adjust(); return VAR;}
<INITIAL>type     {adjust(); return TYPE;}
<INITIAL>array    {adjust(); return ARRAY;}
<INITIAL>if       {adjust(); return IF;}
<INITIAL>then     {adjust(); return THEN;}
<INITIAL>else     {adjust(); return ELSE;}
<INITIAL>do       {adjust(); return DO;}
<INITIAL>of       {adjust(); return OF;}
<INITIAL>nil      {adjust(); return NIL;}

<COMMENT>"/*"     {
                    adjust();
                    commentLevel+=1;
                  }
<COMMENT>"*/"     {
                    adjust();
                    if(--commentLevel == 0)
                        BEGIN INITIAL;
                  }
<COMMENT>.        {adjust();}
<INITIAL>"/*"     {
                    adjust();
                    commentLevel+=1;
                    BEGIN COMMENT;
                  }
                    
<INITIAL>[a-zA-Z][0-9a-zA-Z_]* {adjust(); yylval.sval=String(yytext); return ID;}
<INITIAL>[0-9]+	    {adjust(); yylval.ival=atoi(yytext); return INT;}
<INITIAL>.	        {adjust(); EM_error(EM_tokPos,"illegal token");}
.                   {BEGIN INITIAL; yyless(1);}
<INITIAL>\"(\\\"|[^"])*\"  {adjust(); yylval.sval=getstr(yytext); return STRING;}
