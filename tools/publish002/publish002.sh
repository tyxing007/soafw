#!/bin/bash

######## 参数1表示项目名称


#if [ $# != 1 ];then

# echo "参数数量不是1个(项目名称，例如tsl),请核对"

#  exit

#fi

#### 校验工程名是否是(tsl/order/merchant)等等 #####


if [ "$1" != "tsl" ]&&[ "$1" != "order" ]&&[ "$1" != "merchant" ]&&[ "$1" != "code" ]&&[ "$1" != "user" ]&&[ "$1" != "purchs" ];then

  echo "不是有效的项目名称tsl/order/merchant/code/user/purchs请重新输入"

  exit

fi


app_path="/root/apps"

app_root_path="/root/apps/$1"

seq_no="1"
next_seq_no="2"
date_time=`date +%Y-%m-%d`

#######log_path######
log_path="/data1/logs/service/$1"

global_config_path="/config"

####################

##########app service name #######

app_name="root"

################################

while read seq_num
do
 echo "LINE:"$seq_num
seq_no=$seq_num
done < $1_seq.txt

#seq_no="$num"

echo "当前版本号:""$date_time""_"$seq_no

current_version="$date_time""_"$seq_no

next_seq_no=$[ $seq_no + 1 ]

echo "下一个序列号next_seq_no:"$next_seq_no

sed -i 's'/$seq_no/$next_seq_no/'g' $1_seq.txt

#rm -rf $1_seq.txt

#touch seq.txt

#echo $next_seq_no > $1_seq.txt

global_pom_path="$app_root_path"/"$date_time""_"$seq_no

web_path="$app_root_path"/"$date_time""_"$seq_no/"$1-web"

job_path="$app_root_path"/"$date_time""_"$seq_no/

service_impl_path="$app_root_path"/"$date_time""_"$seq_no/"$1-service-impl"

web_target_path="$app_root_path"/"$date_time""_"$seq_no/"$1-web"/"target"

current_path="$app_root_path"/"$date_time""_""$seq_no"/"bin"

web_src_path="$app_root_path"/"$date_time""_"$seq_no/"$1-web"/"src"

############增加脚本版本文件###########
shell_bash_org_file="/root/shell_bash/$1_seq.txt"
shell_bash_last_file="/root/shell_bash/$1_last_version.txt"
shell_bash_backup_file="/root/shell_bash/$1_last_version_bak.txt"

webPort_xml_file="/root/code/projects/workspace/$1/$1-web/pom.xml"

webPOM_xml_file="/root/code/projects/workspace/$1/pom.xml"
###################################

###################项目级别的config############

pro_config_path="$app_root_path"/"config"

###############################################

############加入软连接########

#current_link_path="$app_root_path"/"bin"
#############################

echo "web_path:"$web_path
echo "job_path:"$job_path
echo "service_impl_path:"$service_impl_path

######################### 删除历史记录####

#rm -rf startService.sh startJob.sh startTradeSyncJob.sh startWeb.sh

########################

######################生成可执行脚本##########
sed '1,$s/$prefix/'"$1"'/g'  startService_org.sh > startService.sh

if [  -n "$2" ];then

echo "输入的端口号:"$2

sed -e '1,$s/$2/'"$2"'/g' -e '1,$s/$prefix/'"$1"'/g'  startWeb_org.sh > startWeb.sh

else

#line_num = `sed -n '/<jetty.port>/p' $webPort_xml_file`

str=`sed -n '/<jetty.port>/p' $webPort_xml_file`

delblankStr=$(echo $str)

port=${delblankStr:12:4}

echo "未输入端口号默认port:"$port

sed -e  '1,$s/$2/'"$port"'/g' -e '1,$s/$prefix/'"$1"'/g'  startWeb_org.sh > startWeb.sh

fi

sh kjt_switch.sh   $1 $current_version

###########################动态生成脚本
declare -a array

i=0

while read line

