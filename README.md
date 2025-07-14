# 🏭 Data Warehouse Project – Maker Inc. (ETL with SSIS)

This project demonstrates a fully functional **ETL pipeline** using **SQL Server Integration Services (SSIS)** to load a dimensional data warehouse for a fictional manufacturing company, **Maker Inc.** It was completed as part of the **CSID6853 – Data Warehousing** course, with a final mark of **92%**.

## 📁 Project Overview

The goal was to build a **star-schema dimensional model**, load it using SSIS, and apply best practices in ETL engineering such as modularization, error handling, lookup validation, and data quality assurance.

---

## 🧱 Data Warehouse Structure

- 🧩 **Fact Tables**:
  - `FactManufacturing`
  - `FactInventory`

- 📊 **Dimension Tables**:
  - `DimBatch`, `DimProduct`, `DimMachine`, `DimMaterial`, `DimMachineType`
  - `DimProductType`, `DimProductSubType`, `DimDate`, `DimCountry`, `DimPlant`

- 📄 **Data Sources**:
  - `BatchData.csv` – batch production records
  - `ExternalAccountData.xls` – hierarchical country-region-account data
  - Order Processing System & Accounting System (simulated relational databases)

---

## 📦 SSIS Packages

### 🔁 `Master.dtsx`
- Orchestrates the loading of dimensions and fact tables in sequence

### 📐 `LoadDimensions.dtsx`
- Cleans tables and loads all dimension tables (except DimBatch)
- Applies transformations, filters, and hierarchical joins
- Sources from Excel, CSV, and SQL

### 🏭 `LoadFacts.dtsx`
- Loads `DimBatch`, `FactManufacturing`, and `FactInventory`
- Uses **lookups**, **derived columns**, and **data quality logic**
- Unmatched records are logged to:
  - `ManufactureErrors.txt`
  - `InventoryErrors.txt`

---

## 🔧 Technologies Used

- 💻 Microsoft SQL Server + SSMS
- 📊 SSIS (SQL Server Integration Services)
- 🗃️ Relational databases + flat files
- 🛠️ Derived Columns, Lookups, Aggregations, Union All, Conditional Splits
- 📁 File-based error handling and data staging

---

## 📈 FactManufacturing ETL Flow

**Source:** `BatchData.csv`  
**Transformations:**  
- Calculate elapsed time using `DATEDIFF(TimeStarted, TimeStopped)`
- Lookup dimension keys (`DimBatch`, `DimProduct`, `DimMachine`)
- Derived fields for accepted/rejected products  
**Errors:** Rows failing lookups logged to `ManufactureErrors.txt`  
**Destination:** `FactManufacturing` table

---

## 📊 Dimensional Model

*(Insert star schema diagram or link to dimensional_model.png if added)*

---

## 📝 How to Run

1. **Setup:** Create SQL Server DB with schema (use `spCreateDM.sql`)
2. **Prepare:** Place data files in `C:\SSISTemp\`
   - `BatchData.csv`
   - `ExternalAccountData.xls`
3. **Load:** Open solution in Visual Studio and run:
   - `Master.dtsx` → orchestrates `LoadDimensions` → `LoadFacts`
4. **Check Outputs:**
   - Error logs: `C:\SSISTemp\ManufactureErrors.txt`, `InventoryErrors.txt`
   - Data warehouse tables populated

---

## ✅ Learning Outcomes

- Applied **star schema modeling** and dimension hierarchies
- Built modular ETL processes with **SSIS control/data flow logic**
- Implemented robust **error handling and data quality checks**
- Integrated diverse data sources (CSV, Excel, SQL)
- Developed reusable and re-runnable pipelines

---

## 📚 Academic Credit

> **CSID6853 – Data Warehousing**  
> Department of Computer Science and Informatics  
> University of the Free State (2025)  
> **Grade: 91%**

---

## 🧠 Author

**Kananelo Lekgetho**  
- Data Enthusiast | Systems Analyst | ETL Developer  
- GitHub: [@Lekgto](https://github.com/Lekgto)  
- [LinkedIn](www.linkedin.com/in/kananelo-lekgetho-3b4049248) 

---

## 📌 Future Improvements

- Integrate **Power BI** or **Grafana** for live dashboards  
- Move pipelines to **cloud-native tools** (Azure Data Factory)  
- Add **unit testing** or **data validation checks**  
- Extend to **real-time streaming** using Kafka or MQTT (for IoT)

---

## 📄 License

This project is for educational and portfolio purposes only. Not for commercial redistribution.
