
-- factory table inserts
INSERT INTO factory (factory_id, factory_name, factory_size) VALUES (1, "Samsung Factory", 134287), (2, "Whirlpool Factory", 187787), (3, "LG Factory", 229540);

-- company table inserts
INSERT INTO company (company_id, company_name, founded_date, company_about) VALUES (1, "Samsung", 19380301, "At Samsung, our sustainability management aims to create integrated values"), (2, "Whirlpool", 19111111, "Whirlpool Corporation is the world’s leading major home appliance company"), (3, "LG Factory", 19581005, "We wish to maintain our hard-earned reputation for bringing added value to the lives of consumers");

-- warehouse table inserts
INSERT INTO warehouse (warehouse_id, warehouse_name, warehouse_size) VALUES (1, "Samsung warehouse", 100000), (2, "Whirlpool warehouse", 70000), (3, "LG warehouse", 62000);

-- store table inserts
INSERT INTO store (store_id, store_name, store_descr) VALUES (1, "Costco", "At Costco bulk quantities of merchandise are sold at deeply discounted prices. It is one of the largest retailers in the world"), (2, "Sears", "Sears is a chain of department stores. they carry clothing, home appliances, household hardware, lawn and garden supplies, electronics and more"), (3, "Best Buy", "Best Buy Co., Inc. is a provider of technology products, services and solutions");

-- employee table inserts
INSERT INTO employee (employee_id, employee_firstname, employee_lastname, dob, salary, is_supervisor ) VALUES (1, "Ronny", "Dorian", 19890222, 150000, 4), (2, "Fadi", "Minawi", 19840815,  100000, NULL), (3, "Rana", "Gonzalez", 18971127, 180000, 2);

-- supervisor table inserts
INSERT INTO supervisor (employee, supervisor) VALUES (1,4), (2,8), (3,1);

-- department table inserts
INSERT INTO department (department_id, department_name, Nb_of_employees, employee, company) VALUES (1, "Marketing", 100, 1, 1), (2, "Accounting", 80, 2, 2),(3, "Production", 300, 3, 3);

-- customer table inserts
INSERT INTO customer (customer_id, email, customer_firstname, customer_lastname) VALUES (1, "ayahalabi@hotmail.com", "Aya", "Halabi"), (2, "roccobruno@hotmail.com", "Rocco", "Bruno"), (3, "juliabotros@hotmail.com", "julia", "Botros");

-- address table inserts
INSERT INTO address (address_id, address_descr, address_city, address_country, address_state, address_zipcode) VALUES (1, "501 Crescent Way", "San Francisco", "United States", "California", 94156), (2, "1258 Owens Street", "Houston", "United States", "Texas", 77001), (3, "12001 Septo Street", "Chatsworth", "United States", "California", 91311);

-- customer_address table inserts
INSERT INTO customer_address (address, customer) VALUES (1, 1), (2, 2), (3, 3);

-- supplier table inserts
INSERT INTO supplier (supplier_id, supplier_name, supplier_descr) VALUES (1, "A_Supplier", "Specified in metal"), (2, "B_Supplier", "Specified in plastic"), (3, "C-Supplier", "Specified in wood");

-- website table inserts
INSERT INTO website (website_url, domain, company) VALUES ("https://www.samsung.com/us/", "Samsung.com", 1), ("https://www.whirlpool.com/", "Whirlpool.com", 2), ("https://www.lg.com/us", "lg.com", 3);

-- assignment table inserts
INSERT INTO assignment (warehouse, store, quantity, assignment_date) VALUES (1,1,50,20200412), (1,2,40,20200115), (2, 3, 70, 20191209), (3, 2, 100, 20200201);

-- browsing table inserts
INSERT INTO browsing (customer, website, browsing_date, browsing_time) VALUES (1,"https://www.samsung.com/us/", 20200412, 9), (1,"https://www.whirlpool.com/",20200115, 5), (2, "https://www.lg.com/us", 20191209, 10);

-- labor table inserts
INSERT INTO labor (labor_id, contract, company, employee) VALUES (1,"full time", 2, 1), (2, "part time", 1, 3), (3, "full time", 3, 1);

-- product_batch table inserts
INSERT INTO product_batch (product_batch_id, product_batch_descr, product_batch_date) VALUES (1,"Mini fridge", 20200205), (2,"French door refrigerator", 20200610), (3,"Side by side refrigerator", 20191105);

-- production table inserts
INSERT INTO production (factory, product_batch) VALUES (1,1), (2,3), (3,2);

-- product_type table inserts
INSERT INTO product_type (product_type_id, product_type_descr) VALUES (1, "Convenience product"), (2, "Shopping product"),  (3, "Speciality product");

-- product_unit table inserts
INSERT INTO product_unit (product_unit_sku, product_unit_name, product_unit_descr, product_unit_price, product_type) VALUES (81207252,"Samsung RF28N9780S", "French door refrigerator", 4995.00,2), (14587621,"LG LMXS28596S", "4 doors smart refrigerator", 3495.00,2), (75476215,"Whirlpool WRT311FZDW", "Top freezer refrigerator", 854.00,2);

