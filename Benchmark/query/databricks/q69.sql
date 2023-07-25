USE CATALOG o9o9uccatalog;
--q69.sql--

SELECT /*TOP 100*/ cd_gender,
       cd_marital_status,
       cd_education_status,
       count(*) cnt1,
       cd_purchase_estimate,
       count(*) cnt2,
       cd_credit_rating,
       count(*) cnt3
FROM TPCDS.customer c,
     TPCDS.customer_address ca,
     TPCDS.customer_demographics
WHERE c.c_current_addr_sk = ca.ca_address_sk
  AND ca_state IN ('KY',
                   'GA',
                   'NM')
  AND cd_demo_sk = c.c_current_cdemo_sk
  AND EXISTS
    (SELECT *
     FROM TPCDS.store_sales,
          TPCDS.date_dim
     WHERE c.c_customer_sk = ss_customer_sk
       AND ss_sold_date_sk = d_date_sk
       AND d_year = 2001
       AND d_moy BETWEEN 4 AND 4+2)
  AND (NOT EXISTS
         (SELECT *
          FROM TPCDS.web_sales,
               TPCDS.date_dim
          WHERE c.c_customer_sk = ws_bill_customer_sk
            AND ws_sold_date_sk = d_date_sk
            AND d_year = 2001
            AND d_moy BETWEEN 4 AND 4+2)
       AND NOT EXISTS
         (SELECT *
          FROM TPCDS.catalog_sales,
               TPCDS.date_dim
          WHERE c.c_customer_sk = cs_ship_customer_sk
            AND cs_sold_date_sk = d_date_sk
            AND d_year = 2001
            AND d_moy BETWEEN 4 AND 4+2))
GROUP BY cd_gender,
         cd_marital_status,
         cd_education_status,
         cd_purchase_estimate,
         cd_credit_rating
ORDER BY cd_gender,
         cd_marital_status,
         cd_education_status,
         cd_purchase_estimate,
         cd_credit_rating
LIMIT 100
-- OPTION (LABEL = 'q69')
