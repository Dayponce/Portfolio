# Analyzing Industry Carbon Emission
In this analysis, the focus is on the carbon emissions data for various industry groups, emphasizing the most recent year within the database. The goal is to understand and compare the carbon footprints of different industries based on the latest available data.

The dataset, publicly available on nature.com, contains product carbon footprints (PCFs) for various companies. PCFs represent greenhouse gas emissions associated with specific products, measured in CO2 (carbon dioxide equivalent). The dataset is stored in a PostgreSQL database and comprises a single table, product_emissions.

## Skills Utilized:
This analysis involves SQL querying, database manipulation, data aggregation, and result filtering techniques. Insights about the carbon footprints of various industry groups are extracted, aiding in the understanding of their environmental impact.

## Analysis Approach:

Initially, the most recent year for which carbon emissions data is available within the product_emissions dataset is identified.
Subsequently, a SQL query is executed to aggregate and summarize carbon emissions by industry groups for this specific year.
The results are sorted in descending order, showcasing the highest-emitting industries at the top.
## Report
Most recent year of data: 2017.

Top-emitting industries:
1. Materials: 107,129.0 PCFs (11 companies).
2. Capital Goods: 94,942.7 PCFs (4 companies).
3. Technology Hardware & Equipment: 21,865.1 PCFs (22 companies).

Notable insights:
- Materials industry had the highest emissions.
- Capital Goods and Technology Hardware & Equipment were significant emitters.
- Implications for environmental monitoring and mitigation efforts.
