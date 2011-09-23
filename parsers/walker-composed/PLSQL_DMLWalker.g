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
tree grammar PLSQL_DMLWalker;

//SHOULD BE OVERRIDEN!
compilation_unit
    :     ^(COMPILATION_UNIT seq_of_statements*)
    ;

//SHOULD BE OVERRIDEN!
seq_of_statements
    :    ^(STATEMENTS statement+)
    ;

//SHOULD BE OVERRIDEN!
statement
    :    select_statement
    |    update_statement
    |    delete_statement
    |    insert_statement
    |    lock_table_statement
    |    merge_statement
    |    case_statement
    ;

select_statement
    :    ^(SELECT_STATEMENT subquery_factoring_clause? subquery for_update_clause* order_by_clause*)  
    ;

// $<Select - Specific Clauses
subquery_factoring_clause
    :    ^(SQL92_RESERVED_WITH factoring_element+)
    ;

factoring_element
    :    ^(FACTORING query_name subquery)
    ;

subquery
    :    ^(SUBQUERY subquery_basic_elements subquery_operation_part*)
    ;

subquery_operation_part
    :    ^((SQL92_RESERVED_UNION|SQL92_RESERVED_INTERSECT|PLSQL_RESERVED_MINUS) SQL92_RESERVED_ALL? subquery_basic_elements)
    ;

subquery_basic_elements
    :    query_block
    |    subquery
    ;

query_block
    :    ^(SQL92_RESERVED_SELECT 
            from_clause 
            (SQL92_RESERVED_DISTINCT|SQL92_RESERVED_UNIQUE)? SQL92_RESERVED_ALL? 
            (    ASTERISK
            |    ^(SELECT_LIST selected_element+)
            )
            into_clause? where_clause? hierarchical_query_clause? 
            group_by_clause? having_clause? model_clause?
        )
    ;

selected_element
    :    ^(SELECT_ITEM expression alias?)
    ;

from_clause
    :    ^(SQL92_RESERVED_FROM table_ref+)
    ;

table_ref
    :    ^(TABLE_REF table_ref_aux join_clause*)
    ;

table_ref_aux
    :    ^(TABLE_REF_ELEMENT alias? dml_table_expression_clause ONLY_VK? pivot_clause? unpivot_clause? flashback_query_clause*)
    ;

join_clause
    :    ^(JOIN_DEF (CROSS_VK|NATURAL_VK)? (INNER_VK|FULL_VK|LEFT_VK|RIGHT_VK)? table_ref_aux query_partition_clause* (join_on_part|join_using_part)?) 
    ;

join_on_part
    :    ^(SQL92_RESERVED_ON expression) 
    ;

join_using_part
    :    ^(PLSQL_NON_RESERVED_USING column_name+)
    ;

query_partition_clause
    :    ^(PARTITION_VK (expression_list|expression+))
    ;

flashback_query_clause
    :    ^((VERSIONS_VK|SQL92_RESERVED_AS) (SCN_VK|TIMESTAMP_VK)? expression) 
    ;

pivot_clause
    :    ^(PIVOT_VK XML_VK? pivot_element+ pivot_for_clause pivot_in_clause)
    ;

pivot_element
    :    ^(PIVOT_ELEMENT alias? expression)
    ;

pivot_for_clause
    :    ^(SQL92_RESERVED_FOR column_name+)
    ;

pivot_in_clause
    :    ^(SQL92_RESERVED_IN 
        (    subquery
        |    ^(ANY_MODE SQL92_RESERVED_ANY+)
        |    ^(ELEMENTS_MODE pivot_in_clause_element+)
        )
        )
    ;

pivot_in_clause_element
    :    ^(PIVOT_IN_ELEMENT alias? (expression|expression_list))
    ;

unpivot_clause
    :    ^(UNPIVOT_VK ((INCLUDE_VK|EXCLUDE_VK) NULLS_VK?)? column_name+ pivot_for_clause unpivot_in_clause)
    ;

