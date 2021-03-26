# Nextflow App for DNAnexus 

This application allows the deployment of Nextflow 
pipelines on DNAnexus cloud platform. 

The app uses an extension plugin for the [Nextflow](https://www.nextflow.io/) 
runtime implementing the support DNAnexus cloud platform which requires 
an activation license.  

Please contact [Seqera Labs](https://www.seqera.io/) for an evaluation license 
at [sales@seqera.io](maiilto:sales@seqera.io) or for more information.


### Input parameters

* pipeline_url: The URL of the Git repository of the pipeline to the executed
* work_dir: The pipeline work directory. It has to be a DNAnexus storage path e.g. dx://PROJECT-0123456789:/some/work/dir (optional)
* resume_id: The unique ID of the Nextflow execution to be resumes (optional)
* log_file: The name of the Nextflow log file (optional)
* opts: Nextflow runtime top options (optional)
* args: Nextflow run options and pipeline parameters (optional)
* license: Your activation license string
  
