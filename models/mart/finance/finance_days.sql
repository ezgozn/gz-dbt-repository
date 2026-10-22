
WITH orders_per_day AS (
    SELECT
        date_date,
        count(DISTINCT order_id) AS nb_transactions,
        Round(sum(order_revenue), 2) as total_revenue,
        Round(sum(order_purchase_cost), 2) as total_purchase_cost,
        Round(sum(order_gross_margin), 2) as total_gross_margin,
        Round(sum(shipping_fee), 2) as total_shipping_fee,
        Round(sum(logcost), 2) as total_logcost,
        Round(sum(ship_cost), 2) as total_ship_cost,
        Round(sum(operational_margin), 2) as total_operational_margin
    FROM {{ ref('int_orders_operational') }}
    GROUP BY date_date
)
SELECT
    date_date,
    total_revenue,
    total_purchase_cost,
    total_gross_margin,
    total_logcost,
    total_ship_cost,
    total_operational_margin,
    ROUND(total_revenue / NULLIF(nb_transactions, 0), 2) AS average_basket
FROM orders_per_day
order by date_date DESC
