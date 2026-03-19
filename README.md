# MD (Data Mining & Modeling)

## Overview

This repository contains data mining projects and practical assignments (Prácticas). It is structured as an **R Project** (`MD.Rproj`) and utilizes `renv` for reproducible dependency management.

## Repository Structure

```text
MD/
├── Practica_1/        # First practical assignment (deliverables, presentations, raw data descriptions)
├── Practica_2/        # Second practical assignment (tasks and documentation)
├── data/              # Raw, processed, and split datasets
├── src/               # R scripts and source code for data processing and analysis
├── markdown/          # RMarkdown files and notebooks
├── reports/           # Generated reports and project deliverables (e.g., D1, D3, D4)
├── slides/            # Presentations and slides used in class or for project defense
├── docs/              # Additional project documentation
├── teoria/            # Theoretical notes and course materials
├── misc/              # Miscellaneous files and temporary resources
├── renv/              # Local R environment library
├── renv.lock          # renv lockfile for dependency reproducibility
├── BeforeMissing.rds  # Intermediate dataset state (R data file)
└── Preprocessed_data.csv # Preprocessed dataset in CSV format
```

## Directory Details

- **`Practica_1/` & `Practica_2/`**: Contain the main assignment deliverables, including Word documents, Excel grids, and PowerPoint presentations outlining the analysis steps.
- **`data/`**: The primary data folder. Data analysis pipelines ingest data from this folder or the root directory (like `Preprocessed_data.csv` and `BeforeMissing.rds`) and output the processed models.
- **`src/` & `markdown/`**: These directories contain the source code for the project. R scripts and RMarkdown models used for data processing, model training, and evaluation are organized here.
- **`reports/` & `slides/`**: Contain formal reports, papers, and presentations generated during the course of the project.
- **`teoria/`**: Course theory and related study materials.

## Setup & Execution

### Prerequisites
- [R](https://www.r-project.org/) and optionally [RStudio](https://rstudio.com/)
- The `renv` package installed in R.

### Environment Setup
This project uses `renv` to maintain dependencies. To restore the exact package versions used in this project:

1. Open `MD.Rproj` in RStudio or launch R from the project root.
2. `renv` will automatically bootstrap itself using the `.Rprofile`.
3. Run the following command in the R console to restore the environment:
   ```R
   renv::restore()
   ```

## Disclaimer
Note that large data files and sensitive artifacts might be excluded via `.gitignore`. The files `BeforeMissing.rds` and `Preprocessed_data.csv` are tracked in the root for direct access during initial evaluation.
