<h1 align = "center">
  <img src="../assets/16Sguild_long.png" alt="16SguildLogo" width="300">
</h1>

<h1 align="center" style="margin-bottom:0;">
  <strong><code>16Sguild</code> : Parameters </strong>
</h1>

<p align="center">
  <img alt="Last Commit" src="https://img.shields.io/github/last-commit/zhao-microbiome-lab/16Sguild">
  <img alt="License" src="https://img.shields.io/github/license/zhao-microbiome-lab/16Sguild">
  <img alt="Top Language" src="https://img.shields.io/github/languages/top/zhao-microbiome-lab/16Sguild">
  <img alt="Contributors" src="https://img.shields.io/github/contributors/zhao-microbiome-lab/16Sguild">
  <img alt="Version" src="https://img.shields.io/github/v/release/USERNAME/REPO?include_prereleases">
</p>

<p align="center">
  <a href="../"><code>Home</code></a>
  <a href="../basic-workflow/"><code>Basic Workflow</code></a>
  <a href="../parameters/"><code>Parameters</code></a>
  <a href="../output/"><code>Output</code></a>
  <a href="../changelog/"><code>Change Log</code></a>
  <a href="../faq/"><code>FAQ</code></a>
</p>

<h1 align="center">
  <a href="https://biostats-shinyr.kumc.edu/16SguildDB/">
    <img src="../assets/16SguildDatabaseButton.PNG" alt="16S Guild Database" width="150"/>
  </a>
</h1>

<p align="center" style="font-size:22px;">
  <strong>
    Descriptions of all input parameters for guild-based analysis of 16S-rRNA sequencing data based on  
    <a href="https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-021-00840-y" target="_blank">Wu and Zhao et al., 2021</a>.
  </strong>
</p>

---

<h2 align="center"> ⚙️ Parameters </h2>

