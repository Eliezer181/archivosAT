
#!/bin/bash

# Obtener el directorio home del usuario actual
home=$(eval echo ~$USER)


echo "Bienvenido selecciona la opcion que buscas."

echo "1- Buscar carpetas vacías o no vacías en subdirectorios."
echo "2- Buscar archivos."
echo "3- Crear una copia de seguridad de las carpetas."
echo "4- Ver carpetas de Home."
echo "5- Ver tamaño de cada archivo."
echo "6- Ayuda."
echo "7- Eliminar carpetas vacías de Home."
echo "8- Eliminar carpetas vacías de subdirectorios."
echo "9- Ver Carpetas con copia de seguridad."
read -p $"Selecciona una opcion:" choice

if [ "$choice" == "1" ]; then
  echo "Opcion 1 seleccionada: buscar carpetas vacías o no vacías en subdirectorios."
  echo "Las carpetas vacias en subdirectorios estaran en rojo, las carpetas no vacias en amarillo."
  folders=$(find $home -type d | sort)
  for folder in $folders; do
    if [ -z "$(ls -A $folder)" ]; then
      echo -e "\033[0;31m${folder##*/}\033[0m"
    else
      echo -e "\033[0;33m${folder##*/}\033[0m"
    fi
  done

elif [ "$choice" == "2" ]; then
    echo "Opcion 2 seleccionada: buscar archivos."
  files=$(find $home -type f | sort)
    for file in $files; do
        echo -e "\033[0;34m${file}\033[0m"
    done

elif [ "$choice" == "3" ]; then
  echo "Opcion 3 seleccionada: crear una copia de seguridad de las carpetas o archivos encontrados."
read -p "Ingresa la ruta de la carpeta para la copia de seguridad: " folder_path
  backup_folder=$(date +"%Y-%m-%d_%H-%M-%S")
  backup_path=$(dirname "$0")
  mkdir $backup_path/backup_$backup_folder
  echo -e "\033[0;32mCopia creada...\033[0m"
  cp -R $folder_path/* $backup_path/backup_$backup_folder

elif [ "$choice" == "4" ]; then
  echo "Opcion 4 seleccionada: ver carpetas de home"
  folders=$(find $home -maxdepth 1 -type d | sort)
  for folder in $folders; do
    if [ -z "$(ls -A $folder)" ]; then
      echo -e "\033[0;31m${folder##*/}\033[0m"
    else
      echo -e "\033[0;33m${folder##*/}\033[0m"
    fi
  done

elif [ "$choice" == "5" ]; then

  echo "Opcion 5 seleccionada: ver tamaño de cada archivo"
  echo -e "\033[0;32mEspera, esto tardara unos minutos...\033[0m"
  files=$(find $home -type f | sort)
  for file in $files; do
    echo "Tamaño del archivo $file: $(du -sh $file | cut -f1)"
  done

elif [ "$choice" == "7" ]; then
echo "Opcion 7 seleccionada: Eliminar carpetas vacías"
echo -e "\033[0;32mEliminando Carpetas...\033[0m"
folders=$(find $home -maxdepth 1 -type d -empty | sort)
for folder in $folders; do
echo "Eliminando carpeta vacía: $folder"
rm -rf $folder
done

elif [ "$choice" == "8" ]; then
  echo "Opcion 8 seleccionada: Eliminar carpetas vacías de subdirectorios"
  echo -e "\033[0;32mEliminando Carpetas...\033[0m"
  folders=$(find $home -type d -empty | sort)
  if [ -z "$folders" ]; then
    echo "No hay carpetas vacías para eliminar."
  else
    for folder in $folders; do
    echo "Eliminando carpeta vacía: $folder"
    rm -rf $folder
    done
fi

elif [ "$choice" == "9" ]; then
  echo "Opcion 9 seleccionada: Mostrar carpetas o archivos con copia de seguridad"
  backup_path=$(dirname "$0")
  files=$(find $backup_path -maxdepth 1 -type d -name "backup_*" -exec ls -R {} \; | sort)
  if [ -z "$files" ]; then
    echo "No se encontraron carpetas o archivos con copia de seguridad."
  else
    for file in $files; do
      echo "Carpetas o archivos con copia de seguridad: $file"
    done
  fi

  elif [ "$choice" == "6" ]; then
  echo "Opcion 6 seleccionada: Ayuda"
  echo "1- Muestra todas las carpetas incluyendo las vacías y no vacías en el directorio home y sus subdirectorios."
  echo "2- Buscar archivos: Muestra todos los archivos en el directorio home y sus subdirectorios."
  echo "3- Crea una copia de seguridad de todos los archivos y carpetas en el directorio home"
  echo "4- Ver carpetas de home: Muestra todas las carpetas en el directorio home, las carpetas vacías aparecerán en rojo y las no vacías en amarillo."
  echo "5- Ver tamaño de cada archivo: Muestra el tamaño de cada archivo en el directorio home y sus subdirectorios."
  echo "6- Ayuda: Muestra esta descripcion de las opciones del script."
  echo "7- Elimina carpetas Vacias de Home."
  echo "8- Elimina carpetas de subdirectorios, antes de eliminar porfavor crea una copia de seguridad."                                                                            echo "9- Puedes ver todas las carpetas a la que hiciste una copia de seguridad."
fi