unpivot_in_clause
    :    ^(SQL92_RESERVED_IN unpivot_in_element+)
    ;

unpivot_in_element
    :    ^(UNPIVOT_IN_ELEMENT column_name+ ^(PIVOT_ALIAS (expression|expression_list)))
    ;

hierarchical_query_clause
    :    ^(HIERARCHICAL start_part? ^(SQL92_RESERVED_CONNECT NOCYCLE_VK? expression))
    ;

start_part
    :    ^(PLSQL_RESERVED_START expression)
    ;

group_by_clause
    :    ^(SQL92_RESERVED_GROUP group_by_element+)
    ;

group_by_element
    :    ^(GROUP_BY_ELEMENT group_by_elements)
    ;

group_by_elements
    :    ^(GROUPING_VK groupin_set+)
    |    grouping_element 
    ;

groupin_set
    :    ^(GROUPIN_SET grouping_element)
    ;

grouping_element
    :    ^((ROLLUP_VK|CUBE_VK) grouping_element+)
    |    expression_list
    |    expression 
    ;

having_clause
    :    ^(SQL92_RESERVED_HAVING expression)
    ;

model_clause
    :    ^(PLSQL_NON_RESERVED_MODEL main_model cell_reference_options* return_rows_clause? reference_model*)
    ;

cell_reference_options
    :    ^((IGNORE_VK|KEEP_VK) NAV_VK)
    |    ^(SQL92_RESERVED_UNIQUE (DIMENSION_VK|SINGLE_VK))
    ;

return_rows_clause
    :    ^(RETURN_VK (UPDATED_VK|SQL92_RESERVED_ALL))
    ;

reference_model
    :    ^(REFERENCE_VK reference_model_name subquery model_column_clauses cell_reference_options*)
    ;

main_model
    :    ^(MAIN_MODEL main_model_name? model_column_clauses model_rules_clause cell_reference_options*)
    ;

model_column_clauses
    :    ^(MODEL_COLUMN ^(DIMENSION_VK model_column_list) ^(MEASURES_VK model_column_list) model_column_partition_part?)
    ;

model_column_partition_part
    :    ^(PARTITION_VK model_column_list)
    ;

model_column_list
    :    ^(MODEL_COLUMNS model_column+)
    ;

model_column
    :    ^(MODEL_COLUMN alias? expression) 
    ;

model_rules_clause
    :    ^(MODEL_RULES model_rules_element+ model_rules_part?)
    ;

model_rules_part
    :    ^(RULES_VK 
            (SQL92_RESERVED_UPDATE|UPSERT_VK SQL92_RESERVED_ALL?)? 
            (AUTOMATIC_VK|SEQUENTIAL_VK)? 
            model_iterate_clause?
        )
    ;

model_rules_element
    :    ^(MODEL_RULE 
            ^(ASSIGN model_expression expression) 
            (SQL92_RESERVED_UPDATE|UPSERT_VK SQL92_RESERVED_ALL?)? 
            order_by_clause?
        )
    ;

model_iterate_clause
    :    ^(ITERATE_VK expression until_part?)
    ;

until_part
    :    ^(UNTIL_VK expression)
    ;

order_by_clause
    :    ^(SQL92_RESERVED_ORDER SIBLINGS_VK? ^(ORDER_BY_ELEMENTS order_by_elements+))
    ;

order_by_elements
    :    ^(ORDER_BY_ELEMENT expression (SQL92_RESERVED_ASC|SQL92_RESERVED_DESC)? (NULLS_VK (FIRST_VK|LAST_VK))?)
    ;

for_update_clause
    :    ^(SQL92_RESERVED_FOR for_update_of_part? for_update_options?)
    ;

for_update_of_part
    :    ^(SQL92_RESERVED_OF column_name+)
    ;

