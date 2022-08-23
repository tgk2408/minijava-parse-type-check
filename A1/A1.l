%{

#include "A1.tab.h"

#include <string.h>

extern isvalid;
%}

%option noyywrap

digit [0-9]
integer 0|[1-9]{digit}*
comment "//".*

%%

{comment} {}

"#defineStmt"  { return defstmt; }
"#defineStmt0" { return defstmt0; }
"#defineStmt1" { return defstmt1; }
"#defineStmt2" { return defstmt2; }

"#defineExpr"  { return defexpr; }
"#defineExpr0" { return defexpr0; }
"#defineExpr1" { return defexpr1; }
"#defineExpr2" { return defexpr2; }

"{" {return curly_op; }
"}" {return curly_cl; }
"(" {return par_op; }
")" {return par_cl; }
"[" {return square_op; }
"]" {return square_cl; }
"." { return Dot; }
"," { return Comma; }
";" { return Semicol; }
"&&" { return And; }
"||" { return Or; }
"!" { return Not; }
"=" { return Equal; }
"<" { return Lt; }
">" { return Gt; }
"+" { return Plus; }
"-" { return Minus; }
"*" { return Mul; }
"/" { return Div; }


"true" { return True; }
"false" { return False; }
"int" { return Int; }
"boolean" { return Boolean; }
"class" { return Class; }
"public" { return Public; }
"static" { return Static; }
"void" { return Void; }
"main" { return Main; }
"extends" { return Extends; }
"System.out.println" { return Systemout; }
"if" { return If; }
"else" { return Else; }
"while" { return While; }
"length" { return Length; }
"new" { return New; }
"this" { return This; }
"return" { return Return; }
"String" { return String; }


{integer} {
	int len = strlen(yytext); 
	yylval.str = (char*) malloc((len + 1) * sizeof(char));
	yylval.str[0] = '\0';
	strcat(yylval.str, yytext);
	return Integer;
}

[a-zA-Z][0-9a-zA-Z_]* {
	int len = strlen(yytext); 
	yylval.str = (char*) malloc((len + 1) * sizeof(char));
	yylval.str[0] = '\0';
	strcat(yylval.str, yytext);
	return Identifier;
}

[ \t\n\f\r\e\v] {}

. {
	isvalid= 0;
	return EndParse;
}

%%