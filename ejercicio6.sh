#!/bin/bash
temp=$(mktemp)
if [ $1 ];then
	while IFS=: read -r name pass uid gid nameinfo home cmd #Con esto podemos nombrar los campos del fichero /etc/passwd con variables que hemos definido
	do
		if [ $1 == $cmd ];then #Si la cadena es igual del ultimo campo del passwd realizará el proceso de hayar el grupo y log

			Grupo=$(cat /etc/group | sed -n -r -e "s/(.*):(.*):($gid):(.*)$/\1/p")
			log=0 #Lo he ppuesto default a 0 ya que si no, hasta que encuentre alguno que esté conectado los campos estarán vacios, y de esta forma me ahorro ese problema
			who -u | grep -E $name | sed  -r -e 's/(.*)   (.*)         (.*) (.*) (.*)/\1/' >>$temp
		    for x in $(cat $temp)
		    do
			    if [ $x == $name ]; then
			    	log=1
			    fi
			done	 
		    echo -e "Logname: $name\n->UID: $uid\n->Grupo: $Grupo\n->GID: $gid\n->Home: $home\n->Shell por defecto: $cmd\n->Logeado: $log\n"
		fi
	 done < /etc/passwd #Documento que estamos leyendo
fi
 
	
if [ ! $1  ];then
while IFS=: read -r name pass uid gid nameinfo home cmd 
	do
		Grupo=$(cat /etc/group | sed -n -r -e "s/(.*):(.*):($gid):(.*)$/\1/p")
		log=0
		who -u | grep -E $name | sed  -r -e 's/(.*)   (.*)         (.*) (.*) (.*)/\1/' >>$temp
	    for x in $(cat $temp)
	    do
		    if [ $x == $name ]; then
		    	log=1
		    fi
		done	 
	    echo -e "Logname: $name\n->UID: $uid\n->Grupo: $Grupo\n->GID: $gid\n->Home: $home\n->Shell por defecto: $cmd\n->Logeado: $log\n"
	done < /etc/passwd
fi