#!/bin/bash

echo "Objetivo: Verificar determinados domínios, se estão acessíveis ou não, e se estiverem, verificar dados do seu certificado."

log_file="monitoramento.log"
echo "--- início do monitoramento: $(date) ---" >> $log_file

for site in "$@"; do
    echo "Verificando o site: $site..."

    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$site")

    if [ "$STATUS" -eq 200 ]; then
        echo "$site - Status: OK (200)" >> $log_file

        SSL_expiration=$(openssl s_client -servername "$site" -connect "$site:443" < /dev/null 2>/dev/null | \
        openssl x509 -noout -enddate | sed 's/notAfter=//')

        if [ -z "$SSL_expiration" ]; then
            echo "- Erro SSL: Não foi possível obter o certificado." >> $log_file
        else
            echo "- SSL expira em: $SSL_expiration" >> $log_file
        fi

    else
        echo "$site - Status: Erro ($STATUS)" >> $log_file
    fi
done

echo "--- Fim do monitoramento ---" >> $log_file
echo "Monitoramento concluído! Verifique o arquivo: $log_file"
