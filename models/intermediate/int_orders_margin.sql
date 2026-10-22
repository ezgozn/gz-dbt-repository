with sales_margin as (
    select
        order_id,
        product_id,
        quantity,
        date_date,
        revenue,
        purchase_cost,
        gross_margin
    from {{ ref('int_sales_margin') }}
)

select
    order_id,
    max(date_date) as date_date,
    ROUND(sum(quantity), 2) as order_quantity,
    ROUND(sum(revenue), 2) as order_revenue,
    ROUND(sum(purchase_cost), 2) as order_purchase_cost,
    ROUND(sum(gross_margin), 2) as order_gross_margin
from sales_margin
GROUP by order_id
ORDER BY order_id DESC
