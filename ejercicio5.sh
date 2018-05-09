#!/bin/bash
echo -e "\n**** Modelo de procesador, megahercios, tamaño de caché, identificador de vendedor y número máximo de hilos de ejecución ****"
cat /proc/cpuinfo | grep -E 'model name' | uniq >>proc.txt #Leemos cada campo que necesitamos del /proc/cpuinfo y con uniq hacemos que no salga reptido
cat /proc/cpuinfo | grep -E 'cpu MHz' | uniq >>proc.txt 
cat /proc/cpuinfo | grep -E 'cache size' | uniq >>proc.txt 
cat /proc/cpuinfo | grep -E 'vendor_' | uniq >>proc.txt 
cat /proc/cpuinfo | grep -E 'siblings' | uniq >>proc.txt 

#Procesador: 1 tab, mhz: 2 tab, cache: 1 tab, vendedor de la cache: 1 tab e hilos: 3 tab
cat proc.txt | sed -r -e 's/model name	: (.*)/Modelo de procesador: \1/' | sed -r -e 's/cpu MHz		: (.*)/Megahercios: \1/' | sed -r -e 's/cache size	: (.*)/Tamaño de caché: \1/' | sed -r -e 's/vendor_id	: (.*)/ID vendedor: \1/' | sed -r -e 's/siblings	: (.*)/Número de hilos: \1/' 

echo -e "\n**** Punto de montaje, dispositivo y tipo de dispositivo ****"
cat /proc/mounts | sed -r -e 's/(.*) (.*) (.*) (.*) (.*) (.*)/->Punto de montaje: \2, Dispositivo: \1, Tipo de dispositivo: \3/'

echo -e "\n**** Particiones y número de bloques ****"
cat /proc/partitions | sed -r -e 's/(.*) (.*) (.*) (.*)/->Partición: \4, Número Bloques: \3/'

echo -e "\n**** Borrando ficheros temporales ****"
rm proc.txt