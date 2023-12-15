.read data.sql


CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) as average_price
  FROM products
  GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store, item, min(price)
  FROM inventory
  GROUP BY item;


CREATE TABLE shopping_list_tmp AS
  SELECT products.name as item, min(products.MSRP / products.rating)
  FROM lowest_prices as price_list, products
  GROUP BY products.category;

CREATE TABLE shopping_list AS
  SELECT a.item, b.store as store
  FROM shopping_list_tmp as a, lowest_prices as b
  WHERE a.item = b.item;

CREATE TABLE total_bandwidth AS
  SELECT sum(a.Mbs)
  FROM stores as a, shopping_list as b
  WHERE a.store = b.store;