for_update_options
    :    SKIP_VK
    |    PLSQL_RESERVED_NOWAIT
    |    ^(WAIT_VK expression)
    ;

// $>

update_statement
    :    ^(SQL92_RESERVED_UPDATE general_table_ref
            update_set_clause
            where_clause? static_returning_clause? error_logging_clause?
        )
    ;

// $<Update - Specific Clauses
update_set_clause
    :    ^(SET_VK update_set_elements+)
    ;

update_set_elements
    :    ^(ASSIGN column_name expression)
    |    ^(ASSIGN column_name+ subquery)
    |    ^(VALUE_VK char_set_name? ID expression)
    ;

// $>

delete_statement
    :    ^(SQL92_RESERVED_DELETE general_table_ref
            where_clause? static_returning_clause? error_logging_clause?)
    ;

insert_statement
    :    ^(SQL92_RESERVED_INSERT
        (    single_table_insert
        |    multi_table_insert
        )
        )
    ;

// $<Insert - Specific Clauses

single_table_insert
    :    ^(SINGLE_TABLE_MODE insert_into_clause (values_clause static_returning_clause?| select_statement) error_logging_clause?)
    ;

multi_table_insert
    :    ^(MULTI_TABLE_MODE select_statement (conditional_insert_clause|multi_table_element+))
    ;

multi_table_element
    :    ^(TABLE_ELEMENT insert_into_clause values_clause? error_logging_clause?)
    ;

conditional_insert_clause
    :    ^(CONDITIONAL_INSERT (SQL92_RESERVED_ALL|FIRST_VK)? conditional_insert_when_part+ conditional_insert_else_part?) 
    ;

conditional_insert_when_part
    :    ^(SQL92_RESERVED_WHEN expression multi_table_element+)
    ;

conditional_insert_else_part
    :    ^(SQL92_RESERVED_ELSE multi_table_element+)
    ;

insert_into_clause
    :    ^(SQL92_RESERVED_INTO general_table_ref ^(COLUMNS column_name*))
    ;

values_clause
    :    ^(SQL92_RESERVED_VALUES expression_list)
    ;

// $>
merge_statement
    :    ^(MERGE_VK alias? tableview_name 
            ^(PLSQL_NON_RESERVED_USING selected_tableview expression)
             merge_update_clause? merge_insert_clause? error_logging_clause?)
    ;

// $<Merge - Specific Clauses

merge_update_clause
    :    ^(MERGE_UPDATE merge_element+ where_clause? merge_update_delete_part?)
    ;

merge_element
    :    ^(ASSIGN column_name expression)
    ;

merge_update_delete_part
    :    ^(SQL92_RESERVED_DELETE where_clause)
    ;

merge_insert_clause
    :    ^(MERGE_INSERT ^(COLUMNS column_name*) expression_list where_clause?) 
    ;

selected_tableview
    :    ^(SELECTED_TABLEVIEW alias? (tableview_name|subquery))
    ;

// $>

lock_table_statement
    :    ^(PLSQL_RESERVED_LOCK lock_table_element+ lock_mode wait_nowait_part?)
    ;

wait_nowait_part
    :    ^(WAIT_VK expression)
    |    PLSQL_RESERVED_NOWAIT
    ;

// $<Lock - Specific Clauses

lock_table_element
    :    ^(LOCK_TABLE_ELEMENT tableview_name partition_extension_clause?)
    ;

lock_mode
    :    ROW_VK PLSQL_RESERVED_SHARE
    |    ROW_VK PLSQL_RESERVED_EXCLUSIVE
    |    PLSQL_RESERVED_SHARE SQL92_RESERVED_UPDATE?
    |    PLSQL_RESERVED_SHARE ROW_VK PLSQL_RESERVED_EXCLUSIVE
    |    PLSQL_RESERVED_EXCLUSIVE
    ;
// $>

// $<Common DDL Clauses

general_table_ref
    :    ^(TABLE_REF alias? dml_table_expression_clause ONLY_VK?)
    ;

