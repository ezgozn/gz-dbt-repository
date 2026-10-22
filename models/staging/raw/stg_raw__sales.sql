with 

source as (

    select * from {{ source('raw', 'sales') }}

),

renamed as (

    select
        CAST(date_date AS DATE) as date_date,
        orders_id as order_id,
        pdt_id as product_id,
        revenue,
        quantity

    from source

)

select * from renamed