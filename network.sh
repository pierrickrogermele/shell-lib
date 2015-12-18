#########
# SAMBA #
#########

function mount_samba {
	username=$1
	password=$2
	server=$3
	disk=$4

	platform=$(uname)
	if [ "$platform" = "Darwin" ] ; then
		mount_dir=$(mktemp -d /tmp/BKP.XXXXX)
		mount -t smbfs //$username:$password@$server/$disk $mount_dir
	else
		mount_dir=$(mktemp -d)
		mount -t smbfs -o username=$username,password=$password //$server/$disk $mount_dir
	fi

	echo $mount_dir
}

################
# TIME CAPSULE #
################

function mount_time_capsule {
	username=$1
	password=$2
	time_capsule=$3
	disk=$4

	mount_dir=$(mktemp -d /tmp/BKP.XXXXX)
	mount_cmd="mount_afp afp://$username:$password@$time_capsule/$disk $mount_dir"
	if ! $mount_cmd ; then
		echo Mount failed: $mount_cmd >&2
		rmdir $mount_dir
	fi

	echo $mount_dir
}

###########
# UNMOUNT #
###########

function unmount_dir {
	dir=$1

	umount $dir
	rmdir $dir
}
