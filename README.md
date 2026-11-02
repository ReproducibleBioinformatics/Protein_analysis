# Protein_analysis

Reproducible analysis of label-free proteomics data (Proteome Discoverer exports): merge of per-sample Excel files, then the standard DEP workflow (filtering, vsn normalization, imputation, limma differential expression, PCA, clustering, volcano plots).

## Requirements

[Docker](https://docs.docker.com/get-docker/) (Docker Desktop on Windows and macOS). The image is available for both amd64 and arm64.

## Usage

1. Download or clone this repository.
2. Put the input Excel files in `data/`.
3. Start JupyterLab by double-clicking the launcher for your system:
   - Linux: `start_linux.sh`
   - macOS: `start_mac.command`
   - Windows: `start_windows.bat`
4. JupyterLab opens in the browser. The repository folder is available inside the container as `/sharedFolder`.
5. Run the notebooks in `notebooks/` in order.

Stop JupyterLab with `Ctrl+C` in the launcher window. To use a port other than 8888, set the `PORT` environment variable before starting.

## Image

`ghcr.io/reproduciblebioinformatics/protein_analysis`, built automatically by GitHub Actions from `docker/Dockerfile`.

- R 4.5.1 (rocker/r-ver, pinned CRAN snapshot), Bioconductor 3.22
- R packages: DEP, limma, edgeR, readxl, ggplot2, pheatmap, IRkernel
- JupyterLab 4.4.5 in a separate Python environment, not exposed as a kernel