static_returning_clause
    :    ^(STATIC_RETURNING expression+ into_clause)
    ;

error_logging_clause
    :    ^(LOG_VK error_logging_into_part? expression? error_logging_reject_part?)
    ;

error_logging_into_part
    :    ^(SQL92_RESERVED_INTO tableview_name)
    ;

error_logging_reject_part
    :    ^(REJECT_VK (UNLIMITED_VK|expression))
    ;

dml_table_expression_clause
    :    ^(TABLE_EXPRESSION 
        (    ^(COLLECTION_MODE expression PLUS_SIGN?)
        |    ^(SELECT_MODE select_statement subquery_restriction_clause?)
        |    ^(DIRECT_MODE tableview_name sample_clause?)
        )
        )
    ;

subquery_restriction_clause
    :    ^(SQL92_RESERVED_WITH (READ_VK|SQL92_RESERVED_CHECK constraint_name?))
    ;

sample_clause
    :    ^(SAMPLE_VK BLOCK_VK? expression seed_part?) 
    ;

seed_part
    :    ^(SEED_VK expression)
    ;

// $>

// $<Expression & Condition

expression_list
    :    ^(EXPR_LIST expression*)
    ;

expression
    :    ^(LOGIC_EXPR expression_element)
    |    ^(EXPR expression_element)
    ;

expression_element
    :    ^(SQL92_RESERVED_OR expression_element expression_element)
    |    ^(SQL92_RESERVED_AND expression_element expression_element)
    |    ^(SQL92_RESERVED_NOT expression_element)
    |    ^((EQUALS_OP|NOT_EQUAL_OP|LESS_THAN_OP|GREATER_THAN_OP|LESS_THAN_OR_EQUALS_OP|GREATER_THAN_OR_EQUALS_OP) expression_element expression_element)

    |    ^(IS_NOT_NULL expression_element)
    |    ^(IS_NULL expression_element)
    |    ^(IS_NOT_NAN expression_element)
    |    ^(IS_NAN expression_element)
    |    ^(IS_NOT_PRESENT expression_element)
    |    ^(IS_PRESENT expression_element)
    |    ^(IS_NOT_INFINITE expression_element)
    |    ^(IS_INFINITE expression_element)
    |    ^(IS_NOT_A_SET expression_element)
    |    ^(IS_A_SET expression_element)
    |    ^(IS_NOT_EMPTY expression_element)
    |    ^(IS_EMPTY expression_element)
    |    ^(IS_NOT_OF_TYPE expression_element type_spec+)
    |    ^(IS_OF_TYPE expression_element type_spec+)

    |    ^((MEMBER_VK|SUBMULTISET_VK) expression_element expression_element)

    |    ^(NOT_IN expression_element in_elements)
    |    ^(SQL92_RESERVED_IN expression_element in_elements)
    |    ^(NOT_BETWEEN expression_element expression_element expression_element)
    |    ^(SQL92_RESERVED_BETWEEN expression_element expression_element expression_element)
    |    ^(NOT_LIKE expression_element expression_element expression_element?)
    |    ^((SQL92_RESERVED_LIKE|LIKEC_VK|LIKE2_VK|LIKE4_VK) expression_element expression_element expression_element?)

    |    ^(CONCATENATION_OP expression_element expression_element)
    |    ^(PLUS_SIGN expression_element expression_element)
    |    ^(MINUS_SIGN expression_element expression_element)
    |    ^(ASTERISK expression_element expression_element)
    |    ^(SOLIDUS expression_element expression_element)

    |    ^(UNARY_OPERATOR expression_element)
    |    ^(SQL92_RESERVED_PRIOR expression_element)
    |    ^(NEW_VK expression)
    |    ^(SQL92_RESERVED_DISTINCT expression_element)
    |    ^(STANDARD_FUNCTION standard_function)
    |    ^((SOME_VK|SQL92_RESERVED_EXISTS|SQL92_RESERVED_ALL|SQL92_RESERVED_ANY) expression_element)
    |    ^(VECTOR_EXPR expression_element+)

    |    ^(DATETIME_OP expression_element datetime_element)
    |    model_expression
    |    ^(KEEP_VK expression_element DENSE_RANK_VK (FIRST_VK|LAST_VK) order_by_clause over_clause?)

    |    ^(DOT_ASTERISK tableview_name)

    |    case_statement
    |    constant
    |    general_element
    |    subquery
    ;

