#!/bin/bash
if [ ! $1 ]; then
	echo "Error en los argumentos, introduzca el fichero"
	exit -1
fi

if [ ! -f $1 ]; then
	echo "Error, no es un fichero"
	exit -1
fi

echo "**** Listar ficheros que empiezan por . de tu HOME ****"
for x in $(ls -a $HOME | grep -E -v '^[[:alpha:]]') #Se listarán los ficheros ocultos del Home y solo mostrará los que no empiecen por letra
do
	echo ${#x} $x # #(Nombre Fichero) devuelve el número de carácteres

done | sort -g | sed -r -e 's/[0-9].* (.*)/\1/'

echo -e "\n**** Hacer una copia del fichero pasado por argumento eliminando las lineas vacias ****"
if [ ! -f $1".sinLineasVacias" ]; then #Comprobamos de que si el fichero no existe que lo cree directamente
	cat $1 | grep '.'>>"$1.sinLineasVacias"
	echo "Copia creada correctamente..."

else #Pero si existe, que lo borre primero y lo cree luego
	echo "Primero se va a borrar la copia con ese nombre..."
	rm $1".sinLineasVacias"
	cat $1 | grep '.'>>"$1.sinLineasVacias"
	echo "Copia creada correctamente..."
fi

echo -e "\n**** Listar los procesos por su pid, su hora de inicio y el nombre del ejecutable ****"

ps -o user,pid,stime,cmd | grep -E "^($USER)" | sed -r -e 's/ //g' | sed  -r -e "s/$USER//" | sed -r -e 's/.([0-9].*)([0-9][0-9]:)/PID: "\1" \2/' | sed -r -e 's/([0-9][0-9][[:punct:]][0-9][0-9])/Hora: "\1"/' | sed -r -e 's/(:[0-9][0-9]\")(.*)$/\1 Ejecutable: "\2"/' 
#Lo que he hecho es usar la funcionalidad del ps -o para que muestre las variables que necesito unicamente y asi poder ayudarme en la realización de la búsqueda de procesos
