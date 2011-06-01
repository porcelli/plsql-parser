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
parser grammar PLSQLKeys_NoAST;

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

create_key
	:	SQL92_RESERVED_CREATE
	;
	
replace_key
	:	{input.LT(1).getText().equalsIgnoreCase("replace")}?=> REGULAR_ID
	;

package_key
	:	{input.LT(1).getText().equalsIgnoreCase("package")}?=> REGULAR_ID
	;

body_key
	:	{input.LT(1).getText().equalsIgnoreCase("body")}? REGULAR_ID
	;

begin_key
	:	SQL92_RESERVED_BEGIN
	;

exit_key:	{input.LT(1).getText().equalsIgnoreCase("exit")}? REGULAR_ID
	;

declare_key
	:	SQL92_RESERVED_DECLARE
	;

exception_key
	:	SQL92_RESERVED_EXCEPTION
	;

serveroutput_key
	:	{input.LT(1).getText().equalsIgnoreCase("serveroutput")}? REGULAR_ID
	;

off_key
	:	{input.LT(1).getText().equalsIgnoreCase("off")}? REGULAR_ID
	;

constant_key
	:	{input.LT(1).getText().equalsIgnoreCase("constant")}? REGULAR_ID
	;

subtype_key
	:	{input.LT(1).getText().equalsIgnoreCase("subtype")}? REGULAR_ID
	;

cursor_key
	:	{input.LT(1).getText().equalsIgnoreCase("cursor")}? REGULAR_ID
	;

nextval_key
	:	{input.LT(1).getText().equalsIgnoreCase("nextval")}?=> REGULAR_ID
	;

goto_key
	:	SQL92_RESERVED_GOTO
	;

execute_key
	:	{input.LT(1).getText().equalsIgnoreCase("execute")}? REGULAR_ID
	;

immediate_key
	:	{input.LT(1).getText().equalsIgnoreCase("immediate")}?=> REGULAR_ID
	;

return_key
	:	{input.LT(1).getText().equalsIgnoreCase("return")}? REGULAR_ID
	;

procedure_key
	:	SQL92_RESERVED_PROCEDURE
	;

function_key
	:	{input.LT(1).getText().equalsIgnoreCase("function")}?=> REGULAR_ID
	;

pragma_key
	:	{input.LT(1).getText().equalsIgnoreCase("pragma")}? REGULAR_ID
	;

exception_init_key
	:	{input.LT(1).getText().equalsIgnoreCase("exception_init")}? REGULAR_ID
	;

type_key
	:	{input.LT(1).getText().equalsIgnoreCase("type")}?=> REGULAR_ID
	;

record_key
	:	{input.LT(1).getText().equalsIgnoreCase("record")}?=> REGULAR_ID
	;

indexed_key
	:	{input.LT(1).getText().equalsIgnoreCase("indexed")}? REGULAR_ID
	;

index_key
	:	PLSQL_RESERVED_INDEX
	;

percent_notfound_key
	:	{input.LT(2).getText().equalsIgnoreCase("notfound")}?=> PERCENT REGULAR_ID
	;

percent_found_key
	:	{input.LT(2).getText().equalsIgnoreCase("found")}?=> PERCENT REGULAR_ID
	;

percent_isopen_key
	:	{input.LT(2).getText().equalsIgnoreCase("isopen")}?=> PERCENT REGULAR_ID
	;

percent_rowcount_key
	:	{input.LT(2).getText().equalsIgnoreCase("rowcount")}?=> PERCENT REGULAR_ID
	;

percent_rowtype_key
	:	{input.LT(2).getText().equalsIgnoreCase("rowtype")}?=> PERCENT REGULAR_ID 
	;

percent_type_key
	:	{input.LT(2).getText().equalsIgnoreCase("type")}?=> PERCENT REGULAR_ID
	;

out_key
	:	{input.LT(1).getText().equalsIgnoreCase("out")}?=> REGULAR_ID
	;

inout_key
	:	{input.LT(1).getText().equalsIgnoreCase("inout")}? REGULAR_ID
	;

extend_key
	:	{input.LT(1).getText().equalsIgnoreCase("extend")}?=> REGULAR_ID
	;

raise_key
	:	{input.LT(1).getText().equalsIgnoreCase("raise")}? REGULAR_ID
	;

while_key
	:	{input.LT(1).getText().equalsIgnoreCase("while")}? REGULAR_ID
	;

loop_key
	:	{input.LT(1).getText().equalsIgnoreCase("loop")}? REGULAR_ID
	;

commit_key
	:	{input.LT(1).getText().equalsIgnoreCase("commit")}?=> REGULAR_ID
	;

work_key:	{input.LT(1).getText().equalsIgnoreCase("work")}? REGULAR_ID
	;

if_key
	:	PLSQL_RESERVED_IF
	;

elsif_key
	:	PLSQL_NON_RESERVED_ELSIF
	;

authid_key
	:	{input.LT(1).getText().equalsIgnoreCase("authid")}?=> REGULAR_ID
	;

definer_key
	:	{input.LT(1).getText().equalsIgnoreCase("definer")}? REGULAR_ID
	;

external_key
	:	{input.LT(1).getText().equalsIgnoreCase("external")}? REGULAR_ID
	;

language_key
	:	{input.LT(1).getText().equalsIgnoreCase("language")}? REGULAR_ID
	;

java_key
	:	{input.LT(1).getText().equalsIgnoreCase("java")}? REGULAR_ID
	;

name_key
	:	{input.LT(1).getText().equalsIgnoreCase("name")}?=> REGULAR_ID
	;

deterministic_key
	:	{input.LT(1).getText().equalsIgnoreCase("deterministic")}?=> REGULAR_ID
	;

parallel_enable_key
	:	{input.LT(1).getText().equalsIgnoreCase("parallel_enable")}?=> REGULAR_ID
	;

result_cache_key
	:	{input.LT(1).getText().equalsIgnoreCase("result_cache")}?=> REGULAR_ID
	;

pipelined_key
	:	{input.LT(1).getText().equalsIgnoreCase("pipelined")}?=> REGULAR_ID
	;

aggregate_key
	:	{input.LT(1).getText().equalsIgnoreCase("aggregate")}? REGULAR_ID
	;

alter_key
	:	SQL92_RESERVED_ALTER
	;

compile_key
	:	{input.LT(1).getText().equalsIgnoreCase("compile")}? REGULAR_ID
	; 

debug_key
	:	{input.LT(1).getText().equalsIgnoreCase("debug")}? REGULAR_ID
	;

reuse_key
	:	{input.LT(1).getText().equalsIgnoreCase("reuse")}? REGULAR_ID
	;

settings_key
	:	{input.LT(1).getText().equalsIgnoreCase("settings")}? REGULAR_ID
	;

specification_key
	:	{input.LT(1).getText().equalsIgnoreCase("specification")}? REGULAR_ID
	;

drop_key
	:	SQL92_RESERVED_DROP
	;

trigger_key
	:	{input.LT(1).getText().equalsIgnoreCase("trigger")}?=> REGULAR_ID
	;

force_key
	:	{input.LT(1).getText().equalsIgnoreCase("force")}?=> REGULAR_ID
	;

validate_key
	:	{input.LT(1).getText().equalsIgnoreCase("validate")}? REGULAR_ID
	;

ref_key
	:	{input.LT(1).getText().equalsIgnoreCase("ref")}?=> REGULAR_ID
	;

array_key
	:	{input.LT(1).getText().equalsIgnoreCase("array")}?=> REGULAR_ID
	;