| Parameter        | Description                                                               | <code>16Sguild</code> process (step)                 | Tool              | Link to Documentation |
|------------------|---------------------------------------------------------------------------|------------------------------------------------------|-------------------|-------------|
| `samplesheet`    | Path to the CSV file containing sample information                        | Sample manifest import (s1)  | QIIME2 import | [Importing data](https://docs.qiime2.org/2024.10/tutorials/importing/)|
| `base_name`      | String identifying the name of input folder                               | General                                         | 16Sguild       | Pipeline Feature |
| `input_type`     | Semantic type required for the QIIME2 import function                     | Import (s1)                                          | QIIME2 import | [Importing data](https://docs.qiime2.org/2024.10/tutorials/importing/) |
| `input_format`   | Format of the data to import (e.g., "PairedEndFastqManifestPhred33")      | Import (s1)                                           | QIIME2 import | [Importing data - Format](https://docs.qiime2.org/2024.10/tutorials/importing/#pairedendfastqmanifestphred33v2) |
| `trim_forward`   | Forward primer sequence to trim                                           | Trimming (s3)                                        | QIIME2 (cutadapt) | [Trimming](https://docs.qiime2.org/2024.10/plugins/available/cutadapt/trim-paired/) |
| `trim_reverse`   | Reverse primer sequence to trim                                           | Trimming (s3)                                        | QIIME2 (cutadapt) | [Trimming](https://docs.qiime2.org/2024.10/plugins/available/cutadapt/trim-paired/) |
| `metadata`       | Path to the sample metadata table (TSV format)                            | Metadata import (s5)                            | QIIME2 metadata | [Metadata](https://docs.qiime2.org/2024.10/tutorials/metadata/#) |
| `trunc_forward`  | Position at which to truncate forward reads in QIIME2 DADA2               | Quality filtering (s5)                           | QIIME2 (DADA2)    | [DADA2](https://amplicon-docs.qiime2.org/en/stable/references/plugins/dada2.html#q2-action-dada2-denoise-paired) |
| `trunc_reverse`  | Position at which to truncate reverse reads in QIIME2 DADA2               | Quality filtering (s5)                          | QIIME2 (DADA2)    | [DADA2](https://amplicon-docs.qiime2.org/en/stable/references/plugins/dada2.html#q2-action-dada2-denoise-paired) |
| `s5_forceDenoiseAll` | (Optional) Forcing all samples in one denoising step. Default is false. | Denoise (s5)                                              | 16Sguild | Pipeline Feature |
| `seed`           | (Optional) Random seed for various steps in <code>16SguildR</code>. Default is 42.          | Quality filtering (s10)                          | 16Sguild | Pipeline Feature |
| `num_replicates` | (Optional) Involved with filtering out unreliable sequences. Default is 1000. | Quality filtering (s10) | 16Sguild | Pipeline Feature |
| `linkage_table`  | Table output from [16Sguild database](https://biostats-shinyr.kumc.edu/16SguildDB/) assigning UUIDs to ASVs                                                 | Filtering (s12)                                  | Database        | Pipeline Feature |
| `max`            | Maximum depth value used for alpha rarefaction                           | Alpha rarefaction (s14)                                  | QIIME2 | [Alpha rarefection](https://docs.qiime2.org/2024.10/plugins/available/diversity/alpha-rarefaction/) |
| `min`            | (Optional) Maximum depth value used for alpha rarefaction. Default is 100. | Alpha rarefaction (s14)                                  | QIIME2 | [Alpha rarefaction](https://docs.qiime2.org/2024.10/plugins/available/diversity/alpha-rarefaction/) |
| `steps`          | (Optional) Number of intermediate depths for alpha rarefaction visualization. Default is 100.   | Alpha rarefaction (s14)                                   | QIIME2  | [Alpha rarefaction](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `sampling_depth` | Rarefaction sampling depth for diversity analysis                         | Diversity analysis (s15)                         | QIIME2  | [Diversity](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `exclude_iterations` |   (Optional) Number of times highly correlated OTU pairs are discovered and excluded in SparCC analysis. Default is 20.  | Correlation analysis (s19)   |  FastSpar | [FastSpar](https://github.com/scwatts/fastspar)|
| `iterations`     |   (Optional) Number of SparCC correlation estimation. Default is 50.      | Correlation analysis (s19)                       | FastSpar  | [FastSpar](https://github.com/scwatts/fastspar)|
| `threshold`      | (Optional) Minimum threshold to exclude correlated OTU pairs in SparCC analysis. Default is 0.2.  | Correlation analysis (s19)                        | FastSpar  | [FastSpar](https://github.com/scwatts/fastspar)|
| `number_bootstrap` | (Optional) Number of bootstraps for permutation based p-value estimations. Default is 1000. | Correlation analysis (s19)                   | FastSpar/rmcorr  | [FastSpar](https://github.com/scwatts/fastspar)|
| `permutations`   |  (Optional) Number of correlations for each bootstrap count. Default is 1000.                | Correlation analysis (s19)                       |  FastSpar | [FastSpar](https://github.com/scwatts/fastspar)|
| `s19_rmcorr`     | (Optional) Run rmcorr for repeated measures correlation. Default is false. Requires including string value for `subject_column`| Correlation analysis (s19) | rmcorr | [RMcorr](https://cran.r-project.org/web/packages/rmcorr/index.html) |
| `subject_column`  | (Optional) Label for sample type. Default is 'subject'. | Correlation analysis (s19) | rmcorr | [RMcorr](https://cran.r-project.org/web/packages/rmcorr/index.html) |
| `nfiles_input`   | (Optional) Number of top individual CAG plots to generate. Default is 5. | Plot CAG (s20c) | 16Sguild| Pipeline Feature |
| `outdir`         | (Optional) Name of folder where the results will be stored. Default is 'results'. | General                      | Nextflow  | [Nextflow](https://www.nextflow.io/docs/latest/workflow.html#outputs) |
| `publish.mode`   | (Optional) Default to 'symlink', but can be changed to 'copy' if necessary to copy results to results file    | General | Nextflow  | [Nextflow](https://www.nextflow.io/docs/latest/reference/process.html#publishdir)|

<br> </br>
<p align="center">
  <a href="../"><code>Home</code></a>
  <a href="../basic-workflow/"><code>Basic Workflow</code></a>
  <a href="../parameters/"><code>Parameters</code></a>
  <a href="../output/"><code>Output</code></a>
  <a href="../changelog/"><code>Change Log</code></a>
  <a href="../faq/"><code>FAQ</code></a>
</p>

<h1 align = "center">
  <img src="../assets/16Sguild.png" alt="16SguildLogo" width="200">
</h1>


