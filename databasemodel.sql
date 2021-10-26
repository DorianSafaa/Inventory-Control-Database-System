-- MySQL Script generated by MySQL Workbench
-- Mon Aug  3 20:00:57 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `factory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `factory` ;

CREATE TABLE IF NOT EXISTS `factory` (
  `factory_id` TINYINT(1) NOT NULL,
  `factory_name` VARCHAR(45) NOT NULL,
  `factory_size` DECIMAL(9) NOT NULL,
  PRIMARY KEY (`factory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_type` ;

CREATE TABLE IF NOT EXISTS `product_type` (
  `product_type_id` TINYINT(1) NOT NULL,
  `product_type_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_unit` ;

CREATE TABLE IF NOT EXISTS `product_unit` (
  `product_unit_sku` INT NOT NULL,
  `product_unit_name` VARCHAR(45) NOT NULL,
  `product_unit_descr` VARCHAR(45) NOT NULL,
  `product_unit_price` DECIMAL(6,2) NOT NULL,
  `product_type` TINYINT(1) NOT NULL,
  PRIMARY KEY (`product_unit_sku`),
  INDEX `product_unit_type_idx` (`product_type` ASC) VISIBLE,
  CONSTRAINT `product_unit_type`
    FOREIGN KEY (`product_type`)
    REFERENCES `product_type` (`product_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `decision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `decision` ;

CREATE TABLE IF NOT EXISTS `decision` (
  `decision_id` TINYINT(1) NOT NULL,
  `decision_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`decision_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `returned_defective_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `returned_defective_item` ;

