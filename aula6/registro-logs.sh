log_file="script.log"
echo "----------------------------------------------" >> $log_file
echo "início do script: $(date)" >> $log_file

ls -l >> $log_file

if [ $? -ne 0 ]; then
    echo "A listagem de arquivos falhou!" >> $log_file
fi

echo "Fim do Script: $(date)" >> $log_file

