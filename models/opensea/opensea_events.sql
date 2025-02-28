{{ config(
        alias ='events',
        post_hook='{{ expose_spells(\'["ethereum","solana"]\',
                                            "project",
                                            "opensea",
                                            \'["rchen8","soispoke"]\') }}'
)
}}

SELECT *
FROM
(
        SELECT
                blockchain,
                project,
                version,
                block_time,
                token_id,
                collection,
                amount_usd,
                token_standard,
                trade_type,
                CAST(number_of_items AS DECIMAL(38,0)) number_of_items,
                trade_category,
                evt_type,
                seller,
                buyer,
                amount_original,
                CAST(amount_raw AS DECIMAL(38,0)) amount_raw,
                currency_symbol,
                currency_contract,
                nft_contract_address,
                project_contract_address,
                aggregator_name,
                aggregator_address,
                tx_hash,
                block_number,
                tx_from,
                tx_to,
                platform_fee_amount_raw,
                platform_fee_amount,
                platform_fee_amount_usd,
                CAST(platform_fee_percentage AS DOUBLE) platform_fee_percentage,
                royalty_fee_amount_raw,
                royalty_fee_amount,
                royalty_fee_amount_usd,
                CAST(royalty_fee_percentage AS DOUBLE) royalty_fee_percentage,
                royalty_fee_receive_address,
                royalty_fee_currency_symbol,
                unique_trade_id
        FROM {{ ref('opensea_ethereum_events') }}
        UNION ALL
        SELECT
                blockchain,
                project,
                version,
                block_time,
                CAST(NULL AS VARCHAR(5)) as token_id,
                CAST(NULL AS VARCHAR(5)) as collection,
                amount_usd,
                token_standard,
                CAST(NULL AS VARCHAR(5)) as trade_type,
                CAST(NULL AS DECIMAL(38,0)) as number_of_items,
                CAST(NULL AS VARCHAR(5)) as trade_category,
                evt_type,
                CAST(NULL AS VARCHAR(5)) as seller,
                CAST(NULL AS VARCHAR(5)) as buyer,
                amount_original,
                CAST(amount_raw AS DECIMAL(38,0)) AS amount_raw,
                currency_symbol,
                currency_contract,
                CAST(NULL AS VARCHAR(5)) as nft_contract_address,
                project_contract_address,
                CAST(NULL AS VARCHAR(5)) as aggregator_name,
                CAST(NULL AS VARCHAR(5)) as aggregator_address,
                tx_hash,
                block_number,
                CAST(NULL AS VARCHAR(5)) as tx_from,
                CAST(NULL AS VARCHAR(5)) as tx_to,
                CAST(NULL AS DOUBLE) AS platform_fee_amount_raw,
                CAST(NULL AS DOUBLE) AS platform_fee_amount,
                CAST(NULL AS DOUBLE) AS platform_fee_amount_usd,
                CAST(NULL AS DOUBLE) as platform_fee_percentage,
                CAST(NULL AS DOUBLE) as royalty_fee_amount_raw,
                CAST(NULL AS DOUBLE) as royalty_fee_amount,
                CAST(NULL AS DOUBLE) as royalty_fee_amount_usd,
                CAST(NULL AS DOUBLE) as royalty_fee_percentage,
                CAST(NULL AS DOUBLE) as royalty_fee_receive_address,
                CAST(NULL AS DOUBLE) as royalty_fee_currency_symbol,
                unique_trade_id
        FROM {{ ref('opensea_solana_events') }}
)