#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"

sleep 5s
notify-send -u normal -t 6000 "Testando o arquivo de descompactacao" "Teste efeituado com sucesso!"

funcao_arquivosCompactos(){
    arquivos=$(ls ~/Downloads/*.tar.gz)
}
# Buscando a área de trabalho que vem criada como padrão pelo sistema
areaDeTrabalho=$(awk -F'/' '$1 ~ /XDG_DESKTOP_DIR/ {print $2}' ~/.config/user-dirs.dirs)

areaDeTrabalho="${areaDeTrabalho//\"/}"
echo -e "Sua área de trabalho é:\n${areaDeTrabalho}"
cd ~/"${areaDeTrabalho}"

while :; do
    sleep 5s
    for arquivo in ${arquivos[@]}; do
        pastaVerificacao="${arquivo//.tar.gz}"
        [[ -d "${pastaVerificacao//Downloads/'Área de trabalho'}" ]] && { echo "EXISTE ${arquivo//.tar.gz}"; continue ;}
        printf '%b' "\E[31;1mDescompactando ${arquivo}...\E[m\n"
        sleep 1s
        tar -xvf "${arquivo}" -C ~/"${areaDeTrabalho}"
        echo -e "\E[32;1mVendo o nome da pasta\E[m"
        sleep 2s
        echo -e "\E[32;1m${arquivo//.tar.gz/}\E[m"
        sleep 2s

    done
    funcao_arquivosCompactos # Chamando a função funcao_arquivosCompactos
done





