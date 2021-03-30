# Nextflow for DNAnexus Platform

## What is Nextflow?

Nextflow is a workflow manager that enables scalable and reproducible scientific workflows using software containers.
Learn more at https://nextflow.io

## What does this app do?

This app allows you to deploy Nextflow pipelines on the DNAnexus cloud.

## What are the input files?

You need to provide the URL of Git repository where a Nextflow pipeline project is stored 
and any input data as expected by the chosen pipeline project. 

## What are the output files?

This depends on the pipeline project executed. 

### Input parameters

* pipeline_url: The URL of the Git repository of the pipeline to the executed
* work_dir: The pipeline work directory. It has to be a DNAnexus storage path e.g. dx://PROJECT-0123456789:/some/work/dir (optional)
* resume_id: The unique ID of the Nextflow execution to be resumes (optional)
* log_file: The name of the Nextflow log file (optional)
* opts: Nextflow runtime top options (optional)
* args: Nextflow run options and pipeline parameters (optional)
* license: Your activation license string
  
