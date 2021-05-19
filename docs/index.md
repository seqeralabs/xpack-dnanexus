---
title: Introduction
headline: 'Overview of the DNAnexus pack for Nextflow'
description: ''
---

The DNAnexus extension package is a plugin provided by [Seqera Labs](https://www.seqera.io/) that enables the deployment of 
[Nextflow](https://www.nextflow.io/) pipelines on the [DNAnexus](https://www.dnanexus.com/) cloud platform. 

!!! note
    The plugin requires a license key to be used. If you are interested, please contact us for an evaluation license at [sales@seqera.io](mailto:sales@seqera.io).

*A pre-built version of this application is available in DNAnexus platform at this link https://platform.dnanexus.com/app/nextflow-dx.*

!!! warning
    The plugin is still in beta version and some Nextflow functionalities are limited. See below for the known problems and limitations.  

## Requirements 

* DNAnexus command line tools aka dx-toolkit. See [here](https://documentation.dnanexus.com/getting-started/tutorials/cli-quickstart) 
for details.
* Nextflow runtime version 21.04.0 or later. 
* Valid license for DNAnexus extension package for Nextflow.  
* [Make](https://www.gnu.org/software/make) tool (only for the project bundling). 


## Known problems and limitations

* Nextflow resume functionality is still not working properly.
* When the pipeline execution terminates abruptly the Nextflow log file is not uploaded the target project storage.
* Some [Biocontainers](https://biocontainers.pro/) may not work properly.  
