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
tree grammar PLSQLWalker;

options {
	tokenVocab=PLSQLParser;
	ASTLabelType=CommonTree;
}

import PLSQLCommonsWalker, PLSQL_DMLWalker;

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

}

compilation_unit
	:	^(COMPILATION_UNIT unit_statement*)
	;

sql_script
	:	^(SQL_SCRIPT serveroutput_declaration? seq_of_statements)
	;

serveroutput_declaration
	:	^(SET_SERVEROUTPUT (SQL92_RESERVED_ON|OFF_VK))
	;

unit_statement
	:	alter_function
	|	alter_package
	|	alter_procedure
	|	alter_trigger
	|	alter_type
	|	create_function_body
	|	create_procedure_body
	|	create_package
	|	create_trigger
	|	create_type
	|	drop_function
	|	drop_package
	|	drop_procedure
	|	drop_trigger
	|	drop_type
	;

// $<DDL -> SQL Statements for Stored PL/SQL Units

// $<Function DDLs

drop_function
	:	^(DROP_FUNCTION function_name)
	;

alter_function
	:	^(ALTER_FUNCTION function_name DEBUG_VK? REUSE_VK? compiler_parameters_clause*)
	;

create_function_body
	:	^(CREATE_FUNCTION REPLACE_VK? function_name type_spec ^(PARAMETERS parameter*)
			invoker_rights_clause* parallel_enable_clause* result_cache_clause* DETERMINISTIC_VK*
			(	^(USING_MODE PIPELINED_VK? AGGREGATE_VK? implementation_type_name)
			|	^(CALL_MODE PIPELINED_VK? call_spec)
			|	^(BODY_MODE PIPELINED_VK? declare_spec* body)
			)
		)
	;

// $<Creation Function - Specific Clauses

parallel_enable_clause
	:	^(PARALLEL_ENABLE_VK partition_by_clause?)
	;

partition_by_clause
	:	^(PARTITION_VK expression 
			(	SQL92_RESERVED_ANY
			|	^(HASH_VK ^(COLUMNS column_name+))
			|	^(RANGE_VK ^(COLUMNS column_name+))
			) 
			streaming_clause?
		)
	;

result_cache_clause
	:	^(RESULT_CACHE_VK relies_on_part?)
	;

relies_on_part
	:	^(RELIES_ON_VK tableview_name+)
	;

streaming_clause
	:	^(STREAMING_CLAUSE (SQL92_RESERVED_ORDER|CLUSTER_VK) expression ^(COLUMNS column_name+)) 
	;
// $>
// $>

// $<Package DDLs

drop_package
	:	^(DROP_PACKAGE package_name BODY_VK?)
	;

alter_package
	:	^(ALTER_PACKAGE package_name DEBUG_VK? REUSE_VK? 
				(PACKAGE_VK|BODY_VK|SPECIFICATION_VK)? compiler_parameters_clause*)
	;

create_package
	:	^(CREATE_PACKAGE_SPEC REPLACE_VK? package_name+ invoker_rights_clause? package_obj_spec*) 
	|	^(CREATE_PACKAGE_BODY REPLACE_VK? package_name+ package_obj_body* seq_of_statements?)
	;

// $<Create Package - Specific Clauses

package_obj_spec
	:	variable_declaration
	| 	subtype_declaration
	| 	cursor_declaration
	| 	exception_declaration
	| 	record_declaration
	| 	table_declaration
	| 	procedure_spec
	| 	function_spec
	;

procedure_spec
	: 	^(PROCEDURE_SPEC procedure_name ^(PARAMETERS parameter*)
			(^(CALL_MODE call_spec))?
	) 
	;

function_spec
	:	^(FUNCTION_SPEC function_name (type_spec|SELF_VK) ^(PARAMETERS parameter*)
			(	^(CALL_MODE call_spec)
			|	^(EXTERNAL_VK expression)
			)?
		)
	;

package_obj_body
	: 	variable_declaration 
	| 	subtype_declaration 
	| 	cursor_declaration 
	| 	exception_declaration 
	| 	record_declaration
	| 	table_declaration
	| 	create_procedure_body
	| 	create_function_body 
	;

// $>

// $>

// $<Procedure DDLs

drop_procedure
	:	^(DROP_PROCEDURE procedure_name)
	;

alter_procedure
	:	^(ALTER_PROCEDURE procedure_name DEBUG_VK? REUSE_VK? compiler_parameters_clause*)
	;

create_procedure_body
	:	^(CREATE_PROCEDURE REPLACE_VK? procedure_name ^(PARAMETERS parameter*) invoker_rights_clause?
			(	EXTERNAL_VK
			|	^(CALL_MODE call_spec)
			|	^(BODY_MODE declare_spec* body)
			)
		)
	;

