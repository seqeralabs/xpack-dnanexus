---
title: Launch your first pipeline
headline: 'Launching your first Nextflow pipeline on DNAnexus'
description: 'Instructions for launching a Nextflow pipeline on DNAnexus'
---

You can find below some examples to deploy the execution of Nextflow with the applet built from the app bundling guide. 

Declare the following environment variable with your `XPACK-DNANEXUS` license. 

``` 
export NXF_XPACK_LICENSE=<YOUR LICENSE CONTENT>
```


## Launching classic NF Hello world app 

    dx run nextflow-app \
      --watch \
      --input-json "$(envsubst < examples/hello.json)"

The above snippet runs the Nextflow [hello](https://github.com/nextflow-io/hello) pipeline.

The Nextflow log file will be uploaded in your DNAnexus project root. You can access with the following 
command:

```
dx cat nextflow.log
```
  
## Launching simple RNAseq pipeline using container execution 

    dx run nextflow-app \
        --watch \
        --input-json "$(envsubst < examples/simple-rnaseq.json)"
    
The above snippet the rnaseq-nf pipeline at [this link](https://github.com/nextflow-io/rnaseq-nf).

The `args` input field is used to specify the Nextflow command line option `-profile` that selects the `docker` profile enabling the use of Docker container.

Note pipeline results are stored in the local `results` directory in the VM running the Nextflow app. 

To save the result in the DNAnexus project storage, add to the `args` attribute in the [examples/simple-rnaseq.json](examples/simple-rnaseq.json) file, the option `--outdir dx://<YOUR PROJECT ID>:/some/output/dir`, replacing the placeholder `<YOUR PROJECT ID>` with the project id that can be found using this oneliner:

```
dx env | grep project | cut -f 2
```

NOTE: The `dx://` pseudo-protocol is used by Nextflow to identify file paths 
in the DNAnexus storage. 


## Launching nf-core RNAseq pipeline 

    dx run nextflow-app \
        --watch \
        --delay-workspace-destruction \
        --instance-type mem3_ssd3_x12 \
        --input-json "$(envsubst < examples/nfcore-rnaseq.json)"

The above example launch shows how to run the exection of the [nf-core/rnaseq](https://github.com/nf-core/rnaseq) pipeline using the `test` profile  
