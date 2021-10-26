"""
This is the user interface where the program interacts with the user.
USAGE: 1. Go to sqlconfig.conf file and change the username and password
          values to the ones from you are using in your mysql instance
       2. Open a terminal windows and run the following command:
       python3 user_interface.py
"""
registered_users = []
logged_users = {}

def write_in_file(query, file):
    with open(file, 'a') as f:
       f.write(query)


def joins(table, attribute_from_table, attribute_from_main_table):
    query = """ JOIN {} ON {} = {} """.format(table, attribute_from_table, attribute_from_main_table)
    return query


def select_query(table):
    query = """SELECT * from track"""
    join1 = joins("album", "Album.id", "Track.album")
    return query + join1


def show_tables_by_role(role):
    query = """SELECT tablename FROM Permission WHERE user_role = %s"""
    values = role
    tables = db.select(query, values)
    for table in tables:
        print(table)


def show_menu():
    """
    Prints in console the main menu
    :return: VOID
    """
    print("User Menu \n"
          "1. Create Account \n"
          "2. Login \n"
          "3. Search \n"
          "4. Insert \n"
          "5. Update \n"
          "6. Delete \n"
          "7. Exit \n")

def show_table_names(tables):
    """
    Show all the tables names
    :param tables: a list with the tables names.
                   You can get it by calling the method
                   get_table_names() from DB object
    :return: VOID
    """
    index = 1
    print("\nTables:")
    for table in tables:
        print(table[0])  # print tables names
        index += 1

# option 1 when user selects create account
def create_account():
    username = input("Your username: ")
    password = input("Password: ")
    role = input("Role, enter [admin] or [user]: ")
    query = """INSERT INTO Account (username, password, role) VALUES (%s, %s, %s)"""
    transaction_query = """INSERT INTO Account (username, password, role) VALUES ({}, {}, {});""".format(username, password, role)
    values = (username, password, role)
    if db.insert(query=query, values=values):
        print("Account created") # true
        write_in_file(transaction_query, "transactions.sql")
    else:
        print("Failed")

# option 2 when user selects login
def login():
    username = input("Your username: ")
    password = input("Password: ")
    query = """SELECT username, password, role from Account where username = %s AND password = %s"""
    values = (username, password)
    results = db.select(query, values)
    if len(results) == 0:
        print("You are not in the system")
    else:
        for result in results:
            username_from_table = result[0]
            password_from_table = result[1]
            role_from_table = result[2]
            user_data = {'user': username, 'password': password, 'role': role_from_table}
            print("you are logged into the system")
            return user_data

