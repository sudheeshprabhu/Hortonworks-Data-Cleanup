
#!/bin/bash
#Script written by Sudheesh
#Cleanup HDP Ambari installation

#Check if OS is RHEL based, if not exit

if [ ! -f /etc/redhat-release ]
then
echo " Script will work only on RHEL/CentOS distros"
fi

echo " !!!!!!!!! CAUTION THIS script will clear all Hadoop data !!!!"

echo -n " Do you want to proceed [y/n] : "
read c

if [ $c -ne y ]
then
exit 1
fi


if [ -f /etc/init.d/ambari-agent ]
then
/etc/init.d/ambari-agent stop
fi

if [ -f /etc/init.d/ambari-server ]
then
/etc/init.d/ambari-server stop
fi


if [ -f /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py ]
then
python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py --silent --skip=users
fi


yum remove hive\*
yum remove oozie\*
yum remove pig\*
yum remove zookeeper\*
yum remove tez\*
yum remove hbase\*
yum remove ranger\*
yum remove knox\*
yum remove ranger\*
yum remove storm\*
yum remove hadoop\*
yum remove ambari\*


#Not adding as it is for testing

#rm -rf /etc/yum.repos.d/ambari.repo /etc/yum.repos.d/HDP*
#yum clean all


if [ -f folder_list.txt ]
then
cat folder_list.txt |xargs rm -rf

else

echo "!!! Folder list file doesn't exist !!! "

fi


ls -l /usr/bin/ |grep "/usr/hdp/" |awk '{print $9}' >hdp_unlink_list.txt
for i in `cat hdp_unlink_list.txt`; do unlink /usr/bin/$i; done