varray_key
	:	{input.LT(1).getText().equalsIgnoreCase("varray")}?=> REGULAR_ID
	;

pls_integer_key
	:	{input.LT(1).getText().equalsIgnoreCase("pls_integer")}?=> REGULAR_ID
	;

serially_reusable_key
	:	{input.LT(1).getText().equalsIgnoreCase("serially_reusable")}?=> REGULAR_ID
	;

autonomous_transaction_key
	:	{input.LT(1).getText().equalsIgnoreCase("autonomous_transaction")}?=> REGULAR_ID
	;

inline_key
	:	{input.LT(1).getText().equalsIgnoreCase("inline")}?=> REGULAR_ID
	;

restrict_references_key
	:	{input.LT(1).getText().equalsIgnoreCase("restrict_references")}?=> REGULAR_ID
	;

exceptions_key
	:	{input.LT(1).getText().equalsIgnoreCase("exceptions")}?=> REGULAR_ID 
	;

save_key
	:	{input.LT(1).getText().equalsIgnoreCase("save")}?=> REGULAR_ID
	;

forall_key
	:	{input.LT(1).getText().equalsIgnoreCase("forall")}?=> REGULAR_ID
	;

continue_key
	:	{input.LT(1).getText().equalsIgnoreCase("continue")}?=> REGULAR_ID
	;

indices_key
	:	{input.LT(1).getText().equalsIgnoreCase("indices")}?=> REGULAR_ID
	;

values_key
	:	SQL92_RESERVED_VALUES
	;

case_key
	:	SQL92_RESERVED_CASE
	;

bulk_key
	:	{input.LT(1).getText().equalsIgnoreCase("bulk")}?=> REGULAR_ID
	;

collect_key
	:	{input.LT(1).getText().equalsIgnoreCase("collect")}?=> REGULAR_ID
	;

committed_key
	:	{input.LT(1).getText().equalsIgnoreCase("committed")}? REGULAR_ID
	;

use_key
	:	{input.LT(1).getText().equalsIgnoreCase("use")}?=> REGULAR_ID
	;

level_key
	:	{input.LT(1).getText().equalsIgnoreCase("level")}? REGULAR_ID
	;

isolation_key
	:	{input.LT(1).getText().equalsIgnoreCase("isolation")}?=> REGULAR_ID
	;

serializable_key
	:	{input.LT(1).getText().equalsIgnoreCase("serializable")}? REGULAR_ID
	;

segment_key
	:	{input.LT(1).getText().equalsIgnoreCase("segment")}? REGULAR_ID
	;

write_key
	:	{input.LT(1).getText().equalsIgnoreCase("write")}?=> REGULAR_ID
	;

wait_key
	:	{input.LT(1).getText().equalsIgnoreCase("wait")}?=> REGULAR_ID
	;

corrupt_xid_all_key
	:	{input.LT(1).getText().equalsIgnoreCase("corrupt_xid_all")}?=> REGULAR_ID
	;

corrupt_xid_key
	:	{input.LT(1).getText().equalsIgnoreCase("corrupt_xid")}?=> REGULAR_ID
	;

batch_key
	:	{input.LT(1).getText().equalsIgnoreCase("batch")}?=> REGULAR_ID
	;

session_key
	:	{input.LT(1).getText().equalsIgnoreCase("session")}?=> REGULAR_ID
	;

role_key
	:	{input.LT(1).getText().equalsIgnoreCase("role")}?=> REGULAR_ID
	;

constraint_key
	:	{input.LT(1).getText().equalsIgnoreCase("constraint")}?=> REGULAR_ID
	;

constraints_key
	:	{input.LT(1).getText().equalsIgnoreCase("constraints")}?=> REGULAR_ID
	;

call_key
	:	{input.LT(1).getText().equalsIgnoreCase("call")}?=> REGULAR_ID
	;

explain_key
	:	{input.LT(1).getText().equalsIgnoreCase("explain")}?=> REGULAR_ID
	;

merge_key
	:	{input.LT(1).getText().equalsIgnoreCase("merge")}?=> REGULAR_ID
	;

plan_key
	:	{input.LT(1).getText().equalsIgnoreCase("plan")}?=> REGULAR_ID
	;

system_key
	:	{input.LT(1).getText().equalsIgnoreCase("system")}?=> REGULAR_ID
	;

subpartition_key
	:	{input.LT(1).getText().equalsIgnoreCase("subpartition")}?=> REGULAR_ID
	;

partition_key
	:	{input.LT(1).getText().equalsIgnoreCase("partition")}?=> REGULAR_ID
	;

matched_key
	:	{input.LT(1).getText().equalsIgnoreCase("matched")}?=> REGULAR_ID
	;

reject_key
	:	{input.LT(1).getText().equalsIgnoreCase("reject")}?=> REGULAR_ID
	;

log_key
	:	{input.LT(1).getText().equalsIgnoreCase("log")}?=> REGULAR_ID
	;

unlimited_key
	:	{input.LT(1).getText().equalsIgnoreCase("unlimited")}?=> REGULAR_ID
	;

limit_key
	:	{input.LT(1).getText().equalsIgnoreCase("limit")}?=> REGULAR_ID
	;

errors_key
	:	{input.LT(1).getText().equalsIgnoreCase("errors")}?=> REGULAR_ID
	;

timestamp_tz_unconstrained_key
	:	{input.LT(1).getText().equalsIgnoreCase("timestamp_tz_unconstrained")}?=> REGULAR_ID
	;

urowid_key
	:	{input.LT(1).getText().equalsIgnoreCase("urowid")}?=> REGULAR_ID
	;

binary_float_min_subnormal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float_min_subnormal")}?=> REGULAR_ID
	;

binary_double_min_normal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double_min_normal")}?=> REGULAR_ID
	;

binary_float_max_normal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float_max_normal")}?=> REGULAR_ID
	;

positiven_key
	:	{input.LT(1).getText().equalsIgnoreCase("positiven")}?=> REGULAR_ID
	;

timezone_abbr_key
	:	{input.LT(1).getText().equalsIgnoreCase("timezone_abbr")}?=> REGULAR_ID
	;

binary_double_min_subnormal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double_min_subnormal")}?=> REGULAR_ID
	;

binary_float_max_subnormal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float_max_subnormal")}?=> REGULAR_ID
	;

binary_double_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double")}?=> REGULAR_ID
	;

bfile_key
	:	{input.LT(1).getText().equalsIgnoreCase("bfile")}?=> REGULAR_ID
	;

binary_double_infinity_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double_infinity")}?=> REGULAR_ID
	;

timezone_region_key
	:	{input.LT(1).getText().equalsIgnoreCase("timezone_region")}?=> REGULAR_ID
	;

timestamp_ltz_unconstrained_key
	:	{input.LT(1).getText().equalsIgnoreCase("timestamp_ltz_unconstrained")}?=> REGULAR_ID
	;

naturaln_key
	:	{input.LT(1).getText().equalsIgnoreCase("naturaln")}?=> REGULAR_ID
	;

simple_integer_key
	:	{input.LT(1).getText().equalsIgnoreCase("simple_integer")}?=> REGULAR_ID
	;

binary_double_max_subnormal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double_max_subnormal")}?=> REGULAR_ID
	;

byte_key
	:	{input.LT(1).getText().equalsIgnoreCase("byte")}?=> REGULAR_ID
	;

binary_float_infinity_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float_infinity")}?=> REGULAR_ID
	;