# option 3 when user selects search
def option3(db_object, tables):
    """
    Search option
    :param db_object: database object
    :param tables: the name of the tables in the database
    :return: VOID
    """
    try:
        # get user input
        table_selected = input("\nSelect a table to search: ")
        attribute_selected = input("Search by (i.e name)? ")
        value_selected = input("Enter the value: ")

        columns = db_object.get_column_names(table_selected)  # get columns names for the table selected

        # build queries with the user input
        query = """SELECT * FROM {} WHERE {} = %s""".format(table_selected, attribute_selected)

        if table_selected == "product_unit":  # only if the table selected is product_unit because we want to join
            columns= ["product sku", "product name", "product description", "price", "product type"]
            query = """SELECT product_unit_sku, product_unit_name, product_unit_descr, product_unit_price,product_type_descr FROM product_unit 
                           JOIN product_type ON product_type_id=product_unit.product_type
                           WHERE product_unit.{} = %s""".format(attribute_selected)

        elif table_selected == "website":  # only if the table selected is website because we want to join
           columns = ["website url", "domain", "company"]
           query = """SELECT website_url, domain, company_name FROM website
               JOIN company ON company_id = website.company
               WHERE website.{} = %s""".format(attribute_selected)

        elif table_selected == "assembling":  # only if the table selected is assembling because we want to join
           query = """SELECT part_name, product_unit_name FROM assembling
               JOIN part ON part_id = assembling.part
               JOIN product_unit ON product_unit_sku= assembling.product_unit
               WHERE assembling.{} = %s""".format(attribute_selected)

        elif table_selected == "list":  # only if the table selected is list because we want to join
           columns = ["website", "product"]
           query = """SELECT domain, product_unit_name FROM list
               JOIN website ON website_url = list.website
               JOIN product_unit ON product_unit_sku= list.product_unit
               WHERE list.{} = %s""".format(attribute_selected)

        elif table_selected == "browsing":  # only if the table selected is browsing because we want to join
           columns = ["customer first name", "website", "date", "time"]
           query = """SELECT customer_firstname, website_url, browsing_date, browsing_time FROM browsing
               JOIN website ON website_url = browsing.website
               JOIN customer ON customer_id = browsing.customer
               WHERE browsing.{} = %s""".format(attribute_selected)

        elif table_selected == "raw_material_unit":  # only if the table selected is raw material unit because we want to join
           columns = ["raw material unit sku", "price", "description", "type"]
           query = """SELECT raw_material_unit_sku, raw_material_unit_price, raw_material_unit_descr, raw_material_type_descr FROM raw_material_unit
               JOIN raw_material_type ON raw_material_type_id = raw_material_unit.raw_material_type
               WHERE raw_material_unit.{} = %s""".format(attribute_selected)

        elif table_selected == "returned_defective_item":  # only if the table selected is returned defective item because we want to join
           columns = ["defect id", "defect description", "product unit", "decision", "factory"]
           query = """SELECT defect_id, defect_descr, product_unit_name, decision_descr, factory_name FROM returned_defective_item
               JOIN product_unit ON product_unit_sku = returned_defective_item.product_unit
               JOIN decision ON decision_id = returned_defective_item.decision
               JOIN factory ON factory_id = returned_defective_item.factory
               WHERE returned_defective_item.{} = %s""".format(attribute_selected)

        elif table_selected == "purchase_order":  # only if the table selected is purchase order because we want to join
           columns = ["customer", "purchase_order_id", "purchase_date", "salesperson"]
           query = """SELECT customer_firstname, purchase_order_id, purchase_date, salesperson_name FROM purchase_order
               JOIN customer ON customer_id = purchase_order.customer
               JOIN salesperson ON salesperson_id = purchase_order.salesperson
               WHERE purchase_order.{} = %s""".format(attribute_selected)

        elif table_selected == "payment":  # only if the table selected is payment because we want to join
           columns = ["payment id", "payment type", "purchase order", "amount", "tax rate percentage"]
           query = """SELECT payment_id, payment_type_descr, purchase_order_id, amount, percentage FROM payment
               JOIN payment_type ON payment_type_id = payment.payment_type
               JOIN purchase_order ON purchase_order_id = payment.purchase_order
               JOIN tax_rate ON tax_rate_id = payment.tax_rate
               WHERE payment.{} = %s""".format(attribute_selected)

        elif table_selected == "return_detail":  # only if the table selected is return_detail because we want to join
           columns = ["return_id", "purchase_order", "return_reason", "return_quantity"]
           query = """SELECT return_id, purchase_order_id, return_reason, return_quantity FROM return_detail
                  JOIN purchase_order ON purchase_order_id = return_detail.purchase_order
                  WHERE return_detail.{} = %s""".format(attribute_selected)

        elif table_selected == "company":  # only if the table selected is company because we want to join
           columns = ["company id", "company name", "founded date", "company about"]
           query = """SELECT * FROM company WHERE company.{} = %s""".format(attribute_selected)

        elif table_selected == "store":  # only if the table selected is store because we want to join
           columns = ["store id", "store name", "store description"]
           query = """SELECT * FROM store WHERE store.{} = %s""".format(attribute_selected)

        elif table_selected == "employee":  # only if the table selected is employee because we want to join
           columns = ["employee id", "employee firstname", "employee lastname", "dob", "salary", "is_supervisor"]
           query = """SELECT * FROM employee WHERE employee.{} = %s""".format(attribute_selected)

        elif table_selected == "customer":  # only if the table selected is customer because we want to join
           columns = ["customer id", "email" , "first name", "last name"]
           query = """SELECT * FROM customer WHERE customer.{} = %s""".format(attribute_selected)

        elif table_selected == "factory":  # only if the table selected is factory because we want to join
           columns = ["factory id", "factory name", "factory size"]
           query = """SELECT * FROM factory WHERE factory.{} = %s""".format(attribute_selected)

        elif table_selected == "supplier":  # only if the table selected is supplier because we want to join
           columns = ["supplier id", "supplier name", "supplier descr"]
           query = """SELECT * FROM supplier WHERE supplier.{} = %s""".format(attribute_selected)

        elif table_selected == "test_unit":  # only if the table selected is supplier because we want to join
           columns = ["test unit sku", "test unit name", "test unit descr"]
           query = """SELECT * FROM test_unit WHERE test_unit.{} = %s""".format(attribute_selected)

        else:
           print("No valid table selected!")

        value = value_selected

        # get the results from the above query
        results = db_object.select(query=query, values=value)
        column_index = 0

        # print results
        print("\n")
        print("Results from: " + table_selected)
        for column in columns:
            values = []
            for result in results:
                values.append(result[column_index])
            print("{}: {}".format(column, values))  # print attribute: value
            column_index += 1
        print("\n")

    except Exception as err:  # handle error
        print("The data requested couldn't be found\n")



