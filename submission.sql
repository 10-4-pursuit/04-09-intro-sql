-- Before you start, ensure you're connected to the PostgreSQL server. Use the appropriate client command line or GUI.
danieltorres@daniels-Air 04-09-intro-sql %  psql -d students
psql (14.11 (Homebrew))
Type "help" for help.

students=# 
-- TASK: Connect to the 'school' database. This is a PostgreSQL command line operation.
-- HINT: Use \c followed by the database name to connect to your database from the psql command line interface.
students=# \c
You are now connected to database "students" as user "danieltorres".
-- TASK: Create a table named 'students' with columns for id (as a primary key), name, age, grade. Later, you will add an 'email' column.
-- HINT: Use the CREATE TABLE command. Define 'id' as SERIAL PRIMARY KEY, and specify 'name', 'age', and 'grade' with appropriate data types (VARCHAR for name, INTEGER for age and grade).
-- After creating the table, verify its creation.
-- HINT FOR VERIFICATION: Use the \dt command to list all tables in the current database.

students=# create table students (id serial primary key, name varchar(255), age integer, grade integer);
CREATE TABLE
            List of relations
 Schema |   Name   | Type  |    Owner     
--------+----------+-------+--------------
 public | students | table | danieltorres

                                     Table "public.students"
 Column |          Type          | Collation | Nullable |               Default                
--------+------------------------+-----------+----------+--------------------------------------
 id     | integer                |           | not null | nextval('students_id_seq'::regclass)
 name   | character varying(255) |           |          | 
 age    | integer                |           |          | 
 grade  | integer                |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (id)
-- TASK: Add an 'email' column of type VARCHAR(255) to the 'students' table.
-- HINT: Use the ALTER TABLE command followed by ADD COLUMN, then specify the column name and its data type.
-- Verify the column addition by selecting all rows from the table (even though it will be empty at this point).
-- HINT FOR SELECTION: Use SELECT * FROM followed by the table name; this will display all columns and rows, showing the structure including the new column.

students=# alter table students add column email varchar(255);
ALTER TABLE
students=# select * from students;
 Column |          Type          | Collation | Nullable |               Default                
--------+------------------------+-----------+----------+--------------------------------------
 id     | integer                |           | not null | nextval('students_id_seq'::regclass)
 name   | character varying(255) |           |          | 
 age    | integer                |           |          | 
 grade  | integer                |           |          | 
 email  | character varying(255) |           |          | 
-- TASK: Insert a row into the 'students' table. Choose any appropriate values for name, age, grade, and email.
-- HINT: Use the INSERT INTO command followed by the table name and a list of column names in parentheses. Use VALUES to specify the corresponding values for each column.
-- Verify the row insertion by selecting all rows from the table.
-- HINT: Similar to the previous selection hint, but now it should return the row you've just inserted.
students=# insert into students (name, age, grade, email) values ('Danny Doe', 15, 10, 'dannydoe@email.com');
students=# select * from students;
 id |   name    | age | grade |       email        
----+-----------+-----+-------+--------------------
  1 | Danny Doe |  15 |    11 | dannydoe@email.com
-- TASK: Increase the grade of all students by 1.
-- HINT: Use the UPDATE command followed by the table name. Use SET to specify which column to update ('grade') and how to update it (increment its current value by 1).
-- Verify the update by selecting all rows.
students=# update students set grade = grade + 1;
UPDATE 1

-- TASK: Set the grade to 11 for all students aged 15.
-- HINT: Similar to the previous UPDATE command, but include a WHERE clause to target only rows where 'age' equals 15.
-- Verify the update by selecting all rows.

 id |   name    | age | grade |       email        
----+-----------+-----+-------+--------------------
  1 | Danny Doe |  15 |    11 | dannydoe@email.com
-- TASK: Update the email of the student named 'John Doe' (or whatever name you used).
-- HINT: Use UPDATE with a WHERE clause to specify the condition (e.g., WHERE name = 'John Doe'), then use SET to change the 'email' column value.
-- Verify the update by selecting the row for the student you updated.
set email = 'dannydoe@gmail.com'
where name = 'Danny Doe';
UPDATE 1
students=# select * from students;
 id |   name    | age | grade |       email        
----+-----------+-----+-------+--------------------
  2 | Jill Doe  |  15 |    11 | jilldoe@email.com
  1 | Danny Doe |  14 |    10 | dannydoe@gmail.com
-- TASK: Select the row for the student named 'John Doe'.
-- HINT: Use SELECT * FROM with a WHERE clause to filter rows based on the 'name' column.
students=# select * from students where name = 'Jill Doe';
 id |   name   | age | grade |       email       
----+----------+-----+-------+-------------------
  2 | Jill Doe |  15 |    11 | jilldoe@email.com
-- TASK: Select all rows for students aged 15.
-- HINT: Similar to the previous SELECT command, but adjust the WHERE clause to filter based on 'age'.
students=# select * from students where age = 15;
 id |   name   | age | grade |       email       
----+----------+-----+-------+-------------------
  2 | Jill Doe |  15 |    11 | jilldoe@email.com
(1 row)
-- TASK: Select only the 'name' and 'email' columns for all students.
-- HINT: Instead of using *, specify the column names you want to retrieve in your SELECT statement.
students=# select name, email from students;
   name    |       email        
-----------+--------------------
 Jill Doe  | jilldoe@email.com
 Danny Doe | dannydoe@gmail.com
-- TASK: Select all columns for all students.
-- HINT: Use SELECT * FROM to fetch all columns from the 'students' table.
students=# select * from students;
 id |   name    | age | grade |       email        
----+-----------+-----+-------+--------------------
  2 | Jill Doe  |  15 |    11 | jilldoe@email.com
  1 | Danny Doe |  14 |    10 | dannydoe@gmail.com
-- TASK: Delete the row for the student named 'John Doe'.
-- HINT: Use DELETE FROM with a WHERE clause to specify which row(s) to remove based on the 'name' column.
-- Verify the deletion by selecting all rows to ensure the row has been removed.
students=# delete from students where name = 'Jill Doe';
DELETE 1
students=# select * from students;
 id |   name    | age | grade |       email        
----+-----------+-----+-------+--------------------
  1 | Danny Doe |  14 |    10 | dannydoe@gmail.com