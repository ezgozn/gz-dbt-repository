with sales as (
    select
        order_id,
        product_id,
        quantity,
        date_date,
        revenue
    from {{ ref('stg_raw__sales') }}
),

products as (
    select
        product_id,
        purchase_price,
    from {{ ref('stg_raw__products') }}
)

select
    sales.date_date,
    sales.order_id,
    sales.product_id,
    sales.quantity,
    sales.revenue,
    products.purchase_price,
    -- Business logic calculations
    ROUND(products.purchase_price * sales.quantity, 2) as purchase_cost,
    ROUND(sales.revenue - (products.purchase_price * sales.quantity), 2) as gross_margin
from sales
left join products on sales.product_id = products.product_id