in_elements
    :    subquery
    |    expression_list
    ;

datetime_element
    :    ^(AT_VK expression_element (LOCAL_VK|TIME_VK expression))
    |    ^(DAY_VK SECOND_VK expression*)
    |    ^(YEAR_VK MONTH_VK expression)
    ;

model_expression
    :    ^(MODEL_EXPRESSION expression_element model_expression_element+)
    ;

model_expression_element
    :    SQL92_RESERVED_ANY
    |    expression
    |    ^(FOR_SINGLE_COLUMN column_name for_single_column_element for_like_part?)
    |    ^(FOR_MULTI_COLUMN column_name+ ^(SQL92_RESERVED_IN (subquery|expression_list+)))
    ;

for_single_column_element
    :    ^(SQL92_RESERVED_IN expression_list)
    |    ^(SQL92_RESERVED_FROM expression) 
    |    ^(SQL92_RESERVED_TO expression) 
    |    ^((INCREMENT_VK|DECREMENT_VK) expression) 
    ;

for_like_part
    :    ^(SQL92_RESERVED_LIKE expression)
    ;

case_statement
    :    ^(SIMPLE_CASE label_name* expression case_when_part+ case_else_part?)  
    |    ^(SEARCHED_CASE label_name* case_when_part+ case_else_part?) 
    ;

// $<CASE - Specific Clauses

case_when_part
    :    ^(SQL92_RESERVED_WHEN expression (seq_of_statements|expression))
    ;

case_else_part
    :    ^(SQL92_RESERVED_ELSE (seq_of_statements|expression))
    ;
// $>

standard_function
    :    ^(FUNCTION_ENABLING_OVER function_argument over_clause?)
    |    ^(FUNCTION_ENABLING_USING function_argument using_clause?)
    |    ^(COUNT_VK ( ASTERISK | expression ) over_clause?)
    |    ^((CAST_VK|XMLCAST_VK) (subquery|expression) type_spec)
    |    ^(CHR_VK expression NCHAR_CS_VK)
    |    ^(COLLECT_VK (SQL92_RESERVED_DISTINCT|SQL92_RESERVED_UNIQUE)? column_name collect_order_by_part?)
    |    ^(FUNCTION_ENABLING_WITHIN_OR_OVER function_argument (within_clause|over_clause)+ )
    |    ^(DECOMPOSE_VK expression (CANONICAL_VK|COMPATIBILITY_VK)?) 
    |    ^(EXTRACT_VK REGULAR_ID expression)
    |    ^((FIRST_VALUE_VK|LAST_VALUE_VK) expression NULLS_VK? over_clause) 
    |    ^(PREDICTION_FUNCTION expression+ cost_matrix_clause? using_clause?)
    |    ^(TRANSLATE_VK expression (CHAR_CS_VK|NCHAR_CS_VK)? expression*)
    |    ^(TREAT_VK expression REF_VK? type_spec)
    |    ^(TRIM_VK (LEADING_VK|TRAILING_VK|BOTH_VK)? expression expression?) 

    |    ^(XMLAGG_VK expression order_by_clause?)
    |    ^((XMLCOLATTVAL_VK|XMLFOREST_VK) xml_multiuse_expression_element+)
    |    ^(XMLEXISTS_VK expression xml_passing_clause?)
    |    ^(XMLPARSE_VK (DOCUMENT_VK|CONTENT_VK) expression WELLFORMED_VK?)
    |    ^(XMLQUERY_VK expression xml_passing_clause? SQL92_RESERVED_NULL?)
    |    ^(XMLROOT_VK expression xml_param_version_part xmlroot_param_standalone_part?)
    |    ^(XMLTABLE_VK xml_namespaces_clause? expression xml_passing_clause? xml_table_column*)
    |    ^(XMLELEMENT_VK
            (ENTITYESCAPING_VK|NOENTITYESCAPING_VK)?
            (NAME_VK|EVALNAME_VK)? expression
            xml_attributes_clause? (expression alias?)*
        )
    |    ^(XMLPI_VK
                (    NAME_VK char_set_name? ID
                |    EVALNAME_VK expression
                )
                expression?
        )
    |    ^(XMLSERIALIZE_VK
                (DOCUMENT_VK|CONTENT_VK)
                expression type_spec?
                xmlserialize_param_enconding_part?
                xml_param_version_part?
                xmlserialize_param_ident_part?
                ((HIDE_VK|SHOW_VK) DEFAULTS_VK)?
        )
    ;

