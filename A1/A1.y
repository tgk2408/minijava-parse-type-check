%{
#include<stdio.h>
#include<stdlib.h>
char outstr [100000];
extern int isvalid = 1;

struct listNode{
	char *key;
	char *value;
	struct listNode* next;
};

struct listNode* head;
struct listNode* tail;

void constructList() {
	head= (struct listNode*)malloc(sizeof(struct listNode));
	tail= head;
	head->next= NULL;
}

void insertValue(char *k, char *v) {
	tail->next= (struct listNode*)malloc(sizeof(struct listNode));
	tail= tail->next;
	tail->key= k;
	tail->value= v;
}

void printList() {
	struct listNode* temp= head;
	while(temp->next != NULL){
		puts(temp->next->key);
		puts(" ");
		puts(temp->next->value);
		puts("\n");
		temp= temp->next;
	}
}

%}

%union {
	char *str;
}

/*declare all the tokens here*/
%type<str> Goal MainClass TypeDeclaration Type MethodDeclaration
%type<str> Statement Expression PrimaryExpression
%type<str> MacroDefinition MacroDefStatement MacroDefExpression
%type<str> MacroDefinitions TypeDeclarations Statements Identifierargs Expressionargs Funcargs
%type<str> TypeIdentifiers TypeIdentifierargs MethodDeclarations

%type<str> CURLY_OP CURLY_CL PAR_OP PAR_CL SQUARE_OP SQUARE_CL DOT COMMA SEMICOL
%type<str> AND OR NOT EQUAL LT GT PLUS MINUS MUL DIV
%type<str> TRUE FALSE
%type<str> INT BOOLEAN

%type<str> IDENTIFIER INTEGER
%type<str> DEFSTMT DEFSTMT0 DEFSTMT1 DEFSTMT2
%type<str> DEFEXPR DEFEXPR0 DEFEXPR1 DEFEXPR2
%type<str> CLASS PUBLIC STATIC VOID MAIN EXTENDS SYSTEMOUT
%type<str> IF ELSE WHILE LENGTH NEW THIS RETURN STRING
%type<str> Integer Identifier
%type<str> ENDPARSE

%token curly_op curly_cl par_op par_cl square_op square_cl Dot Comma Semicol
%token And Or Not Equal Lt Gt Plus Minus Mul Div
%token True False
%token Int Boolean

%token Identifier Integer
%token defstmt defstmt0 defstmt1 defstmt2
%token defexpr defexpr0 defexpr1 defexpr2
%token Class Public Static Void Main Extends Systemout
%token If Else While Length New This Return String
%token EndParse

%%
//grammar rules

Goal: MacroDefinitions MainClass TypeDeclarations;

MacroDefinitions:	{}
					|MacroDefinition MacroDefinitions;

MacroDefinition:	MacroDefExpression
					|MacroDefStatement;

MacroDefExpression:	DEFEXPR IDENTIFIER PAR_OP IDENTIFIER COMMA IDENTIFIER COMMA IDENTIFIER Identifierargs PAR_CL PAR_OP Expression PAR_CL CURLY_OP Statements CURLY_CL
					|DEFEXPR0 IDENTIFIER PAR_OP PAR_CL PAR_OP Expression PAR_CL
					|DEFEXPR1 IDENTIFIER PAR_OP IDENTIFIER PAR_CL CURLY_OP Expression CURLY_CL
					|DEFEXPR2 IDENTIFIER PAR_OP IDENTIFIER COMMA IDENTIFIER PAR_CL PAR_OP Expression PAR_CL;

Identifierargs: {}
				|COMMA IDENTIFIER Identifierargs;

