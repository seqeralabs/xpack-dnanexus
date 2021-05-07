# Nextflow for DNAnexus Platform

## What is Nextflow?

Nextflow is a workflow manager that enables scalable and reproducible scientific workflows using software containers.
Learn more at [https://nextflow.io](https://nextflow.io).

## What does this app do?

This app allows the deployment of Nextflow pipelines on the DNAnexus cloud, taking advantage of 
native integration with the platform, and allowing users to manage their data analyses collaboratively 
within the familiar DNAnexus environment.

## What are the input files?

You need to provide the URL of the Git repository where a Nextflow pipeline project is stored 
and any input data as expected by the chosen pipeline project.

Nextflow pipelines can access files stored in DNAnexus projects prefixing the file paths with 
corresponding project ID, e.g. `dx://PROJECT-0123456789:/some/data/file.bam`.

## What are the output files?

The Nextflow app allows you to run new or existing Nextflow pipelines in the DNAnexus cloud. 
The app output files depends on the pipeline you run.

If the pipeline allows the definition of one or more output file paths, prefix them with the 
DNAnexus project ID where the output is expected to be stored e.g. `dx://PROJECT-0123456789:/some/output`.     

### Input parameters

* pipeline_url: The URL of the Git repository of the pipeline to the executed
* args: Nextflow run options and pipeline parameters (optional)
* scm_file: Git repository credentials file (optional)
* license: Your activation license string
* debug: Enable launcher script debugging mode (optional)
