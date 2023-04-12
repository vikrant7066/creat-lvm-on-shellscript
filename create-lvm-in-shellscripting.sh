function main(){
	echo "[1] pvcreate"
	echo "[2] vgcreate"
	echo "[3] lvcreate"
	echo "[4] make fst"
	echo "[5] mount"
	echo "[6] list"
	echo "[7] quit"


	read -p "Select option : " option
#}


if  [ $option == '1' ]
then
	echo "* creating physical volume *"
	read -p "Enter divice name : " partitionname
	pvcreate /dev/$partitionname
	main


elif [ $option == '2' ]
then

	echo "* creating volume group *" 
	read -p "Enter volume group name : " vg
	read -p "Enter th pv to add : " partitionname
	vgcreate $vg $partitionname
	main

elif [ $option == '3' ]
then
	
	echo "* Creating logical volume *"
	read -p "LV name : " lvname
	read -p "logical volume size : " lvsize
	read -p "vgname : " vgname
	lvcreate -L $lvsize -n $lvname $vgname
	main

elif [ $option =='4' ]
then
	
	echo "* Giving file system type *"
	read -p "Enter device name : " dev
	echo "[1] ext4"
	echo "[2] xfs"
	echo "[3] swap"
	read -p "select fstype : " fst
	if [ $fst == '1' ]
	then
		mkfs.ext4 $dev
	elif [ $fst == '2' ]
	then
		mkfs.xfs $dev
	elif [ $fst == '3' ]
	then
		mkswap $dev
	fi	
	main

elif [ $option == '5' ] 
then
	ehco "* Permanent mount *"
	read -p "Enter device to mount : " part
	read -p "Enter mount point : " mtpt
	read -p "Enter fstype : " fstype
	echo "$part $mtpt $fstype defaults 0 0" >> /etc/fstab
	mount -a
	swapon -a 
	main

elif [ $option == '6' ]
then
	lsblk
	main

elif [ $option == '7' ]
then
	kill

else 
	echo "Invalid option"
	main

fi
}