# option 4 when user selects insert
def option4(db_object, tables):
    try:
        # show tables names
        # show_table_names(tables)

        # get user input for insert
        table = input("\nEnter a table to insert data: ")
        attributes_str = input("Enter the name attribute/s separated by comma? ")
        values_str = input("Enter the values separated by comma: ")
        query = """INSERT INTO {} ({}) VALUES (%s)"""
        transaction_query ="""INSERT INTO {} ( {} ) VALUES ( {} )""".format(table, attributes_str, values_str)

        # from string to list of attributes and values
        if "," in attributes_str:  # multiple attributes
            attributes = attributes_str.split(",")
            values = values_str.split(",")
        else:  # one attribute
            attributes = [attributes_str]
            values = [values_str]
        sql = ""
        if db_object.insert(table=table, attributes=attributes, values=values):
            #write_in_file(sql, "transactions.sql")
            write_in_file(transaction_query, "transactions.sql")
            print("Data successfully inserted into {} \n".format(table))

    except: # data was not inserted, then handle error
        print("Error:", values, "failed to be inserted in ", table, "\n")

# option 5 when user selects update
def option5(db_object, tables):
    # implement all the logic for option 5

    table = input("Table to update: ")
    attribute = input("Attribute to be updated: ")
    old_value = input("Old value: ")
    new_value = input("New value: ")
    query = """UPDATE {} SET {} = %s WHERE {} = %s""".format (table, attribute, attribute)
    transaction_query = """UPDATE {} SET {} = {} WHERE {} = {}""".format (table, attribute, new_value, attribute, old_value)
    values =(new_value, old_value)
    if db.update (query, values):
        write_in_file(transaction_query, "transactions.sql")
        print(" {} was updated in {}". format (new_value, table))
    else:
        print("Update fail")


# option 6 when user deletes data
def option6(db_object, tables):
    try:
        # show tables names
        #show_table_names(tables)


        # get user input for delete
        table = input("\nEnter a table to delete data: ")
        attributes = input("Enter attribute: ")
        value = input("value: ")

        query = """Delete from {} where {} = %s""".format(table,attributes)
        transaction_query = """Delete from {} where {} = {}""".format(table,attributes,value)
        values = value
        if db_object.delete(query, values):
            print("Data successfully deleted from {} \n".format(table))
            write_in_file(transaction_query, "transactions.sql")

    except: # data was not deleted, then handle error
        print("Error:", value, "failed to deleted from ", table, "\n")

##### Driver execution.....
from database import DB

print("Setting up the database......\n")

# DB API object
db = DB(config_file="sqlconfig.conf")

# create a database (must be the same as the one is in your config file)
database = "inventorydb"

if db.create_database(database=database, drop_database_first=True):
    print("Created database {}".format(database))
else:
    print("An error occurred while creating database {} ".format(database))

# create all the tables from databasemodel.sql
db.run_sql_file("databasemodel.sql")

# insert sample data from insert.sql
db.run_sql_file("insert.sql")

#tables = db.get_table_names()
tables = None

show_menu()
option = int(input("Select one option from the menu: "))
while option != 7:
    if logged_users:  # if there is a user logged into the system
        role = logged_users['role']
        print("this is the role" + role)
        tables = show_tables_by_role(role)
    else:
        print("You are not logged into the system")
    if option == 1:
        create_account()
    elif option == 2:
        logged_users = login()
    elif option == 3:
        option3(db, tables)
    elif option == 4:
        option4(db, tables)
    elif option == 5:
        option5(db, tables)
    elif option == 6:
        option6(db, tables)
    show_menu()
    option = int(input("Select one option from the menu: "))
print("You are exiting, bye!")
