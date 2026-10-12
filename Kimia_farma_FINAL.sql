WITH base_analysis AS(
SELECT 
	t.transaction_id,
	t.date,
	t.branch_id,
    k.branch_name,
    k.kota,
    k.provinsi,
    k.rating AS rating_cabang,
    t.customer_name,
    p.product_id,
    p.product_name,
    p.price AS actual_price,
    t.discount_percentage,
	t.rating AS rating_transaksi,
    CASE
		WHEN p.price <= 50000 THEN 0.10
        WHEN p.price < 100000 THEN 0.15
        WHEN p.price < 300000 THEN 0.20
        WHEN p.price < 500000 THEN 0.25
        WHEN p.price >500000 THEN 0.30
	END AS persentase_gross_laba,
	p.price * ( 1 - t.discount_percentage ) AS nett_sales

FROM kimia_farma.kf_final_transaction AS t
LEFT JOIN kimia_farma.kf_kantor_cabang AS k
	ON t.branch_id = k.branch_id
LEFT JOIN kimia_farma.kf_product AS p
 ON t.product_id = p.product_id
 )
 
 SELECT *,
 persentase_gross_laba * nett_sales AS nett_profit
 FROM base_analysis
    
ORDER BY t.date DESC;