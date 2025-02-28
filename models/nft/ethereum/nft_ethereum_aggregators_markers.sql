{{ config(
        alias ='aggregators_markers',
		materialized = 'view',
        unique_key='hash_marker',
        post_hook='{{ expose_spells(\'["ethereum"]\',
                                    "sector",
                                    "nft",
                                    \'["hildobby"]\') }}')
}}

 WITH reservoir AS (
    SELECT distinct substring(unhex(regexp_replace(data, '^.*00', '')), 2, length(unhex(regexp_replace(data, '^.*00', '')))-2) AS router_website
    , regexp_replace(data, '^.*00', '') AS hash_marker
    FROM {{ source('ethereum','transactions') }}
    WHERE to IN (
        '0x00000000006c3852cbef3e08e8df289169ede581', --seaport
        '0x74312363e45dcaba76c59ec49a7aa8a65a67eed3', --x2y2
        '0x59728544b08ab483533076417fbbb2fd0b17ce3a', --looksrare
        '0x9ebfb53fa8526906738856848a27cb11b0285c3f'  --reservoir
    )
    AND RIGHT(data, 2) = '1f'
    AND LEFT(regexp_replace(data, '^.*00', ''), 2)='1f'
    AND regexp_replace(data, '^.*00', '') != '1f'
    AND length(regexp_replace(data, '^.*00', ''))%2 = 0
    AND block_time > '2022-10-15'
    )

SELECT hash_marker
, 'Reservoir' AS aggregator_name
, CASE WHEN router_website='ens.vision' THEN 'ENS.Vision'
    WHEN router_website='nftnerds.ai' THEN 'NFTNerds'
    WHEN router_website='0xba5ed0773240626366a7eb3a4bea22f0dd46b1b5' THEN 'Unknown'
    WHEN router_website='rare.id' THEN 'Rare.ID'
    WHEN router_website='sound.xyz' THEN 'Sound'
    WHEN router_website='freshdrops.io' THEN 'freshdrops'
    WHEN router_website='buy.onchainbirds.com' THEN 'OnChainBirds'
    WHEN router_website='app.gmtools.xyz' THEN 'GM Tools'
    WHEN router_website='sansa.xyz' THEN 'sansa'
    WHEN router_website='anotherblock.io' THEN 'anotherblock'
    WHEN router_website='koinect.com' THEN 'koinfetti'
    WHEN router_website='9dcc.market' THEN '9dcc'
    WHEN router_website='3landersnft.com' THEN '3Landers'
    WHEN router_website='marketplace.piratesnft.io' THEN 'Pirates of the Metaverse'
    WHEN router_website='market.wagmiarmy.io' THEN 'WAGMI ARMY'
    WHEN router_website='marketplace.nfteams.club' THEN 'NFTeams'
    WHEN router_website='firstmate.xyz' THEN 'FirstMate'
    WHEN router_website='reservoir.market' THEN 'Reservoir'
    WHEN router_website='market.inbetweeners.io' THEN 'inBetweeners'
    WHEN router_website='mintify.xyz' THEN 'mintify'
    WHEN router_website='marketplace.truthlabs.co' THEN 'Truth Labs'
    WHEN router_website='marketplace.tajigen.xyz' THEN 'Citizens of Tajigen'
    WHEN router_website='market.techieclub.co' THEN 'Techie Club'
    WHEN router_website='spryng.xyz' THEN 'Spryng'
    WHEN router_website='marketplace.mobo.xyz' THEN 'Mobo Marketplace'
    WHEN router_website='nft.coinbase.com' THEN 'Coinbase NFT'
    WHEN router_website='parcel.so' THEN 'Parcel'
    WHEN router_website='underground.deadbirds.io' THEN 'Dead Birds Society'
    WHEN router_website='localhost' THEN 'Unknown'
    WHEN router_website='gmoney.market' THEN 'gmoney market'
    WHEN router_website='marketplace.cryptochicks.app' THEN 'CryptoChicks'
    WHEN router_website='market.memnfts.com' THEN 'Mems'
    WHEN router_website='marketplace.eyeverse.world' THEN 'Eyeverse'
    WHEN router_website='eye.watch' THEN 'Eye Watch'
    WHEN router_website='your.source' THEN 'Unknown'
    WHEN router_website='marketplace-wine-xi.vercel.app' THEN 'Unknown'
    WHEN router_website='mems.reservoir.market' THEN 'Mems'
    WHEN router_website='development.mysterious.io' THEN 'Mysterious'
    WHEN router_website='bayc.snag-render.com' THEN 'Unknown'
    WHEN router_website='tod-market.vercel.app' THEN 'The Odd District'
    WHEN router_website='terraformexplorer.xyz' THEN 'terraform explorer'
    WHEN router_website='skry.xyz' THEN 'SKRY'
    WHEN router_website='marketplace.cryptotechwomennft.com' THEN 'Crypto Tech Women'
    WHEN router_website='soundxyz-git-soundxyz-first-mate.vercel.app' THEN 'Sound'
    WHEN router_website='koinfetti.com' THEN 'koinfetti'
    WHEN router_website='nounish.market' THEN 'Nounish Market'
    WHEN router_website='dev.evaluate.xyz' THEN 'Evaluate Market'
    WHEN router_website='market.cosmoskidznft.com' THEN 'Cosmos Kidz'
    ELSE router_website::string
    END AS router_name
, LENGTH(hash_marker) AS hash_marker_size
FROM reservoir
UNION ALL
SELECT '72db8c0b' AS hash_marker
, 'Gem' AS aggregator_name
, NULL AS router_name
, LENGTH('72db8c0b') AS hash_marker_size
UNION ALL
SELECT '332d1229' AS hash_marker
, 'Blur' AS aggregator_name
, NULL AS router_name
, LENGTH('332d1229') AS hash_marker_size
UNION ALL
SELECT '9616c6c64617461' AS hash_marker
, 'Rarible' AS aggregator_name
, NULL AS router_name
, LENGTH('9616c6c64617461') AS hash_marker_size