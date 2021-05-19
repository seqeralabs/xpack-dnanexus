---
title: Changelog
headline: 'Changelog for the various releases of DNAnexus xpack for Nextflow'
description: 'Brief overview of the overall changes for each version.'
---

## `1.0.0-beta.2`

- As of version `1.0.0-beta.2` directives [cpus](https://www.nextflow.io/docs/latest/process.html#cpus), [memory](https://www.nextflow.io/docs/latest/process.html#memory), [disk](https://www.nextflow.io/docs/latest/process.html#disk) and [accelerator](https://www.nextflow.io/docs/latest/process.html#accelerator)
  are supported. When specified Nextflow look up for a machine type able to 
  satisfy the requested resources. The `machineType` directive has in any case 
  precedence, when specified any `cpus`, `memory`, `disk` and `accelerator`
  is ignored. 