over_clause
    :    ^(OVER_VK query_partition_clause? (order_by_clause windowing_clause?)?)
    ;

windowing_clause
    :    ^((ROWS_VK|RANGE_VK)
            (    ^(SQL92_RESERVED_BETWEEN windowing_elements windowing_elements)
            |    windowing_elements+
            )
        )
    ;

windowing_elements
    :    ^(UNBOUNDED_VK PRECEDING_VK)
    |    ^(CURRENT_VK ROW_VK)
    |    ^((PRECEDING_VK|FOLLOWING_VK) expression)
    ;

using_clause
    :    ^(PLSQL_NON_RESERVED_USING using_element+)
    ;

using_element
    :    ^(ELEMENT SQL92_RESERVED_IN? OUT_VK? expression alias?)
    |    ASTERISK
    ;

collect_order_by_part
    :    ^(SQL92_RESERVED_ORDER expression)
    ;

within_clause
    :    ^(WITHIN_VK order_by_clause)
    ;

cost_matrix_clause
    :    ^(COST_VK
            (    PLSQL_NON_RESERVED_MODEL AUTO_VK?
            |    cost_class_name+ expression_list
            )
        )
    ;

xml_passing_clause
    :    ^(PASSING_VK VALUE_VK? expression alias? (expression alias?)?)
    ;

xml_attributes_clause
    :    ^(XMLATTRIBUTES_VK
            (ENTITYESCAPING_VK|NOENTITYESCAPING_VK)?
            (SCHEMACHECK_VK|NOSCHEMACHECK_VK)?
            xml_multiuse_expression_element+
        )
    ;

xml_namespaces_clause
    :    ^(XMLNAMESPACES_VK
            (expression alias?)* xml_general_default_part?
        )
    ;

xml_table_column
    :    ^(XML_COLUMN xml_column_name (ORDINALITY_VK|type_spec expression? xml_general_default_part?) )
    ;

xml_general_default_part
    :    ^(SQL92_RESERVED_DEFAULT expression)
    ;

xml_multiuse_expression_element
    :    ^(XML_ELEMENT expression xml_alias?)
    ;

xml_alias
    :    ^(XML_ALIAS ID)
    |    ^(XML_ALIAS ^(EVALNAME_VK expression))
    ;

xml_param_version_part
    :    ^(VERSION_VK (NO_VK VALUE_VK|expression))
    ;

xmlroot_param_standalone_part
    :    ^(STANDALONE_VK (YES_VK|NO_VK VALUE_VK?))
    ;

xmlserialize_param_enconding_part
    :    ^(ENCODING_VK expression)
    ;

xmlserialize_param_ident_part
    :    NO_VK INDENT_VK
    |    ^(INDENT_VK expression?)
    ;

// $>
