sql_execute explain select o_orderpriority, count(*) as order_count from orders where o_orderdate >= '1995-03-01' and o_orderdate < adddate('1995-03-01', 90) and exists ( select * from lineitem where l_orderkey = o_orderkey and l_commitdate < l_receiptdate ) group by o_orderpriority order by o_orderpriority

sql_execute select * from show
