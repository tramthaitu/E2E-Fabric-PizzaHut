# 🍕 End-to-End PizzaHut Analysis on Microsoft Fabric

This project demonstrates a comprehensive **End-to-End Data Analytics Solution** built entirely on the **Microsoft Fabric** platform. It automates the data lifecycle for Pizza Hut sales data, from ingestion to ETL processing, Machine Learning deployment (Prediction & Customer Segmentation), and final reporting in Power BI, featuring real-time monitoring via Microsoft Teams.

## 📖 Table of Contents
- [Project Objective](#-project-objective)
- [High-Level Workflow](#-high-level-workflow)
- [Core Technology Stack](#-core-technology-stack)
- [Solution Architecture & Data Lineage](#-solution-architecture--data-lineage)
- [Workflow Details](#-workflow-details)
  - [1. Master Orchestration Pipeline](#1-master-orchestration-pipeline)
  - [2. ETL Pipeline (Data Engineering)](#2-etl-pipeline-data-engineering)
  - [3. Data Science Pipeline](#3-data-science-pipeline)
- [Serving Layer & Reporting](#-serving-layer--reporting)
- [Automation & Monitoring](#-automation--monitoring)

---

## 🎯 Project Objective

The primary goal of this project is to modernize the analytics capability for Pizza Hut data by leveraging the unified experience of Microsoft Fabric. Key objectives include:
* **Automation:** Replace manual data tasks with automated pipelines moving data from SharePoint to the Warehouse.
* **Advanced Analytics:** Apply Machine Learning models to predict **Voucher Status** and perform **Customer Segmentation** to understand buying behavior.
* **Centralized Storage:** Implement a Medallion Architecture using Lakehouse for staging and Warehouse for serving.
* **Operational Excellence:** Ensure high availability through automated monitoring and alerts via Microsoft Teams.

---

## 🔄 High-Level Workflow

The diagram below illustrates the conceptual journey of the data from the source to the final dashboard, highlighting the interaction between Data Engineering and Data Science.

<p align="center">
  <img src="images/Data%20workflow.png" width="100%">
  <br>
  <em>Figure 1: Conceptual End-to-End Workflow for Pizza Hut Analysis.</em>
</p>

---

## 🛠 Core Technology Stack

* **Platform:** Microsoft Fabric (All-in-one analytics solution).
* **Ingestion & Orchestration:** Data Factory (Pipelines).
* **Data Engineering:** Synapse Data Engineering (Spark Notebooks / PySpark).
* **Data Warehousing:** Synapse Data Warehouse (T-SQL Stored Procedures).
* **Machine Learning:** Synapse Data Science (MLflow, Scikit-learn).
* **Storage:** OneLake (Lakehouse for Staging, Warehouse for Serving).
* **Visualization:** Power BI (Direct Lake mode).
* **Automation:** Power Automate, Microsoft Teams.

---

## 🏗 Solution Architecture & Data Lineage

While the workflow above shows the concept, the view below represents the **actual technical implementation** and lineage within the Microsoft Fabric workspace.

<p align="center">
  <img src="images/Data%20lineage%201.png" width="100%">
  <br>
  <em>Figure 2: Implementation Lineage in Microsoft Fabric.</em>
</p>

**Data Flow Explanation:**
1.  **Ingestion:** Data Factory pipeline extracts raw sales files from **SharePoint**.
2.  **Staging (Lakehouse):** Raw data is loaded into the **Fabric Lakehouse**.
3.  **Processing:**
    * *Data Engineering:* The `Load Data` Notebook cleans and standardizes the data.
    * *Data Science:* Parallel processes run for **Model Training**, **Prediction**, and **Customer Segmentation**.
4.  **Loading (Warehouse):** Processed data and ML results are loaded into the **Fabric Warehouse** via SQL Scripts (Stored Procedures).
5.  **Reporting:** Power BI visualizes the data directly from the Warehouse.

---

## 🚀 Workflow Details

The system is orchestrated using a "Parent-Child" pipeline pattern for modularity and maintainability.

### 1. Master Orchestration Pipeline
This is the parent pipeline that controls the execution sequence. It ensures that the Data Warehouse is updated with fresh data (ETL) *before* the Machine Learning models run.

<p align="center">
  <img src="images/Master%20pipeline.png" width="90%">
  <br>
  <em>Step 1: Master Pipeline orchestrating ETL and DS tasks.</em>
</p>

* **Step 1:** Trigger `Load DWH Pipeline`.
* **Step 2:** On success, trigger `DS Pipeline` (Data Science).
* **Step 3:** Send a completion notification to Teams.

### 2. ETL Pipeline (Data Engineering)
Responsible for transforming Raw data into Silver/Gold quality data.

<p align="center">
  <img src="images/Load%20DWH%20pipeline.png" width="90%">
  <br>
  <em>Step 2: Data Engineering pipeline with Stored Procedures.</em>
</p>

* **Notebook `Load data`:** Uses PySpark to handle null values, format dates, and apply business logic.
* **Stored Procedures:** Uses T-SQL to `MERGE` (Upsert) data into Fact and Dimension tables within the Warehouse.
* **Logic:** Includes `If Condition` activities to handle success/failure paths.

### 3. Data Science Pipeline
Dedicated pipeline for advanced analytics and model inference.

<p align="center">
  <img src="images/DS%20pipeline.png" width="90%">
  <br>
  <em>Step 3: Machine Learning pipeline for training and prediction.</em>
</p>

* **Train Model:** Retrains the machine learning model with the latest dataset.
* **Prediction:** Generates predictions for customer behavior (e.g., Voucher Status).
* **Customer Segment:** Runs clustering algorithms to segment customers.
* **Load Results:** Inferences are written back to the Warehouse via Stored Procedures to be visualized in Power BI.

---

## 📊 Serving Layer & Reporting

The reporting layer leverages the **Semantic Model** with **Direct Lake** mode. This allows Power BI to query the Warehouse directly without importing data, ensuring near real-time performance.

<p align="center">
  <img src="images/Data%20lineage%202.png" width="100%">
  <br>
  <em>Figure: Data flow from Warehouse to Power BI Report.</em>
</p>

<p align="center">
  <img src="images/Data%20model.jpg" width="100%">
  <br>
  <em>Figure: Semantic Model relationship diagram in Power BI.</em>
</p>

---

## 🔔 Automation & Monitoring

To ensure operational stability, the project integrates **Power Automate** to send real-time pipeline status notifications to a specific **Microsoft Teams** channel.

### Power Automate Configuration
A generic Workflow is triggered via Webhook from the Fabric Pipelines to post messages.

<p align="center">
  <img src="images/Power%20automate.jpg" width="80%">
  <br>
  <em>Configuration of Power Automate Webhook.</em>
</p>

### Real-time Notifications
The team receives detailed updates, including which tables were loaded successfully and the status of ML models.

<p align="center">
  <img src="images/messages%20microsoft.png" width="60%">
  <br>
  <em>Example of Teams Notifications on success.</em>
</p>

---

## 👤 Author
Project developed by **[Your Name]**.