binary_float_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float")}?=> REGULAR_ID
	;

range_key
	:	{input.LT(1).getText().equalsIgnoreCase("range")}?=> REGULAR_ID
	;

nclob_key
	:	{input.LT(1).getText().equalsIgnoreCase("nclob")}?=> REGULAR_ID
	;

clob_key
	:	{input.LT(1).getText().equalsIgnoreCase("clob")}?=> REGULAR_ID
	;

dsinterval_unconstrained_key
	:	{input.LT(1).getText().equalsIgnoreCase("dsinterval_unconstrained")}?=> REGULAR_ID
	;

yminterval_unconstrained_key
	:	{input.LT(1).getText().equalsIgnoreCase("yminterval_unconstrained")}?=> REGULAR_ID
	;

rowid_key
	:	{input.LT(1).getText().equalsIgnoreCase("rowid")}?=> REGULAR_ID
	;

binary_double_nan_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double_nan")}?=> REGULAR_ID
	;

timestamp_unconstrained_key
	:	{input.LT(1).getText().equalsIgnoreCase("timestamp_unconstrained")}?=> REGULAR_ID
	;

binary_float_min_normal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float_min_normal")}?=> REGULAR_ID
	;

signtype_key
	:	{input.LT(1).getText().equalsIgnoreCase("signtype")}?=> REGULAR_ID
	;

blob_key
	:	{input.LT(1).getText().equalsIgnoreCase("blob")}?=> REGULAR_ID
	;

nvarchar2_key
	:	{input.LT(1).getText().equalsIgnoreCase("nvarchar2")}?=> REGULAR_ID
	;

binary_double_max_normal_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_double_max_normal")}?=> REGULAR_ID
	;

binary_float_nan_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_float_nan")}?=> REGULAR_ID
	;

string_key
	:	{input.LT(1).getText().equalsIgnoreCase("string")}?=> REGULAR_ID
	;

c_key
	:	{input.LT(1).getText().equalsIgnoreCase("c")}?=> REGULAR_ID
	;

library_key
	:	{input.LT(1).getText().equalsIgnoreCase("library")}?=> REGULAR_ID
	;

context_key
	:	{input.LT(1).getText().equalsIgnoreCase("context")}?=> REGULAR_ID
	;

parameters_key
	:	{input.LT(1).getText().equalsIgnoreCase("parameters")}?=> REGULAR_ID
	;

agent_key
	:	{input.LT(1).getText().equalsIgnoreCase("agent")}?=> REGULAR_ID
	;

cluster_key
	:	{input.LT(1).getText().equalsIgnoreCase("cluster")}?=> REGULAR_ID
	;

hash_key
	:	{input.LT(1).getText().equalsIgnoreCase("hash")}?=> REGULAR_ID
	;

relies_on_key
	:	{input.LT(1).getText().equalsIgnoreCase("relies_on")}?=> REGULAR_ID
	;

returning_key
	:	{input.LT(1).getText().equalsIgnoreCase("returning")}?=> REGULAR_ID
	;	

statement_id_key
	:	{input.LT(1).getText().equalsIgnoreCase("statement_id")}?=> REGULAR_ID
	;

deferred_key
	:	{input.LT(1).getText().equalsIgnoreCase("deferred")}?=> REGULAR_ID
	;

advise_key
	:	{input.LT(1).getText().equalsIgnoreCase("advise")}?=> REGULAR_ID
	;

resumable_key
	:	{input.LT(1).getText().equalsIgnoreCase("resumable")}?=> REGULAR_ID
	;

timeout_key
	:	{input.LT(1).getText().equalsIgnoreCase("timeout")}?=> REGULAR_ID
	;

parallel_key
	:	{input.LT(1).getText().equalsIgnoreCase("parallel")}?=> REGULAR_ID
	;

ddl_key
	:	{input.LT(1).getText().equalsIgnoreCase("ddl")}?=> REGULAR_ID
	;

query_key
	:	{input.LT(1).getText().equalsIgnoreCase("query")}?=> REGULAR_ID
	;

dml_key
	:	{input.LT(1).getText().equalsIgnoreCase("dml")}?=> REGULAR_ID
	;

guard_key
	:	{input.LT(1).getText().equalsIgnoreCase("guard")}?=> REGULAR_ID
	;

nothing_key
	:	{input.LT(1).getText().equalsIgnoreCase("nothing")}?=> REGULAR_ID
	;

enable_key
	:	{input.LT(1).getText().equalsIgnoreCase("enable")}?=> REGULAR_ID
	;

database_key
	:	{input.LT(1).getText().equalsIgnoreCase("database")}?=> REGULAR_ID
	;

disable_key
	:	{input.LT(1).getText().equalsIgnoreCase("disable")}?=> REGULAR_ID
	;

link_key
	:	{input.LT(1).getText().equalsIgnoreCase("link")}?=> REGULAR_ID
	;

identified_key
	:	PLSQL_RESERVED_IDENTIFIED
	;

none_key
	:	{input.LT(1).getText().equalsIgnoreCase("none")}?=> REGULAR_ID
	;

before_key
	:	{input.LT(1).getText().equalsIgnoreCase("before")}?=> REGULAR_ID 
	;

referencing_key
	:	{input.LT(1).getText().equalsIgnoreCase("referencing")}?=> REGULAR_ID
	;

logon_key
	:	{input.LT(1).getText().equalsIgnoreCase("logon")}?=> REGULAR_ID
	;

after_key
	:	{input.LT(1).getText().equalsIgnoreCase("after")}? REGULAR_ID
	;

schema_key
	:	{input.LT(1).getText().equalsIgnoreCase("schema")}?=> REGULAR_ID
	;

grant_key
	:	SQL92_RESERVED_GRANT
	;

truncate_key
	:	{input.LT(1).getText().equalsIgnoreCase("truncate")}?=> REGULAR_ID
	;

startup_key
	:	{input.LT(1).getText().equalsIgnoreCase("startup")}?=> REGULAR_ID
	;

statistics_key
	:	{input.LT(1).getText().equalsIgnoreCase("statistics")}?=> REGULAR_ID
	;

noaudit_key
	:	{input.LT(1).getText().equalsIgnoreCase("noaudit")}?=> REGULAR_ID
	;

suspend_key
	:	{input.LT(1).getText().equalsIgnoreCase("suspend")}?=> REGULAR_ID
	;

audit_key
	:	{input.LT(1).getText().equalsIgnoreCase("audit")}?=> REGULAR_ID
	;

disassociate_key
	:	{input.LT(1).getText().equalsIgnoreCase("disassociate")}?=> REGULAR_ID 
	;

shutdown_key
	:	{input.LT(1).getText().equalsIgnoreCase("shutdown")}?=> REGULAR_ID
	;

compound_key
	:	{input.LT(1).getText().equalsIgnoreCase("compound")}?=> REGULAR_ID
	;

servererror_key
	:	{input.LT(1).getText().equalsIgnoreCase("servererror")}?=> REGULAR_ID
	;

parent_key
	:	{input.LT(1).getText().equalsIgnoreCase("parent")}?=> REGULAR_ID
	;

follows_key
	:	{input.LT(1).getText().equalsIgnoreCase("follows")}?=> REGULAR_ID
	;

nested_key
	:	{input.LT(1).getText().equalsIgnoreCase("nested")}?=> REGULAR_ID
	;

old_key
	:	{input.LT(1).getText().equalsIgnoreCase("old")}?=> REGULAR_ID
	;

