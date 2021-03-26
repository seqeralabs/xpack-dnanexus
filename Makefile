#
# Copyright 2021, Seqera Labs, S.L. All Rights Reserved.
#

## DNAnexus quickstart
clean:
	rm -rf build
	
dx-pack:
	mkdir -p build/nextflow/resources/usr/bin
	mkdir -p build/nextflow/resources/opt/nextflow
	NXF_VER=21.03.0-edge NXF_HOME=build/nextflow/resources/opt/nextflow bash -c 'curl get.nextflow.io | bash'
	mv nextflow build/nextflow/resources/usr/bin/nextflow
	rm -rf build/nextflow/resources/opt/nextflow/tmp

dx-build:
    # copy dnanexus template
	cp src/* build/nextflow/
	dx build build/nextflow -f
	# info
	echo "Run with: dx run nextflow --watch -y"

dx-run: 
	dx run nextflow --watch -y
