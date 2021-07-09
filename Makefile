#
# Copyright 2021, Seqera Labs, S.L. All Rights Reserved.
#

## DNAnexus quickstart
clean:
	rm -rf build
	
dx-pack:
	mkdir -p build/nextflow-app/resources/usr/bin
	mkdir -p build/nextflow-app/resources/opt/nextflow
	NXF_VER=21.04.0 NXF_HOME=build/nextflow-app/resources/opt/nextflow bash -c 'curl get.nextflow.io | bash'
	mv nextflow build/nextflow-app/resources/usr/bin/nextflow
	rm -rf build/nextflow-app/resources/opt/nextflow/tmp

dx-build:
    # copy dnanexus template
	cp -r app/* build/nextflow-app/
	dx build build/nextflow-app -f
	# info
	echo "Run with: dx run nextflow-app --watch -y"

dx-run: 
	dx run nextflow-app --watch -y
	
DOCKER = squidfunk/mkdocs-material:7.1.2

mkdocs-build:
	docker run --rm -p 8000:8000 -v ${PWD}:/docs $(DOCKER) build

mkdocs-serve:
	docker run --rm -it -p 8000:8000 -v ${PWD}:/docs $(DOCKER)

mkdocs-clean:
	rm -rf site