statement_key
	:	{input.LT(1).getText().equalsIgnoreCase("statement")}?=> REGULAR_ID
	;

db_role_change_key
	:	{input.LT(1).getText().equalsIgnoreCase("db_role_change")}?=> REGULAR_ID
	;

each_key
	:	{input.LT(1).getText().equalsIgnoreCase("each")}?=> REGULAR_ID
	;

logoff_key
	:	{input.LT(1).getText().equalsIgnoreCase("logoff")}?=> REGULAR_ID
	;

analyze_key
	:	{input.LT(1).getText().equalsIgnoreCase("analyze")}?=> REGULAR_ID
	;

instead_key
	:	{input.LT(1).getText().equalsIgnoreCase("instead")}?=> REGULAR_ID
	;

associate_key
	:	{input.LT(1).getText().equalsIgnoreCase("associate")}?=> REGULAR_ID
	;

new_key
	:	{input.LT(1).getText().equalsIgnoreCase("new")}?=> REGULAR_ID
	;

revoke_key
	:	SQL92_RESERVED_REVOKE
	;

rename_key
	:	{input.LT(1).getText().equalsIgnoreCase("rename")}?=> REGULAR_ID 
	;

customdatum_key
	:	{input.LT(1).getText().equalsIgnoreCase("customdatum")}?=> REGULAR_ID
	;

oradata_key
	:	{input.LT(1).getText().equalsIgnoreCase("oradata")}?=> REGULAR_ID
	;

constructor_key
	:	{input.LT(1).getText().equalsIgnoreCase("constructor")}?=> REGULAR_ID
	;

sqldata_key
	:	{input.LT(1).getText().equalsIgnoreCase("sqldata")}?=> REGULAR_ID
	;

member_key
	:	{input.LT(1).getText().equalsIgnoreCase("member")}?=> REGULAR_ID
	;

self_key
	:	{input.LT(1).getText().equalsIgnoreCase("self")}?=> REGULAR_ID
	;

object_key
	:	{input.LT(1).getText().equalsIgnoreCase("object")}?=> REGULAR_ID
	;

variable_key
	:	{input.LT(1).getText().equalsIgnoreCase("variable")}?=> REGULAR_ID
	;

instantiable_key
	:	{input.LT(1).getText().equalsIgnoreCase("instantiable")}?=> REGULAR_ID
	;

final_key
	:	{input.LT(1).getText().equalsIgnoreCase("final")}?=> REGULAR_ID
	;

static_key
	:	{input.LT(1).getText().equalsIgnoreCase("static")}?=> REGULAR_ID
	;

oid_key
	:	{input.LT(1).getText().equalsIgnoreCase("oid")}?=> REGULAR_ID
	;

result_key
	:	{input.LT(1).getText().equalsIgnoreCase("result")}?=> REGULAR_ID
	;

under_key
	:	{input.LT(1).getText().equalsIgnoreCase("under")}?=> REGULAR_ID
	;

map_key
	:	{input.LT(1).getText().equalsIgnoreCase("map")}?=> REGULAR_ID
	;

overriding_key
	:	{input.LT(1).getText().equalsIgnoreCase("overriding")}?=> REGULAR_ID
	;

add_key
	:	{input.LT(1).getText().equalsIgnoreCase("add")}?=> REGULAR_ID
	;

modify_key
	:	{input.LT(1).getText().equalsIgnoreCase("modify")}?=> REGULAR_ID
	;

including_key
	:	{input.LT(1).getText().equalsIgnoreCase("including")}?=> REGULAR_ID
	;

substitutable_key
	:	{input.LT(1).getText().equalsIgnoreCase("substitutable")}?=> REGULAR_ID
	;

attribute_key
	:	{input.LT(1).getText().equalsIgnoreCase("attribute")}?=> REGULAR_ID
	;

cascade_key
	:	{input.LT(1).getText().equalsIgnoreCase("cascade")}?=> REGULAR_ID 
	;

data_key
	:	{input.LT(1).getText().equalsIgnoreCase("data")}?=> REGULAR_ID
	;

invalidate_key
	:	{input.LT(1).getText().equalsIgnoreCase("invalidate")}? REGULAR_ID
	;

element_key
	:	{input.LT(1).getText().equalsIgnoreCase("element")}?=> REGULAR_ID
	;

first_key
	:	{input.LT(1).getText().equalsIgnoreCase("first")}?=> REGULAR_ID
	;

check_key
	:	SQL92_RESERVED_CHECK
	;

option_key
	:	SQL92_RESERVED_OPTION
	;

nocycle_key
	:	{input.LT(1).getText().equalsIgnoreCase("nocycle")}?=> REGULAR_ID
	;

locked_key
	:	{input.LT(1).getText().equalsIgnoreCase("locked")}?=> REGULAR_ID
	;

block_key
	:	{input.LT(1).getText().equalsIgnoreCase("block")}?=> REGULAR_ID
	;

xml_key
	:	{input.LT(1).getText().equalsIgnoreCase("xml")}?=> REGULAR_ID
	;

pivot_key
	:	{(input.LT(1).getText().equalsIgnoreCase("pivot"))}?=> REGULAR_ID
	;

prior_key
	:	SQL92_RESERVED_PRIOR
	;

sequential_key
	:	{input.LT(1).getText().equalsIgnoreCase("sequential")}?=> REGULAR_ID
	;

single_key
	:	{input.LT(1).getText().equalsIgnoreCase("single")}?=> REGULAR_ID
	;

skip_key
	:	{input.LT(1).getText().equalsIgnoreCase("skip")}?=> REGULAR_ID
	;

model_key
	:	//{input.LT(1).getText().equalsIgnoreCase("model")}?=> REGULAR_ID
		PLSQL_NON_RESERVED_MODEL
	;

updated_key
	:	{input.LT(1).getText().equalsIgnoreCase("updated")}?=> REGULAR_ID
	;

increment_key
	:	{input.LT(1).getText().equalsIgnoreCase("increment")}?=> REGULAR_ID
	;

exclude_key
	:	{input.LT(1).getText().equalsIgnoreCase("exclude")}?=> REGULAR_ID
	;

reference_key
	:	{input.LT(1).getText().equalsIgnoreCase("reference")}?=> REGULAR_ID
	;

sets_key
	:	{input.LT(1).getText().equalsIgnoreCase("sets")}?=> REGULAR_ID
	;

until_key
	:	{input.LT(1).getText().equalsIgnoreCase("until")}?=> REGULAR_ID
	;

seed_key
	:	{input.LT(1).getText().equalsIgnoreCase("seed")}?=> REGULAR_ID
	;

maxvalue_key
	:	{input.LT(1).getText().equalsIgnoreCase("maxvalue")}?=> REGULAR_ID
	;

siblings_key
	:	{input.LT(1).getText().equalsIgnoreCase("siblings")}?=> REGULAR_ID
	;

cube_key
	:	{input.LT(1).getText().equalsIgnoreCase("cube")}?=> REGULAR_ID
	;

nulls_key
	:	{input.LT(1).getText().equalsIgnoreCase("nulls")}?=> REGULAR_ID
	;

dimension_key
	:	{input.LT(1).getText().equalsIgnoreCase("dimension")}?=> REGULAR_ID
	;

scn_key
	:	{input.LT(1).getText().equalsIgnoreCase("scn")}?=> REGULAR_ID
	;

decrement_key
	:	{input.LT(1).getText().equalsIgnoreCase("decrement")}?=> REGULAR_ID
	;

