USE CATALOG o9o9uccatalog;
--q82.sql--

SELECT /*TOP 100*/ i_item_id,
       i_item_desc,
       i_current_price
FROM TPCDS.item,
     TPCDS.inventory,
     TPCDS.date_dim,
     TPCDS.store_sales
WHERE i_current_price BETWEEN 62 AND 62+30
  AND inv_item_sk = i_item_sk
  AND d_date_sk=inv_date_sk
  AND d_date BETWEEN cast('2000-05-25' AS date) AND (DATEADD(DAY, 60, cast('2000-05-25' AS date)))
  AND i_manufact_id IN (129,
                        270,
                        821,
                        423)
  AND inv_quantity_on_hand BETWEEN 100 AND 500
  AND ss_item_sk = i_item_sk
GROUP BY i_item_id,
         i_item_desc,
         i_current_price
ORDER BY i_item_id
LIMIT 100
-- OPTION (LABEL = 'q82')
