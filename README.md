# XPACK-DNANEXUS

DNAnexus extension package for Nextflow (XPACK-DNANEXUS)

## Introduction 

DNAnexus extension package is a plugin provided by [Seqera Labs](https://www.seqera.io/) that allows the deployment of 
[Nextflow](https://www.nextflow.io/) pipeline on [DNAnexus](https://www.dnanexus.com/) cloud platform. 

The plugin requires a license key to be uses. If you are interested in it please contact us for an evaluation 
license at [sales@seqera.io](maiilto:sales@seqera.io).

NOTE: this plugin is still in beta version, some Nextflow functionalities are limited. See below for the known 
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

In alternative to bundle the pipeline in the DNAnexus applet, it can be pulled from a Git repository 
as usually done by Nextflow. 

The `Makefile` included in this repository automate the creation of the DNAnexus applet for Nextflow 
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
make dx-pull-nf
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

You can find below some examples of to deploy the execution of Nextflow with the applet build with the 
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
    
The above snippet the rnaseq-nf pipeline at [this link](https://github.com/seqeralabs/rnaseq-nf).

The `args` input field is used to specify the Nextflow command line option `-profile` that selects 
enabling the use of Docker container and the [`dx-data`](https://github.com/seqeralabs/rnaseq-nf/blob/master/nextflow.config#L72-L76) 
which specifies as input some (minimal) dataset hosted in a DNAnexus project.

The pipeline results file will be stored in the project storage in the `nf-out/` directory. Check the content 
with the command: 

```
dx ls nf-out 
```

##### Launching nf-core RNAseq pipeline 

    dx run nf-dxapp \
        --watch \
        --delay-workspace-destruction \
        --instance-type mem3_ssd3_x12 \
        --input-json "$(envsubst < examples/nfcore-rnaseq.json)"


## Known problems and limitations

* Nextflow directive [cpus](https://www.nextflow.io/docs/latest/process.html#cpus) and 
[memory](https://www.nextflow.io/docs/latest/process.html#memory) are not yet supported. 
Use the [machineType](https://www.nextflow.io/docs/latest/process.html#machinetype) to specify 
the DNAnexus VM type depending process requirements.   
* Nextflow resume functionality is still not working properly.
* When the pipeline execution terminates abruptly the Nextflow log file is not upload the target project storage.
* Some [Biocontainers](https://biocontainers.pro/) may not work properly.  

## Copyright 

Seqera Labs, all right reserved.  
