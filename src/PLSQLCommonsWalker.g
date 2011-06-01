/*
 * Oracle(c) PL/SQL 11g Parser  
 *
 * Copyright (c) 2009, Alexandre Porcelli
 * 
 * This copyrighted material is made available to anyone wishing to use, modify, 
 * copy, or redistribute it subject to the terms and conditions of the GNU 
 * Lesser General Public License, as published by the Free Software Foundation. 
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * See the GNU Lesser General Public License  for more details. 
 * 
 * You should have received a copy of the GNU Lesser General Public License 
 * along with this distribution; if not, write to: 
 * Free Software Foundation, Inc. 
 * 51 Franklin Street, Fifth Floor 
 * Boston, MA  02110-1301  USA 
 * 
 */
tree grammar PLSQLCommonsWalker;

@header {
/*
 * Oracle(c) PL/SQL 11g Parser  
 *
 * Copyright (c) 2009, Alexandre Porcelli
 * 
 * This copyrighted material is made available to anyone wishing to use, modify, 
 * copy, or redistribute it subject to the terms and conditions of the GNU 
 * Lesser General Public License, as published by the Free Software Foundation. 
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * See the GNU Lesser General Public License  for more details. 
 * 
 * You should have received a copy of the GNU Lesser General Public License 
 * along with this distribution; if not, write to: 
 * Free Software Foundation, Inc. 
 * 51 Franklin Street, Fifth Floor 
 * Boston, MA  02110-1301  USA 
 * 
 */
}

// $<Common SQL PL/SQL Clauses/Parts

partition_extension_clause
	:	^((SUBPARTITION_VK|PARTITION_VK) expression_list)
	;

alias
	:	^(ALIAS char_set_name? ID)
	;

where_clause
	:	^(SQL92_RESERVED_WHERE expression)
	;

into_clause
	:	^(SQL92_RESERVED_INTO variable_name+) 
	|	^(BULK_VK variable_name+) 
	;

// $>

// $<Common PL/SQL Named Elements

xml_column_name
	:	^(XML_COLUMN_NAME char_set_name? ID)
	;

cost_class_name
	:	^(COST_CLASS_NAME char_set_name? ID)
	;

attribute_name
	:	^(ATTRIBUTE_NAME char_set_name? ID)
	;

savepoint_name
	:	^(SAVEPOINT_NAME char_set_name? ID)
	;

rollback_segment_name
	:	^(ROLLBACK_SEGMENT_NAME char_set_name? ID)
	;


table_var_name
	:	^(TABLE_VAR_NAME char_set_name? ID)
	;

schema_name
	:	^(SCHEMA_NAME char_set_name? ID)
	;

routine_name
	:	^(ROUTINE_NAME char_set_name? ID+ link_name?)
	;

package_name
	:	^(PACKAGE_NAME char_set_name? ID)
	;

implementation_type_name
	:	^(IMPLEMENTATION_TYPE_NAME char_set_name? ID+)
	;

parameter_name
	:	^(PARAMETER_NAME char_set_name? ID)
	;

reference_model_name
	:	^(REFERENCE_MODEL_NAME char_set_name? ID)
	;

main_model_name
	:	^(MAIN_MODEL_NAME char_set_name? ID)
	;

query_name
	:	^(QUERY_NAME char_set_name? ID)
	;

constraint_name
	:	^(CONSTRAINT_NAME char_set_name? ID+ link_name?)
	;

label_name
	:	^(LABEL_NAME ID)
	;

type_name
	:	^(TYPE_NAME ID+)
	;

exception_name
	:	^(EXCEPTION_NAME char_set_name? ID+)
	;

function_name
	:	^(FUNCTION_NAME char_set_name? ID+)
	;

procedure_name
	:	^(PROCEDURE_NAME char_set_name? ID+)
	;

trigger_name
	:	^(TRIGGER_NAME char_set_name? ID+)
	;

variable_name
	:	^(HOSTED_VARIABLE_NAME char_set_name? ID+)
	|	^(VARIABLE_NAME char_set_name? ID+)
	;

index_name
	:	^(INDEX_NAME char_set_name? ID)
	;

cursor_name
	:	^(CURSOR_NAME char_set_name? ID)
	;

record_name
	:	^(RECORD_NAME char_set_name? ID)
	;

