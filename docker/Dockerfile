# Standalone JupyterLab + R environment for protein spectral-count analysis
FROM rocker/r-ver:4.5.1

ARG JUPYTERLAB_VERSION=4.4.5
ARG BIOC_VERSION=3.22

# Python only for JupyterLab, in its own venv (never used for the analysis)
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 python3-venv \
      libxml2-dev libcurl4-openssl-dev libssl-dev zlib1g-dev libzmq3-dev \
      && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/jupyter \
 && /opt/jupyter/bin/pip install --no-cache-dir "jupyterlab==${JUPYTERLAB_VERSION}" \
 && rm -rf /opt/jupyter/share/jupyter/kernels/python3

COPY jupyter_server_config.py /opt/jupyter/etc/jupyter/jupyter_server_config.py

# R packages for the analysis (CRAN snapshot is pinned by rocker/r-ver)
RUN R -q -e 'install.packages(c("IRkernel", "readxl", "ggplot2", "pheatmap", "BiocManager"))' \
 && R -q -e 'BiocManager::install("edgeR", version = Sys.getenv("BIOC_VERSION"), update = FALSE, ask = FALSE)' \
 && R -q -e 'pkgs <- c("IRkernel", "readxl", "ggplot2", "pheatmap", "edgeR"); missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]; if (length(missing)) { message("Missing packages: ", paste(missing, collapse = ", ")); quit(status = 1) }'

# Register R as a kernel inside the JupyterLab venv
RUN PATH=/opt/jupyter/bin:$PATH R -q -e 'IRkernel::installspec(user = FALSE, prefix = "/opt/jupyter", displayname = "R 4.5.1")'

# Writable home for any user id (the Linux launcher runs with the host uid)
RUN mkdir -p /home/user /sharedFolder && chmod 1777 /home/user /sharedFolder
ENV HOME=/home/user

USER 1000:1000
WORKDIR /sharedFolder
EXPOSE 8888

CMD ["/opt/jupyter/bin/jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--ServerApp.root_dir=/sharedFolder"]
