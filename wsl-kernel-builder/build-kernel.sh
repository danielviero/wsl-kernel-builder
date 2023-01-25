#!/bin/bash
set -e

# Verifica a existência da pasta de saída, para onde o novo kernel será copiado.
if [ ! -d /output ]; then
    echo ATENÇÃO: Mapeie um volume em /output onde será colocada a imagem gerada.
    exit 1
fi

echo -----------------------------------
echo Baixando o código-fonte atual do Kernel
echo -----------------------------------
echo Baixando de $WSL2_KERNEL_SOURCE_URL...
curl -L -o WSL2-Linux-Kernel.zip $WSL2_KERNEL_SOURCE_URL
echo Descompactando arquivos...
unzip -q -d src WSL2-Linux-Kernel.zip
cd /src/*
echo Baixado em $(pwd)

echo
echo -----------------------------------
echo Ajustando configuração
echo -----------------------------------
mv /wsl-config .config

echo
echo Diferenças da configuração padrão para a que será usada:
echo
diff -y --suppress-common-lines Microsoft/config-wsl .config || true

echo 
echo -----------------------------------
echo Compilando
echo -----------------------------------
export NPROC="$(getconf _NPROCESSORS_ONLN)"
echo Usando $NPROC processadores.
echo
make -j$NPROC
make modules_install -j$NPROC

echo 
echo -----------------------------------
echo Copiando kernel para /output
echo -----------------------------------
cp arch/x86/boot/bzImage /output/bzImageWithUsbStorageSupport
ls -lh /output