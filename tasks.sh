#!/bin/bash

SCRIPT=$0
BASE_DIR=$(cd `dirname $0`; pwd)

function task_destroy(){
    docker-compose down && docker volume prune -f && docker system prune -f
}

function task_generate-keys(){
    mkdir -p $BASE_DIR/concourse/web/keys $BASE_DIR/concourse/worker/keys
    # PEM_OPTION=
    PEM_OPTION='-m PEM'

    yes | ssh-keygen $PEM_OPTION -t rsa -f $BASE_DIR/concourse/web/keys/tsa_host_key -N ''
    yes | ssh-keygen $PEM_OPTION -t rsa -f $BASE_DIR/concourse/web/keys/session_signing_key -N ''

    yes | ssh-keygen $PEM_OPTION -t rsa -f $BASE_DIR/concourse/worker/keys/worker_key -N ''

    cp $BASE_DIR/concourse/worker/keys/worker_key.pub $BASE_DIR/concourse/web/keys/authorized_worker_keys
    cp $BASE_DIR/concourse/web/keys/tsa_host_key.pub $BASE_DIR/concourse/worker/keys

}

function help(){
    cat <<EOF
TASKS
$(cat $SCRIPT | grep -E "^function task_" | sed -E 's/function task_([a-zA-Z0-9-]+).*/\1/' )
EOF
}


OPERATION=$1; shift

if [ -z "$OPERATION" -o "$OPERATION" = "help" -o "$OPERATION" = "h" ]
then
    help
else
    task_$OPERATION $*
fi