do
   str=$(echo $line)
  if [[ ${str:1:14} =  "module>$1-job" ]]; then

    #echo $str
    str2=$(echo ${str#*>})
    # echo "str2:"$str2
    str3=$(echo ${str2%<*})
    #echo "str3:"$str3
    array[$i]=$str3
    i=$[$i + 1]
  fi

done < $webPOM_xml_file


for var in ${array[@]};do

echo "测试数据##########################$var:"  $var
 
 param1="$1"
 
 strlen=${#param1}
# echo "strlen"$strlen

 start_shell=${var:$strlen:200}

 echo "start_shell:"$start_shell
 
 start_shell="start"$start_shell

 echo "start_shell=========="$start_shell
 rm -rf "$start_shell".sh 

sed '1,$s/$prefix/'"$var"'/g'  startall.sh > "$start_shell".sh

chmod 755 "$start_shell".sh

###########创建路径

if [ ! -d "$job_path$var" ]; then
 
   mkdir -p  "$job_path$var"
fi

done

for var in ${array[@]};do

 if [ "$1" = "tsl" ];then
 echo "我要测试###################################"$1
cd /root/code/projects/workspace/$1/$var

 mvn assembly:assembly
else

 echo "非tsl工程"

fi



done

################## if apps dir not exists then create #######
if [ ! -d "$app_path" ]; then
   mkdir -p "$app_path"
fi  


if [ ! -d "$global_pom_path" ]; then
   mkdir -p "$global_pom_path"
fi

if [ ! -d "$web_path" ]; then
   mkdir -p "$web_path"
fi

if [ ! -d "$service_impl_path" ]; then
   mkdir -p "$service_impl_path"
fi

if [ ! -d "$current_path" ]; then
   mkdir -p "$current_path"
fi


if [ ! -d "$log_path" ]; then
   mkdir -p "$log_path"
fi

if [ ! -d "$global_config_path" ]; then
   mkdir -p "$global_config_path"
fi

if [ ! -d "$web_target_path" ]; then
   mkdir -p "$web_target_path"
fi

if [ ! -d "$web_src_path" ]; then
   mkdir -p "$web_src_path"
fi

if [ ! -d "$pro_config_path" ]; then
   mkdir -p "$pro_config_path"
fi

##############新增tsljob#######
###########打包 service ##############


cd /root/code/projects/workspace/$1/$1-service-impl

 mvn assembly:assembly

########新增配置文件config#########
cp -Rpf /root/code/projects/workspace/$1/config  $pro_config_path


###################################

cd /root/apps/$1/

rm -rf current

cp -Rpf /root/code/projects/workspace/$1/pom.xml  $global_pom_path

if [ "$1" = "tsl" ];then
   
for var in ${array[@]};do

  param1="$1"
 
 strlen=${#param1}

 start_shell=${var:$strlen:200} 

 start_shell="start"$start_shell

cp -Rpf /root/code/projects/workspace/$1/$var/target/*.tar.gz  $job_path$var

cp -Rpf /root/shell_bash/$start_shell.sh  $current_path

done

fi

cp -Rpf /root/code/projects/workspace/$1/$1-service-impl/target/*.tar.gz  $service_impl_path

cp -Rpf /root/shell_bash/startService.sh  $service_impl_path

cp -Rpf /root/code/projects/workspace/$1/$1-web/pom.xml  $web_path

cp -Rpf /root/code/projects/workspace/$1/$1-web/target/*.war /root/code/projects/workspace/$1/$1-web/target/$1-web $web_target_path

cp -Rpf /root/code/projects/workspace/$1/$1-web/src/* /root/code/projects/workspace/$1/$1-web/target/$1-web $web_src_path

cp -Rpf /root/shell_bash/current  $app_root_path

cp -Rpf /root/shell_bash/start.sh      $app_root_path

cp -Rpf /root/shell_bash/startWeb.sh  $current_path

cp -Rpf /root/shell_bash/startService.sh  $current_path

echo "publish project execute over!!!"

echo "当前版本号请记录:""$date_time""_"$seq_no
