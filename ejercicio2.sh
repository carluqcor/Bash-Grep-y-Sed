#!/bin/bash
if [ ! $1 ]; then
	echo "Error en los argumentos, introduzca el fichero"
	exit -1
fi

if [ ! -f $1 ]; then
	echo "Error, no es un fichero"
	exit -1
fi

echo -e "\n"
cat $1 | sed -r -e '/  /d' | sed -r -e '/=/d' | sed -r -e 's/Dirigida por (.+)$/|-> Director: \1/' | sed -r -e 's/(.+) [[:punct:]].*[[:punct:]]$/|-> Fecha de estreno: \1/' | sed -r -e 's/Reparto: (.*)$/|-> Reparto: \1/' | sed -r -e 's/([0-9]hr [0-9][0-9]min)/|-> Duración: \1/g' | sed -r -e 's/(^[^(|)].*)/Titulo: \1/' | sed '/^$/d' 
echo -e "\n"					

#Primero borramos las lineas en blanco y lo "subrayado"(======), ahora empezamos a ordenar por el director, ya que para el titulo no tenemos nada de referencia, con el director usamos la referencia de 
#Dirigida por... asi todo el rato con los demás hasta llegar al final y nos falta el titulo, donde nos damos cuenta que ahora todas las lineas empiezan por | a si que hacemos que seleccione todas la lineas
#que no empiecen por | y coja el titulo y lo imprima despues de Titulo: y para borrar las lineas de salto de linea es tan facil como un sed con la opción de borrar(^) y $ y la bandera d 