collection_name
	:	^(COLLECTION_NAME char_set_name? ID+)
	;

link_name
	:	^(LINK_NAME char_set_name? ID)
	;

column_name
	:	^(COLUMN_NAME char_set_name? ID+)
	;

tableview_name
	:	^(TABLEVIEW_NAME char_set_name? ID+ link_name? partition_extension_clause?)
	;

char_set_name
	:	^(CHAR_SET_NAME ID+)
	;

// $>

// $<Common PL/SQL Specs

function_argument
	:	^(ARGUMENTS argument*)
	;

argument
	:	^(ARGUMENT expression parameter_name?)
	;

type_spec
	: 	^(CUSTOM_TYPE type_name REF_VK? (PERCENT_ROWTYPE_VK|PERCENT_TYPE_VK)?)
	|	^(NATIVE_DATATYPE native_datatype_element type_precision? (TIME_VK LOCAL_VK?)?)
	|	^(INTERVAL_DATATYPE (YEAR_VK|DAY_VK) (MONTH_VK|SECOND_VK) expression*)
	;

type_precision
	:	^(PRECISION constant constant? (CHAR_VK|BYTE_VK)? (TIME_VK LOCAL_VK?)?)
	;

native_datatype_element
	:	BINARY_INTEGER_VK
	|	PLS_INTEGER_VK
	|	NATURAL_VK
	|	BINARY_FLOAT_VK
	|	BINARY_DOUBLE_VK
	|	NATURALN_VK
	|	POSITIVE_VK
	|	POSITIVEN_VK
	|	SIGNTYPE_VK
	|	SIMPLE_INTEGER_VK
	|	NVARCHAR2_VK
	|	DEC_VK
	|	INTEGER_VK
	|	INT_VK
	|	NUMERIC_VK
	|	SMALLINT_VK
	|	NUMBER_VK
	|	DECIMAL_VK 
	|	DOUBLE_VK PRECISION_VK?
	|	FLOAT_VK
	|	REAL_VK
	|	NCHAR_VK
	|	LONG_VK RAW_VK?
	|	CHAR_VK  
	|	CHARACTER_VK 
	|	VARCHAR2_VK
	|	VARCHAR_VK
	|	STRING_VK
	|	RAW_VK
	|	BOOLEAN_VK
	|	DATE_VK
	|	ROWID_VK
	|	UROWID_VK
	|	YEAR_VK
	|	MONTH_VK
	|	DAY_VK
	|	HOUR_VK
	|	MINUTE_VK
	|	SECOND_VK
	|	TIMEZONE_HOUR_VK
	|	TIMEZONE_MINUTE_VK
	|	TIMEZONE_REGION_VK
	|	TIMEZONE_ABBR_VK
	|	TIMESTAMP_VK
	|	TIMESTAMP_UNCONSTRAINED_VK
	|	TIMESTAMP_TZ_UNCONSTRAINED_VK
	|	TIMESTAMP_LTZ_UNCONSTRAINED_VK
	|	YMINTERVAL_UNCONSTRAINED_VK
	|	DSINTERVAL_UNCONSTRAINED_VK
	|	BFILE_VK
	|	BLOB_VK
	|	CLOB_VK
	|	NCLOB_VK
	|	MLSLABEL_VK
	;

general_element
	:	^(CASCATED_ELEMENT general_element+)
	|	^(HOSTED_VARIABLE_ROUTINE_CALL routine_name function_argument)
	|	^(HOSTED_VARIABLE char_set_name? ID+)
	|	^(ROUTINE_CALL routine_name function_argument)
	|	^(ANY_ELEMENT char_set_name? ID+)
	;

// $>

// $<Lexer Mappings

constant
	:	UNSIGNED_INTEGER
	|	EXACT_NUM_LIT
	|	APPROXIMATE_NUM_LIT
	|	CHAR_STRING
	|	SQL92_RESERVED_NULL
	|	SQL92_RESERVED_TRUE
	|	SQL92_RESERVED_FALSE
	|	DBTIMEZONE_VK 
	|	SESSIONTIMEZONE_VK
	|	MINVALUE_VK
	|	MAXVALUE_VK
	|	SQL92_RESERVED_DEFAULT
	;

// $>
