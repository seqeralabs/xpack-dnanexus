#!/bin/bash
#
# Copyright 2021, Seqera Labs, S.L. All Rights Reserved.
#
set -eo pipefail

# Main entry point for this app.
main() {
    [[ $debug ]] && set -x && env | sort

    export NXF_HOME=/opt/nextflow
    export NXF_UUID=${resume_id:-$(uuidgen)}
    export NXF_XPACK_LICENSE=${license}
    export NXF_IGNORE_RESUME_HISTORY=true
    export NXF_ANSI_LOG=false
    export NXF_EXECUTOR=dnanexus
    export NXF_PLUGINS_DEFAULT=xpack-dnanexus

    # log file name
    LOG=nextflow.log
    DX_WORK=${work_dir:-$DX_WORKSPACE_ID:/scratch/}
    DX_LOG=${log_file:-$DX_PROJECT_CONTEXT_ID:$LOG}

    # upload nextflow log in background
    mkfifo $LOG; < $LOG dx upload - --path $DX_LOG --wait --brief --no-progress --parents &

    echo "============================================================="
    echo "=== NF work-dir ${DX_WORK}"
    echo "=== NF Resume ID ${NXF_UUID}"
    echo "============================================================="

    # restore cache
    mkdir -p .nextflow/cache/$NXF_UUID
    dx download "$DX_PROJECT_CONTEXT_ID:/.nextflow/cache/$NXF_UUID/*" -o ".nextflow/cache/$NXF_UUID" --no-progress -r -f || true

    # launch nextflow
    nextflow -trace nextflow.plugin \
          $opts \
          -log $LOG \
          run $pipeline_url \
          -resume $NXF_UUID \
          -work-dir dx://$DX_WORK \
          $args

    # backup cache
    dx rm -r "$DX_PROJECT_CONTEXT_ID:/.nextflow/cache/$NXF_UUID/*" || true
    dx upload ".nextflow/cache/$NXF_UUID" --path "$DX_PROJECT_CONTEXT_ID:/.nextflow/cache/$NXF_UUID" --no-progress --brief --wait -p -r
}

nf_task_exit() {
  ret=$?
  if [ -f .command.log ]; then
    dx upload .command.log --path "${cmd_log_file}" --brief --no-progress || true
  else
    >&2 echo "Missing Nextflow .command.log file"
  fi
  dx-jobutil-add-output exit_code "$ret" --class=int
}

nf_task_entry() {
  # capture the exit code
  trap nf_task_exit EXIT
  # run the task
  dx cat "${cmd_launcher_file}" > .command.run
  bash .command.run > >(tee .command.log) 2>&1
}

