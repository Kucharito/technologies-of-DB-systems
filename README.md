# TDS Projekt – Adam Kuchár (KUC0396)

This project was created as part of the **TDS (Databases)** course.  
It demonstrates database schema design, data manipulation, and SQL queries in **Oracle Database**.

---

## 📂 Project structure

- **SchemaTDS.sql**  
  Contains the database schema (tables, constraints).  

- **InsertTDS.sql**  
  Contains sample data inserts for populating the schema.  

- **SelectJoinFunctions.sql**  
  Contains example queries with `SELECT`, `JOIN`, and functions.  

- **KompletSQL.sql**  
  A complete script including schema creation, inserts, and queries.  

- **TDS.docx**  
  Documentation of the project (assignment, explanation, results).

---

## 🚀 How to run the project

1. Open **Oracle SQL Developer** (or any Oracle client).  
2. Connect to your Oracle Database instance.  
3. Run the scripts in the following order:

   ```sql
   -- Step 1: Create schema
   @SchemaTDS.sql;

   -- Step 2: Insert data
   @InsertTDS.sql;

   -- Step 3: Run example queries
   @SelectJoinFunctions.sql;

4. Alternatively, you can run everything at once:
   @Komplet.sql;


## 🗄️ Database contents

The schema contains several tables (defined in **SchemaTDS.sql**) and is populated with realistic sample data.  
The queries demonstrate:

- Basic `SELECT` statements  
- `JOIN` operations between tables  
- Use of aggregate and scalar functions  
- Filtering with `WHERE`, `GROUP BY`, `HAVING`


## 🧑‍💻 Author

Created by **Adam Kuchár**  
Developed as part of coursework – **Databases**.  
