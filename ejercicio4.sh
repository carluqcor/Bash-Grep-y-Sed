#!/bin/bash

if [ ! $1 ]; then
	echo "Error en los argumentos, introduzca como 1º argumento el fichero"
	exit -1
fi

if [ ! -f $1 ]; then
	echo "Error, el 1º argumento no es un fichero"
	exit -1
fi

if [ ! $2 ]; then
	echo "Error en los argumentos, introduzca como 2º argumento el número para el timeout"
	exit -1
fi


for x in $(cat $1)
do
	ping -W $2 -c 1 $x >> temp1.txt #Guardamos en un archivo temporal lo que da como resultado el hacer un único ping con timeout que proporcionará el argumento 2 

	if [ $? -eq 0 ]; then #Si el último dato recibido es = a 0 entonces ha logrado responder antes del timeoout
		sed -n -r -e  's/(.+from )(.+)(:.+ )(time=)(.+)( ms)/La IP \2 ha tardado \5 milisegundos/p' temp1.txt >>temp2.txt
	else #Si no, no habrá logrado responder antes de que se acabe el tiempo
		echo "La IP $x no respondió tras $2 segundos">>temp3.txt 
	fi
done

echo -e "\nSe va a ordenar el fichero de forma que el tiempo en ms sea de menor a mayor"
sort -g -k 6 -u temp2.txt #Se ordena el fichero por decimales con -g y -u para que solo muestre una vez

cat temp3.txt

echo -e "\nBorrando los ficheros temporales..."
$(rm temp?.txt)
echo -e "Ficheros borrados satisfactoriamente\n"