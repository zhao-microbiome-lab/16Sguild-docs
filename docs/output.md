# Output

Descriptions of all output files for guild-based analysis of 16S-rRNA sequencing data based on [Wu and Zhao et al., 2021](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-021-00840-y).

Output files will be located under the folder `/results`.

---

| Subfolder | Description | `16Sguild` process (step) |  Tool | Link to Documentation |
|-----------|----------------------|---------------------------------------|-------|-----------------------|
| `/main_results/s1_{base_name}_raw.qzv` | QIIME2 visualization summarizing the quality and distribution of the raw sequencing data before trimming | Quality Check (s2) | QIIME2 | [Demux Summarize](https://docs.qiime2.org/2024.10/plugins/available/demux/summarize/) |
| `/main_results/s3_{base_name}_trimmed.qzv` | QIIME2 visualization (.qzv) summarizing the quality and distribution of the raw sequencing data after trimming | Trimming (s3) | QIIME2 (cutadapt) | [Trimming](https://docs.qiime2.org/2024.10/plugins/available/cutadapt/trim-paired/) |
| `/main_results/MULTIQC` | foldering containing the MultiQC file for all raw samples pooled together. | MultiQC (s0) | MultiQC | [MultiQC](https://nf-co.re/modules/multiqc/) |
| `/main_results/MULTIQC_trimmed` | foldering containing the MultiQC file for all trimmed samples pooled together. | MultiQC (s0) | MultiQC | [MultiQC](https://nf-co.re/modules/multiqc/) |
| `/main_results/s7_{base_name}_.qzv` | QIIME2 visualization of feature table summary of denoising statistics | Denoise (s5) | 16Sguild | Pipeline Feature |
| `/main_results/s11a_database` | `rds` file for [16Sguild database](https://biostats-shinyr.kumc.edu/16SguildDB/) assigning UUIDs to ASVs | Filtering (s12) | Database | Pipeline Feature |
| `/main_results/s14_alpha-rarefaction.qzv` | QIIME2 visualization of alpha rarefaction | Alpha rarefaction (s14) | QIIME2 | [Alpha rarefaction](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `/main_results/s17_formatTable` | filtered ASV table | Filtering (s17) | 16Sguild | Pipeline Feature |
| `/main_results/s20_CAG` | tables and graphs for CAG results | Plot CAG (s20) | 16Sguild | Pipeline Feature |
| `/intermediate_results/s1` | import sequencing files into a QIIME 2 artifact (.qza file)  | Import (s1) | QIIME2 | [Importing data](https://docs.qiime2.org/2024.10/tutorials/importing/) |
| `/intermediate_results/s2` | QIIME2 artifact (.qza) summarizing the quality and distribution of the raw sequencing data after trimming | Quality Check (s2) | QIIME2 | [Demux Summarize](https://docs.qiime2.org/2024.10/plugins/available/demux/summarize/) |
| `/intermediate_results/FASTQC` | folder containing the FASTQC files for the raw samples | FASTQC (s0) | FASTQC | [FASTQC](https://nf-co.re/modules/fastqc/) |
| `/intermediate_results/FASTQC_trimmed` | folder containing the FASTQC files for the trimmed samples | FASTQC (s0) | FASTQC | [FASTQC](https://nf-co.re/modules/fastqc/) |
| `/intermediate_results/s5` |  | Quality filtering (s5) | QIIME2 (DADA2) | [DADA2](https://amplicon-docs.qiime2.org/en/stable/references/plugins/dada2.html#q2-action-dada2-denoise-paired) |
| `/intermediate_results/s6_{base_name}_group#_denoising-stats.qzv` | | Denoise (s5) | 16Sguild | Pipeline Feature |
| `/intermediate_results/s9` | converts QIIME2 artifact into FASTA file  | Filtering (s12) | 16Sguild | Pipeline Feature |
| `/intermediate_results/s10` |  | Quality filtering (s10) | 16Sguild | Pipeline Feature |
| `/intermediate_results/s11b` | UUID and txt files for database | Filtering (s12) | Database | Pipeline Feature |
| `/intermediate_results/s12` | Prepare both sequences and feature table into proper QIIME-compatible artifacts | QIIME2 Import (s12) | QIIME2 | Pipeline Feature |
| `/intermediate_results/s13` | This set of steps produces a rooted phylogenetic tree (.qza) by aligning representative sequences, filtering the alignment, building an unrooted tree, and then applying midpoint rooting. | (s13) | QIIME2 | Pipeline Feature |
| `/intermediate_results/alphaBetaDiversity` | QIIME2 visualization of beta diversity plots | Diversity analysis (s15) | QIIME2 | [Diversity](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `/intermediate_results/s15` |  | Diversity analysis (s15) | QIIME2 | [Diversity](https://docs.qiime2.org/2024.10/plugins/available/diversity/index.html) |
| `/intermediate_results/s16` | exporting results | Export (s16) | 16Sguild | Pipeline Feature |
| `/intermediate_results/s19` | correlation analysis results | Correlation analysis (s19) | FastSpar | [FastSpar](https://github.com/scwatts/fastspar) |

