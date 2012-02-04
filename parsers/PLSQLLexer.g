/**
 * Oracle(c) PL/SQL 11g Parser  
 *
 * Copyright (c) 2009-2011 Alexandre Porcelli <alexandre.porcelli@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
lexer grammar PLSQLLexer;

tokens { // moved to the import vocabulary
    UNSIGNED_INTEGER; // Imaginary token based on subtoken typecasting - see the rule <EXACT_NUM_LIT>
    APPROXIMATE_NUM_LIT; // Imaginary token based on subtoken typecasting - see the rule <EXACT_NUM_LIT>
    MINUS_SIGN; // Imaginary token based on subtoken typecasting - see the rule <SEPARATOR>
    DOUBLE_PERIOD;
    UNDERSCORE; // Imaginary token based on subtoken typecasting - see the rule <INTRODUCER>
}

@header {
/**
 * Oracle(c) PL/SQL 11g Parser  
 *
 * Copyright (c) 2009-2011 Alexandre Porcelli <alexandre.porcelli@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package br.com.porcelli.parser.plsql;

import java.util.LinkedList;
}

@members {
    // buffer (queue) to hold the emit()'d tokens
    private LinkedList<Token> tokenBuffer = new LinkedList<Token>();

    public void emit(Token t) {
        tokenBuffer.add(t);
    }

    private void advanceInput(){
        state.tokenStartCharIndex = input.index();
        state.tokenStartCharPositionInLine = input.getCharPositionInLine();
        state.tokenStartLine = input.getLine();
    }


    /**
     * Return a token from this source; i.e., match a token on the char stream.
     */
    public Token nextToken() {
        while (true) {
            if (tokenBuffer.size() == 0) {
                state.token = null;
                state.channel = Token.DEFAULT_CHANNEL;
                state.tokenStartCharIndex = input.index();
                state.tokenStartCharPositionInLine = input.getCharPositionInLine();
                state.tokenStartLine = input.getLine();
                state.text = null;
                if (input.LA(1) == CharStream.EOF) {
                    return Token.EOF_TOKEN;
                }
                try {
                    int m = input.mark();
                    state.backtracking = 1;
                    state.failed = false;
                    mTokens();
                    state.backtracking = 0;

                    if (state.failed) {
                        input.rewind(m);
                        input.consume();
                    } else {
                        emit();
                    }
                } catch (RecognitionException re) {
                    // shouldn't happen in backtracking mode, but...
                    reportError(re);
                    recover(re);
                }
            } else {
                Token result = tokenBuffer.poll();
                if (result == Token.SKIP_TOKEN || result.getType() == Token.INVALID_TOKEN_TYPE || result == null)
                {
                    // discard
                    // SKIP & INVALID
                    // tokens
                    continue;
                }
                return result;
            }
        }
    }
}

FOR_NOTATION
    :    UNSIGNED_INTEGER
        {state.type = UNSIGNED_INTEGER; emit(); advanceInput();}
        '..'
        {state.type = DOUBLE_PERIOD; emit(); advanceInput();}
        UNSIGNED_INTEGER
        {state.type = UNSIGNED_INTEGER; emit(); advanceInput(); $channel=HIDDEN;}
    ;

//{ Rule #358 <NATIONAL_CHAR_STRING_LIT> - subtoken typecast in <REGULAR_ID>, it also incorporates <character_representation>
//  Lowercase 'n' is a usual addition to the standard
NATIONAL_CHAR_STRING_LIT
    :    ('N' | 'n') '\'' (options{greedy=true;}: ~('\'' | '\r' | '\n' ) | '\'' '\'' | NEWLINE)* '\''
    ;
//}

//{ Rule #040 <BIT_STRING_LIT> - subtoken typecast in <REGULAR_ID>
//  Lowercase 'b' is a usual addition to the standard
BIT_STRING_LIT
    :    ('B' | 'b') ('\'' ('0' | '1')* '\'' SEPARATOR? )+
    ;
