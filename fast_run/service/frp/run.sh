#! /bin/bash
if [ ! -d /504service/frp ]; then
	mkdir -p /504service/frp
fi
FRPFileDir="/opt/frp/frp_0.21.0_linux_amd64"

if [ ! -d $FRPFileDir ]; then
	mkdir -p $FRPFileDir
fi

alias cp=cp
cp -r ./frp_0.21.0_linux_amd64/* $FRPFileDir/
chmod a+x $FRPFileDir/*
if [[ $(hostname) =~ '25' ]]; then
  echo "It is 501-25"; 
  cp $FRPFileDir/frpc_config/frpc25.ini  $FRPFileDir/ && \
  rm $FRPFileDir/frpc.ini && mv $FRPFileDir/frpc25.ini $FRPFileDir/frpc.ini
fi
if [[ $(hostname) =~ '26' ]]; then
  echo "It is 501-26"; 
  cp $FRPFileDir/frpc_config/frpc26.ini  $FRPFileDir/ && \
  rm $FRPFileDir/frpc.ini && mv $FRPFileDir/frpc26.ini $FRPFileDir/frpc.ini
fi

cp ./frp.sh /504service/frp
cp ./frpd.service /usr/lib/systemd/system/
alias cp='cp -i'

sleep 1
systemctl restart frpd.service
systemctl enable frpd.service 
systemctl status frpd.service 

exit 0