// $>

// $<Trigger DDLs

drop_trigger
	:	^(DROP_TRIGGER trigger_name)
	;

alter_trigger
	:	^(ALTER_TRIGGER trigger_name 
			(	(ENABLE_VK|DISABLE_VK)
			|	^(RENAME_VK trigger_name)
			|	DEBUG_VK? REUSE_VK? compiler_parameters_clause*
			)
		)
	;

create_trigger
	:	^(CREATE_TRIGGER REPLACE_VK? trigger_name  
			simple_dml_trigger? compound_dml_trigger? non_dml_trigger?
			trigger_follows_clause? (ENABLE_VK|DISABLE_VK)? trigger_when_clause? trigger_body)
	;

trigger_follows_clause
	:	^(FOLLOWS_VK trigger_name+)
	;

trigger_when_clause
	:	^(SQL92_RESERVED_WHEN expression)
	;

// $<Create Trigger- Specific Clauses
simple_dml_trigger
	:	^(SIMPLE_DML (BEFORE_VK|AFTER_VK|INSTEAD_VK) FOR_EACH_ROW? referencing_clause? dml_event_clause)
	;

compound_dml_trigger
	:	^(COMPOUND_DML referencing_clause? dml_event_clause)
	;

non_dml_trigger
	:	^(NON_DML (BEFORE_VK|AFTER_VK) non_dml_event+ (DATABASE_VK|schema_name? SCHEMA_VK))
	;

trigger_body
	:	^(COMPOUND_VK trigger_name declare_spec* timing_point_section+)
	|	^(CALL_VK routine_name function_argument?) 
	|	^(BODY_MODE block)
	;

timing_point_section
	:	^(BEFORE_STATEMENT block)
	|	^(BEFORE_EACH_ROW block)
	|	^(AFTER_STATEMENT block)
	|	^(AFTER_EACH_ROW block)
	;

non_dml_event
	:	SQL92_RESERVED_ALTER
	|	ANALYZE_VK
	|	ASSOCIATE_VK STATISTICS_VK
	|	AUDIT_VK
	|	COMMENT_VK
	|	SQL92_RESERVED_CREATE
	|	DISASSOCIATE_VK STATISTICS_VK
	|	SQL92_RESERVED_DROP
	|	SQL92_RESERVED_GRANT
	|	NOAUDIT_VK
	|	RENAME_VK
	|	SQL92_RESERVED_REVOKE
	|	TRUNCATE_VK
	|	DDL_VK
	|	STARTUP_VK
	|	SHUTDOWN_VK
	|	DB_ROLE_CHANGE_VK
	|	LOGON_VK
	|	LOGOFF_VK
	|	SERVERERROR_VK
	|	SUSPEND_VK
	|	DATABASE_VK
	|	SCHEMA_VK
	|	FOLLOWS_VK
	;

dml_event_clause
	:	^(DML_EVENT dml_event_element+ ^(SQL92_RESERVED_ON tableview_name dml_event_nested_clause?))  
	;

dml_event_element
	:	^(DML_EVENT_ELEMENT (SQL92_RESERVED_DELETE|SQL92_RESERVED_INSERT|SQL92_RESERVED_UPDATE) ^(COLUMNS column_name*))
	;

dml_event_nested_clause
	:	^(NESTED_VK tableview_name)
	;

referencing_clause
	:	^(REFERENCING_VK referencing_element+)
	;

referencing_element
	:	^((NEW_VK|OLD_VK|PARENT_VK) alias)
	;

// $>
// $>

// $<Type DDLs

drop_type
	:	^(DROP_TYPE type_name BODY_VK? FORCE_VK? VALIDATE_VK?)
	;

alter_type
	:	^(ALTER_TYPE type_name 
			(	^(REPLACE_VK ^(OBJECT_MEMBERS element_spec+) invoker_rights_clause?)
			|	^(ALTER_ATTRIBUTE (ADD_VK|MODIFY_VK|SQL92_RESERVED_DROP) ^(ATTRIBUTES attribute_definition+))
			|	^(ALTER_METHOD alter_method_element+)
			|	alter_collection_clauses
			|	modifier_clause
			|	^(COMPILE_VK (SPECIFICATION_VK|BODY_VK)? DEBUG_VK? REUSE_VK? compiler_parameters_clause*)
			) 
			dependent_handling_clause?
		)
	;

// $<Alter Type - Specific Clauses

