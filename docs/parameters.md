<div align="center">
    <img src="../assets/16Sguild_long.png" alt="16S Guild Long" width="450"/>
</div>

# Parameters

Descriptions of all input parameters for guild-based analysis of 16S-rRNA sequencing data based on [Wu and Zhao et al., 2021](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-021-00840-y).

---

| Parameter | Description | `16Sguild` process (step) | Tool | Link to Documentation |
|-----------|-------------|--------------------------|------|-----------------------|
| `samplesheet` | Path to the CSV file containing sample information | Sample manifest import (s1) | QIIME2 import | [Importing data](https://docs.qiime2.org/2024.10/tutorials/importing/) |
| `base_name` | String identifying the name of input folder | General | 16Sguild | Pipeline Feature |
| `input_type` | Semantic type required for the QIIME2 import function | Import (s1) | QIIME2 import | [Importing data](https://docs.qiime2.org/2024.10/tutorials/importing/) |
| `input_format` | Format of the data to import (e.g., "PairedEndFastqManifestPhred33") | Import (s1) | QIIME2 import | [Importing data - Format](https://docs.qiime2.org/2024.10/tutorials/importing/#pairedendfastqmanifestphred33v2) |
| `trim_forward` | Forward primer sequence to trim | Trimming (s3) | QIIME2 (cutadapt) | [Trimming](https://docs.qiime2.org/2024.10/plugins/available/cutadapt/trim-paired/) |
| `trim_reverse` | Reverse primer sequence to trim | Trimming (s3) | QIIME2 (cutadapt) | [Trimming](https://docs.qiime2.org/2024.10/plugins/available/cutadapt/trim-paired/) |
| `metadata` | Path to the sample metadata table (TSV format) | Metadata import (s5) | QIIME2 metadata | [Metadata](https://docs.qiime2.org/2024.10/tutorials/metadata/#) |
| `trunc_forward` | Position at which to truncate forward reads in QIIME2 DADA2 | Quality filtering (s5) | QIIME2 (DADA2) | [DADA2](https://amplicon-docs.qiime2.org/en/stable/references/plugins/dada2.html#q2-action-dada2-denoise-paired) |
| `trunc_reverse` | Position at which to truncate reverse reads in QIIME2 DADA2 | Quality filtering (s5) | QIIME2 (DADA2) | [DADA2](https://amplicon-docs.qiime2.org/en/stable/references/plugins/dada2.html#q2-action-dada2-denoise-paired) |
| `s5_forceDenoiseAll` | (Optional) Force all samples in one denoising step. Default is false. | Denoise (s5) | 16Sguild | Pipeline Feature |
| `seed` | (Optional) Random seed for various steps in `16SguildR`. Default is 42. | Quality filtering (s10) | 16Sguild | Pipeline Feature |
| `num_replicates` | (Optional) Involved with filtering out unreliable sequences. Default is 1000. | Quality filtering (s10) | 16Sguild | Pipeline Feature |
| `linkage_table` | Table output from [16Sguild database](https://biostats-shinyr.kumc.edu/16SguildDB/) assigning UUIDs to ASVs | Filtering (s12) | Database | Pipeline Feature |
| `max` | Maximum depth value used for alpha rarefaction | Alpha rarefaction (s14) | QIIME2 | [Alpha rarefaction](https://docs.qiime2.org/2024.10/plugins/available/diversity/alpha-rarefaction/) |
| `min` | (Optional) Minimum depth value used for alpha rarefaction. Default is 100. | Alpha rarefaction (s14) | QIIME2 | [Alpha rarefaction](https://docs.qiime2.org/2024.10/plugins/available/diversity/alpha-rarefaction/) |
| `steps` | (Optional) Number of intermediate depths for alpha rarefaction visualization. Default is 100. | Alpha rarefaction (s14) | QIIME2 | [Alpha rarefaction](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `sampling_depth` | Rarefaction sampling depth for diversity analysis | Diversity analysis (s15) | QIIME2 | [Diversity](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `exclude_iterations` | (Optional) Number of times highly correlated OTU pairs are discovered and excluded in SparCC analysis. Default is 20. | Correlation analysis (s19) | FastSpar | [FastSpar](https://github.com/scwatts/fastspar) |
| `iterations` | (Optional) Number of SparCC correlation estimations. Default is 50. | Correlation analysis (s19) | FastSpar | [FastSpar](https://github.com/scwatts/fastspar) |
| `threshold` | (Optional) Minimum threshold to exclude correlated OTU pairs in SparCC analysis. Default is 0.2. | Correlation analysis (s19) | FastSpar | [FastSpar](https://github.com/scwatts/fastspar) |
| `number_bootstrap` | (Optional) Number of bootstraps for permutation based p-value estimations. Default is 1000. | Correlation analysis (s19) | FastSpar/rmcorr | [FastSpar](https://github.com/scwatts/fastspar) |
| `permutations` | (Optional) Number of correlations for each bootstrap count. Default is 1000. | Correlation analysis (s19) | FastSpar | [FastSpar](https://github.com/scwatts/fastspar) |
| `s19_rmcorr` | (Optional) Run rmcorr for repeated measures correlation. Default is false. Requires `subject_column`. | Correlation analysis (s19) | rmcorr | [RMcorr](https://cran.r-project.org/web/packages/rmcorr/index.html) |
| `subject_column` | (Optional) Label for sample type. Default is `'subject'`. | Correlation analysis (s19) | rmcorr | [RMcorr](https://cran.r-project.org/web/packages/rmcorr/index.html) |
| `nfiles_input` | (Optional) Number of top individual CAG plots to generate. Default is 5. | Plot CAG (s20c) | 16Sguild | Pipeline Feature |
| `outdir` | (Optional) Name of folder where the results will be stored. Default is `'results'`. | General | Nextflow | [Nextflow](https://www.nextflow.io/docs/latest/workflow.html#outputs) |
| `publish.mode` | (Optional) Default to `'symlink'`, but can be changed to `'copy'` if necessary. | General | Nextflow | [Nextflow](https://www.nextflow.io/docs/latest/reference/process.html#publishdir) |
