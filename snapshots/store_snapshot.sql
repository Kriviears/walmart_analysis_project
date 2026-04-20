{% snapshot store_snapshot %}

    {{
        config(
            target_schema="snapshots",
            unique_key="store_id",
            strategy="check",
            check_cols=[
                "fuel_price",
                "store_temperature",
                "unemployment",
                "cpi",
                "markdown1",
                "markdown2",
                "markdown3",
                "markdown4",
                "markdown5",
            ],
        )
    }}

    select *
    from {{ ref("silver_facts") }}

{% endsnapshot %}