-- product_batch_item table inserts
INSERT INTO product_batch_item (product_batch, product_unit, quantity) VALUES (1, 81207252,90), (2, 14587621,100),  (3, 75476215, 200);

-- raw_material_type table inserts
INSERT INTO raw_material_type (raw_material_type_id, raw_material_type_descr) VALUES (1, "Metal"), (2, "Plastic"), (3, "Wood");

-- raw_material_unit table inserts
INSERT INTO raw_material_unit (raw_material_unit_sku, raw_material_unit_price, raw_material_unit_descr, raw_material_type) VALUES (91567252, 40.00, "Aluminium",1), (52136487,35.00, "Steel",1), (62145032, 20.00, "Plastic",2);

-- supply_item table inserts
INSERT INTO supply_item (supplier, raw_material_unit) VALUES (1, 91567252), (1,52136487), (2,62145032);

-- supply_order table inserts
INSERT INTO supply_order (supply_order_id, supply_order_date, factory, supplier) VALUES (1, 20200204, 1,1), (2, 20200510, 2,2), (3, 20200612, 3,2);

-- supply_line_item table inserts
INSERT INTO supply_line_item (supply_line_id, supply_line_item_quantity, raw_material_unit, supply_order) VALUES (1, 100, 91567252, 1), (2, 175, 52136487, 2), (3, 200, 62145032, 3);

-- test table inserts
INSERT INTO test (test_id, test_instr) VALUES (1,"Test the durability"), (2,"Test the temperature"), (3,"Test the noise");

-- test_run table inserts
INSERT INTO test_run (factory, test, test_run_id) VALUES (1, 1, 1), (2,1,2), (3,2,3);

-- test_batch table inserts
INSERT INTO test_batch (test_batch_id, test_batch_descr, test_batch_date) VALUES (1, "Test new compressor", 20181215), (2, "Test new thermostat", 20190412), (3, "Test new cabinet insulation", 20170801);

-- test_unit table inserts
INSERT INTO test_unit (test_unit_sku, test_unit_name, test_unit_descr) VALUES (52149863, "Double door refrigerator", "Test new compressor"), (45781244, "Mini Fridge","Test new thermostat"), (22556895, "French door refrigerator","Test new cabinet insulation");

-- test_batch_reference table inserts
INSERT INTO test_batch_reference (test_unit, test_batch) VALUES (52149863, 1), (45781244, 2), (22556895,3);

-- decision table inserts
INSERT INTO decision (decision_id, decision_descr) VALUES (1, "Repairable"), (2, "Recycable"), (3, "Disposable");

-- returned_defective_item table inserts
INSERT INTO returned_defective_item (defect_id, defect_descr, product_unit, decision, factory) VALUES (1, "Freezer is not cold enough", 81207252,1,1), (2, "Water leaking", 14587621,2,1), (3, "Refrigerator is freezing food", 75476215,3,3);

-- defect_type table inserts
INSERT INTO defect_type (defect_type_code, defect_type_descr) VALUES (1, "Motor problem"), (2, "Thermostat problem"), (3, "Filter problem");

-- defect_level table inserts
INSERT INTO defect_level (returned_defective_item, defect_type, defect_level_id) VALUES (1, 2, 1), (2, 3, 2), (3, 2, 3);

-- customer_type table inserts
INSERT INTO customer_type (customer_type_id, customer_type_descr) VALUES (1, "Consumer"), (2,"Government"), (3,"Business");

-- customer_associated_type table inserts
INSERT INTO customer_associated_type (customer, customer_type) VALUES (1, 1), (2,2), (3,3);

-- stock table inserts
INSERT INTO stock (stock_id, product_batch, warehouse) VALUES (1, 1, 1), (2,2,2), (3, 3,3);

-- rent_factory table inserts
INSERT INTO rent_factory (rent_factory_id, factory, company) VALUES (1, 1, 1), (2,2,2), (3, 3,3);

-- rent_warehouse table inserts
INSERT INTO rent_warehouse (rent_warehouse_id, warehouse, company) VALUES (1, 1, 1), (2,2,2), (3, 3,3);

-- list table inserts
INSERT INTO list (website, product_unit) VALUES ("https://www.samsung.com/us/", 81207252), ("https://www.whirlpool.com/",14587621), ("https://www.lg.com/us", 75476215);

-- salesperson table inserts
INSERT INTO salesperson (salesperson_id, salesperson_name) VALUES (1, "Veronica"), (2,"Alice"), (3, "Tom");

-- purchase_order table inserts
INSERT INTO purchase_order (customer, purchase_order_id, purchase_date, salesperson) VALUES (1, 1, 20200408,1), (2,2,20200309,2), (3, 3, 20200518,3);

-- payment_type table inserts
INSERT INTO payment_type (payment_type_id, payment_type_descr) VALUES (1, "Electronic"), (2,"Cash"), (3, "Bank Check");

