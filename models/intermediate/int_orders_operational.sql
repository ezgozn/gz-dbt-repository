with orders_margin as (
    select
        order_id,
        date_date,
        order_quantity,
        order_revenue,
        order_purchase_cost,
        order_gross_margin
    from {{ ref('int_orders_margin') }}
),

ship as (
    select
        order_id,
        shipping_fee,
        logcost,
        ship_cost
    from {{ ref('stg_raw__ship') }}
)

select
    orders_margin.date_date,
    orders_margin.order_id,
	orders_margin.order_quantity,
	orders_margin.order_revenue,
	orders_margin.order_purchase_cost,
	orders_margin.order_gross_margin,
	ship.shipping_fee,
	ship.logcost,
	ship.ship_cost,
    -- Business logic calculations
    ROUND(orders_margin.order_gross_margin + ship.shipping_fee - (ship.ship_cost + ship.logcost), 2) as operational_margin
from orders_margin
left join ship on orders_margin.order_id = ship.order_id
ORDER BY order_id desc

