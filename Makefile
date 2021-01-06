#
# Copyright 2021, Seqera Labs, S.L. All Rights Reserved.
#

## DNAnexus quickstart
clean:
	rm -rf build
	
dx-pull-nf:
	mkdir -p build/nf-dxapp/resources/usr/bin
	mkdir -p build/nf-dxapp/resources/opt/nextflow
	NXF_VER=21.01.0-edge NXF_HOME=build/nf-dxapp/resources/opt/nextflow bash -c 'curl get.nextflow.io | bash'
	mv nextflow build/nf-dxapp/resources/usr/bin/nextflow

dx-core-pack:
	mkdir -p build/nf-dxapp/resources/usr/bin
	cd ../nextflow && rm -rf build && make packCore
	cp ../nextflow/build/releases/nextflow-* build/nf-dxapp/resources/usr/bin/nextflow

dx-plugin-pack: 
	cd ../nf-xpack && make assemble
	mkdir -p build/nf-dxapp/resources/opt/nextflow/plugins
	cp -r ../nf-xpack/build/plugins/xpack-dnanexus-* build/nf-dxapp/resources/opt/nextflow/plugins
	rm build/nf-dxapp/resources/opt/nextflow/plugins/*.zip

dx-build: dx-core-pack dx-plugin-pack
    # copy dnanexus template
	cp app/dxapp.* build/nf-dxapp/
	dx build build/nf-dxapp -f
	# info
	echo "Run with: dx run nf-dxapp --watch -y"

dx-run: dx-build
	dx run nf-dxapp --watch -y