//}


//{ Rule #284 <HEX_STRING_LIT> - subtoken typecast in <REGULAR_ID>
//  Lowercase 'x' is a usual addition to the standard
HEX_STRING_LIT
    :    ('X' | 'x') ('\'' ('a'..'f' | 'A'..'F' | '0'..'9')* '\'' SEPARATOR? )+ 
    ;
//}

PERIOD
    :    '.' 
    {    if ((char) input.LA(1) == '.') {
            input.consume();
            $type = DOUBLE_PERIOD;
        }
    }
    ;

//{ Rule #238 <EXACT_NUM_LIT> 
//  This rule is a bit tricky - it resolves the ambiguity with <PERIOD> 
//  It als44o incorporates <mantisa> and <exponent> for the <APPROXIMATE_NUM_LIT>
//  Rule #501 <signed_integer> was incorporated directly in the token <APPROXIMATE_NUM_LIT>
//  See also the rule #617 <unsigned_num_lit>
EXACT_NUM_LIT
    : (
            UNSIGNED_INTEGER
            ( '.' UNSIGNED_INTEGER
            |    {$type = UNSIGNED_INTEGER;}
            ) ( ('E' | 'e') ('+' | '-')? UNSIGNED_INTEGER {$type = APPROXIMATE_NUM_LIT;} )?
    |    '.' UNSIGNED_INTEGER ( ('E' | 'e') ('+' | '-')? UNSIGNED_INTEGER {$type = APPROXIMATE_NUM_LIT;} )?
    )
    ( 'D' | 'd' | 'f' | 'F')?
    ;
//}

//{ Rule #--- <CHAR_STRING> is a base for Rule #065 <char_string_lit> , it incorporates <character_representation>
//  and a superfluous subtoken typecasting of the "QUOTE"
CHAR_STRING
    :    '\'' (options{greedy=true;}: ~('\'' | '\r' | '\n') | '\'' '\'' | NEWLINE)* '\''
    ;
//}

// Perl-style quoted string, see Oracle SQL reference, chapter String Literals
CHAR_STRING_PERL    : ('q'|'Q') ( QS_ANGLE | QS_BRACE | QS_BRACK | QS_PAREN | QS_OTHER) {$type = CHAR_STRING;};
fragment QUOTE      : '\'' ;
fragment QS_ANGLE   : QUOTE '<' ( options {greedy=false;} : . )* '>' QUOTE ;
fragment QS_BRACE   : QUOTE '{' ( options {greedy=false;} : . )* '}' QUOTE ;
fragment QS_BRACK   : QUOTE '[' ( options {greedy=false;} : . )* ']' QUOTE ;
fragment QS_PAREN   : QUOTE '(' ( options {greedy=false;} : . )* ')' QUOTE ;

fragment QS_OTHER_CH: ~('<'|'{'|'['|'('|' '|'\t'|'\n'|'\r');
fragment QS_OTHER
//    For C target we have to preserve case sensitivity.
//		@declarations {
//    		ANTLR3_UINT32 (*oldLA)(struct ANTLR3_INT_STREAM_struct *, ANTLR3_INT32);
//		}
//		@init {
//			oldLA = INPUT->istream->_LA;
//            INPUT->setUcaseLA(INPUT, ANTLR3_FALSE);
//		}
		:
		QUOTE delimiter=QS_OTHER_CH
/* JAVA Syntax */
    ( { input.LT(1) != $delimiter.text.charAt(0) || ( input.LT(1) == $delimiter.text.charAt(0) && input.LT(2) != '\'') }? => . )*
    ( { input.LT(1) == $delimiter.text.charAt(0) && input.LT(2) == '\'' }? => . ) QUOTE
/* C Syntax */
//		( { LA(1) != $delimiter->getText(delimiter)->chars[0] || LA(2) != '\'' }? => . )*
//		( { LA(1) == $delimiter->getText(delimiter)->chars[0] && LA(2) == '\'' }? => . ) QUOTE
// 		{ INPUT->istream->_LA = oldLA; }
		;


