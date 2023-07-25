USE CATALOG o9o9uccatalog;
--q54.sql--
 WITH my_customers AS
  (SELECT DISTINCT c_customer_sk ,
                   c_current_addr_sk
   FROM
     (SELECT cs_sold_date_sk sold_date_sk,
             cs_bill_customer_sk customer_sk,
             cs_item_sk item_sk
      FROM TPCDS.catalog_sales
      UNION ALL SELECT ws_sold_date_sk sold_date_sk,
                       ws_bill_customer_sk customer_sk,
                       ws_item_sk item_sk
      FROM TPCDS.web_sales) cs_or_ws_sales,
        TPCDS.item,
        TPCDS.date_dim,
        TPCDS.customer
   WHERE sold_date_sk = d_date_sk
     AND item_sk = i_item_sk
     AND i_category = 'Women'
     AND i_class = 'maternity'
     AND c_customer_sk = cs_or_ws_sales.customer_sk
     AND d_moy = 12
     AND d_year = 1998 ) ,
      my_revenue AS
  (SELECT c_customer_sk,
          sum(ss_ext_sales_price) AS revenue
   FROM my_customers,
        TPCDS.store_sales,
        TPCDS.customer_address,
        TPCDS.store,
        TPCDS.date_dim
   WHERE c_current_addr_sk = ca_address_sk
     AND ca_county = s_county
     AND ca_state = s_state
     AND ss_sold_date_sk = d_date_sk
     AND c_customer_sk = ss_customer_sk
     AND d_month_seq BETWEEN
       (SELECT DISTINCT d_month_seq+1
        FROM TPCDS.date_dim
        WHERE d_year = 1998
          AND d_moy = 12) AND
       (SELECT DISTINCT d_month_seq+3
        FROM TPCDS.date_dim
        WHERE d_year = 1998
          AND d_moy = 12)
   GROUP BY c_customer_sk) ,
      segments AS
  (SELECT cast((revenue/50) AS integer) AS SEGMENT
   FROM my_revenue)
SELECT /*TOP 100*/ SEGMENT,
       count(*) AS num_customers,
       SEGMENT*50 AS segment_base
FROM segments
GROUP BY SEGMENT
ORDER BY SEGMENT,
         num_customers
LIMIT 100
-- OPTION (LABEL = 'q54')
		 