CREATE TABLE lineitem (
	l_orderkey INTEGER,
	l_partkey INTEGER,
	l_suppkey INTEGER,
	l_linenumber INTEGER,
	l_quantity DECIMAL(10,2),
	l_extendedprice DECIMAL(10,2),
	l_discount DECIMAL(10,2),
	l_tax DECIMAL(10,2),
	l_returnflag CHAR(1),
	l_linestatus CHAR(1),
	l_shipDATE DATE,
	l_commitDATE DATE,
	l_receiptDATE DATE,
	l_shipinstruct CHAR(25),
	l_shipmode CHAR(10),
	l_comment VARCHAR(44),
	PRIMARY KEY (l_orderkey, l_linenumber), 
	index i_l_shipdate (l_shipdate),
	index i_l_suppkey_partkey (l_partkey, l_suppkey),
	index i_l_partkey (l_partkey), 
	index i_l_suppkey (l_suppkey),
	index i_l_receiptdate (l_receiptdate),
	index i_l_orderkey (l_orderkey),
	index i_l_orderkey_quantity (l_orderkey, l_quantity), 
	index i_l_commitdate (l_commitdate)
);