unpivot_key
	:	{(input.LT(1).getText().equalsIgnoreCase("unpivot"))}?=> REGULAR_ID
	;

keep_key
	:	{input.LT(1).getText().equalsIgnoreCase("keep")}?=> REGULAR_ID
	;

measures_key
	:	{input.LT(1).getText().equalsIgnoreCase("measures")}?=> REGULAR_ID
	;

rows_key
	:	{input.LT(1).getText().equalsIgnoreCase("rows")}?=> REGULAR_ID
	;

sample_key
	:	{input.LT(1).getText().equalsIgnoreCase("sample")}?=> REGULAR_ID
	;

upsert_key
	:	{input.LT(1).getText().equalsIgnoreCase("upsert")}?=> REGULAR_ID
	;

versions_key
	:	{input.LT(1).getText().equalsIgnoreCase("versions")}?=> REGULAR_ID
	;

rules_key
	:	{input.LT(1).getText().equalsIgnoreCase("rules")}?=> REGULAR_ID
	;

iterate_key
	:	{input.LT(1).getText().equalsIgnoreCase("iterate")}?=> REGULAR_ID
	;

minvalue_key
	:	{input.LT(1).getText().equalsIgnoreCase("minvalue")}?=> REGULAR_ID
	;

rollup_key
	:	{input.LT(1).getText().equalsIgnoreCase("rollup")}?=> REGULAR_ID
	;

nav_key
	:	{input.LT(1).getText().equalsIgnoreCase("nav")}?=> REGULAR_ID
	;

automatic_key
	:	{input.LT(1).getText().equalsIgnoreCase("automatic")}?=> REGULAR_ID
	;

last_key
	:	{input.LT(1).getText().equalsIgnoreCase("last")}?=> REGULAR_ID
	;

main_key
	:	{input.LT(1).getText().equalsIgnoreCase("main")}?=> REGULAR_ID
	;

grouping_key
	:	{input.LT(1).getText().equalsIgnoreCase("grouping")}?=> REGULAR_ID
	;

include_key
	:	{input.LT(1).getText().equalsIgnoreCase("include")}?=> REGULAR_ID
	;

ignore_key
	:	{input.LT(1).getText().equalsIgnoreCase("ignore")}?=> REGULAR_ID
	;

unique_key
	:	SQL92_RESERVED_UNIQUE
	;

submultiset_key
	:	{input.LT(1).getText().equalsIgnoreCase("submultiset")}?=> REGULAR_ID
	;

at_key
	:	{input.LT(1).getText().equalsIgnoreCase("at")}?=> REGULAR_ID
	;

a_key
	:	{input.LT(1).getText().equalsIgnoreCase("a")}?=> REGULAR_ID
	;

empty_key
	:	{input.LT(1).getText().equalsIgnoreCase("empty")}?=> REGULAR_ID
	;

likec_key
	:	{input.LT(1).getText().equalsIgnoreCase("likec")}?=> REGULAR_ID
	;

nan_key
	:	{input.LT(1).getText().equalsIgnoreCase("nan")}?=> REGULAR_ID
	;

infinite_key
	:	{input.LT(1).getText().equalsIgnoreCase("infinite")}?=> REGULAR_ID
	;

like2_key
	:	{input.LT(1).getText().equalsIgnoreCase("like2")}?=> REGULAR_ID
	;

like4_key
	:	{input.LT(1).getText().equalsIgnoreCase("like4")}?=> REGULAR_ID
	;

present_key
	:	{input.LT(1).getText().equalsIgnoreCase("present")}?=> REGULAR_ID
	;

dbtimezone_key
	:	{input.LT(1).getText().equalsIgnoreCase("dbtimezone")}?=> REGULAR_ID
	;

sessiontimezone_key
	:	{input.LT(1).getText().equalsIgnoreCase("sessiontimezone")}?=> REGULAR_ID
	;

nchar_cs_key
	:	{input.LT(1).getText().equalsIgnoreCase("nchar_cs")}?=> REGULAR_ID
	;

decompose_key
	:	{input.LT(1).getText().equalsIgnoreCase("decompose")}?=> REGULAR_ID
	;

following_key
	:	{input.LT(1).getText().equalsIgnoreCase("following")}?=> REGULAR_ID
	;

first_value_key
	:	{input.LT(1).getText().equalsIgnoreCase("first_value")}?=> REGULAR_ID
	;

preceding_key
	:	{input.LT(1).getText().equalsIgnoreCase("preceding")}?=> REGULAR_ID
	;

within_key
	:	{input.LT(1).getText().equalsIgnoreCase("within")}?=> REGULAR_ID
	;

canonical_key
	:	{input.LT(1).getText().equalsIgnoreCase("canonical")}?=> REGULAR_ID
	;

compatibility_key
	:	{input.LT(1).getText().equalsIgnoreCase("compatibility")}?=> REGULAR_ID
	;

over_key
	:	{input.LT(1).getText().equalsIgnoreCase("over")}?=> REGULAR_ID
	;

multiset_key
	:	{input.LT(1).getText().equalsIgnoreCase("multiset")}?=> REGULAR_ID
	;

last_value_key
	:	{input.LT(1).getText().equalsIgnoreCase("last_value")}?=> REGULAR_ID
	;

current_key
	:	{input.LT(1).getText().equalsIgnoreCase("current")}?=> REGULAR_ID
	;

unbounded_key
	:	{input.LT(1).getText().equalsIgnoreCase("unbounded")}?=> REGULAR_ID
	;

dense_rank_key
	:	{input.LT(1).getText().equalsIgnoreCase("dense_rank")}?=> REGULAR_ID
	;

cost_key
	:	{input.LT(1).getText().equalsIgnoreCase("cost")}?=> REGULAR_ID
	;

char_cs_key
	:	{input.LT(1).getText().equalsIgnoreCase("char_cs")}?=> REGULAR_ID
	;

auto_key
	:	{input.LT(1).getText().equalsIgnoreCase("auto")}?=> REGULAR_ID
	;

treat_key
	:	{input.LT(1).getText().equalsIgnoreCase("treat")}?=> REGULAR_ID
	;

content_key
	:	{input.LT(1).getText().equalsIgnoreCase("content")}?=> REGULAR_ID
	;

xmlparse_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlparse")}?=> REGULAR_ID
	;

xmlelement_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlelement")}?=> REGULAR_ID
	;

entityescaping_key
	:	{input.LT(1).getText().equalsIgnoreCase("entityescaping")}?=> REGULAR_ID
	;

standalone_key
	:	{input.LT(1).getText().equalsIgnoreCase("standalone")}?=> REGULAR_ID
	;

wellformed_key
	:	{input.LT(1).getText().equalsIgnoreCase("wellformed")}?=> REGULAR_ID
	;

xmlexists_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlexists")}?=> REGULAR_ID
	;

version_key
	:	{input.LT(1).getText().equalsIgnoreCase("version")}?=> REGULAR_ID
	;

xmlcast_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlcast")}?=> REGULAR_ID
	;

yes_key
	:	{input.LT(1).getText().equalsIgnoreCase("yes")}?=> REGULAR_ID
	;

no_key
	:	{input.LT(1).getText().equalsIgnoreCase("no")}?=> REGULAR_ID
	;

evalname_key
	:	{input.LT(1).getText().equalsIgnoreCase("evalname")}?=> REGULAR_ID
	;

xmlpi_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlpi")}?=> REGULAR_ID
	;

xmlcolattval_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlcolattval")}?=> REGULAR_ID
	;