CREATE TABLE IF NOT EXISTS `returned_defective_item` (
  `defect_id` TINYINT(1) NOT NULL,
  `defect_descr` VARCHAR(45) NOT NULL,
  `product_unit` INT NOT NULL,
  `decision` TINYINT(1) NOT NULL,
  `factory` TINYINT(1) NOT NULL,
  PRIMARY KEY (`defect_id`),
  INDEX `defect_product_unit_idx` (`product_unit` ASC) VISIBLE,
  INDEX `item_decision_idx` (`decision` ASC) VISIBLE,
  INDEX `fk_factory_idx` (`factory` ASC) VISIBLE,
  CONSTRAINT `fk_product_unit`
    FOREIGN KEY (`product_unit`)
    REFERENCES `product_unit` (`product_unit_sku`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_decision`
    FOREIGN KEY (`decision`)
    REFERENCES `decision` (`decision_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_factory`
    FOREIGN KEY (`factory`)
    REFERENCES `factory` (`factory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defect_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defect_type` ;

CREATE TABLE IF NOT EXISTS `defect_type` (
  `defect_type_code` TINYINT(1) NOT NULL,
  `defect_type_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`defect_type_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `defect_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `defect_level` ;

CREATE TABLE IF NOT EXISTS `defect_level` (
  `returned_defective_item` TINYINT(1) NOT NULL,
  `defect_type` TINYINT(1) NOT NULL,
  `defect_level_id` TINYINT(1) NOT NULL,
  PRIMARY KEY (`defect_level_id`),
  INDEX `defect_type_idx` (`defect_type` ASC) VISIBLE,
  INDEX `returned_defective_item_idx` (`returned_defective_item` ASC) VISIBLE,
  CONSTRAINT `fk_returned_defective_level`
    FOREIGN KEY (`returned_defective_item`)
    REFERENCES `returned_defective_item` (`defect_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_defect_type_level`
    FOREIGN KEY (`defect_type`)
    REFERENCES `defect_type` (`defect_type_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test` ;

CREATE TABLE IF NOT EXISTS `test` (
  `test_id` TINYINT(1) NOT NULL,
  `test_instr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`test_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_run`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_run` ;

CREATE TABLE IF NOT EXISTS `test_run` (
  `factory` TINYINT(1) NOT NULL,
  `test` TINYINT(1) NOT NULL,
  `test_run_id` TINYINT(1) NOT NULL,
  INDEX `factory_idx` (`factory` ASC) VISIBLE,
  INDEX `test_idx` (`test` ASC) VISIBLE,
  PRIMARY KEY (`test_run_id`),
  CONSTRAINT `fk_testrun_factory`
    FOREIGN KEY (`factory`)
    REFERENCES `factory` (`factory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_run_test`
    FOREIGN KEY (`test`)
    REFERENCES `test` (`test_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_batch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_batch` ;

CREATE TABLE IF NOT EXISTS `test_batch` (
  `test_batch_id` TINYINT(1) NOT NULL,
  `test_batch_descr` VARCHAR(45) NOT NULL,
  `test_batch_date` DATE NOT NULL,
  PRIMARY KEY (`test_batch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_testing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_testing` ;

CREATE TABLE IF NOT EXISTS `product_testing` (
  `test` TINYINT(1) NOT NULL,
  `test_batch` TINYINT(1) NOT NULL,
  `product_testing_id` TINYINT(1) NOT NULL,
  INDEX `test_batch_idx` (`test_batch` ASC) VISIBLE,
  INDEX `test_idx` (`test` ASC) VISIBLE,
  PRIMARY KEY (`product_testing_id`),
  CONSTRAINT `fk_testing_test_batch`
    FOREIGN KEY (`test_batch`)
    REFERENCES `test_batch` (`test_batch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_testing_test`
    FOREIGN KEY (`test`)
    REFERENCES `test` (`test_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_unit` ;

CREATE TABLE IF NOT EXISTS `test_unit` (
  `test_unit_sku` INT NOT NULL,
  `test_unit_name` VARCHAR(45) NOT NULL,
  `test_unit_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`test_unit_sku`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test_batch_reference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_batch_reference` ;

CREATE TABLE IF NOT EXISTS `test_batch_reference` (
  `test_unit` INT NOT NULL,
  `test_batch` TINYINT(1) NOT NULL,
  INDEX `test_batch_idx` (`test_batch` ASC) VISIBLE,
  INDEX `test_unit_idx` (`test_unit` ASC) VISIBLE,
  CONSTRAINT `fk_reference_test_batch`
    FOREIGN KEY (`test_batch`)
    REFERENCES `test_batch` (`test_batch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reference_test_unit`
    FOREIGN KEY (`test_unit`)
    REFERENCES `test_unit` (`test_unit_sku`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supplier` ;

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` TINYINT(1) NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `supplier_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supply_order` ;

CREATE TABLE IF NOT EXISTS `supply_order` (
  `supply_order_id` TINYINT(1) NOT NULL,
  `supply_order_date` DATE NOT NULL,
  `factory` TINYINT(1) NOT NULL,
  `supplier` TINYINT(1) NOT NULL,
  PRIMARY KEY (`supply_order_id`),
  INDEX `factory_idx` (`factory` ASC) VISIBLE,
  INDEX `supplier_idx` (`supplier` ASC) VISIBLE,
  CONSTRAINT `fk_order_factory`
    FOREIGN KEY (`factory`)
    REFERENCES `factory` (`factory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_supplier`
    FOREIGN KEY (`supplier`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `raw_material_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `raw_material_type` ;

CREATE TABLE IF NOT EXISTS `raw_material_type` (
  `raw_material_type_id` TINYINT(1) NOT NULL,
  `raw_material_type_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`raw_material_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `raw_material_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `raw_material_unit` ;

CREATE TABLE IF NOT EXISTS `raw_material_unit` (
  `raw_material_unit_sku` INT NOT NULL,
  `raw_material_unit_price` DECIMAL(6,2) NOT NULL,
  `raw_material_unit_descr` VARCHAR(45) NOT NULL,
  `raw_material_type` TINYINT(1) NULL,
  PRIMARY KEY (`raw_material_unit_sku`),
  INDEX `RawMaterial_type_idx` (`raw_material_type` ASC) VISIBLE,
  CONSTRAINT `RawMaterial_type`
    FOREIGN KEY (`raw_material_type`)
    REFERENCES `raw_material_type` (`raw_material_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supply_item` ;

CREATE TABLE IF NOT EXISTS `supply_item` (
  `supplier` TINYINT(1) NOT NULL,
  `raw_material_unit` INT NOT NULL,
  INDEX `supplier_idx` (`supplier` ASC) VISIBLE,
  INDEX `raw_material_unit_idx` (`raw_material_unit` ASC) VISIBLE,
  CONSTRAINT `fk_supply_supplier`
    FOREIGN KEY (`supplier`)
    REFERENCES `supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supply_raw_material_unit`
    FOREIGN KEY (`raw_material_unit`)
    REFERENCES `raw_material_unit` (`raw_material_unit_sku`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply_line_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supply_line_item` ;

CREATE TABLE IF NOT EXISTS `supply_line_item` (
  `supply_line_id` TINYINT(9) NOT NULL,
  `supply_line_item_quantity` INT NOT NULL,
  `raw_material_unit` INT NOT NULL,
  `supply_order` TINYINT(1) NOT NULL,
  PRIMARY KEY (`supply_line_id`),
  INDEX `raw_material_unit_idx` (`raw_material_unit` ASC) VISIBLE,
  INDEX `supply_order_idx` (`supply_order` ASC) VISIBLE,
  CONSTRAINT `fk_line_raw_material_unit`
    FOREIGN KEY (`raw_material_unit`)
    REFERENCES `raw_material_unit` (`raw_material_unit_sku`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_line_supply_order`
    FOREIGN KEY (`supply_order`)
    REFERENCES `supply_order` (`supply_order_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_batch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_batch` ;

CREATE TABLE IF NOT EXISTS `product_batch` (
  `product_batch_id` TINYINT(1) NOT NULL,
  `product_batch_descr` VARCHAR(45) NOT NULL,
  `product_batch_date` DATE NOT NULL,
  PRIMARY KEY (`product_batch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `production`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `production` ;

CREATE TABLE IF NOT EXISTS `production` (
  `factory` TINYINT(1) NOT NULL,
  `product_batch` TINYINT(1) NOT NULL,
  INDEX `factory_idx` (`factory` ASC) VISIBLE,
  INDEX `product_batch_idx` (`product_batch` ASC) VISIBLE,
  CONSTRAINT `fk_production_factory`
    FOREIGN KEY (`factory`)
    REFERENCES `factory` (`factory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_production_batch`
    FOREIGN KEY (`product_batch`)
    REFERENCES `product_batch` (`product_batch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_batch_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_batch_item` ;

CREATE TABLE IF NOT EXISTS `product_batch_item` (
  `product_batch` TINYINT(1) NOT NULL,
  `product_unit` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `product_batch_idx` (`product_batch` ASC) VISIBLE,
  INDEX `product_unit_idx` (`product_unit` ASC) VISIBLE,
  CONSTRAINT `fk_product_batch_item`
    FOREIGN KEY (`product_batch`)
    REFERENCES `product_batch` (`product_batch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_unit_item`
    FOREIGN KEY (`product_unit`)
    REFERENCES `product_unit` (`product_unit_sku`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse` ;

CREATE TABLE IF NOT EXISTS `warehouse` (
  `warehouse_id` TINYINT(1) NOT NULL,
  `warehouse_name` VARCHAR(45) NOT NULL,
  `warehouse_size` DECIMAL(9) NOT NULL,
  PRIMARY KEY (`warehouse_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stock` ;

CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` TINYINT(1) NOT NULL,
  `product_batch` TINYINT(1) NOT NULL,
  `warehouse` TINYINT(1) NOT NULL,
  PRIMARY KEY (`stock_id`),
  INDEX `warehouse_idx` (`warehouse` ASC) VISIBLE,
  INDEX `product_batch_idx` (`product_batch` ASC) VISIBLE,
  CONSTRAINT `fk_stock_warehouse`
    FOREIGN KEY (`warehouse`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_stock_product_batch`
    FOREIGN KEY (`product_batch`)
    REFERENCES `product_batch` (`product_batch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company` ;

CREATE TABLE IF NOT EXISTS `company` (
  `company_id` TINYINT(1) NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `founded_date` DATE NOT NULL,
  `company_about` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_factory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rent_factory` ;

CREATE TABLE IF NOT EXISTS `rent_factory` (
  `rent_factory_id` TINYINT(1) NOT NULL,
  `factory` TINYINT(1) NOT NULL,
  `company` TINYINT(1) NOT NULL,
  PRIMARY KEY (`rent_factory_id`),
  INDEX `factory_idx` (`factory` ASC) VISIBLE,
  INDEX `company_idx` (`company` ASC) VISIBLE,
  CONSTRAINT `fk_rent_factory`
    FOREIGN KEY (`factory`)
    REFERENCES `factory` (`factory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_factory_company`
    FOREIGN KEY (`company`)
    REFERENCES `company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rent_warehouse` ;

CREATE TABLE IF NOT EXISTS `rent_warehouse` (
  `rent_warehouse_id` TINYINT(1) NOT NULL,
  `warehouse` TINYINT(1) NOT NULL,
  `company` TINYINT(1) NOT NULL,
  PRIMARY KEY (`rent_warehouse_id`),
  INDEX `company_idx` (`company` ASC) VISIBLE,
  INDEX `warehouse_idx` (`warehouse` ASC) VISIBLE,
  CONSTRAINT `fk_warehouse_company`
    FOREIGN KEY (`company`)
    REFERENCES `company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rent_warehouse`
    FOREIGN KEY (`warehouse`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `employee` ;

CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` TINYINT(1) NOT NULL,
  `employee_firstname` VARCHAR(45) NOT NULL,
  `employee_lastname` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `salary` INT NOT NULL,
  `is_supervisor` TINYINT(1) NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supervisor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supervisor` ;

CREATE TABLE IF NOT EXISTS `supervisor` (
  `employee` TINYINT(1) NOT NULL,
  `supervisor` TINYINT(1) NOT NULL,
  PRIMARY KEY (`employee`),
  CONSTRAINT `fk_employee_supervisor`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `labor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `labor` ;

CREATE TABLE IF NOT EXISTS `labor` (
  `labor_id` TINYINT(1) NOT NULL,
  `contract` VARCHAR(45) NOT NULL,
  `company` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  PRIMARY KEY (`labor_id`),
  INDEX `company_idx` (`company` ASC) VISIBLE,
  INDEX `employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_labor_company`
    FOREIGN KEY (`company`)
    REFERENCES `company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_labor_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `department` ;

CREATE TABLE IF NOT EXISTS `department` (
  `department_id` TINYINT(1) NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `Nb_of_employees` INT NOT NULL,
  `company` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NULL,
  PRIMARY KEY (`department_id`),
  INDEX `company_idx` (`company` ASC) VISIBLE,
  INDEX `fk_department_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_department_company`
    FOREIGN KEY (`company`)
    REFERENCES `company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_department_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `store` ;

CREATE TABLE IF NOT EXISTS `store` (
  `store_id` TINYINT(1) NOT NULL,
  `store_name` VARCHAR(45) NOT NULL,
  `store_descr` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `website`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `website` ;

CREATE TABLE IF NOT EXISTS `website` (
  `website_url` VARCHAR(45) NOT NULL,
  `domain` VARCHAR(45) NOT NULL,
  `company` TINYINT(1) NOT NULL,
  PRIMARY KEY (`website_url`),
  INDEX `company_idx` (`company` ASC) VISIBLE,
  CONSTRAINT `fk_website_company`
    FOREIGN KEY (`company`)
    REFERENCES `company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assignment` ;

CREATE TABLE IF NOT EXISTS `assignment` (
  `warehouse` TINYINT(1) NOT NULL,
  `store` TINYINT(1) NOT NULL,
  `quantity` INT NOT NULL,
  `assignment_date` DATE NOT NULL,
  INDEX `warehouse_idx` (`warehouse` ASC) VISIBLE,
  INDEX `store_idx` (`store` ASC) VISIBLE,
  CONSTRAINT `fk_assignment_warehouse`
    FOREIGN KEY (`warehouse`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_assignment_store`
    FOREIGN KEY (`store`)
    REFERENCES `store` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` TINYINT(1) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `customer_firstname` VARCHAR(45) NOT NULL,
  `customer_lastname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `browsing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `browsing` ;

CREATE TABLE IF NOT EXISTS `browsing` (
  `customer` TINYINT(1) NOT NULL,
  `website` VARCHAR(45) NOT NULL,
  `browsing_date` DATE NOT NULL,
  `browsing_time` TIME NOT NULL,
  INDEX `customer_idx` (`customer` ASC) VISIBLE,
  INDEX `website_idx` (`website` ASC) VISIBLE,
  CONSTRAINT `fk_browsing_customer`
    FOREIGN KEY (`customer`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_browsing_website`
    FOREIGN KEY (`website`)
    REFERENCES `website` (`website_url`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_type` ;

CREATE TABLE IF NOT EXISTS `customer_type` (
  `customer_type_id` TINYINT(1) NOT NULL,
  `customer_type_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_associated_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_associated_type` ;

CREATE TABLE IF NOT EXISTS `customer_associated_type` (
  `customer` TINYINT(1) NOT NULL,
  `customer_type` TINYINT(1) NOT NULL,
  INDEX `customer_idx` (`customer` ASC) VISIBLE,
  INDEX `customer_type_idx` (`customer_type` ASC) VISIBLE,
  CONSTRAINT `fk_type_customer`
    FOREIGN KEY (`customer`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_type`
    FOREIGN KEY (`customer_type`)
    REFERENCES `customer_type` (`customer_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `address_id` INT NOT NULL,
  `address_descr` VARCHAR(45) NOT NULL,
  `address_city` VARCHAR(45) NOT NULL,
  `address_country` VARCHAR(45) NOT NULL,
  `address_state` VARCHAR(45) NOT NULL,
  `address_zipcode` INT NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_address` ;

CREATE TABLE IF NOT EXISTS `customer_address` (
  `address` INT NOT NULL,
  `customer` TINYINT(1) NOT NULL,
  INDEX `customer_idx` (`customer` ASC) VISIBLE,
  INDEX `address_idx` (`address` ASC) VISIBLE,
  CONSTRAINT `fk_address_customer`
    FOREIGN KEY (`customer`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_address`
    FOREIGN KEY (`address`)
    REFERENCES `address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesperson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salesperson` ;

CREATE TABLE IF NOT EXISTS `salesperson` (
  `salesperson_id` INT NOT NULL,
  `salesperson_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`salesperson_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `purchase_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `purchase_order` ;

CREATE TABLE IF NOT EXISTS `purchase_order` (
  `customer` TINYINT(1) NOT NULL,
  `purchase_order_id` TINYINT(1) NOT NULL,
  `purchase_date` DATE NOT NULL,
  `salesperson` INT NULL,
  PRIMARY KEY (`purchase_order_id`),
  INDEX `customer_idx` (`customer` ASC) VISIBLE,
  INDEX `fk_order_salesperson_idx` (`salesperson` ASC) VISIBLE,
  CONSTRAINT `fk_purchase_order_customer`
    FOREIGN KEY (`customer`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_salesperson`
    FOREIGN KEY (`salesperson`)
    REFERENCES `salesperson` (`salesperson_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `return_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `return_detail` ;

CREATE TABLE IF NOT EXISTS `return_detail` (
  `return_id` TINYINT(1) NOT NULL,
  `purchase_order` TINYINT(1) NOT NULL,
  `return_reason` VARCHAR(45) NOT NULL,
  `return_quantity` INT NOT NULL,
  PRIMARY KEY (`return_id`),
  INDEX `purchase_order_idx` (`purchase_order` ASC) VISIBLE,
  CONSTRAINT `fk_return_purchase_order`
    FOREIGN KEY (`purchase_order`)
    REFERENCES `purchase_order` (`purchase_order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logistic_provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `logistic_provider` ;

CREATE TABLE IF NOT EXISTS `logistic_provider` (
  `logistic_provider_id` TINYINT(1) NOT NULL,
  `logistic_provider_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`logistic_provider_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `region_id` TINYINT(1) NOT NULL,
  `region_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery` ;

CREATE TABLE IF NOT EXISTS `delivery` (
  `delivery_id` TINYINT(1) NOT NULL,
  `delivery_status` VARCHAR(45) NOT NULL,
  `delivery_date` DATE NOT NULL,
  `purchase_order` TINYINT(1) NOT NULL,
  `logistic_provider` TINYINT(1) NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `purchase_order_idx` (`purchase_order` ASC) VISIBLE,
  INDEX `logistic_provider_idx` (`logistic_provider` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_purchase_order`
    FOREIGN KEY (`purchase_order`)
    REFERENCES `purchase_order` (`purchase_order_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_delivery_logistic_provider`
    FOREIGN KEY (`logistic_provider`)
    REFERENCES `logistic_provider` (`logistic_provider_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delivery_limit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery_limit` ;

CREATE TABLE IF NOT EXISTS `delivery_limit` (
  `logistic_provider` TINYINT(1) NOT NULL,
  `region` TINYINT(1) NOT NULL,
  INDEX `logistic_provider_idx` (`logistic_provider` ASC) VISIBLE,
  INDEX `region_idx` (`region` ASC) VISIBLE,
  CONSTRAINT `fk_limit_logistic_provider`
    FOREIGN KEY (`logistic_provider`)
    REFERENCES `logistic_provider` (`logistic_provider_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_limit_region`
    FOREIGN KEY (`region`)
    REFERENCES `region` (`region_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment_type` ;

CREATE TABLE IF NOT EXISTS `payment_type` (
  `payment_type_id` TINYINT(1) NOT NULL,
  `payment_type_descr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tax_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tax_rate` ;

CREATE TABLE IF NOT EXISTS `tax_rate` (
  `tax_rate_id` INT NOT NULL,
  `percentage` INT NOT NULL,
  PRIMARY KEY (`tax_rate_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment` ;

CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` TINYINT(1) NOT NULL,
  `payment_type` TINYINT(1) NOT NULL,
  `purchase_order` TINYINT(1) NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  `tax_rate` INT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `purchase_order_idx` (`purchase_order` ASC) VISIBLE,
  INDEX `payment_type_idx` (`payment_type` ASC) VISIBLE,
  INDEX `tax_rate_payment_idx` (`tax_rate` ASC) VISIBLE,
  CONSTRAINT `fk_payment_purchase_order`
    FOREIGN KEY (`purchase_order`)
    REFERENCES `purchase_order` (`purchase_order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_type`
    FOREIGN KEY (`payment_type`)
    REFERENCES `payment_type` (`payment_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tax_rate_payment`
    FOREIGN KEY (`tax_rate`)
    REFERENCES `tax_rate` (`tax_rate_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `credit_card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `credit_card` ;

CREATE TABLE IF NOT EXISTS `credit_card` (
  `card_number` INT NOT NULL,
  `ccv` INT NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `expiration_date` TIMESTAMP(6) NOT NULL,
  `payment_type` TINYINT(1) NOT NULL,
  PRIMARY KEY (`card_number`, `payment_type`),
  INDEX `payment_type_idx` (`payment_type` ASC) VISIBLE,
  CONSTRAINT `fk_credit_payment_type`
    FOREIGN KEY (`payment_type`)
    REFERENCES `payment_type` (`payment_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bank_check`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bank_check` ;

CREATE TABLE IF NOT EXISTS `bank_check` (
  `account_number` INT NOT NULL,
  `payment_type` TINYINT(1) NOT NULL,
  `routing_number` INT NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`account_number`, `payment_type`),
  INDEX `payment_type_idx` (`payment_type` ASC) VISIBLE,
  CONSTRAINT `fk_check_payment_type`
    FOREIGN KEY (`payment_type`)
    REFERENCES `payment_type` (`payment_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `line_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `line_item` ;

CREATE TABLE IF NOT EXISTS `line_item` (
  `line_item_id` TINYINT(1) NOT NULL,
  `quantity` INT NOT NULL,
  `discount` INT NOT NULL,
  `purchase_order` TINYINT(1) NOT NULL,
  `product_unit` INT NOT NULL,
  PRIMARY KEY (`line_item_id`),
  INDEX `product_unit_idx` (`product_unit` ASC) VISIBLE,
  INDEX `purchase_order_idx` (`purchase_order` ASC) VISIBLE,
  CONSTRAINT `fk_product_unit_line`
    FOREIGN KEY (`product_unit`)
    REFERENCES `product_unit` (`product_unit_sku`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_purchase_order_line`
    FOREIGN KEY (`purchase_order`)
    REFERENCES `purchase_order` (`purchase_order_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `list` ;

CREATE TABLE IF NOT EXISTS `list` (
  `website` VARCHAR(45) NOT NULL,
  `product_unit` INT NOT NULL,
  INDEX `fk_listation_website_idx` (`website` ASC) VISIBLE,
  INDEX `fk_listation_product_unit_idx` (`product_unit` ASC) VISIBLE,
  CONSTRAINT `fk_listation_website`
    FOREIGN KEY (`website`)
    REFERENCES `website` (`website_url`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_listation_product_unit`
    FOREIGN KEY (`product_unit`)
    REFERENCES `product_unit` (`product_unit_sku`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `part` ;

CREATE TABLE IF NOT EXISTS `part` (
  `part_id` INT NOT NULL,
  `part_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`part_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assembling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembling` ;

CREATE TABLE IF NOT EXISTS `assembling` (
  `part` INT NOT NULL,
  `product_unit` INT NOT NULL,
  INDEX `assembling_part_idx` (`part` ASC) VISIBLE,
  INDEX `assembling_product_idx` (`product_unit` ASC) VISIBLE,
  CONSTRAINT `assembling_part`
    FOREIGN KEY (`part`)
    REFERENCES `part` (`part_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `assembling_product`
    FOREIGN KEY (`product_unit`)
    REFERENCES `product_unit` (`product_unit_sku`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project` ;

CREATE TABLE IF NOT EXISTS `project` (
  `project_id` INT NOT NULL,
  `project_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `participation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `participation` ;

CREATE TABLE IF NOT EXISTS `participation` (
  `employee` TINYINT(1) NOT NULL,
  `project` INT NOT NULL,
  INDEX `participation_employee_idx` (`employee` ASC) VISIBLE,
  INDEX `participation_project_idx` (`project` ASC) VISIBLE,
  CONSTRAINT `participation_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `participation_project`
    FOREIGN KEY (`project`)
    REFERENCES `project` (`project_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `store_salesperson`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `store_salesperson` ;

CREATE TABLE IF NOT EXISTS `store_salesperson` (
  `store` TINYINT(1) NOT NULL,
  `salesperson` INT NOT NULL,
  INDEX `fk_store_salesperson_idx` (`store` ASC) VISIBLE,
  INDEX `fk_salesperson_idx` (`salesperson` ASC) VISIBLE,
  CONSTRAINT `fk_store`
    FOREIGN KEY (`store`)
    REFERENCES `store` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_store_salesperson`
    FOREIGN KEY (`salesperson`)
    REFERENCES `salesperson` (`salesperson_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


DROP TABLE IF EXISTS `Account` ;

CREATE TABLE IF NOT EXISTS `Account` (
    username VARCHAR(40) NOT NULL,
    password VARCHAR(40) NOT NULL,
    role VARCHAR(40) NOT NULL);



DROP TABLE IF EXISTS `Permission` ;

CREATE TABLE IF NOT EXISTS `Permission`(
    user_role VARCHAR(40) NOT NULL,
    tablename VARCHAR(40) NOT NULL);


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;