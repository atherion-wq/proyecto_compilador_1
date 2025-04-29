package analizador;
import static analizador.Tokens.*;

%%
%class Analizador
%type Tokens

%{
  public String lexeme;

  public int getLinea() {
      return yyline + 1;
  }
%}

%%

"int"                   { lexeme = yytext(); return TIPO_INT; }
"float"                 { lexeme = yytext(); return TIPO_FLOAT; }
"char"                  { lexeme = yytext(); return TIPO_CHAR; }
"string"                { lexeme = yytext(); return TIPO_STRING; }
"bool"                  { lexeme = yytext(); return TIPO_BOOL; }
"arreglo"               { lexeme = yytext(); return ARREGLO; }
"null"                  { lexeme = yytext(); return NULL; }
"luna"                  { lexeme = yytext(); return LUNA; }
"sol"                   { lexeme = yytext(); return SOL; }
"void"                  { lexeme = yytext(); return VOID; }
"main"                  { lexeme = yytext(); return MAIN; }
"def"                   { lexeme = yytext(); return DEF; }
"if"                    { lexeme = yytext(); return IF; }
"else"                  { lexeme = yytext(); return ELSE; }
"elif"                  { lexeme = yytext(); return ELIF; }
"while"                 { lexeme = yytext(); return WHILE; }
"do"                    { lexeme = yytext(); return DO; }
"for"                   { lexeme = yytext(); return FOR; }
"switch"                { lexeme = yytext(); return SWITCH; }
"case"                  { lexeme = yytext(); return CASE; }
"default"               { lexeme = yytext(); return DEFAULT; }
"break"                 { lexeme = yytext(); return BREAK; }
"return"                { lexeme = yytext(); return RETURN; }
"sysRead"               { lexeme = yytext(); return SYSREAD; }
"sysPrint"              { lexeme = yytext(); return SYSPRINT; }

([a-zA-Z])([a-zA-Z0-9])*  { lexeme = yytext(); return IDENTIFICADOR; }

0                         { lexeme = yytext(); return LITERAL_INT; }
-?[1-9][0-9]*             { lexeme = yytext(); return LITERAL_INT; }
0\.[0-9]+                 { lexeme = yytext(); return LITERAL_FLOAT; }
-?[1-9][0-9]*\.[0-9]+     { lexeme = yytext(); return LITERAL_FLOAT; }
\'[a-zA-Z]\'              { lexeme = yytext(); return LITERAL_CHAR; }
\"([^\"\\\n]*)\"          { lexeme = yytext(); return LITERAL_STRING; }

"@"[^\n]*                 { /* Comentario de línea */ }
\{([^}]|\n)*}             { /* Comentario múltiple */ }

"^"|"#"                  { lexeme = yytext(); return OPERADOR_LOG; }
"!"                      { lexeme = yytext(); return NEGACION; }
">="|"<="|"=="|"!="|">"|"<"  { lexeme = yytext(); return OPERADOR_REL; }
"\+\+"                   { lexeme = yytext(); return INCREMENTO; }
"--"                     { lexeme = yytext(); return DECREMENTO; }
"\*\*"                   { lexeme = yytext(); return POT; }
"\+"                     { lexeme = yytext(); return SUMA; }
"-"                      { lexeme = yytext(); return RESTA; }
"\*"                     { lexeme = yytext(); return MULT; }
"//"                     { lexeme = yytext(); return DIVENTERA; }
"~"                      { lexeme = yytext(); return MOD; }
"="                      { lexeme = yytext(); return IGUAL; }
","                      { lexeme = yytext(); return COMA; }
":"                      { lexeme = yytext(); return DOS_PUNTOS; }
"\."                     { lexeme = yytext(); return PUNTO; }
"ʃ"                      { lexeme = yytext(); return PARENTESIS_IZQ; }
"ʅ"                      { lexeme = yytext(); return PARENTESIS_DER; }
"\\"                     { lexeme = yytext(); return LLAVE_ABRE; }
"/"                      { lexeme = yytext(); return LLAVE_CIERRA; }
"\|"                     { lexeme = yytext(); return BARRA_ARREGLO; }
"\?"                     { lexeme = yytext(); return DELIMITADOR; }
[ \t\r]+                 { /* Ignorar espacios y tabulaciones */ }
\n                       { yyline++; }


. { lexeme = yytext(); return ERROR; }