document_key
	:	{input.LT(1).getText().equalsIgnoreCase("document")}?=> REGULAR_ID
	;

xmlforest_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlforest")}?=> REGULAR_ID
	;

passing_key
	:	{input.LT(1).getText().equalsIgnoreCase("passing")}?=> REGULAR_ID
	;

columns_key
	:	PLSQL_RESERVED_COLUMNS
	;

indent_key
	:	{input.LT(1).getText().equalsIgnoreCase("indent")}?=> REGULAR_ID
	;

hide_key
	:	{input.LT(1).getText().equalsIgnoreCase("hide")}?=> REGULAR_ID
	;

xmlagg_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlagg")}?=> REGULAR_ID
	;

path_key
	:	{input.LT(1).getText().equalsIgnoreCase("path")}?=> REGULAR_ID
	;

xmlnamespaces_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlnamespaces")}?=> REGULAR_ID
	;

size_key
	:	SQL92_RESERVED_SIZE
	;

noschemacheck_key
	:	{input.LT(1).getText().equalsIgnoreCase("noschemacheck")}?=> REGULAR_ID
	;

noentityescaping_key
	:	{input.LT(1).getText().equalsIgnoreCase("noentityescaping")}?=> REGULAR_ID
	;

xmlquery_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlquery")}?=> REGULAR_ID
	;

xmltable_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmltable")}?=> REGULAR_ID
	;

xmlroot_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlroot")}?=> REGULAR_ID
	;

schemacheck_key
	:	{input.LT(1).getText().equalsIgnoreCase("schemacheck")}?=> REGULAR_ID
	;

xmlattributes_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlattributes")}?=> REGULAR_ID
	;

encoding_key
	:	{input.LT(1).getText().equalsIgnoreCase("encoding")}?=> REGULAR_ID
	;

show_key
	:	{input.LT(1).getText().equalsIgnoreCase("show")}?=> REGULAR_ID
	;

xmlserialize_key
	:	{input.LT(1).getText().equalsIgnoreCase("xmlserialize")}?=> REGULAR_ID
	;

ordinality_key
	:	{input.LT(1).getText().equalsIgnoreCase("ordinality")}?=> REGULAR_ID
	;

defaults_key
	:	{input.LT(1).getText().equalsIgnoreCase("defaults")}?=> REGULAR_ID
	;

insert_key
	:	SQL92_RESERVED_INSERT
	;

order_key
	:	SQL92_RESERVED_ORDER
	;

minus_key
	:	PLSQL_RESERVED_MINUS
	;

row_key
	:	{input.LT(1).getText().equalsIgnoreCase("row")}? REGULAR_ID
	;

mod_key
	:	{input.LT(1).getText().equalsIgnoreCase("mod")}? REGULAR_ID
	;

raw_key
	:	{input.LT(1).getText().equalsIgnoreCase("raw")}?=> REGULAR_ID
	;

power_key
	:	{input.LT(1).getText().equalsIgnoreCase("power")}? REGULAR_ID
	;

lock_key
	:	PLSQL_RESERVED_LOCK
	;

exists_key
	:	SQL92_RESERVED_EXISTS
	;

having_key
	:	SQL92_RESERVED_HAVING
	;

any_key
	:	SQL92_RESERVED_ANY
	;

with_key
	:	SQL92_RESERVED_WITH
	;

transaction_key
	:	{input.LT(1).getText().equalsIgnoreCase("transaction")}?=> REGULAR_ID
	;

rawtohex_key
	:	{input.LT(1).getText().equalsIgnoreCase("rawtohex")}? REGULAR_ID
	;

number_key
	:	{input.LT(1).getText().equalsIgnoreCase("number")}?=> REGULAR_ID
	;

nocopy_key
	:	{input.LT(1).getText().equalsIgnoreCase("nocopy")}?=> REGULAR_ID
	;

to_key
	:	SQL92_RESERVED_TO
	;

abs_key
	:	{input.LT(1).getText().equalsIgnoreCase("abs")}? REGULAR_ID
	;

rollback_key
	:	{input.LT(1).getText().equalsIgnoreCase("rollback")}?=> REGULAR_ID
	;

share_key
	:	PLSQL_RESERVED_SHARE
	;

greatest_key
	:	{input.LT(1).getText().equalsIgnoreCase("greatest")}? REGULAR_ID
	;

vsize_key
	:	{input.LT(1).getText().equalsIgnoreCase("vsize")}? REGULAR_ID
	;

exclusive_key
	:	PLSQL_RESERVED_EXCLUSIVE
	;

varchar2_key
	:	{input.LT(1).getText().equalsIgnoreCase("varchar2")}?=> REGULAR_ID
	;

rowidtochar_key
	:	{input.LT(1).getText().equalsIgnoreCase("rowidtochar")}? REGULAR_ID
	;

open_key
	:	{input.LT(1).getText().equalsIgnoreCase("open")}?=> REGULAR_ID
	;

comment_key
	:	{input.LT(1).getText().equalsIgnoreCase("comment")}?=> REGULAR_ID
	;

sqrt_key
	:	{input.LT(1).getText().equalsIgnoreCase("sqrt")}? REGULAR_ID
	;

instr_key
	:	{input.LT(1).getText().equalsIgnoreCase("instr")}? REGULAR_ID
	;

nowait_key
	:	PLSQL_RESERVED_NOWAIT
	;

lpad_key
	:	{input.LT(1).getText().equalsIgnoreCase("lpad")}? REGULAR_ID
	;

boolean_key
	:	{input.LT(1).getText().equalsIgnoreCase("boolean")}?=> REGULAR_ID
	;

rpad_key
	:	{input.LT(1).getText().equalsIgnoreCase("rpad")}? REGULAR_ID
	;

savepoint_key
	:	{input.LT(1).getText().equalsIgnoreCase("savepoint")}?=> REGULAR_ID
	;

decode_key
	:	{input.LT(1).getText().equalsIgnoreCase("decode")}? REGULAR_ID
	;

reverse_key
	:	{input.LT(1).getText().equalsIgnoreCase("reverse")}? REGULAR_ID
	;

least_key
	:	{input.LT(1).getText().equalsIgnoreCase("least")}? REGULAR_ID
	;

nvl_key
	:	{input.LT(1).getText().equalsIgnoreCase("nvl")}? REGULAR_ID
	;

variance_key
	:	{input.LT(1).getText().equalsIgnoreCase("variance")}? REGULAR_ID
	;

start_key
	:	PLSQL_RESERVED_START
	;

desc_key
	:	SQL92_RESERVED_DESC
	;

concat_key
	:	{input.LT(1).getText().equalsIgnoreCase("concat")}? REGULAR_ID
	;

dump_key
	:	{input.LT(1).getText().equalsIgnoreCase("dump")}? REGULAR_ID
	;

soundex_key
	:	{input.LT(1).getText().equalsIgnoreCase("soundex")}? REGULAR_ID
	;

positive_key
	:	{input.LT(1).getText().equalsIgnoreCase("positive")}?=> REGULAR_ID
	;

union_key
	:	SQL92_RESERVED_UNION
	;

ascii_key
	:	{input.LT(1).getText().equalsIgnoreCase("ascii")}? REGULAR_ID
	;

connect_key
	:	SQL92_RESERVED_CONNECT
	;

asc_key
	:	SQL92_RESERVED_ASC
	;

hextoraw_key
	:	{input.LT(1).getText().equalsIgnoreCase("hextoraw")}? REGULAR_ID
	;