Expression: PrimaryExpression AND PrimaryExpression
			|PrimaryExpression OR PrimaryExpression
			|PrimaryExpression NOT EQUAL PrimaryExpression
			|PrimaryExpression LT EQUAL PrimaryExpression
			|PrimaryExpression PLUS PrimaryExpression
			|PrimaryExpression MINUS PrimaryExpression
			|PrimaryExpression MUL PrimaryExpression
			|PrimaryExpression DIV PrimaryExpression
			|PrimaryExpression SQUARE_OP PrimaryExpression SQUARE_CL
			|PrimaryExpression DOT LENGTH
			|PrimaryExpression
			|PrimaryExpression DOT IDENTIFIER PAR_OP Funcargs PAR_CL
			|IDENTIFIER PAR_OP Funcargs PAR_CL;

PrimaryExpression: 	INTEGER
					|TRUE
					|FALSE
					|IDENTIFIER
					|THIS
					|NEW INT SQUARE_OP Expression SQUARE_CL
					|NEW IDENTIFIER PAR_OP PAR_CL
					|NOT Expression
					|PAR_OP Expression PAR_CL;

Funcargs: 	{}
			|Expression
			|Expression Expressionargs;

Expressionargs:	{}
				|COMMA Expression Expressionargs ;


Statements: {}
			|Statement Statements ;

Statement: 	CURLY_OP Statements CURLY_CL
			|SYSTEMOUT PAR_OP Expression PAR_CL SEMICOL
			|IDENTIFIER EQUAL Expression SEMICOL
			|IDENTIFIER SQUARE_OP Expression SQUARE_CL EQUAL Expression SEMICOL
			|IF PAR_OP Expression PAR_CL Statement
			|IF PAR_OP Expression PAR_CL Statement ELSE Statement
			|WHILE PAR_OP Expression PAR_CL Statement
			|IDENTIFIER PAR_OP Funcargs PAR_CL SEMICOL;


MacroDefStatement:	DEFSTMT IDENTIFIER PAR_OP IDENTIFIER COMMA IDENTIFIER COMMA IDENTIFIER Identifierargs PAR_CL PAR_OP Expression PAR_CL CURLY_OP Statements CURLY_CL
					|DEFSTMT0 IDENTIFIER PAR_OP PAR_CL CURLY_OP Statements CURLY_CL
					|DEFSTMT1 IDENTIFIER PAR_OP IDENTIFIER PAR_CL CURLY_OP Statements CURLY_CL
					|DEFSTMT2 IDENTIFIER PAR_OP IDENTIFIER COMMA IDENTIFIER PAR_CL CURLY_OP Statements CURLY_CL;




MainClass: CLASS IDENTIFIER CURLY_OP PUBLIC STATIC VOID MAIN PAR_OP STRING SQUARE_OP SQUARE_CL IDENTIFIER PAR_CL CURLY_OP SYSTEMOUT PAR_OP Expression PAR_CL SEMICOL CURLY_CL CURLY_CL;

TypeDeclarations:	{}
					|TypeDeclaration TypeDeclarations;

TypeDeclaration: CLASS IDENTIFIER CURLY_OP TypeIdentifiers MethodDeclarations CURLY_CL
				 |CLASS IDENTIFIER EXTENDS IDENTIFIER CURLY_OP TypeIdentifiers MethodDeclarations CURLY_CL;

TypeIdentifiers: Statements
				|Type IDENTIFIER SEMICOL TypeIdentifiers;

Type: 	INT SQUARE_OP SQUARE_CL
		|BOOLEAN
		|INT
		|IDENTIFIER;

MethodDeclarations: {}
					|MethodDeclaration MethodDeclarations;

MethodDeclaration: PUBLIC Type IDENTIFIER PAR_OP TypeIdentifierargs PAR_CL CURLY_OP TypeIdentifiers RETURN Expression SEMICOL CURLY_CL;

TypeIdentifierargs:	{}
					|Type IDENTIFIER
					|TypeIdentifierargs COMMA Type IDENTIFIER;

