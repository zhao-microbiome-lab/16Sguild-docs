<div align="center">
    <img src="../assets/16Sguild_long.png" alt="16S Guild Long" width="450"/>
</div>

# Frequently Asked Questions

FAQs for guild-based analysis of 16S-rRNA sequencing data based on [Wu and Zhao et al., 2021](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-021-00840-y).

---

### How can I submit a question, request a fix, or suggest an improvement to 16Sguild?

Thank you for asking! As scientists, we value collaboration, and look forward to hearing from you. We request that all these notes be submitted to the [GitHub Issues](https://github.com/zhao-microbiome-lab/16Sguild/issues) page, which the team will monitor and respond to regularly.

### What about metagenomic samples?

Great question! We are looking to implement a guild-based pipeline for analysis of metagenomic data. Keep an eye out for the release of this new pipeline, `metaguild`.

### Is there a specific way I should format my metadata file?

Good question! The metadata file should be in a `.tsv` file format. Ensure that each sample only appears once in the list (i.e. if you have paired-end sequencing data, remove one of the replicate names). If the first column in your metadata file is the sample names, then you might want to duplicate the names into a second column for visualization purposes because QIIME2 ignores the first column. Finally, ensure that the metadata file is in the same folder with the raw data and that the path is correct in your parameter file.

### Where can I find my sample output once the pipeline is at the end of a part?

Typically, all output files are in the `results/visualization` folder. After the first stop, the file should say `s3_<base_name>_trimmed.qzv`. At stop 2, the file should say `s5_<base_name>_table.qzv`. After stop 3, the file should be under `/s14_alphaRarefaction/s14_...<base_name>_alpha-rarefaction.qzv`. All of these files can be downloaded and then visualized on the [QIIME2 Visualization platform](https://view.qiime2.org/). To find the linkage table, go to `results/database/s11a` and there should be an `.rds` file to download and upload to the [database](https://biostats-shinyr.kumc.edu/16SguildDB/).

### What if I want to change some of the default parameters in the params file?

You can change the default options in the `params.yml` file if you write them in.