alter_method_element
	:	^(ALTER_METHOD_ELEMENT (ADD_VK|SQL92_RESERVED_DROP) map_order_function_spec? subprogram_spec?)
	;

attribute_definition
	:	^(ATTRIBUTE attribute_name type_spec?)
	;

alter_collection_clauses
	:	^(ALTER_COLLECTION 
			(	^(TYPE_VK type_spec)
			|	^(LIMIT_VK expression)
			)
		) 
	;

dependent_handling_clause
	:	^(DEPENDENT_HANDLING 
			(	INVALIDATE_VK
			|	^(CASCADE_VK 
					(	CONVERT_VK
					|	SQL92_RESERVED_NOT? INCLUDING_VK
					)?
				)
			)
		)
	;

dependent_exceptions_part
	:	^(EXCEPTIONS_VK FORCE_VK? tableview_name)
	;

// $>

create_type
	:	^(CREATE_TYPE_BODY REPLACE_VK? type_name ^(TYPE_BODY_ELEMENTS type_body_elements+))
	|	^(CREATE_TYPE_SPEC REPLACE_VK? type_name CHAR_STRING? object_type_def?)
	;

object_type_def
	:	^(OBJECT_TYPE_DEF (object_as_part|object_under_part) invoker_rights_clause?
			 sqlj_object_type? modifier_clause* ^(OBJECT_MEMBERS element_spec*))  
	;

object_as_part
	:	^(OBJECT_AS (OBJECT_VK|varray_type_def|nested_table_type_def))
	;

object_under_part
	:	^(UNDER_VK type_spec)
	;

nested_table_type_def
	:	^(NESTED_TABLE_TYPE_DEF type_spec SQL92_RESERVED_NULL?) 
	;

sqlj_object_type
	:	^(JAVA_VK expression (SQLDATA_VK|CUSTOMDATUM_VK|ORADATA_VK))
	;

type_body_elements
	:	map_order_func_declaration
	|	subprog_decl_in_type
	;

map_order_func_declaration
	:	^((MAP_VK|SQL92_RESERVED_ORDER) create_function_body)
	;

subprog_decl_in_type
	:	^((MEMBER_VK|STATIC_VK)
			(	create_procedure_body
			|	create_function_body
			|	constructor_declaration
			)
		)
	;

constructor_declaration
	:	^(CONSTRUCTOR_VK type_spec FINAL_VK? INSTANTIABLE_VK? ^(PARAMETERS type_elements_parameter*) 
			(	^(CALL_MODE call_spec)
			|	^(BODY_MODE declare_spec* body)
			)
		)
	;

// $>

// $<Common Type Clauses

modifier_clause
	:	^(MODIFIER SQL92_RESERVED_NOT? (INSTANTIABLE_VK|FINAL_VK|OVERRIDING_VK))
	;

sqlj_object_type_attr
	:	^(EXTERNAL_VK expression)
	;

element_spec
	:	^(ELEMENT_SPEC element_spec_options+ modifier_clause? pragma_clause?)
	;

element_spec_options
	:	subprogram_spec
	|	constructor_spec
	|	map_order_function_spec
	|	^(FIELD_SPEC id type_spec sqlj_object_type_attr?)
	;

subprogram_spec
	:	^((MEMBER_VK|STATIC_VK)
			(	procedure_spec
			|	function_spec
			)
		)
	;

constructor_spec
	:	^(CONSTRUCTOR_SPEC type_spec FINAL_VK? INSTANTIABLE_VK? ^(PARAMETERS type_elements_parameter*) constructor_call_mode?)
	;

constructor_call_mode
	:	^(CALL_MODE call_spec)
	;

map_order_function_spec
	:	^((MAP_VK|SQL92_RESERVED_ORDER) function_spec)
	;

pragma_clause
	:	^(PRAGMA_VK pragma_elements+)
	;

pragma_elements
	:	id
	|	SQL92_RESERVED_DEFAULT
	;

type_elements_parameter
	:	^(PARAMETER parameter_name type_spec)
	;

// $>
// $>

// $<Common DDL Clauses

invoker_rights_clause
	:	^(AUTHID_VK (CURRENT_USER_VK|DEFINER_VK))
	;

compiler_parameters_clause
	:	^(COMPILER_PARAMETER ^(ASSIGN id expression))
	;

call_spec
	:	^(LANGUAGE_VK ( java_spec | c_spec ))
	;

// $<Call Spec - Specific Clauses

java_spec
	:	^(JAVA_VK CHAR_STRING)
	;

c_spec
	:	^(C_VK CHAR_STRING? CONTEXT_VK? ^(LIBRARY_VK id) c_agent_in_clause? c_parameters_clause?)
	;

