#!/bin/bash

echo "Olá, bem vindo ao meu script!"
nome="Matheus"

echo "Prazer, $nome"
echo "O nome do arquivo é $0"
read -p "Digite seu nome: " nome_usuario
echo "Olá, $nome_usuario!"

echo "Data do log $(date)" > log_sistema.txt
echo "Fim dolog $(date)" >> log_sistema.txt
