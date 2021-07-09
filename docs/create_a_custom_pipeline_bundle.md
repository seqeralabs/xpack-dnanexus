---
title: Create a custome pipeline bundle
headline: 'Create a custom Nextflow pipeline bundle for DNAnexus xpack'
description: ''
---

In order to deploy the execution of a Nextflow pipeline in DNAnexus you will need to create 
a DNAnexus applet bundling the Nextflow runtime along the DNAnexus extension plugin and, optionally, 
the pipeline scripts.

In alternative to bundling the pipeline in the DNAnexus applet, it can be pulled from a Git repository 
as is usually done by Nextflow. 

The `Makefile` included in this repository automates the creation of the DNAnexus applet for Nextflow 
using the following steps: 

## Login in your DNAnexus workspace 

```
dx login
```

## Clone this repository in your computer using the following command

``` 
git clone https://github.com/seqeralabs/xpack-dnanexus
cd xpack-dnanexus
```              

## Create the DNAnexus bundle including the Nextflow runtime 

```
make dx-pack
```

The above command creates the bundle skeleton in the directory `build/nextflow-app`.  

## Modify the app metadata 

DNAnexus app requires a file named `dxapp.json` to configure the application deployment 
and parameters. 

A predefined app metadata file with the settings required for the Nextflow execution 
is available in this repository at the path [app/dxapp.json](app/dxapp.json). Modify it according your 
requirements. 

See the [DNAnexus documentation](
https://documentation.dnanexus.com/developer/apps/app-metadata) for further details.


## Build the DNAnexus applet

``` 
make dx-build
```

The above command build the DNAnexus applet for Nextflow with the name `nextflow-app` ready to be executed. 
 