//{ Rule #163 <DELIMITED_ID>
DELIMITED_ID
    :    '"' (~('"' | '\r' | '\n') | '"' '"')+ '"' 
    ;
//}

//{ Rule #546 <SQL_SPECIAL_CHAR> was split into single rules
PERCENT
    :    '%'
    ;

AMPERSAND
    :    '&'
    ;

LEFT_PAREN
    :    '('
    ;

RIGHT_PAREN
    :    ')'
    ;

DOUBLE_ASTERISK
    :    '**'
    ;

ASTERISK
    :    '*'
    ;

PLUS_SIGN
    :    '+'
    ;

COMMA
    :    ','
    ;

SOLIDUS
    :    '/'
    ; 

AT_SIGN
    :    '@'
    ;

ASSIGN_OP
    :    ':='
    ;

// See OCI reference for more information about this
BINDVAR
    :    COLON SIMPLE_LETTER  ( SIMPLE_LETTER | '0' .. '9' | '_' )*
    |    COLON DELIMITED_ID  // not used in SQL but spotted in v$sqltext when using cursor_sharing
    |    COLON UNSIGNED_INTEGER
    |    QUESTION_MARK // not in SQL, not in Oracle, not in OCI, use this for JDBC
    ;

COLON
    :    ':'
    ;

SEMICOLON
    :    ';'
    ;

LESS_THAN_OR_EQUALS_OP
    :    '<='
    ;

LESS_THAN_OP
    :    '<'
    ;

GREATER_THAN_OR_EQUALS_OP
    :    '>='
    ;

NOT_EQUAL_OP
    :    '!='
    |    '<>'
    |    '^='
    |    '~='
    ;
CARRET_OPERATOR_PART
    :    '^'
    ;

TILDE_OPERATOR_PART
    :    '~'
    ;

EXCLAMATION_OPERATOR_PART
    :    '!'
    ;

GREATER_THAN_OP
    :    '>'
    ;

fragment
QUESTION_MARK
    :    '?'
    ;

// protected UNDERSCORE : '_' SEPARATOR ; // subtoken typecast within <INTRODUCER>
CONCATENATION_OP
    :    '||'
    ;

VERTICAL_BAR
    :    '|'
    ;

EQUALS_OP
    :    '='
    ;

//{ Rule #532 <SQL_EMBDD_LANGUAGE_CHAR> was split into single rules:
LEFT_BRACKET
    :    '['
    ;

RIGHT_BRACKET
    :    ']'
    ;

//}

//{ Rule #319 <INTRODUCER>
INTRODUCER
    :    '_' (SEPARATOR {$type = UNDERSCORE;})?
    ;

//{ Rule #479 <SEPARATOR>
//  It was originally a protected rule set to be filtered out but the <COMMENT> and <MINUS_SIGN> clashed. 
SEPARATOR
    :    '-' {$type = MINUS_SIGN;}
    |    COMMENT { $channel=HIDDEN; }
    |    (SPACE | NEWLINE)+ { $channel=HIDDEN; }
    ;
//}

//{ Rule #504 <SIMPLE_LETTER> - simple_latin _letter was generalised into SIMPLE_LETTER
//  Unicode is yet to be implemented - see NSF0
fragment
SIMPLE_LETTER
    :    'a'..'z'
    |    'A'..'Z'
    ;
//}

//  Rule #176 <DIGIT> was incorporated by <UNSIGNED_INTEGER> 
//{ Rule #615 <UNSIGNED_INTEGER> - subtoken typecast in <EXACT_NUM_LIT> 
fragment
UNSIGNED_INTEGER
    :    ('0'..'9')+ 
    ;
//}

//{ Rule #097 <COMMENT>
fragment
COMMENT
    :    '--' ( ~('\r' | '\n') )* (NEWLINE|EOF)
    |    '/*' (options{greedy=false;} : .)* '*/'
    ;
