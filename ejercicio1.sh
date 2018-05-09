#!/bin/bash
if [ ! $1 ]; then
	echo "Eror en los argumentos, introduzca el fichero"
	exit -1
fi

if [ ! -f $1 ]; then
	echo "Error, no es un fichero"
	exit -1
fi

#1
echo -e "**** Duración de peliculas ****"

cat $1 | grep -E '[0-9][0-9]min' #Para segundos sería igual que min pero poniendo seg

#2
echo -e "\n**** Pais y fecha de las peliculas ****"
cat $1 | grep -E '[[:punct:]][[:blank:]][[:punct:]][[:upper:]]' #Patron: ) -[Mayúscula]

#3
echo -e "\n**** Pais de las peliculas ****" #Primero seleccionamos -Pais- y luego quitamos los guiones con ^ que no selecciona el elemento que haya después
cat $1 | grep  -o -E '\-.*\-' | grep -o -E '[^\-].*[^\-]'

#4
echo -e "\n**** Numero de películas en 2016 y 2017 ****" #Busca donde haya un 3 digitos juntos y un 7 y un 6 respectivamente para contar las peliculas con wc -l
var1=$(cat $1 | grep -E '[[:digit:]][[:digit:]][[:digit:]][7]' | wc -l)
var2=$(cat $1 | grep -E '[[:digit:]][[:digit:]][[:digit:]][6]' | wc -l)
echo -e "El número de películas en 2016 es $var2 y en 2017 es $var1\n"

#5
echo -e "\n**** Mostrar todo el fichero sin lineas vacias ****"  
cat $1 | grep '.'

#6
echo -e "\n**** Lineas que empiezan por E (con o sin espacios antes) ****" 
cat $1 | grep -E '^[[:blank:]]*E' #Todas las lineas que empiezen por E o tengan un espacio y E (esto lo hace *)

#7
echo -e "\n**** Lı́neas que contienen d, l o t, una vocal y la misma letra ****" 
cat $1 | grep -E '([dlt])[aeiou]\1' #\1 Hace referencia al primer grupo

#8
echo -e "\n**** Lı́neas que contienen al menos 8 aes o más  ****" 
cat $1 | grep -i -E 'a.*a.*a.*a.*a.*a.*a.*a.*'  #para buscar más de 8 aes

#9
echo -e "\n**** Lı́neas que terminan en ... y no empiezan en espacios ****" 
cat $1 | grep -E '^[^ ].*(\.\.\.)$' #Busca con el primer ^ al principio y con el ^ que no esté el espacio, basicamente que no empieze por espacio y tengan ... al final

#10
echo -e "\n**** Usando el sed, entrecomillar las vocales con tildes ****" 
cat $1 | sed -r -e 's/([áÁéÉíÍóÓúÚ])/"\1"/g' #El \1 referencia al primer grupo que en este caso es el unico del rango de valores disponible []
