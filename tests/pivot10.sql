 SELECT *
 FROM s JOIN d USING(c)
 PIVOT
 (
 MAX(c_c_p) as max_ccp
 , MAX(d_c_p) max_dcp
 , MAX(d_x_p) dxp
 , COUNT(1) cnt
 FOR (i, p) IN
 (
 (1,1) as one_one,
 (1,2) as one_two,
 (1,3) as one_three,
 (2,1) as two_one,
 (2,2) as two_two,
 (2,3) as two_three
 )
 )						 
 WHERE d_t = 'P'
