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
parser grammar PLSQLCommons_NoAST;

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
	:	( subpartition_key | partition_key ) 
		for_key? expression_list
	;

alias
	:	as_key? (id|alias_quoted_string)
	;

alias_quoted_string
	:	quoted_string
	;

where_clause
	:	where_key condition_wrapper
	;

into_clause
	:	into_key variable_name (COMMA variable_name)* 
	|	bulk_key collect_key into_key variable_name (COMMA variable_name)* 
	;

// $>

// $<Common PL/SQL Named Elements

xml_column_name
	:	id
	|	quoted_string
	;

cost_class_name
	:	id
	;

attribute_name
	:	id
	;

savepoint_name
	:	id
	;

rollback_segment_name
	:	id
	;


table_var_name
	:	id
	;

schema_name
	:	id
	;

routine_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)* (AT_SIGN link_name)?
	;

package_name
	:	id
	;

implementation_type_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)?
	;

parameter_name
	:	id
	;

reference_model_name
	:	id
	;

main_model_name
	:	id
	;

aggregate_function_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)*
	;

query_name
	:	id
	;

constraint_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)* (AT_SIGN link_name)?
	;

label_name
	:	id_expression
	;

type_name
	:	id_expression ((PERIOD id_expression)=> PERIOD id_expression)*
	;

exception_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)* 
	;

function_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)?
	;

procedure_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)?
	;

trigger_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)?
	;

variable_name
	:	COLON? (INTRODUCER char_set_name)?
			id_expression (((PERIOD|COLON) id_expression)=> (PERIOD|COLON) id_expression)?
	;

index_name
	:	id
	;

cursor_name
	:	id
	;

record_name
	:	id
	;

collection_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)?
	;

link_name
	:	id
	;

column_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)*
	;

tableview_name
	:	id ((PERIOD id_expression)=> PERIOD id_expression)? 
	(	AT_SIGN link_name
	|	{!(input.LA(2) == SQL92_RESERVED_BY)}?=> partition_extension_clause
	)?
	;

char_set_name
	:	id_expression ((PERIOD id_expression)=> PERIOD id_expression)*
	;

// $>

// $<Common PL/SQL Specs

function_argument
	:	LEFT_PAREN 
			argument? (COMMA argument )* 
		RIGHT_PAREN
	;

argument
	:	((id EQUALS_OP GREATER_THAN_OP)=> id EQUALS_OP GREATER_THAN_OP)? expression_wrapper
	;

type_spec
	: 	datatype
	|	ref_key? type_name (percent_rowtype_key|percent_type_key)?
	;

datatype
	:	native_datatype_element
		precision_part?
		(with_key local_key? time_key zone_key)?
	|	interval_key (year_key|day_key)
				(LEFT_PAREN expression_wrapper RIGHT_PAREN)? 
			to_key (month_key|second_key) 
				(LEFT_PAREN expression_wrapper RIGHT_PAREN)?
	;

precision_part
	:	LEFT_PAREN numeric (COMMA numeric)? (char_key | byte_key)? RIGHT_PAREN
	;

native_datatype_element
	:	binary_integer_key
	|	pls_integer_key
	|	natural_key
	|	binary_float_key
	|	binary_double_key
	|	naturaln_key
	|	positive_key
	|	positiven_key
	|	signtype_key
	|	simple_integer_key
	|	nvarchar2_key
	|	dec_key
	|	integer_key
	|	int_key
	|	numeric_key
	|	smallint_key
	|	number_key
	|	decimal_key 
	|	double_key precision_key?
	|	float_key
	|	real_key
	|	nchar_key
	|	long_key raw_key?
	|	char_key  
	|	character_key 
	|	varchar2_key
	|	varchar_key
	|	string_key
	|	raw_key
	|	boolean_key
	|	date_key
	|	rowid_key
	|	urowid_key
	|	year_key
	|	month_key
	|	day_key
	|	hour_key
	|	minute_key
	|	second_key
	|	timezone_hour_key
	|	timezone_minute_key
	|	timezone_region_key
	|	timezone_abbr_key
	|	timestamp_key
	|	timestamp_unconstrained_key
	|	timestamp_tz_unconstrained_key
	|	timestamp_ltz_unconstrained_key
	|	yminterval_unconstrained_key
	|	dsinterval_unconstrained_key
	|	bfile_key
	|	blob_key
	|	clob_key
	|	nclob_key
	|	mlslabel_key
	;

general_element
	:	general_element_part (((PERIOD|COLON) general_element_part)=> (PERIOD|COLON) general_element_part)*
	;

general_element_part
	:	(INTRODUCER char_set_name)? COLON? id_expression 
			(((PERIOD|COLON) id_expression)=> (PERIOD|COLON) id_expression)* function_argument?
	;

// $>

// $<Lexer Mappings

constant
	:	numeric
	|	quoted_string
	|	null_key
	|	true_key
	|	false_key
	|	dbtimezone_key 
	|	sessiontimezone_key
	|	minvalue_key
	|	maxvalue_key
	|	default_key
	;

numeric
	:	UNSIGNED_INTEGER
	|	EXACT_NUM_LIT
	|	APPROXIMATE_NUM_LIT;

quoted_string
	:	CHAR_STRING
	;

id
	:	(INTRODUCER char_set_name)?
		id_expression
	;

id_expression
	:	REGULAR_ID
	|	DELIMITED_ID
	;
// $>
