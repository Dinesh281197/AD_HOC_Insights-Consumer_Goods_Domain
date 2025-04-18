/*10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order*/ 


with cte as(
SELECT division, product_code, product,sum(sold_quantity) as total_sold_quantity FROM fact_sales_monthly
join dim_product
using(product_code)
where fiscal_year=2021
group by division, product_code, product),
cte_2 as(
select *, dense_rank() over(partition by division order by total_sold_quantity desc) as rank_order from cte)

select * from cte_2
where rank_order <= 3
order by division,rank_order
