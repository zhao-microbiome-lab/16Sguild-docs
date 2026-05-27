<h1 align = "center">
  <img src="../assets/16Sguild_long.png" alt="16SguildLogo" width="300">
</h1>

<h1 align="center" style="margin-bottom:0;">
  <strong><code>16Sguild</code> : Basic Workflow</strong>
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

<p align="center" style="font-size:18px;">
 <strong>
    An initial, simple workflow for guild-based analysis of 16S-rRNA sequencing data based on  
    <a href="https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-021-00840-y" target="_blank">Wu and Zhao et al., 2021</a>.
 </strong>
</p>

---

<h2 align="center"> Introduction </h2>

??? info "Information block"
    These blocks contain general information about pipeline use. They may include suggestions or information about what is happening within a step.

??? nextflow "Nextflow block"
    These blocks contain information about the use of Nextflow to build this pipeline.

??? param "Parameters block"
    These blocks contain information about the parameters that will be included in the `params.yml` input for the pipeline.

In this vignette, we walk through how to run the pipeline step by step. Users can follow along by running the code chunks alongside this demonstration. The example dataset is a random subset of samples taken from a study by <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC7858243" target="_blank">Tsay et al., 2021</a> completed at New York University (NYU) <a href="https://www.ebi.ac.uk/ena/browser/view/PRJNA592147" target="_blank">(ENA Project: PRJNA592147)</a> <a href="https://github.com/segalmicrobiomelab/lung_cancer_prognosis_microbiome" target="_blank">(GitHub)</a>. The subset consists of 50 random samples taken from lung cancer patients, collected by an airway brush. These samples have been subset down by approximately half of the number of reads to 25,000. These samples will be referred to as NYU from here on out.