to_date_key
	:	{input.LT(1).getText().equalsIgnoreCase("to_date")}? REGULAR_ID
	;

floor_key
	:	{input.LT(1).getText().equalsIgnoreCase("floor")}? REGULAR_ID
	;

sign_key
	:	{input.LT(1).getText().equalsIgnoreCase("sign")}? REGULAR_ID
	;

update_key
	:	SQL92_RESERVED_UPDATE
	;

trunc_key
	:	{input.LT(1).getText().equalsIgnoreCase("trunc")}? REGULAR_ID
	;

rtrim_key
	:	{input.LT(1).getText().equalsIgnoreCase("rtrim")}? REGULAR_ID
	;

close_key
	:	{input.LT(1).getText().equalsIgnoreCase("close")}?=> REGULAR_ID
	;

to_char_key
	:	{input.LT(1).getText().equalsIgnoreCase("to_char")}? REGULAR_ID
	;

ltrim_key
	:	{input.LT(1).getText().equalsIgnoreCase("ltrim")}? REGULAR_ID
	;

mode_key
	:	PLSQL_RESERVED_MODE
	;

uid_key
	:	{input.LT(1).getText().equalsIgnoreCase("uid")}? REGULAR_ID
	;

chr_key
	:	{input.LT(1).getText().equalsIgnoreCase("chr")}? REGULAR_ID
	;

intersect_key
	:	SQL92_RESERVED_INTERSECT
	;

chartorowid_key
	:	{input.LT(1).getText().equalsIgnoreCase("chartorowid")}? REGULAR_ID
	;

mlslabel_key
	:	{input.LT(1).getText().equalsIgnoreCase("mlslabel")}?=> REGULAR_ID
	;

userenv_key
	:	{input.LT(1).getText().equalsIgnoreCase("userenv")}? REGULAR_ID
	;

stddev_key
	:	{input.LT(1).getText().equalsIgnoreCase("stddev")}? REGULAR_ID
	;

length_key
	:	{input.LT(1).getText().equalsIgnoreCase("length")}? REGULAR_ID
	;

fetch_key
	:	SQL92_RESERVED_FETCH
	;

group_key
	:	SQL92_RESERVED_GROUP
	;

sysdate_key
	:	{input.LT(1).getText().equalsIgnoreCase("sysdate")}? REGULAR_ID
	;

binary_integer_key
	:	{input.LT(1).getText().equalsIgnoreCase("binary_integer")}?=> REGULAR_ID
	;

to_number_key
	:	{input.LT(1).getText().equalsIgnoreCase("to_number")}? REGULAR_ID
	;

substr_key
	:	{input.LT(1).getText().equalsIgnoreCase("substr")}? REGULAR_ID
	;

ceil_key
	:	{input.LT(1).getText().equalsIgnoreCase("ceil")}? REGULAR_ID
	;

initcap_key
	:	{input.LT(1).getText().equalsIgnoreCase("initcap")}? REGULAR_ID
	;

round_key
	:	{input.LT(1).getText().equalsIgnoreCase("round")}? REGULAR_ID
	;

long_key
	:	{input.LT(1).getText().equalsIgnoreCase("long")}?=> REGULAR_ID
	;

read_key
	:	{input.LT(1).getText().equalsIgnoreCase("read")}?=> REGULAR_ID
	;

only_key
	:	{input.LT(1).getText().equalsIgnoreCase("only")}? REGULAR_ID
	;

set_key
	:	{input.LT(1).getText().equalsIgnoreCase("set")}?=> REGULAR_ID
	;

nullif_key
	:	{input.LT(1).getText().equalsIgnoreCase("nullif")}? REGULAR_ID
	;

coalesce_key
	:	{input.LT(1).getText().equalsIgnoreCase("coalesce")}? REGULAR_ID
	;

count_key
	:	{input.LT(1).getText().equalsIgnoreCase("count")}? REGULAR_ID
	;

avg_key	:	{input.LT(1).getText().equalsIgnoreCase("avg")}? REGULAR_ID
	;

max_key	:	{input.LT(1).getText().equalsIgnoreCase("max")}? REGULAR_ID
	;

min_key	:	{input.LT(1).getText().equalsIgnoreCase("min")}? REGULAR_ID
	;

sum_key	:	{input.LT(1).getText().equalsIgnoreCase("sum")}? REGULAR_ID
	;

unknown_key
	:	{input.LT(1).getText().equalsIgnoreCase("unknown")}? REGULAR_ID
	;

escape_key
	:	{input.LT(1).getText().equalsIgnoreCase("escape")}? REGULAR_ID
	;

some_key
	:	{input.LT(1).getText().equalsIgnoreCase("some")}? REGULAR_ID
	;

match_key
	:	{input.LT(1).getText().equalsIgnoreCase("match")}? REGULAR_ID
	;

cast_key
	:	{input.LT(1).getText().equalsIgnoreCase("cast")}? REGULAR_ID
	;

full_key:	{input.LT(1).getText().equalsIgnoreCase("full")}?=> REGULAR_ID
	;

partial_key
	:	{input.LT(1).getText().equalsIgnoreCase("partial")}? REGULAR_ID
	;

character_key
	:	{input.LT(1).getText().equalsIgnoreCase("character")}?=> REGULAR_ID
	;

except_key
	:	{input.LT(1).getText().equalsIgnoreCase("except")}? REGULAR_ID
	;

char_key:	{input.LT(1).getText().equalsIgnoreCase("char")}?=> REGULAR_ID
	;

varying_key
	:	{input.LT(1).getText().equalsIgnoreCase("varying")}?=> REGULAR_ID
	;

varchar_key
	:	{input.LT(1).getText().equalsIgnoreCase("varchar")}?=> REGULAR_ID
	;

national_key
	:	{input.LT(1).getText().equalsIgnoreCase("national")}? REGULAR_ID
	;

nchar_key
	:	{input.LT(1).getText().equalsIgnoreCase("nchar")}? REGULAR_ID
	;

bit_key	:	{input.LT(1).getText().equalsIgnoreCase("bit")}? REGULAR_ID
	;

float_key
	:	{input.LT(1).getText().equalsIgnoreCase("float")}? REGULAR_ID
	;
	
real_key:	{input.LT(1).getText().equalsIgnoreCase("real")}?=> REGULAR_ID
	;

double_key
	:	{input.LT(1).getText().equalsIgnoreCase("double")}?=> REGULAR_ID
	;

precision_key
	:	{input.LT(1).getText().equalsIgnoreCase("precision")}? REGULAR_ID
	;

interval_key
	:	{input.LT(1).getText().equalsIgnoreCase("interval")}?=> REGULAR_ID
	;

time_key
	:	{input.LT(1).getText().equalsIgnoreCase("time")}? REGULAR_ID
	;
 
zone_key:	{input.LT(1).getText().equalsIgnoreCase("zone")}? REGULAR_ID
	;

timestamp_key
	:	{input.LT(1).getText().equalsIgnoreCase("timestamp")}? REGULAR_ID
	;

date_key:	{input.LT(1).getText().equalsIgnoreCase("date")}?=> REGULAR_ID
	;

numeric_key
	:	{input.LT(1).getText().equalsIgnoreCase("numeric")}?=> REGULAR_ID
	;

decimal_key
	:	{input.LT(1).getText().equalsIgnoreCase("decimal")}?=> REGULAR_ID
	;

dec_key	:	{input.LT(1).getText().equalsIgnoreCase("dec")}?=> REGULAR_ID
	;

