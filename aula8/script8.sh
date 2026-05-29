#!/bin/bash

log_file="Auditoria_$(date +%Y-%m-%d).log"
servico=www.google.com

echo "---Início da auditoria: $(date) ---" >> $log_file

#função para checar o status do serviço
checar_status(){
	echo "1. Checando o status do serviço em $servico..." >> $log_file
	curl -s -l $servico &> /dev/null
	if [ $? -eq 0 ]; then
		echo "-> Status: OK" >> $log_file
	else
		echo "-> Status: Falha. O serviço pode estar offline." >> $log_file
		exit 1
	fi
}

#Função verifica validade certificado SSL
checar_ssl(){
	echo "2. Verificando a validade do certificado SSL..." >> $log_file
	expiracao=$(openssl s_client -servername "$(echo $servico | sed 's|^https://||')" -connect "$(echo $servico | sed 's|^https://||')":443 </dev/null 2>/dev/null | openssl x509 -noout -enddate | sed 's/notAfter=//')
	if [ -z "$expiracao" ]; then
		echo "-> ERRO: Falha ao obter certificado." >> $log_file
	else
		echo "-> Válido até: $expiracao" >> $log_file
	fi
}

#Função para encontrar aquivos grandes e pequenos

encontrar_arquivos(){
	echo "3. Buscando arquivos antigos (mais de 30 dias)..." >> $log_file
	find . -type f -mtime +30 -print >> $log_file
}

#Chamadas das funções
checar_status
checar_ssl
encontrar_arquivos

echo "--- Auditoria Concluída. Verifique o log: $log_file ---"
