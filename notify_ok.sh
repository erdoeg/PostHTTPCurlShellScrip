#!/usr/bin/sh

DATAATUAL=`date +%Y-%m-%d-%H:%M:%S`
OUTDIR=/grafometria/out
OUTNOTIFY="\\\\152.22.22.22\\abcde\\out\\"
success = true

echo
echo "--------------| STARTING NOTIFY [$DATAATUAL]|---------------"
echo
echo "`ls -lrt ${OUTDIR}`"
echo "------------------------------------------------------------"
echo

for i in `ls ${OUTDIR}`
do
	package="$OUTNOTIFY$i"
	cmd_http=`curl -i -o - --silent -H "Content-Type: application/json" -X POST -d '{"docNumber":"$package","fileName":"$OUTDIR/$package"}' https://servicos.nsportal.com.br/xxxxxx/zzzzzzz/abcd`
	http_status=$(echo "$cmd_http" | grep HTTP |  awk '{print $2}')
    
    echo "PACOTE -> [${i}]"
    echo "PATH PACOTE -> [$package]"
    echo "Notify $i -> [$DATAATUAL] - [$http_status]"
    echo
	if [ $http_status -ne "200" ]; then
	    success=false
	fi

done

echo "Notify Done [$DATAATUAL] - Success [$success - $http_status]"


#./testando.sh >> logtestando.log