integer_key
	:	{input.LT(1).getText().equalsIgnoreCase("integer")}?=> REGULAR_ID
	;

int_key	:	{input.LT(1).getText().equalsIgnoreCase("int")}?=> REGULAR_ID
	;

smallint_key
	:	{input.LT(1).getText().equalsIgnoreCase("smallint")}?=> REGULAR_ID
	;

corresponding_key
	:	{input.LT(1).getText().equalsIgnoreCase("corresponding")}? REGULAR_ID
	;

cross_key
	:	{input.LT(1).getText().equalsIgnoreCase("cross")}?=> REGULAR_ID
	;

join_key
	:	{input.LT(1).getText().equalsIgnoreCase("join")}?=> REGULAR_ID
	;

left_key
	:	{input.LT(1).getText().equalsIgnoreCase("left")}?=> REGULAR_ID
	;

right_key
	:	{input.LT(1).getText().equalsIgnoreCase("right")}?=> REGULAR_ID
	;

inner_key
	:	{input.LT(1).getText().equalsIgnoreCase("inner")}?=> REGULAR_ID
	;

natural_key
	:	{input.LT(1).getText().equalsIgnoreCase("natural")}?=> REGULAR_ID
	;

outer_key
	:	{input.LT(1).getText().equalsIgnoreCase("outer")}?=> REGULAR_ID
	;

using_key
	:	PLSQL_NON_RESERVED_USING
	;

indicator_key
	:	{input.LT(1).getText().equalsIgnoreCase("indicator")}? REGULAR_ID
	;

user_key
	:	{input.LT(1).getText().equalsIgnoreCase("user")}? REGULAR_ID
	;

current_user_key
	:	{input.LT(1).getText().equalsIgnoreCase("current_user")}? REGULAR_ID
	;

session_user_key
	:	{input.LT(1).getText().equalsIgnoreCase("session_user")}? REGULAR_ID
	;

system_user_key
	:	{input.LT(1).getText().equalsIgnoreCase("system_user")}? REGULAR_ID
	;

value_key
	:	{input.LT(1).getText().equalsIgnoreCase("value")}? REGULAR_ID
	;

substring_key
	:	{input.LT(1).getText().equalsIgnoreCase("substring")}?=> REGULAR_ID
	;

upper_key
	:	{input.LT(1).getText().equalsIgnoreCase("upper")}? REGULAR_ID
	;

lower_key
	:	{input.LT(1).getText().equalsIgnoreCase("lower")}? REGULAR_ID
	;

convert_key
	:	{input.LT(1).getText().equalsIgnoreCase("convert")}? REGULAR_ID
	;

translate_key
	:	{input.LT(1).getText().equalsIgnoreCase("translate")}? REGULAR_ID
	;

trim_key
	:	{input.LT(1).getText().equalsIgnoreCase("trim")}? REGULAR_ID
	;

leading_key
	:	{input.LT(1).getText().equalsIgnoreCase("leading")}? REGULAR_ID
	;

trailing_key
	:	{input.LT(1).getText().equalsIgnoreCase("trailing")}? REGULAR_ID
	;

both_key
	:	{input.LT(1).getText().equalsIgnoreCase("both")}? REGULAR_ID
	;

collate_key
	:	{input.LT(1).getText().equalsIgnoreCase("collate")}? REGULAR_ID
	;

position_key
	:	{input.LT(1).getText().equalsIgnoreCase("position")}? REGULAR_ID
	;

extract_key
	:	{input.LT(1).getText().equalsIgnoreCase("extract")}? REGULAR_ID
	;

second_key
	:	{input.LT(1).getText().equalsIgnoreCase("second")}? REGULAR_ID
	;

timezone_hour_key
	:	{input.LT(1).getText().equalsIgnoreCase("timezone_hour")}? REGULAR_ID
	;

timezone_minute_key
	:	{input.LT(1).getText().equalsIgnoreCase("timezone_minute")}? REGULAR_ID
	;

char_length_key
	:	{input.LT(1).getText().equalsIgnoreCase("char_length")}? REGULAR_ID
	;

octet_length_key
	:	{input.LT(1).getText().equalsIgnoreCase("octet_length")}? REGULAR_ID
	;

character_length_key
	:	{input.LT(1).getText().equalsIgnoreCase("character_length")}? REGULAR_ID
	;

bit_length_key
	:	{input.LT(1).getText().equalsIgnoreCase("bit_length")}? REGULAR_ID
	;

local_key
	:	{input.LT(1).getText().equalsIgnoreCase("local")}? REGULAR_ID
	;

current_timestamp_key
	:	{input.LT(1).getText().equalsIgnoreCase("current_timestamp")}? REGULAR_ID
	;

current_date_key
	:	{input.LT(1).getText().equalsIgnoreCase("current_date")}? REGULAR_ID
	;

current_time_key
	:	{input.LT(1).getText().equalsIgnoreCase("current_time")}? REGULAR_ID
	;

module_key
	:	{input.LT(1).getText().equalsIgnoreCase("module")}? REGULAR_ID
	;

global_key
	:	{input.LT(1).getText().equalsIgnoreCase("global")}? REGULAR_ID
	;

year_key
	:	{input.LT(1).getText().equalsIgnoreCase("year")}?=> REGULAR_ID
	;

month_key
	:	{input.LT(1).getText().equalsIgnoreCase("month")}? REGULAR_ID
	;

day_key
	:	{input.LT(1).getText().equalsIgnoreCase("day")}?=> REGULAR_ID
	;

hour_key:	{input.LT(1).getText().equalsIgnoreCase("hour")}? REGULAR_ID
	;

minute_key
	:	{input.LT(1).getText().equalsIgnoreCase("minute")}? REGULAR_ID
	;

is_key
	:	SQL92_RESERVED_IS
	;

else_key
	:	SQL92_RESERVED_ELSE
	;

table_key
	:	SQL92_RESERVED_TABLE
	;

then_key
	:	SQL92_RESERVED_THEN
	;

end_key
	:	SQL92_RESERVED_END
	;

all_key
	:	SQL92_RESERVED_ALL
	;

on_key
	:	SQL92_RESERVED_ON
	;

or_key
	:	SQL92_RESERVED_OR
	;

and_key
	:	SQL92_RESERVED_AND
	;

not_key
	:	SQL92_RESERVED_NOT
	;

true_key
	:	SQL92_RESERVED_TRUE
	;

false_key
	:	SQL92_RESERVED_FALSE
	;

default_key
	:	SQL92_RESERVED_DEFAULT
	;

distinct_key
	:	SQL92_RESERVED_DISTINCT
	;

into_key
	:	SQL92_RESERVED_INTO
	;

by_key
	:	SQL92_RESERVED_BY
	;

as_key
	:	SQL92_RESERVED_AS
	;

in_key
	:	SQL92_RESERVED_IN
	;

of_key
	:	SQL92_RESERVED_OF
	;

null_key
	:	SQL92_RESERVED_NULL
	;

for_key
	:	SQL92_RESERVED_FOR
	;

select_key
	:	SQL92_RESERVED_SELECT
	;

when_key
	:	SQL92_RESERVED_WHEN
	;

delete_key
	:	SQL92_RESERVED_DELETE
	;

between_key
	:	SQL92_RESERVED_BETWEEN
	;

like_key
	:	SQL92_RESERVED_LIKE
	;

from_key
	:	SQL92_RESERVED_FROM
	;

where_key
	:	SQL92_RESERVED_WHERE
	;
