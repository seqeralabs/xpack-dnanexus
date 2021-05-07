#
# Copyright 2021, Seqera Labs, S.L. All Rights Reserved.
#

## DNAnexus quickstart
clean:
	rm -rf build
	
dx-pack:
	mkdir -p build/nextflow-dx/resources/usr/bin
	mkdir -p build/nextflow-dx/resources/opt/nextflow
	NXF_VER=21.04.0 NXF_HOME=build/nextflow-dx/resources/opt/nextflow bash -c 'curl get.nextflow.io | bash'
	mv nextflow build/nextflow-dx/resources/usr/bin/nextflow
	rm -rf build/nextflow-dx/resources/opt/nextflow/tmp

dx-build:
    # copy dnanexus template
	cp -r app/* build/nextflow-dx/
	dx build build/nextflow-dx -f
	# info
	echo "Run with: dx run nextflow-dx --watch -y"

dx-run: 
	dx run nextflow-dx --watch -y

dx-publish:
	cp -r app/* build/nextflow-dx/
	dx build build/nextflow-dx -f --app --bill-to=org-seqera
	dx add developers app-nextflow-dx org-dnanexus_tools_admin
