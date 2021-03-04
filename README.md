# XPACK-DNANEXUS

DNAnexus extension package for Nextflow (XPACK-DNANEXUS)

## Introduction 

The DNAnexus extension package is a plugin provided by [Seqera Labs](https://www.seqera.io/) that enables the deployment of 
[Nextflow](https://www.nextflow.io/) pipelines on the [DNAnexus](https://www.dnanexus.com/) cloud platform. 

The plugin requires a license key to be used. If you are interested, please contact us for an evaluation 
license at [sales@seqera.io](maiilto:sales@seqera.io).

NOTE: The plugin is still in beta version and some Nextflow functionalities are limited. See below for the known 
problems and limitations.  

## Requirements 

* DNAnexus command line tools aka dx-toolkit. See [here](https://documentation.dnanexus.com/getting-started/tutorials/cli-quickstart) 
for details.
* Nextflow runtime version 21.02.0-edge or later. 
* Valid license for DNAnexus extension package for Nextflow.  
* [Make](https://www.gnu.org/software/make) tool (only for the project bundling). 

## Get started 

In order to deploy the execution of a Nextflow pipeline in DNAnexus you will need to create 
a DNAnexus applet bundling the Nextflow runtime along the DNAnexus extension plugin and, optionally, 
the pipeline scripts.

In alternative to bundling the pipeline in the DNAnexus applet, it can be pulled from a Git repository 
as is usually done by Nextflow. 

The `Makefile` included in this repository automates the creation of the DNAnexus applet for Nextflow 
using the following steps: 

#### 0. Login in your DNAnexus workspace 

```
dx login
```

#### 1. Clone this repository in your computer using the following command

``` 
git clone https://github.com/seqeralabs/xpack-dnanexus
cd xpack-dnanexus
```              

#### 2. Create the DNAnexus bundle including the Nextflow runtime 

```
make dx-pack
```

The above command creates the bundle skeleton in the directory `build/nf-dxapp`.  

#### 3. Modify the app metadata 

DNAnexus app requires a file named `dxapp.json` to configure the application deployment 
and parameters. 

A predefined app metadata file with the settings required for the Nextflow execution 
is available in this repository at the path [app/dxapp.json]. Modify it according your 
requirements. 

See the [DNAnexus documentation](
https://documentation.dnanexus.com/developer/apps/app-metadata) for further details.


#### 4. Build the DNAnexus applet

``` 
make dx-build
```

The above command build the DNAnexus applet for Nextflow with the name `nf-dxapp` ready to be executed. 

#### 5. Example runs

You can find below some examples to deploy the execution of Nextflow with the applet build from the 
above guide. 

Declare the following environment variable with your XPACK-DNANEXUS license. 

``` 
export NXF_XPACK_LICENSE=<YOUR LICENSE CONTENT>
```
 


##### Launching classic NF Hello world app 

    dx run nf-dxapp \
      --watch \
      --input-json "$(envsubst < examples/hello.json)"

The above snippet runs the Nextflow [hello](https://github.com/nextflow-io/hello) pipeline.

The Nextflow log file will be uploaded in your DNAnexus project root. You can access with the following 
command:

```
dx cat nextflow.log
```
  
##### Launching simple RNAseq pipeline using container execution 

    dx run nf-dxapp \
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


##### Launching nf-core RNAseq pipeline 

    dx run nf-dxapp \
        --watch \
        --delay-workspace-destruction \
        --instance-type mem3_ssd3_x12 \
        --input-json "$(envsubst < examples/nfcore-rnaseq.json)"

The above example launch shows how to run the exection of the [nf-core/rnaseq](https://github.com/nf-core/rnaseq) pipeline using the `test` profile  

## Latest changes  

- As of version `1.0.0-beta.2` directives [cpus](https://www.nextflow.io/docs/latest/process.html#cpus), [memory](https://www.nextflow.io/docs/latest/process.html#memory), [disk](https://www.nextflow.io/docs/latest/process.html#disk) and [accelerator](https://www.nextflow.io/docs/latest/process.html#accelerator)
  are supported. When specified Nextflow look up for a machine type able to 
  satisfy the requested resources. The `machineType` directive has in any case 
  precedence, when specified any `cpus`, `memory`, `disk` and `accelerator`
  is ignored. 

## Known problems and limitations

* Nextflow resume functionality is still not working properly.
* When the pipeline execution terminates abruptly the Nextflow log file is not uploaded the target project storage.
* Some [Biocontainers](https://biocontainers.pro/) may not work properly.  

## Copyright 

Seqera Labs, All rights reserved.  