//}

// SQL*Plus prompt
// TODO should be grammar rule, but tricky to implement
PROMPT
	: 'prompt' SPACE ( ~('\r' | '\n') )* (NEWLINE|EOF)
	;
//}



//{ Rule #360 <NEWLINE>
fragment
NEWLINE
    :    '\r' (options{greedy=true;}: '\n')?
    |    '\n'
    ;
//}

//{ Rule #522 <SPACE>
fragment
SPACE    :    ' '
    |    '\t'
    ;
//}

fragment APPROXIMATE_NUM_LIT: ;
fragment MINUS_SIGN: ;    
fragment UNDERSCORE: ;
fragment DOUBLE_PERIOD: ;

//{ Rule #442 <REGULAR_ID> additionally encapsulates a few STRING_LITs.
//  Within testLiterals all reserved and non-reserved words are being resolved

SQL92_RESERVED_ALL
    :    'all'
    ;

SQL92_RESERVED_ALTER
    :    'alter'
    ;

SQL92_RESERVED_AND
    :    'and'
    ;

SQL92_RESERVED_ANY
    :    'any'
    ;

SQL92_RESERVED_AS
    :    'as'
    ;

SQL92_RESERVED_ASC
    :    'asc'
    ;

//SQL92_RESERVED_AT
//    :    'at'
//    ;

SQL92_RESERVED_BEGIN
    :    'begin'
    ;

SQL92_RESERVED_BETWEEN
    :    'between'
    ;

SQL92_RESERVED_BY
    :    'by'
    ;

SQL92_RESERVED_CASE
    :    'case'
    ;

SQL92_RESERVED_CHECK
    :    'check'
    ;

PLSQL_RESERVED_CLUSTERS
    :    'clusters'
    ;

PLSQL_RESERVED_COLAUTH
    :    'colauth'
    ;

PLSQL_RESERVED_COMPRESS
    :    'compress'
    ;

SQL92_RESERVED_CONNECT
    :    'connect'
    ;

//PLSQL_NON_RESERVED_COLUMNS
//    :    'columns'
//    ;

PLSQL_NON_RESERVED_CONNECT_BY_ROOT
    :    'connect_by_root'
    ;

PLSQL_RESERVED_CRASH
    :    'crash'
    ;

SQL92_RESERVED_CREATE
    :    'create'
    ;

SQL92_RESERVED_CURRENT
    :    'current'
    ;

SQL92_RESERVED_CURSOR
    :    'cursor'
    ;

SQL92_RESERVED_DATE
    :    'date'
    ;

SQL92_RESERVED_DECLARE
    :    'declare'
    ;

SQL92_RESERVED_DEFAULT
    :    'default'
    ;

SQL92_RESERVED_DELETE
    :    'delete'
    ;

SQL92_RESERVED_DESC
    :    'desc'
    ;

SQL92_RESERVED_DISTINCT
    :    'distinct'
    ;

SQL92_RESERVED_DROP
    :    'drop'
    ;

SQL92_RESERVED_ELSE
    :    'else'
    ;

SQL92_RESERVED_END
    :    'end'
    ;

