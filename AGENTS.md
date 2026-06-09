# MD

Frozen coursework for FIB-UPC Data Mining (MD): exploratory analysis and modelling in R, organised as an RStudio project (`MD.Rproj`) and managed with `renv` for reproducibility.

## Architecture
- `src/` — R scripts (`PCA.R`, `clustering-profiling.R`, `anova.R`, `preprocessing.r`, `sampling.r`) and RMarkdown sources.
- `markdown/` — RMarkdown notebooks.
- `data/`, `Preprocessed_data.csv`, `BeforeMissing.rds` — datasets at various pipeline stages.
- `Practica_1/`, `Practica_2/` — deliverables (docx, pptx, xlsx).
- `reports/`, `slides/`, `teoria/`, `docs/` — generated outputs and course material.

## Build and Test
1. Open `MD.Rproj` in RStudio (or launch R from repo root); `.Rprofile` bootstraps `renv` automatically.
2. Restore pinned packages: `renv::restore()`.
3. Run scripts in `src/` directly, or knit `.Rmd` files via `rmarkdown::render("path/to/file.Rmd")`.

## Pitfalls
- Frozen coursework — do not refactor or restructure; preserve original analysis.
- `renv.lock` pins R 4.2.2; mismatched R versions will warn and may fail to restore.
- Do not run `renv::update()` or blindly upgrade packages; it will desync the lockfile.
- Large intermediate artefacts (`.rds`, `.csv`) live at the root for direct access — keep them in place.

See [README.md](README.md).