c_agent_in_clause
	:	^(AGENT_VK expression+)
	;

c_parameters_clause
	:	^(PARAMETERS_VK (THREE_DOTS|expression+))
	;

// $>

parameter
	:	^(PARAMETER parameter_name (SQL92_RESERVED_IN|OUT_VK|INOUT_VK)* type_spec? default_value_part?)
	;

default_value_part
	:	^(DEFAULT_VALUE expression)
	;

// $>

// $>

// $<PL/SQL Elements Declarations

declare_spec
	:	variable_declaration
	| 	subtype_declaration
	| 	cursor_declaration
	| 	exception_declaration
	| 	pragma_declaration
	| 	record_declaration
	| 	table_declaration
	| 	create_procedure_body
	| 	create_function_body
	;

//incorporates constant_declaration
variable_declaration
	:	^(VARIABLE_DECLARE variable_name type_spec CONSTANT_VK? SQL92_RESERVED_NULL? default_value_part?)
	;	

subtype_declaration
  	:	^(SUBTYPE_DECLARE type_name type_spec SQL92_RESERVED_NULL? subtype_range?)
  	;

subtype_range
	:	^(RANGE_VK expression+)
	;

//cursor_declaration incorportates curscursor_body and cursor_spec
cursor_declaration
	:	^(CURSOR_DECLARE cursor_name type_spec? select_statement? ^(PARAMETERS parameter_spec*)) 
	;

parameter_spec
	:	^(PARAMETER parameter_name type_spec? default_value_part?)
	;

exception_declaration 
	:	^(EXCEPTION_DECLARE exception_name)
	;      	   

pragma_declaration
	:	^(PRAGMA_DECLARE 
			(	SERIALLY_REUSABLE_VK
			|	 AUTONOMOUS_TRANSACTION_VK
			|	^(EXCEPTION_INIT_VK exception_name constant)
			|	^(INLINE_VK id expression)
			|	^(RESTRICT_REFERENCES_VK SQL92_RESERVED_DEFAULT? id*)
			)
		)
	;

record_declaration
	:	record_type_dec
	|	record_var_dec
	;

// $<Record Declaration - Specific Clauses

//incorporates ref_cursor_type_definition
record_type_dec
	:	^(RECORD_TYPE_DECLARE type_name REF_VK? type_spec? ^(FIELDS field_spec*))
	;

field_spec
	:	^(FIELD_SPEC column_name type_spec? SQL92_RESERVED_NULL? default_value_part?)
	;

record_var_dec
	:	^(RECORD_VAR_DECLARE record_name type_name (PERCENT_ROWTYPE_VK|PERCENT_TYPE_VK))
	;

// $>

table_declaration
	:	table_type_dec
	|	table_var_dec
	;

table_type_dec
	:	^(TABLE_TYPE_DECLARE type_name 
			(	varray_type_def
			|	SQL92_RESERVED_NULL? ^(SQL92_RESERVED_TABLE type_spec table_indexed_by_part?)
			)
		)
	;

table_indexed_by_part
	:	^(INDEXED_BY type_spec)
	;

varray_type_def
	:	SQL92_RESERVED_NULL? ^(VARR_ARRAY_DEF expression type_spec)
	;

table_var_dec
	:	^(TABLE_VAR_DECLARE table_var_name type_spec)
	;

// $>

// $<PL/SQL Statements

seq_of_statements
	: 	^(STATEMENTS statement+)
	;

statement
	:	label_declaration
	|	assignment_statement
	|	continue_statement
	|	exit_statement
	|	goto_statement
	|	if_statement
	|	loop_statement
	|	forall_statement
	|	null_statement
	|	raise_statement
	|	return_statement
	|	case_statement
	|	sql_statement
	|	function_call
	|	body
	|	block
	;

label_declaration
	:	^(LABEL_DECLARE label_name)
	;

assignment_statement
	: 	^(ASSIGN general_element expression)
	;

continue_statement
	:	^(CONTINUE_VK label_name? general_when?)
	;

general_when
	:	^(SQL92_RESERVED_WHEN expression)
	;

exit_statement
	:	^(EXIT_VK label_name? general_when?)
	;

goto_statement
	:	^(SQL92_RESERVED_GOTO label_name)
	;

if_statement
	:	^(PLSQL_RESERVED_IF expression seq_of_statements elsif_part* else_part?)
	;

elsif_part
	:	^(PLSQL_NON_RESERVED_ELSIF expression seq_of_statements)
	;

else_part
	:	^(SQL92_RESERVED_ELSE seq_of_statements)
	;

