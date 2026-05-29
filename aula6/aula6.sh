#!/bin/bash 

echo "Aula 6: Error-logging e depuração"
echo ""
rm teste.txt 2> /dev/null || echo "Arquivo não encontrado!"

echo "Parte 2: substituindo erros exibidos pelo terminal"

rm teste2.txt 2> /dev/null

if [ $? -ne 0 ]; then
    echo "Arquivo não localizado!"
fi
