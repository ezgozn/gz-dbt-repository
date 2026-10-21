with 

source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        products_id as product_id,
        CAST(purchse_price AS FLOAT64) as purchase_id

    from source

)

select * from renamed