SQL92_RESERVED_EXCEPTION
    :    e='exception'
    // "exception" is a keyword only withing the contex of the PL/SQL language
    // while it can be an identifier(column name, table name) in SQL
    // "exception" is a keyword if and only it is followed by "when"
    {
    $e.setType(SQL92_RESERVED_EXCEPTION);
    emit($e);
    advanceInput();

    $type = Token.INVALID_TOKEN_TYPE;
    int markModel = input.mark();

    // Now loop over next Tokens in the input and eventually set Token's type to REGULAR_ID

    // Subclassed version will return NULL unless EOF is reached.
    // nextToken either returns NULL => then the next token is put into the queue tokenBuffer
    // or it returns Token.EOF, then nothing is put into the queue
    Token t1 = super.nextToken();
    {    // This "if" handles the situation when the "model" is the last text in the input.
        if( t1 != null && t1.getType() == Token.EOF)
        {
             $e.setType(REGULAR_ID);
        } else {
             t1 = tokenBuffer.pollLast(); // "withdraw" the next token from the queue
             while(true)
             {
                 if(t1.getType() == EOF)   // is it EOF?
                 {
                     $e.setType(REGULAR_ID);
                     break;
                 }

                 if(t1.getChannel() == HIDDEN) // is it a white space? then advance to the next token
                 {
                     t1 = super.nextToken(); if( t1 == null) { t1 = tokenBuffer.pollLast(); };
                     continue;
                 }

                 if( t1.getType() != SQL92_RESERVED_WHEN && t1.getType() != SEMICOLON) // is something other than "when"
                 {
                     $e.setType(REGULAR_ID);
                     break;
                 }

                 break; // we are in the model_clase do not rewrite anything
              } // while true
         } // else if( t1 != null && t1.getType() == Token.EOF)
    }
    input.rewind(markModel);
    }
    ;

PLSQL_RESERVED_EXCLUSIVE
    :    'exclusive'
    ;

SQL92_RESERVED_EXISTS
    :    'exists'
    ;

SQL92_RESERVED_FALSE
    :    'false'
    ;

SQL92_RESERVED_FETCH
    :    'fetch'
    ;

SQL92_RESERVED_FOR
    :    'for'
    ;

SQL92_RESERVED_FROM
    :    'from'
    ;

SQL92_RESERVED_GOTO
    :    'goto'
    ;

SQL92_RESERVED_GRANT
    :    'grant'
    ;

SQL92_RESERVED_GROUP
    :    'group'
    ;

SQL92_RESERVED_HAVING
    :    'having'
    ;

PLSQL_RESERVED_IDENTIFIED
    :    'identified'
    ;

PLSQL_RESERVED_IF
    :    'if'
    ;

SQL92_RESERVED_IN
    :    'in'
    ;

PLSQL_RESERVED_INDEX
    :    'index'
    ;

PLSQL_RESERVED_INDEXES
    :    'indexes'
    ;

SQL92_RESERVED_INSERT
    :    'insert'
    ;

SQL92_RESERVED_INTERSECT
    :    'intersect'
    ;

SQL92_RESERVED_INTO
    :    'into'
    ;

SQL92_RESERVED_IS
    :    'is'
    ;

SQL92_RESERVED_LIKE
    :    'like'
    ;

PLSQL_RESERVED_LOCK
    :    'lock'
    ;

PLSQL_RESERVED_MINUS
    :    'minus'
    ;

PLSQL_RESERVED_MODE
    :    'mode'
    ;

PLSQL_RESERVED_NOCOMPRESS
    :    'nocompress'
    ;

SQL92_RESERVED_NOT
    :    'not'
    ;

PLSQL_RESERVED_NOWAIT
    :    'nowait'
    ;

SQL92_RESERVED_NULL
    :    'null'
    ;

SQL92_RESERVED_OF
    :    'of'
    ;

SQL92_RESERVED_ON
    :    'on'
    ;

SQL92_RESERVED_OPTION
    :    'option'
    ;

SQL92_RESERVED_OR
    :    'or'
    ;

SQL92_RESERVED_ORDER
    :    'order'
    ;

SQL92_RESERVED_OVERLAPS
    :    'overlaps'
    ;

SQL92_RESERVED_PRIOR
    :    'prior'
    ;

SQL92_RESERVED_PROCEDURE
    :    'procedure'
    ;

SQL92_RESERVED_PUBLIC
    :    'public'
    ;

PLSQL_RESERVED_RESOURCE
    :    'resource'
    ;

SQL92_RESERVED_REVOKE
    :    'revoke'
    ;

SQL92_RESERVED_SELECT
    :    'select'
    ;

PLSQL_RESERVED_SHARE
    :    'share'
    ;

SQL92_RESERVED_SIZE
    :    'size'
    ;