loop_statement
	:	^(WHILE_LOOP label_name* expression seq_of_statements)
	|	^(FOR_LOOP label_name* cursor_loop_param seq_of_statements)
	|	^(LOOP_VK label_name* seq_of_statements)
	;

// $<Loop - Specific Clause

cursor_loop_param
	:	^(INDEXED_FOR index_name REVERSE_VK? ^(SIMPLE_BOUND expression expression))
	|	^(CURSOR_BASED_FOR record_name cursor_name expression_list?)
	|	^(SELECT_BASED_FOR record_name select_statement)
	;

// $>

forall_statement
	:	^(FORALL_VK index_name bounds_clause sql_statement EXCEPTIONS_VK?)
	;

bounds_clause
	:	^(SIMPLE_BOUND expression expression)
	|	^(INDICES_BOUND collection_name between_bound?)
	|	^(VALUES_BOUND index_name) 
	;

between_bound
	:	^(SQL92_RESERVED_BETWEEN expression expression)
	;

null_statement
	:	SQL92_RESERVED_NULL
	;

raise_statement
	:	^(RAISE_VK exception_name?)
	;

return_statement
	:	^(RETURN_VK expression?)
	;

function_call
	:	^(ROUTINE_CALL routine_name function_argument?)
	;

body
	:	^(BODY label_name? seq_of_statements exception_clause?) 
	;

// $<Body - Specific Clause

exception_clause
	:	^(SQL92_RESERVED_EXCEPTION exception_handler+)
	;

exception_handler
	:	^(SQL92_RESERVED_WHEN exception_name+ seq_of_statements)
	;

// $>

block
	:	^(BLOCK declare_spec* body)
	;

// $>

// $<SQL PL/SQL Statements

sql_statement
	:	execute_immediate
	|	data_manipulation_language_statements
	|	cursor_manipulation_statements
	|	transaction_control_statements
	;

execute_immediate
	:	^(EXECUTE_VK expression (into_clause|using_clause|dynamic_returning_clause)?) 
	;

// $<Execute Immediate - Specific Clause
dynamic_returning_clause
	:	^(DYNAMIC_RETURN into_clause)
	;
// $>


// $<DML SQL PL/SQL Statements

data_manipulation_language_statements
	:	merge_statement
	|	lock_table_statement
	|	select_statement
	| 	update_statement
	| 	delete_statement
	|	insert_statement
	;

// $>

// $<Cursor Manipulation SQL PL/SQL Statements

cursor_manipulation_statements
	:	close_statement
	|	open_statement
	|	fetch_statement
	|	open_for_statement
	;

close_statement
	: 	^(CLOSE_VK variable_name) 
	;

open_statement
	:	^(OPEN_VK cursor_name expression_list?)
	;

fetch_statement
	:	^(SQL92_RESERVED_FETCH cursor_name 
			(	^(SQL92_RESERVED_INTO variable_name+)
			|	^(BULK_VK variable_name+)
			)
		)
	;

open_for_statement
	:	^(OPEN_VK variable_name (expression|select_statement) using_clause?)
	;

// $>

// $<Transaction Control SQL PL/SQL Statements

transaction_control_statements
	:	set_transaction_command
	|	set_constraint_command
	|	commit_statement
	|	rollback_statement
	|	savepoint_statement
	;

set_transaction_command
	:	^(SET_TRANSACTION CHAR_STRING?
			(	^(READ_VK (ONLY_VK|WRITE_VK))
			|	^(ISOLATION_VK (SERIALIZABLE_VK|COMMITTED_VK))
			|	^(ROLLBACK_VK rollback_segment_name)
			)?
		)
	;

set_constraint_command
	:	^(SET_CONSTRAINT (SQL92_RESERVED_ALL|constraint_name+) (IMMEDIATE_VK|DEFERRED_VK))
	;

commit_statement
	: 	^(COMMIT_VK WORK_VK? 
			(	^(COMMENT_VK expression)
			|	^(FORCE_VK (CORRUPT_XID_VK expression|CORRUPT_XID_ALL_VK|expression expression?))
			)?
			write_clause?
		)
	;

write_clause
	:	^(WRITE_VK (WAIT_VK|PLSQL_RESERVED_NOWAIT)? (IMMEDIATE_VK|BATCH_VK)?)
	;

rollback_statement
	: 	^(ROLLBACK_VK WORK_VK? 
			(	^(SQL92_RESERVED_TO savepoint_name)
			|	^(FORCE_VK CHAR_STRING)
			)?
		)
	;

savepoint_statement
	:	^(SAVEPOINT_VK savepoint_name) 
	;

// $>

id
	:	char_set_name? ID
	;

