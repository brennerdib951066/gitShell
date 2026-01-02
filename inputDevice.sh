#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
habilitado='yes'
# Verificando as credenciais do usuario
titulo='macros requer acesso'
source "${arquivoLogin}"
chamadaGoogle=$(funcao1)
if ! verificarCredenciais; then notify-send -u normal -t 6000 "Erro fatal" "Suas credenciais estão erradas\nInsire-as corretamente"; exit 1; fi

funcaoGoogleChrome(){
    if [[ "$line" = 'key press   56' ]]; then
        google-chrome-stable --profile-directory="${1}" "${listaBubble[@]}" &>- &
    else
        google-chrome-stable --profile-directory="${1}" "${2}" &>- &
    fi
}

funcaoAcaoDoSistema() {
    if [[ $line = 'key press   12' ]]; then
        qdbus org.kde.ksmserver /KSMServer logout 0 0 0
    else
        systemctl "${1}" -i
    fi
}

funcaoArquivoExecutavel(){
        "${1}"
}

funcaoAbrirArquivos(){
    kate "${1}" &>- &
}

funcaoAbrirProgramas(){
    eval "${1}"
}

#funcaoDeEstudo(){

#}
# ID do dispositivo (encontrado usando xinput list)
declare -A DEVICE_ID
deviceBusca=$(xinput)
[[ "${deviceBusca,,}" =~ "2.4g composite devic" ]] && { DEVICE_ID=(["2.4G Devic"]="9" ["VIVO BOOK ASUS"]="15"); dispositivos=("2.4G Devic" "VIVO BOOK ASUS");} || { DEVICE_ID=(["SEMICO Usb"]="8" ["VIVO BOOK ASUS"]="15"); dispositivos=("SEMICO Usb" "VIVO BOOK ASUS") ;}
#DEVICE_ID=(["SEMICO Usb"]="8" ["VIVO BOOK ASUS"]="15")
#dispositivos=("SEMICO Usb" "VIVO BOOK ASUS")
segundoPlano='sim'
PS3=$'\nOPÇÃO:   '

if [[ "${segundoPlano}" = "nao" ]]; then
    select menu in "${dispositivos[@]}"; do
        case "${REPLY}" in
            1) { echo -e "Escolheu ${dispositivos[0]}"; DispositivoEscolhido=${DEVICE_ID[Tean Usb]}; break ;}
            ;;
            2) { echo -e "Escolheu ${dispositivos[1]}"; DispositivoEscolhido=${DEVICE_ID[Logitech]}; break ;}
            ;;
            *) echo -e 'Opção não existe!!!!'
        esac

    done
else
    #DispositivoEscolhido=${DEVICE_ID[VIVO BOOK ASUS]}
    DispositivoEscolhido=${DEVICE_ID['2.4G Devic']}
fi
#echo $0; sleep 5s
# Inicie o monitoramento do dispositivo em segundo plano
xinput test "$DispositivoEscolhido" | while read -r line; do
    echo $'\E[31;1mLMEBRE-SE F2 DESABILITA\E[m'
    echo
    echo $'\E[31;1mLMEBRE-SE F1 HABILITA\E[m'
    [[ "${line}" = 'key press   68' && ${habilitado} = 'yes' ]] && habilitado='no'
    [[ "${line}" = 'key press   67' && ${habilitado} = 'no' ]]  && habilitado='yes'
    if [[ "${habilitado}" = 'yes' ]]; then
            case $line in
                "key press   69")  source ~/'Área de Trabalho/sh/chamadaGoogle.txt'         ; chamadaGoogle          # Tecla 'F3'
                ;;
                "key press   70")  source ~/'Área de Trabalho/sh/chamadaAcoesDoSistema.txt' ; chamadaAcoesDoSistema  # Tecla 'F4'
                ;;
                "key press   71")  source ~/'Área de Trabalho/sh/chamadaAbrirArquivos.txt'  ; chamadaAbrirArquivos   # Tecla 'F5'
                ;;
                "key press   72")  source ~/'Área de Trabalho/sh/chamadaExecutaveis.txt'    ; chamadaExecutaveis     # Tecla 'F6'
                ;;
                "key press   73")  source ~/'Área de Trabalho/sh/chamadaProgramas.txt'      ; chamadaProgramas       # Tecla 'F7'
                ;;
                #"key press   78")  source ~/'Área de Trabalho/sh/chamadaEstudos.txt'        ; chamadaEstudos         # Tecla 'F8'
                #;;
            esac
    fi
done
