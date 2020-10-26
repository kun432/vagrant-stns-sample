#!/usr/local/bin/bash

DOMAIN="example.internal"
USERLIST="./user.lst"
GROUPLIST="./group.lst"

_output_file=$1

if [ ! -f $USERLIST -a ! -f $GROUPLIST ]; then
    echo "$0 requires $USERLIST and $GROUPLIST"
    exit 1
fi

# hash
declare -A groups

exec < $GROUPLIST
while read _name _id
do
    groups["$_id"]="$_name"
done

## user list
exec < $USERLIST
while read _username _uid _gid
do
    _groupname=${groups["$_gid"]}
    _conffile="${_groupname}.conf"
    echo "### ${_groupname} : ${_username} (UID: ${_uid} GID: ${_gid}) ###"
    if [ ! -f ${_username}.id_rsa ]; then
        echo "keypair not found. creating..."
        echo ssh-keygen -t rsa -b 4096 -N "" -C "${_username}@${DOMAIN}" -f ${_username}.id_rsa
    fi
    _pubkey=$(cat ${_username}.id_rsa.pub)
    cat <<EOF | tee -a $_conffile
[users.${_username}]
id = ${_uid}
group_id = ${_gid}
keys = ["${_pubkey}"]
shell = "/bin/bash"  

EOF
    
done

## [WIP]group list
exec < $GROUPLIST
while read _name _id
do
    _conffile="${_name}.conf"
    grep "$_name" $USERLIST | awk '{ print $1 }'
    cat <<EOF | tee -a $_conffile
[groups.${_name}]
id   = $_id
user = [ "john", "paul", "george", "ringo" ]
EOF
done