-- tax_rate table inserts
INSERT INTO tax_rate (tax_rate_id, percentage) VALUES (1, 10), (2,20), (3, 50);

-- payment table inserts
INSERT INTO payment (payment_id, payment_type, purchase_order, amount, tax_rate) VALUES (1, 1, 1, 500.00, 1), (2, 3, 2, 1000.00, 2), (3, 2, 3, 600.00,3);

-- bank_check table inserts
INSERT INTO bank_check (account_number, payment_type, routing_number, bank) VALUES (1245876, 3, 54687952, "Wells Fargo"), (5213687, 3, 47841240, "Bank of America"), (9987548, 3, 77847965, "Citi");

-- credit_card table inserts
INSERT INTO credit_card (card_number, ccv, bank, expiration_date, payment_type) VALUES (124587612, 543, "Wells Fargo", 20250312, 1), (52136814, 785, "Bank of America", 20210308, 1), (12589658, 254, "Citi", 20241205, 1);

-- store_salesperson table inserts
INSERT INTO store_salesperson (store, salesperson) VALUES (1, 1), (2,2), (3,3);

-- line_item table inserts
INSERT INTO line_item (line_item_id, quantity, discount, purchase_order, product_unit) VALUES (1, 2, 20, 1, 81207252), (2, 1, 10, 2, 14587621), (3, 5, 0, 3, 75476215);

-- return_detail table inserts
INSERT INTO return_detail (return_id, purchase_order, return_reason, return_quantity) VALUES (1, 1, "Wrong order", 1), (2, 2, "Defective", 1), (3, 3, "Broken", 2);

-- logistic_provider table inserts
INSERT INTO logistic_provider (logistic_provider_id, logistic_provider_name) VALUES (1, "UPS"), (2,"Amazon"), (3, "Fedex");

-- delivery table inserts
INSERT INTO delivery (delivery_id, delivery_status, delivery_date, purchase_order, logistic_provider) VALUES (1, "Delivered", 20200709, 1, 1), (2, "Shipped", 20200720, 2, 2), (3, "In Process", 20200801, 1,2);

-- region table inserts
INSERT INTO region (region_id, region_name) VALUES (1, "Within United States"), (2, "International"), (3, "US and Canada");

-- delivery_limit table inserts
INSERT INTO delivery_limit (logistic_provider, region) VALUES (1, 1), (2, 2), (3, 1);

-- part table inserts
INSERT INTO part (part_id, part_name) VALUES (1, "Motor"), (2, "filter"), (3, "Ice Maker");

-- assembling table inserts
INSERT INTO assembling (part, product_unit) VALUES (1,81207252 ), (2, 14587621), (3, 75476215);

-- project table inserts
INSERT INTO project (project_id, project_name) VALUES (1,"New product release"), (2, "Budgeting"), (3, "New Ad");

-- participation table inserts
INSERT INTO participation (project, employee) VALUES (1,2), (2, 2), (3, 3);

-- Permission table inserts
INSERT INTO Permission (user_role, tablename) VALUES ("Admin", "factory"),
("Admin", "company"),
("Admin", "warehouse"),
("Admin", "store"),
("Admin", "employee"),
("Admin", "supervisor"),
("Admin", "department"),
("Admin", "company"),
("Admin", "customer"),
("Admin", "address"),
("Admin", "customer_address"),
("Admin", "supplier"),
("Admin", "website"),
("Admin", "assignment"),
("Admin", "browsing"),
("Admin", "labor"),
("Admin", "product_batch"),
("Admin", "production"),
("Admin", "product_type"),
("Admin", "product_unit"),
("Admin", "product_batch_item"),
("Admin", "raw_material_type"),
("Admin", "raw_material_unit"),
("Admin", "supply_item"),
("Admin", "company"),
("Admin", "supply_order"),
("Admin", "supply_line_item"),
("Admin", "test"),
("Admin", "test_run"),
("Admin", "test_batch"),
("Admin", "test_unit"),
("Admin", "test_batch_reference"),
("Admin", "decision"),
("Admin", "returned_defective_item"),
("Admin", "defect_type"),
("Admin", "defect_level"),
("Admin", "customer_type"),
("Admin", "company"),
("Admin", "customer_associated_type"),
("Admin", "stock"),
("Admin", "rent_factory"),
("Admin", "rent_warehouse"),
("Admin", "list"),
("Admin", "salesperson"),
("Admin", "purchase_order"),
("Admin", "payment_type"),
("Admin", "tax_rate"),
("Admin", "payment"),
("Admin", "credit_card"),
("Admin", "bank_check"),
("Admin", "store_salesperson"),
("Admin", "line_item"),
("Admin", "return_detail"),
("Admin", "logistic_provider"),
("Admin", "delivery"),
("Admin", "region"),
("Admin", "delivery_limit"),
("Admin", "part"),
("Admin", "assembling"),
("Admin", "project"),
("Admin", "participation"),
("User", "website"),
("User", "delivery"),
("User", "payment"),
("User", "purchase_order"),
("User", "return_detail"),
("User", "product_unit"),
("User", "product_type");
