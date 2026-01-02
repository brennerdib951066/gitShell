#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"


# função buscando o id do canal do YOUTUBE
aberturaDeCanal(){
    google-chrome-stable --profile-directory='Brenner' 'https://www.youtube.com/@'${1,,}'' &>- &
}

canalId(){
    idCanal="$(wget https://www.youtube.com/@${1} -O - | grep -iEo 'content=\"vnd.youtube://www.youtube.com/channel/([A-Za-z0-9]+_?-?)+')"
    [[ ! "${idCanal}" ]] && { echo "Não encontrei o canal ${1^^}, desculpe!"; exit 1 ;}
    idCanal=${idCanal##*/}
    echo -e "\E[41;1mO id do canal ${1^^} é: ${idCanal}\E[m"
    read -p $'Deseja abrir o '${1^^}' [S/n]?   ' abrirCanal
    [[ ! "${abrirCanal}" || "${abrirCanal}" =~ [simSIM] ]] && aberturaDeCanal "${1}"
}


# Verificações
[[ ${UID} -eq 0 ]] && { echo $'\E[41;1mErro, não aceito usuário ROOT\E[m'; sleep 1s ; exit ; }

[[ ${1:?$'\E[31;1mPor favor mande um nome de canal!\E[m'} ]]

echo $'Buscando'${1}''; sleep 2s
canalId "${1}"