// SQL92_RESERVED_SQL
//     :    'sql'
//     ;

PLSQL_RESERVED_START
    :    'start'
    ;

PLSQL_RESERVED_TABAUTH
    :    'tabauth'
    ;

SQL92_RESERVED_TABLE
    :    'table'
    ;

SQL92_RESERVED_THE
    :    'the'
    ;

SQL92_RESERVED_THEN
    :    'then'
    ;

SQL92_RESERVED_TO
    :    'to'
    ;

SQL92_RESERVED_TRUE
    :    'true'
    ;

SQL92_RESERVED_UNION
    :    'union'
    ;

SQL92_RESERVED_UNIQUE
    :    'unique'
    ;

SQL92_RESERVED_UPDATE
    :    'update'
    ;

SQL92_RESERVED_VALUES
    :    'values'
    ;

SQL92_RESERVED_VIEW
    :    'view'
    ;

PLSQL_RESERVED_VIEWS
    :    'views'
    ;

SQL92_RESERVED_WHEN
    :    'when'
    ;

SQL92_RESERVED_WHERE
    :    'where'
    ;

SQL92_RESERVED_WITH
    :    'with'
    ;

PLSQL_NON_RESERVED_USING
    :    'using'
    ;

PLSQL_NON_RESERVED_MODEL
    :    m='model'
    {
         // "model" is a keyword if and only if it is followed by ("main"|"partition"|"dimension")
         // otherwise it is a identifier(REGULAR_ID).
         // This wodoo implements something like context sensitive lexer.
         // Here we've matched the word "model". Then the Token is created and en-queued in tokenBuffer
         // We still remember the reference($m) onto this Token
         $m.setType(PLSQL_NON_RESERVED_MODEL);
         emit($m);
         advanceInput();

         $type = Token.INVALID_TOKEN_TYPE;
         int markModel = input.mark();

         // Now loop over next Tokens in the input and eventually set Token's type to REGULAR_ID

         // Subclassed version will return NULL unless EOF is reached.
         // nextToken either returns NULL => then the next token is put into the queue tokenBuffer
         // or it returns Token.EOF, then nothing is put into the queue
         Token t1 = super.nextToken();
         {    // This "if" handles the situation when the "model" is the last text in the input.
              if( t1 != null && t1.getType() == Token.EOF)
              {
                  $m.setType(REGULAR_ID);
              } else {
                  t1 = tokenBuffer.pollLast(); // "withdraw" the next token from the queue
                  while(true)
                  {
                     if(t1.getType() == EOF)   // is it EOF?
                     {
                         $m.setType(REGULAR_ID);
                         break;
                     }

                     if(t1.getChannel() == HIDDEN) // is it a white space? then advance to the next token
                     {
                         t1 = super.nextToken(); if( t1 == null) { t1 = tokenBuffer.pollLast(); };
                         continue;
                     }

                     if( t1.getType() != REGULAR_ID || // is something other than ("main"|"partition"|"dimension")
                        ( !t1.getText().equalsIgnoreCase("main") &&
                          !t1.getText().equalsIgnoreCase("partition") &&
                          !t1.getText().equalsIgnoreCase("dimension")
                       ))
                     {
                         $m.setType(REGULAR_ID);
                         break;
                     }

                     break; // we are in the model_clase do not rewrite anything
                  } // while true
              } // else if( t1 != null && t1.getType() == Token.EOF)
         }
         input.rewind(markModel);
    }
    ;

PLSQL_NON_RESERVED_ELSIF
    :    'elsif'
    ;

PLSQL_NON_RESERVED_PIVOT
    :    'pivot'
    ;

PLSQL_NON_RESERVED_UNPIVOT
    :    'unpivot'
    ;

REGULAR_ID
    :    (SIMPLE_LETTER) (SIMPLE_LETTER | '$' | '_' | '#' | '0'..'9')*
    ;

ZV
    :    '@!' {$channel=HIDDEN;}
    ;

// disambiguate these