??? info "Background"

    The human microbiome is composed of trillions of microorganisms, including bacteria, archaea, viruses, and fungi. Understanding the composition and diversity of these communities is critical for studying their role in health and disease. One of the most widely used methods for profiling bacterial communities is targeted DNA squencing of the 16S rRNA gene.

    When analyzing this data, the sequences are corrected for sequencing errors using tools such as DADA2 (Calahan et al., 2016). These unique DNA sequences are known as amplicon sequence variant (ASV). ASVs are a unique DNA sequence of the target region (e.g., V4) that is distinguished from all others by even a single nucleotide. These ASVs provide higher resolution, reproducibility across studies, and the ability to detect fine-scale differences in microbial communities when compared to conventional taxonomic approaches, where multiple ASVs are classified as one taxa. For example, conventional approaches may group ASVs at the species level. However, bacteria in the same species can have up to 5% difference in their strains. These differences may correspond to meaningful behavior differences that could be lost in the heterogeneity of the species classification.

    We have created a novel method at looking at the microbiome as an ecosystem of these high resolution ASV units that interacts with each other in correlated ways based on function. These interacting modules of genomes or ASVs are called **guilds**: ecologically coherent groups that respond together to environmental inputs, perform complementary metabolic functions, and compete or cooperate as groups. We have developed a genome-specific and guild-based analysis pipeline to uncover biologically meaningful patterns that better reflect the modular structure of the microbiome.

    In this pipeline, individual microbial entities—ASVs—are identified and tagged with a universal unique identifier (UUID) for precise tracking. This approach is database-independent, avoiding limitations of incomplete or biased reference databases. Rather, the UUIDs are stored in a [database](https://biostats-dashboard.kumc.edu/16SguildDB/) with their unique, unchanging ASV sequence. Building on this foundation, we analyze interactions among microbial entities to reveal ecological relationships between these ASVs. These ASVs are clustered into co-abundance groups based on co-abundance behavior. These co-abundance groups may represent guilds, where members share ecological niches and exhibit similar abundance patterns across samples or conditions. This process allows us to identify guild-level functions, highlighting complex microbial behaviors and interactions. The collective dynamics of guilds reveal the emergent properties of the microbiome, which integrate into systems-level functions that influence host physiology and health.

??? nextflow "About Nextflow"
  
    The 16sguild pipeline has been built using <a href="https://www.nextflow.io/docs/latest/overview.html#why-nextflow" target="_blank">Nextflow</a>. Nextflow is a language that allows users to chain different processes together. These processes can be in different programming languages that run on Linux. The goal is to take complicated processes and combine them into a streamlined package with easy to execute command lines. This pipeline currently uses R, Bash, and Groovy.<br><br>

    One massively useful feature of Nextflow is the <code>-resume</code> flag. The allows users to resume the pipeline, picking up where it left off by caching, without re-running everything up to that point.

    Another useful feature is that Nextflow can run steps in parallel. This means it can divide samples, process them on different CPUs, and them bring them together at the end before continuing to the next step. This means that Nextflow can run faster than using just one CPU alone, without requiring the user to write their own parallel code.

    Nextflow also allows for the pipeline to be run using containers. These containers hold an image of the process and it runs through this container, ensuring reproducibility on all operating systems.

<h2 align="center"> 🛠️ Installation </h2>
To install <code>16Sguild</code>, users can directly call the pipeline using nextflow from the GitHub, like so:

```bash
nextflow run zhao-microbiome-lab/16Sguild/main.nf -params-file examples/params.yml -profile test
```
Or, users can choose to download and run from the source file, like this:

```bash
git clone https://github.com/zhao-microbiome-lab/16Sguild.git
cd 16Sguild
nextflow run main.nf -params-file examples/params.yml -profile test
```
Please keep in mind that the <code>-profile test</code> is only to run the NYU example data.

For HPC users, you will need to specify the workload manager under the <code>-profile</code> as well. For example: <code>-profile slurm,test</code>

<h2 align="center"> Example Data </h2>
Download Required Example Data Files
<br> </br>

[![Download](https://img.shields.io/badge/Download-NYU_example_samples-840024)](https://biostats-shinyr.kumc.edu/16SguildDB_ExampleData/NYU_Example_FASTQ_Files.zip)

[![Download](https://img.shields.io/badge/Download-manifest_example-840024)](test/manifest.csv)

[![Download](https://img.shields.io/badge/Download-metadata_example-840024)](test/metadata.txt)




<h2 align="center"> Input Files </h2>
Users are required to have certain input files to run the 16Sguild pipeline. These include: 
<ul>
  <li>Manifest</li>
  <li>Metadata</li>
  <li>Parameters</li>
</ul>

<h3 align="center"> Manifest </h3>
First, users set up their manifest file. This file contains the sample-id, absolute file path, and direction. 


??? info "Manifest"

    The manifest represents two paired-end samples in FASTQ format, each consisting of forward and reverse reads, organized according to QIIME2's manifest specification: [`qiime tools import`](https://docs.qiime2.org/2024.10/tutorials/importing/).

    Below is an example of what the file would look like for 2 samples:

    **`input/manifest.csv`**

    ```
    sample-id,absolute-filepath,direction
    Sample1,/files/Sample1_1.fastq,forward
    Sample1,/files/Sample1_2.fastq,reverse
    Sample2,/files/Sample2_1.fastq,forward
    Sample2,/files/Sample2_2.fastq,reverse
    ```

    | sample-id | absolute-filepath      | direction |
    |-----------|------------------------|-----------|
    | Sample1   | /files/Sample1_1.fastq | forward   |
    | Sample1   | /files/Sample1_2.fastq | reverse   |
    | Sample2   | /files/Sample2_1.fastq | forward   |
    | Sample2   | /files/Sample2_2.fastq | reverse   |

<h3 align="center"> Metadata </h3>
Users now set up their metadata file. This contains additional information about the samples, such as cancer status, cohort, age, sex, etc. <code>16Sguild</code> requires the first column header to be sample-id and the other columns can be named as desired.  


??? info "Metadata"

    The `metadata` is a text file which identifies associated metadata with the sample-id as coded in the `input/manifest.csv` document. Unlike the `manifest.csv`, the `metadata` can only have unique samples listed (no duplicates).

    Here is an example of what this file may look like for 2 samples:

    **`input/metadata.txt`**

    | sample-id | cohort | cancer status | sex |
    |-----------|--------|---------------|-----|
    | Sample 1  | 2024   | Active cancer | F   |
    | Sample 2  | 2024   | Benign tumor  | M   |
  
<h3 align="center"> 🎛️ Parameters </h3>

The parameters file contains project-specific information that is required to run the pipeline. Here are the initial set of parameter requirements for intial run: 

```groovy
  samplesheet: "manifest.csv"
  metadata: "metadata.txt"
  base_name: "16sguild_Example"
  input_type: "SampleData[PairedEndSequencesWithQuality]"
  input_format: "PairedEndFastqManifestPhred33"
  trim_forward: "GTGCCAGCMGCCGCGGTAA"
  trim_reverse: "GGACTACHVGGGTWTCTAAT"
```
In order to use <code>16Sguild</code>, users need to create a project-specific parameters file, usually named <code>params.yml</code>. This file will provide the information needed to run the pipeline. Detailed definitions for each of the parameters are included under the parameters tab.

??? param "samplesheet"

    The `samplesheet` points to the `manifest` CSV file. This manifest file is in the format expected for the [`qiime tools import`](https://docs.qiime2.org/2024.10/tutorials/importing/) function.

??? param "metadata"

    The `metadata` is a text file which identifies associated metadata with the sample-id as coded in the `input/manifest.csv` document. Unlike the `manifest.csv`, the `metadata` can only have unique samples listed (no duplicates).

??? param "base_name"

    The `base_name` identifies the project name and will be added to the output files. The default is `16Sguild`.

??? param "input_type"

    The `input_type` refers to the type of sequencing performed: single-end or paired-end. QIIME2 requires the sequencing be identified as “SampleData[SequencesWithQuality]” for single-end or “SampleData[PairedEndSequencesWithQuality]” for paired-end. **At this time, the 16Sguild pipeline only accepts paired-end sequencing.**

??? param "input_format"

    The `input_format` refers to the type of fastq manifest file. Common types include:

    - “PairedEndFastqManifestPhred33”
    - “PairedEndFastqManifestPhred64”
    - “CasavaOneEightSingleLanePerSampleDirFmt”

    More information can be found on the [QIIME tutorial website](https://docs.qiime2.org/2024.10/tutorials/importing/) under the “Fastq Manifest” formats section.

??? param "trim_forward / trim_reverse"

    Both `trim_forward` and `trim_reverse` refer to the primers used during PCR amplification. These primers are designed to target the bacterial 16S rRNA gene and bind to the DNA, directing amplification to the region of interest. Before we can start looking at our sequences, we must remove the primers because they are not an actual part of the original sequence.

    **Common Primers**

    | Region | Position and Direction | Common Primers |
    |--------|------------------------|----------------|
    | V4     | 515F <br /> 806R       | GTGYCAGCMGCCGCGGTAA <br /> GGACTACHVGGGTWTCTAAT |
    | V3-V4  | 341F <br /> 805R       | CCTACGGGNGGCWGCAG <br /> GACTACHVGGGTATCTAATCC |
    | V4-V5  | 515F <br /> 926R       | GTGYCAGCMGCCGCGGTAA <br /> CCGYCAATTWMTTTRAGTTT |


<h2 align="center"> Correlation </h2>
The pipeline is defaulted to run multiple samples from one timepoint using SparCC implemented through FastSpar <a href="https://academic.oup.com/bioinformatics/article/35/6/1064/5086389?login=false" target="_blank">(Watts et al., 2018)</a>. The pipeline can also run repeated measures correlation samples using rmcorr <a href="https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2017.00456/full" target="_blank">(Bakdash and Marusich, 2017)</a>. To run correlated samples, the user must set <code>s19_rmcorr</code> to <code>true</code>. The <code>metadata</code> file must also include a <code>subject_column</code> parameter to indicate the string name of the column that defines the samples from the same subject (default is <code>subject_id</code>). If the parameter column is <code>subject_id</code> it can be left out of the parameters, otherwise the column name must be specified (for example, <code>subject_column: "subject"</code>).
<br></br>

Here is an example <code>params.yml</code> file with the correlation:
```groovy
  s19_rmcorr: true

  samplesheet: "manifest.csv"
  metadata: "metadata.txt"
  base_name: "16sguild_Example"
  input_type: "SampleData[PairedEndSequencesWithQuality]"
  input_format: "PairedEndFastqManifestPhred33"
  trim_forward: "GTGCCAGCMGCCGCGGTAA"
  trim_reverse: "GGACTACHVGGGTWTCTAAT"
  subject_column: "subject"
```
Please note that the NYU example data is not correlated.


<h2 align="center"> Parts </h2>
The pipeline has set parts. The pipeline will run automatically through a part and stop itself once it reaches the end of the part. At the end of the part, users will need to examine their data and update their parameter file accordingly to continue with their analysis. 
<br>
<p align="center">
  <img alt="Workflow" src="../assets/16Sguild_metroMap.png" width="1000">
</p>
<p align="center">
  <em>Basic workflow overview of 16Sguild pipeline.</em>
</p>

<h3 align="center"> Part 1 </h3>
Part 1 is involved with importing the FASTQ files, trimming the primer sequences, and QCing the samples. 
At the end of Part 1, the pipeline will automatically stop and say "**Pipeline Paused: End of Part 1***". Here is what the log file will display:
[insert pic of log]
<br>
Users will need to select trimming lengths for truncation and the maximum value for filtering unreliable sequences. 

Firstly, users should navigate to the results folder of the pipeline and under the visualization output, there is a input_trimmed.qzv file. This file needs to be downloaded and viewed using the <a href="https://view.qiime2.org/">QIIME2 Viewer</a>. Users should navigate to the second tab “Interactive Quality Plot” and examine the quality plots. Here is what the users should see: 
<br>

<img src="../assets/quality_plot.png" alt=qzv quality plots>


Zooming in on the graphs shows that the quality scores stay above 30 until the end of the reads. Therefore, the sequences do not need to be truncated for our example data. Users will now add to their parameters files to reflect this: 

```bash
  samplesheet: "manifest.csv"
  metadata: "metadata.txt"
  base_name: "16sguild_Example"
  input_type: "SampleData[PairedEndSequencesWithQuality]"
  input_format: "PairedEndFastqManifestPhred33"
  trim_forward: "GTGCCAGCMGCCGCGGTAA"
  trim_reverse: "GGACTACHVGGGTWTCTAAT"

  # End of Part 1
  trunc_forward: "0"
  trunc_reverse: "0"
```

<p>Secondly, users need to select the maximum value for filtering unreliable sequences. The file can be found and downloaded from results &rarr; visualization &rarr; s7_input.qzv. Load the .qzv file into the <a href="https://view.qiime2.org/">QIIME2 Viewer</a>. The maximum is suggested to be set to median frequency, rounded up or down to the nearest hundred. Now update the params file with that value:</p>

```bash
  samplesheet: "manifest.csv"
  metadata: "metadata.txt"
  base_name: "16sguild_Example"
  input_type: "SampleData[PairedEndSequencesWithQuality]"
  input_format: "PairedEndFastqManifestPhred33"
  trim_forward: "GTGCCAGCMGCCGCGGTAA"
  trim_reverse: "GGACTACHVGGGTWTCTAAT"

# End of Part 1
  trunc_forward: "0"
  trunc_reverse: "0"
  max: “23700” 
```
  <p>
    The user can now resume the pipeline by uncommenting the resume flag in their bin/bash file:
  </p>
  <pre><code>nextflow run zhao-microbiome-lab/16Sguild/main.nf -params-file examples/params.yml -profile test -resume</code></pre>
  
??? nextflow "Nextflow resuming and caching"

    For more information about the Nextflow resuming and caching capability, users can refer to the
    [Nextflow caching and resume documentation](https://www.nextflow.io/docs/latest/cache-and-resume.html).

??? param "trunc_forward / trunc_reverse"

    As a general rule, a good quality read is considered greater than 30 (the y-axis Quality Score). Look for where the median begins to drop below 25 and this is where you want to trim. However, keep in mind that a pair end sequence needs to overlap by ~ 20-30 base pairs. To calculate the overlapping base pairs, use this equation:

    $$\text{Sequence Forward Cut Off} + \text{Sequence Reverse Cut Off} - \text{Amplicon Size} = \text{Number of Overlapping Base Pairs}$$

    The amplicon size depends on the region and is given below:

    - V4: 291
    - V4-V5: 363
    - V3-V4: 464

??? param "max / min"

    Users will primarily be interested in changing the maximum value for filtering unreliable sequences. The minimum value is defaulted to 100 and can be changed if necessary. Users simply designate the maximum in the params.yml file by adding max:

    ```bash
    # End of Part 1
    max:
    min: # optional, default 100
    ```

<h3 align="center"> Part 2 </h3>
<p>Part 2 is involved with denoising and quality filtering. It also generates a table of the ASVs contained in the sample. 

During Part 2, users take the table of ASVs, which is a RDS file found in results &rarr; main_results &rarr; s11a_database &rarr; input_bundle.rds. Download this file and upload it to the database website: 
  
  <p align="center">
    <a href="https://biostats-dashboard.kumc.edu/16SguildDB/">
      <img src="../assets/16SguildDatabaseButton.PNG" alt="16S Guild Database" width="150"/>
    </a> 
  </p>

Users need to fill out the database questionnaire with clear contact details, while being as specific as possible. Selecting the sequencing platform and 16S rRNA region are also required. Acknowledge that you understand contributing to the database and then run the filtering and download the linkage table. For the NYU example dataset, simply click the box saying it is the example dataset and fill out your contact details. The database will generate a linkage table to assign UUIDs to the ASVs. This now is the End of Part 2. Put the linkage table in your run folder and update the params.yml file with its absolute file path:</p>

```bash
  samplesheet: "manifest.csv"
  metadata: "metadata.txt"
  base_name: "16sguild_Example"
  input_type: "SampleData[PairedEndSequencesWithQuality]"
  input_format: "PairedEndFastqManifestPhred33"
  trim_forward: "GTGCCAGCMGCCGCGGTAA"
  trim_reverse: "GGACTACHVGGGTWTCTAAT"

# End of Part 1
  trunc_forward: "0"
  trunc_reverse: "0"
  max: "23700"

# End of Part 2
  linkage_table: /input/ASV_linkage_table_date.txt 
```
Resume the pipeline.

<h3 align="center"> Part 3 </h3>
<p>Part 3 is involved with generating phylogenetic trees to run alpha rarefaction. 
At the end of Part 3, users need to select the sampling depth value for alpha rarefaction. This graph can be found in the results &rarr; visualization &rarr; s14_alphaRarefaction &rarr; s14_input_alpha-rarefaction.qzv. Load this file into the <a href="https://view.qiime2.org/">QIIME2 Viewer</a> and use the observed_features metric. Observe the graph and identify where the curves begin to flatten for each sample ID. Here is an example of the graph:</p>

<img src="../assets/alpha_rarefaction_curve.png" alt=alpha rarefaction curve qzv>

Users can see for this example NYU data that they flatten out around 20,000. Enter this value in the params file and resume the pipeline. 
```groovy
  samplesheet: "manifest.csv"
  metadata: "metadata.txt"
  base_name: "16sguild_Example"
  input_type: "SampleData[PairedEndSequencesWithQuality]"
  input_format: "PairedEndFastqManifestPhred33"
  trim_forward: "GTGCCAGCMGCCGCGGTAA"
  trim_reverse: "GGACTACHVGGGTWTCTAAT"

# End of Part 1
  trunc_forward: "0"
  trunc_reverse: "0"
  max: “23700”

# End of Part 2
  linkage_table: /input/ASV_linkage_table_date.txt

# End of Part 3
  sampling_depth: "20000"
```
Resume the pipeline.

??? info "Alpha rarefaction"

    When microbial communities are sequenced, each sample yields a different number of reads. Some samples may have hundreds of thousands of reads, while others have only a few thousand. Because diversity measures are sensitive to sequencing depth, we need a way to compare samples fairly.

    This is where rarefaction comes in. Rarefaction is the process of subsampling reads from each sample down to a common depth, so that all samples are evaluated as if they had the same number of reads. This prevents samples with more sequences from artificially appearing more diverse simply because they were sequenced more deeply.

    An alpha rarefaction curve plots the number of observed features (ASVs, OTUs, or species-level groups) against different sequencing depths. As you sample more reads, you discover many new taxa. But eventually, the curve plateaus, meaning that most of the diversity present in the sample has been captured and sequencing deeper would yield little additional information.

    In QIIME2, alpha rarefaction curves help us decide on the `sampling_depth` to use when rarefying for diversity analyses:

    - If the curve for most samples plateaus well before the chosen depth, that depth is sufficient.
    - If many samples’ curves are still climbing sharply at that depth, it means additional sequencing might have been needed, and choosing too high a depth may exclude samples with fewer reads.
    - The goal is to choose a depth where the majority of samples have reached a plateau while retaining as many samples as possible.

<h3 align="center"> Part 4 </h3>
Part 4 is involved with running diversity analysis, optional correlation analysis, and forming the guilds found in the samples. It also plots the individual guilds and the top 5 most prevelant guilds, called co-abundant groups (CAGs). 
At the end of Part 4, go look at your results in the results folder. More information can be found on the results in the <a href="output.md" style="margin-left: 15px;">output</a> section.

<h2>References</h2>
Callahan BJ, McMurdie PJ, Rosen MJ, Han AW, Johnson AJ, Holmes SP. DADA2: High-resolution sample inference from Illumina amplicon data. Nat Methods. 2016 Jul;13(7):581-3. doi: 10.1038/nmeth.3869. Epub 2016 May 23. PMID: 27214047; PMCID: PMC4927377.

---
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

