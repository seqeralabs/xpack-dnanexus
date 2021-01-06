# xpack-dnanexus

DNAnexus extension package for Nextflow

## Get started 

NOTE: the following examples requires a pre-build app named `nf-dxapp`. The final release
uses will be able to package their own version. 

Declare in your environment the following variable with your NF-XPACK for DNAnexus license key: 

    export NXF_XPACK_LICENSE=<license content>


### Launching classic NF Hello world app 


  dx run nf-dxapp \
    --watch \
    --delay-workspace-destruction \
    --input-json "$(envsubst < examples/hello.json)"

The above snippet runs the Nextflow [hello](https://github.com/nextflow-io/hello) pipeline.

  
### Launching simple RNAseq pipeline using container execution 

    dx run nf-dxapp \
        --watch \
        --delay-workspace-destruction \
        --input-json "$(envsubst < examples/simple-rnaseq.json)"
    
The above snippet the rnaseq-nf pipeline at [this link](https://github.com/pditommaso/rnaseq-nf).

The `args` input field is used to specify the Nextflow command line options `-profile` selecting 
enabling the use of Docker container and the [`dx-profile`](https://github.com/pditommaso/rnaseq-nf/blob/master/nextflow.config#L66-L70) 
which specifies as input some (minimal) dataset hosted in a DNAnexus project.

### Launching nf-core RNAseq pipeline 

    dx run nf-dxapp \
        --watch \
        --delay-workspace-destruction \
        --instance-type mem3_ssd3_x12 \
        --input-json "$(envsubst < examples/nfcore-rnaseq.json)"

### Resume pipeline execution

To resume a pipeline execution you will need to provide the run *work directory* and the *resume Id*.
You can find this information in the pipeline output, for example: 

    2021-01-06 17:15:34 Nextflow STDOUT =============================================================
    2021-01-06 17:22:00 Nextflow STDOUT === NF work-dir container-Fzpy7200kPbf59Z54ZYBkkxp:/scratch/
    2021-01-06 17:22:00 Nextflow STDOUT === NF Resume ID 01cb129f-a894-4e5d-8a67-8bbcb989ff18
    2021-01-06 17:15:34 Nextflow STDOUT =============================================================

Include this information in the json input file or as option in the launch command line as specified in the 
following example:

    dx run nf-dxapp \
        --watch \
        --delay-workspace-destruction \
        --input-json "$(envsubst < examples/hello.json)" \
        -iwork_dir=container-Fzpy2Z00kKBBGzjy4ZQ8jy8g:/scratch/ \
        -iresume_id=c2ce3c83-8433-4cac-b29c-5165478dcfda



## Copyright 

Seqera Labs, all right reserved.  
