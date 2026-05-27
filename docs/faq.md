<h1 align="center" style="margin-bottom:0;">
    <img src="../assets/16Sguild_long.png" alt="16S Guild Logo" width="300"/>
</h1>

<h1 align="center" style="margin-bottom:0;">
  <strong><code>16Sguild</code> : Frequently Asked Questions</strong>
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
    FAQs for guild-based analysis of 16S-rRNA sequencing data based on  
    <a href="https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-021-00840-y" target="_blank">Wu and Zhao et al., 2021</a>.
  </strong>
</p>

---

<h2 align="center"> ❓ Frequently Asked Questions </h2>

<h3> How can I submit a question, request a fix, or suggest an improvement to 16Sguild? </h3>

Thank you for asking! As scientists, we value collaboration, and look forward to hearing from you. We request that all these notes be submitted to the [GitHub Issues](https://github.com/zhao-microbiome-lab/16Sguild/issues) page, which the team will monitor and respond to regularly.

<h3> What about metagenomic samples? </h3>

Great question! We are looking to implement a guild-based pipeline for analysis of metagenomic data. Keep an eye out for the release of this new pipeline, <code>metaguild</code>.

<h3> Is there a specific way I should format my metadata file? </h3>

Good question! The metadata file should be in a `.tsv` file format. Ensure that each sample only appears once in the list (i.e. if the you have paired-end sequencing data, remove one of the replicate names). If the first column in your metadata file is the sample names, then you might want to duplicate the names into a second column for visualization purposes because QIIME2 ignores the first column. Finally, ensure that the metadata file is in the same folder with the raw data and that the path is correct in your parameter file.

<h3> Where can I find my sample output once the pipeline is at the end of a part? </h3>

Typically, all output files are in the `results/visualization` folder. After the first stop, the file should say `s3_<base_name>_trimmed.qzv`. At stop 2, the file should say `s5_<base_name>_table.qzv`. After stop 3, the file should be under `/s14_alphaRarefaction/s14_...<base_name>_alpha-rarefaction.qzv`. All of these files can be downloaded and then visualized on the [QIIME2 Visualization platform](https://view.qiime2.org/). To find the linkage table, go to `results/database/s11a` and there should be an `.rds` file to download and uploaded to the [database](https://biostats-shinyr.kumc.edu/16SguildDB/).

<h3> What if I want to change some of the default parameters in the params file? </h3>

You can change the default options in the `params.yml` file if you write them in. 

---

<p align="center">
  <a href="../"><code>Home</code></a>
  <a href="../basic-workflow/"><code>Basic Workflow</code></a>
  <a href="../parameters/"><code>Parameters</code></a>
  <a href="../output/"><code>Output</code></a>
  <a href="../changelog/"><code>Change Log</code></a>
  <a href="../faq/"><code>FAQ</code></a>
</p>

<p align="center">
  <img width="200" height="200" alt="16Sguild badge" src="../assets/16Sguild.png" />
</p>
