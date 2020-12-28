# Inventory-Control-Database-System
This project 3 parts: Conceptual Model, Relational Model and Implementation in Python

Part1: The Semantic-Conceptual Model
I created a complete technical document that defines in detail the conceptual design and architecture of database system.

Section I: Project Description
In this section, I created a complete description of the idea for Inventory Control Database System project. This is a high level description which includes the scope of the database system that I am about to create, my motivation and goals to create this project and define the technical problem it solves.

Section II: Use Cases
Based on my project description, I created five use cases for all the main entities and actors in my system.

Section III: Database Requirements (Business Rules)
In this section, I created 33 database requirements which include the following relationships:

Many-to-Many
One-to-One
Many-to-One
One-to-Many
ISA
Aggregation
Recursive

Section IV: Detailed List of Main Entities, Attributes and Keys
In this section, I created 25 entities, and each entity has at least three or more attributes.

Section V: Entity Relationship Diagram (ERD)
Based on my database requirements from section III and the entities and attributes from section IV, I created a Entity Relationship Diagram (ERD) using drawing diagram software draw.io that will represent the conceptual high level architecture of my database system.

Section VI: Testing Table
I created a testing table for ERD.

Part 2: The Relational Model
In this part, I created a complete technical document that will define in detail the logical design and architecture of my database system.

Section VII: Database Model
In this section, I used MYSQLWorkBench to create the database model of my database system based on the final version of my ERD.

Section VIII: Forward Engineering
In this section, I transformed my database model into the database schema that is used to create the physical database, tables and attributes in my system.

Section IX: Inserting Data
In this section, I created sample data that represents the scope and domain of the real data and inserted into my database.

Section X: Testing
In this section, I tested the integrity of my database model using the sample data inserted in section IV.

Part 3: Final project
In this part, I created a real application in Python using the database model I created in Part 1 and Part 2. It is a functional application (console, terminal or GUI) to represent the functionality of my inventory control database model with real users.

The app creates a periodically back up of the database and also saves user transactions to a transactions.sql file that happen between the time the backup was done until the next database backup. Once the next database backup is created, content will be deleted in the transactions.sql and start again the process. The steps are as follows:

Initial menu that the program shows to the user in screen.

 > User Menu 
 > 1. Create Account 
 > 2. Login 
 > 3. Search
 > 4. Insert 
 > 5. Update
 > 6. Delete 
 > 7. Exit
 
 > Select an option: 1
Create user account: user inputs enter the name, email and password.

> Name: safaa
> Email: safaadorian@gmail.com
> Password: 00000

> Account sucessfully created!

> User Menu 
> 1. Create Account 
> 2. Login 
> 3. Search
> 4. Insert 
> 5. Update
> 6. Delete 
> 7. Exit

> Select an option: 2
Login: the user can log into the system using the data provided at registration time.

 > 1. email: safaadorian@gmail.com
 > 2. password: 00000
 
 >  You are logged as safaa!
 
 > User Menu 
 > 1. Create Account 
 > 2. Login 
 > 3. Search
 > 4. Insert 
 > 5. Update
 > 6. Delete 
 > 7. Exit
 
 > Select an option: 3
Search: when users select this option, they are able to search for data based on the main entities implemented in the store database model.

Insert: users are able to insert data to the database model which they have access to.

Update: users are able to update data from the database model.

Delete: users are able to delete data from the database model.
