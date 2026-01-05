# Data Pipeline

A data pipeline allows data movement when multiple databases are used in a company or project and we need to combine and use data together.

### ETL vs ELT Pipelines
- **ELT Pipeline** → Extract → Load → Transform  
- **ETL Pipeline** → Extract → Transform → Load  

---

## Key Components of Data Pipelines

1. **Data Sources**  
   Sources from where we pull our data. These may include databases, API calls, logs, etc.

2. **Data Ingestion**  
   Feeding data into the data pipeline. After ingestion, either ETL or ELT operations are performed.

3. **Data Processing**  
   Cleaning, filtering, normalizing, and transforming data. This processed data is suitable for analytics and machine learning tasks.

4. **Data Storage**  
   If ELT is used, storage occurs right after ingestion.  
   Examples: SQL databases, key-value stores, graph databases, MongoDB (NoSQL), etc.

5. **Data Analysis**  
   Analyzing the refined data according to requirements, monitoring metrics, and generating insights.

6. **Data Visualization**  
   An important step as visualization helps other team members understand the data and insights more clearly.

7. **Monitoring and Orchestration**  
   Continuous monitoring and orchestration to ensure the refined data is correctly loaded and pipelines are running smoothly.

> The above pipeline represents a **general architecture**.  
> Some steps may differ depending on the technology stack, but the base architecture remains the same.

---

## Different Types of Data Pipelines

### 1. Batch Processing
Designed to process data in batches, usually scheduled or periodic.  
Suitable for large volumes of data but not ideal for time-series or real-time use cases.

### 2. Streaming Processing
Real-time data processing with immediate analysis and decision-making.  
Common use cases include fraud detection and social media monitoring.

### 3. Data Integration
An automated workflow that collects data from multiple sources, transforms it into a consistent format, and loads it into a target system (data warehouse, data lake, or application) for analytics or operations.

---

## Building Real-Time Machine Learning Pipelines

### Challenges

There is a significant difference between building a **research environment project** and a **production-ready AI system**, making production pipelines much more complex.

1. **Siloed Development**  
   Multiple team members work together, and they may use different tools and environments for the same task.

2. **Lengthy Process**  
   Developing a research-level pipeline is comparatively easier.  
   Production-level pipelines require more effort as each stage of development is more complex and time-consuming.

3. **Access and Features**  
   Real-world feature extraction is required instead of one-time extraction from CSV files.

4. **Model Accuracy**  
   Tracking, maintaining, and explaining model accuracy in production is challenging and critical.
