# Nextflow app for DNAnexus 

## Get started 

The Nextflow app is avaiable in the DNAnexus Tools library. To get started with: 

1. Sign-in the [DNAnexus](http://dnanexus.com/) platform 
2. Navigate to the Nextflow app available at [this link](https://platform.dnanexus.com/app/nextflow-dx).
3. Click on *Install* buttom to make it available in your workspace
 
Note: The use of this app requires an activation licenses provided by Seqera Labs. If you 
don't have it already please contact us at [sales@seqera.io](maiilto:sales@seqera.io) for obtaining
an evaluation license free of charge.

## Launch your first Nextflow pipeline

The Nextflow app allow you running existing Nextflow pipelines natively  
in the DNAnexus platform i.e. scaling jobs and reading/writing data stored in the DNAnexus storage. 

Run your first pipeline following these steps: 

1. Save the Nextflow app activation license into a project workspace e.g. `project-12345:/nf-license.txt`.
2. Click the **Run** button in the [Nextflow app page](https://platform.dnanexus.com/app/nextflow-dx).
3. Select the project where the app is expected to be run. 
4. In the **Analysis settings** page specify the **Execution name** of your choice (and other optional settings)
5. Click in the *Analysis inputs 1* page and specify the following fields: 
    - **Pipeline URL**: This is the URL Nextflow pipeline to be executed. Enter the value `https://github.com/nextflow-io/rnaseq-nf`. 
    - **Nextflow run arguments & pipeline parameters**: This field allows you to specify Nextflow command line options. Enter the value `-profile docker` to enable pipeline profile for Docker execution. 
    - **Activation license**: the path of your license file previously stored in the DNAnexus storage e.g. `dx://project-12345:/nf-license.txt`. NOTE, path should start with the `dx://` prefix. 

## Use the command line to run Nextflow for DNAnexus 

The command line tool allow the automation of recurrent pipeline execution. 

Follow these steps to run a simple the example Nextflow pipeline :

* Install the DNAnexus command line tools aka dx-toolkit. See [here](https://documentation.dnanexus.com/getting-started/tutorials/cli-quickstart) for details.
* Save the following JSON snippet into a file named `settings.json` (replacing the license path with your own)

      {
        "pipeline_url": "https://github.com/nextflow-io/rnaseq-nf",
        "args": "-profile docker ",
        "license": "dx://project-12345:/nf-license.txt"
      }

* Launch the pipeline execution using the command:

      dx run nextflow-dx \
            --watch \
            --input-json "$(envsubst < settings.json)"