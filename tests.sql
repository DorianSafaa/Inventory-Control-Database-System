       -- Script name: tests.sql
       -- Author:      Safaa Dorian
       -- Purpose:     test the integrity of this database system
      
      SET SQL_SAFE_UPDATES=0;
       
       -- the database used to insert the data into.
       USE InventoryControlDB; 
       
       -- 1. Testing factory table
       DELETE FROM factory WHERE factory_name = "Samsung Factory";
       UPDATE factory SET factory_id = 4 WHERE factory_name = "LG Factory";

		-- 2. Testing company table
       DELETE FROM company WHERE company_id=1;
       UPDATE company SET company_id = 1 WHERE company_name = "Whirlpool";
       
		-- 3. Testing employee table
      -- DELETE FROM employee WHERE salary=150000;
      -- Cannot delete or update a parent row: a foreign key constraint fails;
       UPDATE employee SET employee_firstname="Omar" WHERE employee_id=2;
        
		-- 4. Testing supplier table
       DELETE FROM supplier WHERE supplier_id=1;
      UPDATE supplier SET supplier_id=4 WHERE supplier_id=2;
     
       
      	-- 5. Testing project table
       DELETE FROM project WHERE project_name="Budgeting";
       UPDATE project SET project_name="Statistical result" WHERE project_id=2;
       
       	-- 6. Testing warehouse table
       DELETE FROM warehouse WHERE warehouse_size=10000;
       UPDATE warehouse SET warehouse_name="Costco warehouse" WHERE warehouse_id=3;
       
       	-- 7. Testing store table
       DELETE FROM store WHERE store_id=1;
       UPDATE store SET store_id=4 WHERE store_id=2;
       
       	-- 8. Testing test table
		DELETE FROM test WHERE test_instr="Test the temperature";
		UPDATE test SET test_id=4 WHERE test_id=1;
       
       	-- 9. Testing test_batch table
       DELETE FROM test_batch WHERE test_batch_date=20181215;
       UPDATE test_batch SET test_batch_descr="New motor" WHERE test_batch_id=2;
       
       	-- 10. Testing test_unit table
		DELETE FROM test_unit WHERE test_unit_sku=3;
       UPDATE test_unit SET test_unit_descr="test new compressor" WHERE test_unit_name="double door refrigerator";
       
       	-- 11. Testing decision table
       DELETE FROM decision WHERE decision_descr="recycable";
       UPDATE decision SET decision_descr="recycable" WHERE decision_id=3;
       
       	-- 12. Testing defect_type table
		DELETE FROM defect_type WHERE defect_type_code=1;
		UPDATE defect_type SET defect_type_descr="Ice maker problem" WHERE defect_type_code=2;
     
       
       	-- 13. Testing product_batch table
       DELETE FROM product_batch WHERE product_batch_descr="Mini Fridge";
       UPDATE product_batch SET product_batch_id=4 WHERE product_batch_date=20200205;
       
       	-- 14. Testing product_type table
		DELETE FROM product_type WHERE product_type_descr="Convenience product";
       UPDATE product_type SET product_type_id=4 WHERE product_type_descr="Shopping product";
       
       	-- 15. Testing raw_material_type table
       -- DELETE FROM raw_material_type WHERE raw_material_type_id=4;
       -- Cannot update or delete a parent row;
       UPDATE raw_material_type SET raw_material_type_id=4  WHERE raw_material_type_descr="Metal";
       
       	-- 16. Testing salesperson table
       DELETE FROM salesperson WHERE salesperson_name="Bob";
       UPDATE salesperson SET salesperson_name="Ronny" WHERE salesperson_id=2;
       
       	-- 17. Testing part table
       DELETE FROM part WHERE part_id=2;
       UPDATE part SET part_name="wheels" WHERE part_id=3;
        
		-- 18. Testing customer table
        DELETE FROM customer where customer_id=2;
        UPDATE customer SET customer_firstname="Omar" WHERE customer_id=3;
       
		-- 19. Testing address table
       DELETE FROM address WHERE address_city="San Francisco";
       UPDATE address SET address_city="Alo Palto" WHERE address_id=2;
       
		-- 20. Testing logistic_provider table
       DELETE FROM logistic_provider WHERE logistic_provider_name="UPS";
       UPDATE logistic_provider SET logistic_provider_name="DHL" WHERE logistic_provider_id=2;
       
		-- 21. Testing customer_type table
       DELETE FROM customer_type WHERE customer_type_descr="Business";
       UPDATE customer_type SET customer_type_id=4 WHERE customer_type_id=2;
       
		-- 22. Testing region table
       DELETE FROM region WHERE region_id=1;
       UPDATE region SET region_name="North America" WHERE region_id=2;
       
		-- 23. Testing tax_rate table
       -- DELETE FROM tax_rate WHERE percentage=50;
       -- Cannot delete a parent row: a foreign key constraint fails;
       UPDATE tax_rate SET percentage=75 WHERE tax_rate_id=2;
       
		-- 24. Testing payment_type table
       DELETE FROM payment_type WHERE payment_type_id=3;
       UPDATE payment_type SET payment_type_id=6 WHERE payment_type_descr="Cash";
       