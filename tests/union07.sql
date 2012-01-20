--
-- note: this query was copied from the druid project
-- http://code.alibabatech.com/wiki/display/druid/home
-- 
select *
from (select row_.*, rownum as rownum_
        from (select *
                from (select results.*, row_number() over (partition by (results.object_id) order by results.gmt_modified desc) as rn
                        from (select sus.id as id, sus.gmt_create as gmt_create, sus.gmt_modified as gmt_modified, sus.company_id as company_id, sus.object_id as object_id
                                        , sus.object_type as object_type, sus.confirm_type as confirm_type, sus.operator as operator, sus.filter_type as filter_type, sus.member_id as member_id
                                        , sus.member_fuc_q as member_fuc_q, sus.risk_type as risk_type, 'y' as is_draft
                                from f_u_c_ sus, a_b_c_draft p, member m
                                where 1 = 1 and p.company_id = m.company_id and m.login_id = :2 and (p.sale_type in (:4) and p.id = sus.object_id)
                                union
                                select sus.id as id, sus.gmt_create as gmt_create, sus.gmt_modified as gmt_modified, sus.company_id as company_id, sus.object_id as object_id
                                        , sus.object_type as object_type, sus.confirm_type as confirm_type, sus.operator as operator, sus.filter_type as filter_type, sus.member_id as member_id
                                        , sus.member_fuc_q as member_fuc_q, sus.risk_type as risk_type, 'n' as is_draft
                                from f_u_c_ sus, a_b_c p, member m
                                where 1 = 1 and p.company_id = m.company_id and m.login_id = :3 and (p.sale_type in (:5) and p.id = sus.object_id)
                                ) results
                        )
                where rn = 1
                order by gmt_modified desc
                ) row_
        where rownum <= :1
        )
where rownum_ >= :1;