CURLY_OP: curly_op {
	strcat( outstr,"{\n");
};
CURLY_CL: curly_cl {
	strcat( outstr,"\n}\n");
};
PAR_OP: par_op {
	strcat( outstr,"( ");
};
PAR_CL: par_cl {
	strcat( outstr,") ");
};
SQUARE_OP: square_op {
	strcat( outstr,"[ ");
};
SQUARE_CL: square_cl {
	strcat( outstr,"] ");
};
DOT: Dot {
	strcat( outstr,".");
}; 
COMMA: Comma {
	strcat( outstr,", ");
};
SEMICOL: Semicol {
	strcat( outstr,";\n");
};
DEFSTMT:defstmt {
	strcat( outstr,"\n#defineStmt ");
}; 
DEFSTMT0:defstmt0 {
	strcat( outstr,"\n#defineStmt0 ");
}; 
DEFSTMT1:defstmt1 {
	strcat( outstr,"\n#defineStmt1 ");
}; 
DEFSTMT2:defstmt2 {
	strcat( outstr,"\n#defineStmt2 ");
}; 
DEFEXPR:defexpr {
	strcat( outstr,"\n#defineExpr ");
};
DEFEXPR0:defexpr0 {
	strcat( outstr,"\n#defineExpr0 ");
};
DEFEXPR1:defexpr1 {
	strcat( outstr,"\n#defineExpr1 ");
};
DEFEXPR2:defexpr2 {
	strcat( outstr,"\n#defineExpr2 ");
};
AND: And {
	strcat( outstr,"&&");
}; 
OR: Or {
	strcat( outstr,"||");
};
NOT: Not {
	strcat( outstr,"!");
}; 
EQUAL: Equal {
	strcat( outstr,"=");
};
LT: Lt {
	strcat( outstr,"<");
}; 
GT: Gt {
	strcat( outstr,">");
}; 
PLUS: Plus {
	strcat( outstr,"+");
};
MINUS: Minus {
	strcat( outstr,"-");
};
MUL: Mul {
	strcat( outstr,"*");
};
DIV: Div {
	strcat( outstr,"/");
};
TRUE: True {
	strcat( outstr,"true ");
};
FALSE: False {
	strcat( outstr,"false ");
};
INT: Int {
	strcat( outstr,"int ");	
}; 
BOOLEAN: Boolean {
	strcat( outstr,"boolean ");
};
IDENTIFIER: Identifier {
	strcat( outstr, $1);
	strcat( outstr, " ");
}; 
INTEGER: Integer {
	strcat( outstr, $1);
	strcat( outstr, " ");
}; 
CLASS: Class {
	strcat( outstr,"class ");
}; 
PUBLIC: Public {
	strcat( outstr,"public ");
};
STATIC: Static {
	strcat( outstr,"static ");
}; 
VOID: Void {
	strcat( outstr,"void ");
}; 
MAIN: Main {
	strcat( outstr,"main ");
}; 
EXTENDS: Extends {
	strcat( outstr,"extends ");
}; 
SYSTEMOUT: Systemout {
	strcat( outstr,"System.out.println ");
}; 
IF: If {
	strcat( outstr,"if ");
}; 
ELSE: Else {
	strcat( outstr,"else ");
}; 
WHILE: While {
	strcat( outstr,"while ");
}; 
LENGTH: Length {
	strcat( outstr,"length ");
}; 
NEW: New {
	strcat( outstr,"new ");
}; 
THIS: This {
	strcat( outstr,"this ");
}; 
RETURN: Return {
	strcat( outstr,"return ");
}; 
STRING: String {
	strcat( outstr,"String ");
}; 
ENDPARSE: EndParse{
	return 0;
}

%%

int yyerror(char *s)
{
	isvalid = 0;
	printf("//Failed to parse the input code\n");
	return 0;
}

int main(int argc, char **argv)
{
	constructList();
	yyparse();
	if(isvalid){
		puts(outstr);
		puts("\n");
		//printList();
	}
	return 0;
}