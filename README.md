# SIR COVID-19 Model – Canada (Dec 2021 to May 2022)

This project uses MATLAB to simulate and fit a classic SIR (Susceptible–Infected–Recovered) epidemic model to real COVID-19 data from Canada, focusing on the Omicron wave (Dec 2021 – May 2022).

- Imports daily case data from [Our World in Data](https://ourworldindata.org/coronavirus)
- Estimates active infections using a 14-day rolling sum
- Fits the SIR model parameters (`β`, `γ`) using nonlinear least squares (`fminsearch`)
- Compares model predictions to real data
- Plots the fitted infection curve against actual active cases

Outputs:
- Estimated transmission rate `β`
- Estimated recovery rate `γ`
- Basic reproduction number `R₀ = β / γ`

How to Run:
1. Download the COVID dataset from Our World in Data
2. Place `owid-covid-data.csv` in the project folder
3. Run `run_spreadmodel.m` in MATLAB
