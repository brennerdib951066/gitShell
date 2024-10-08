#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
habilitado='yes'
# Verificando as credenciais do usuario
titulo='macros requer acesso'
source "${arquivoLogin}"

if ! verificarCredenciais; then notify-send -u normal -t 6000 "Erro fatal" "Suas credenciais estão erradas\nInsire-as corretamente"; exit 1; fi

funcaoGoogleChrome(){
    if [[ "$line" = 'key press   56' ]]; then
        google-chrome-stable --profile-directory="${1}" "${listaBubble[@]}" &>- &
    else
        google-chrome-stable --profile-directory="${1}" "${2}" &>- &
    fi
}

funcaoAcaoDoSistema() {
    if [[ $line = 'key press   89' ]]; then
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

funcao_kate_deploy() {
    echo "A tecla 'd' foi pressionada!"
    arquivoDeploy='/usr/bin/dibScripts/python/viverBemSeguros/deploy.py'
    kate "${arquivoDeploy}" &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'd' for pressionada
}

funcao_flameshot() {
    echo "A tecla 'f' foi pressionada!"
    diretorio="${HOME}/Desktop"
    if [[ ! -e "${diretorio}" ]];then
            diretorio="${diretorio/Desktop/Área de Trabalho}"
            if [[ ! -e "${diretorio}" ]]; then
                diretorio="${diretorio/Área de Trabalho/Área de trabalho}"
            fi
    fi
    flameshot gui -s -p "${diretorio}" &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'f' for pressionada
}

funcao_kde_connect() {
    echo "A tecla 'k' foi pressionada!"
    kdeconnect-app &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'k' for pressionada
}

funcao_kde_monitor_do_sistema() {
    echo "A tecla 'o' foi pressionada!"
    page='Histórico'
    plasma-systemmonitor --page-name "${page}" &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'o' for pressionada
}
funcao_peek() {
    echo "A tecla 'G' foi pressionada!"
    peek &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'G' for pressionada
}

funcao_kde_discover() {
    echo "A tecla 'u' foi pressionada!"
    plasma-discover &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'u' for pressionada
}

funcao_loginViverBem() {
    echo "A tecla 'l' foi pressionada!"
    DISPLAY=:0.0 '/usr/bin/dibScripts/python/bibliotecas/logarViverBemSeguros.py' &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'l' for pressionada
}

funcao_deslogarViverBem() {
    echo "A tecla 's' foi pressionada!"
    DISPLAY=:0.0 '/usr/bin/dibScripts/python/bibliotecas/deslogarViver.py' &>- &
    # Coloque aqui o código que você deseja executar quando a tecla '39' for pressionada
}

funcao_BackupBcDiarioViverBem() {
    echo "A tecla '8' foi pressionada!"
    DISPLAY=:0.0 '/usr/bin/dibScripts/python/viverBemSeguros/backupBcDiario.py' &>- &
    # Coloque aqui o código que você deseja executar quando a tecla '8' for pressionada
}

funcao_deploViverBem() {
    echo "A tecla 'A' foi pressionada!"
    DISPLAY=:0.0 '/usr/bin/dibScripts/python/viverBemSeguros/deploy.py' &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'A' for pressionada
}

funcao_cadastroDeEtiquetasViverBem() {
    echo "A tecla 'E' foi pressionada!"
    DISPLAY=:0.0 '/usr/bin/dibScripts/python/viverBemSeguros/etiquetas.py' &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'E' for pressionada
}

funcao_katakana() {
    echo "A tecla 'n' foi pressionada!"
    DISPLAY=:0.0 '/usr/bin/dibScripts/python/bibliotecas/tabelaKatakana.py' &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'w' for pressionada
}
#funcao_terminal() {
#    echo "A tecla 't' foi pressionada!"
#    localidade='Área de trabalho'
#    if [[ ! -e "${HOME}/${localidade}" ]]; then
#            localidade="Área de Trabalho"
#            if [[ ! -e "${HOME}/${localidade}" ]]; then
#                localidade="Desktop"
#                cd "${HOME}/${localidade}"
#            else
#                cd "${HOME}/${localidade}"
#            fi
#    fi
#    konsole --workdir ${HOME}/Desktop &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 't' for pressionada
#}
funcao_desativarScript() {
    echo "A tecla 'p' foi pressionada!"
    pid=$(ps -ax | grep -i 'xinput' | awk -F' ' 'NR == 1{print $1}')
    kill -19 $pid

    #notify-send -u normal -t 6000 "Desativação" "Desativado com sucesso seu macro"
    resposta=$(zenity --title='DESATIVAÇÃO DE MACROS' --text='Desativado com sucesso seu macro Deseja reativa-lo?' --question)
    [[ "${?}" = 0 ]] && funcao_ativarScript

    # Desativando ou destruindo esse processo
}

funcao_ativarScript() {
    echo "A tecla 'l' foi pressionada!"
    kill -18 $pid &>- &
    # Coloque aqui o código que você deseja executar quando a tecla 'a' for pressionada
}



# ID do dispositivo (encontrado usando xinput list)
declare -A DEVICE_ID
DEVICE_ID=(["SEMICO Usb"]="8" ["Logitech"]="16")
dispositivos=("SEMICO Usb" "Logitech")
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
    DispositivoEscolhido=${DEVICE_ID[SEMICO Usb]}
fi
#echo $0; sleep 5s

# Inicie o monitoramento do dispositivo em segundo plano
xinput test "$DispositivoEscolhido" | while read -r line; do
    [[ "${line}" = 'key press   68' && ${habilitado} = 'yes' ]] && habilitado='no'
    [[ "${line}" = 'key press   67' && ${habilitado} = 'no' ]]  && habilitado='yes'
    if [[ "${habilitado}" = 'yes' ]]; then
            case $line in
        ############################ LISTA FUNÇÃO GOOGLE CHROME #########################################################################################################

                "key press   56") listaBubble=('https://bubble.io/page?type=page&name=setor_administrativo&id=viverbemseguroscrm&tab=tabs-1&subtab=Plan'
            'https://bubble.io/page?type=page&name=setor_administrativo&id=viverbemseguroscrm&tab=tabs-3&subtab=Data+Types&type_id=user'
            'https://www.sistemaviverbemseguros.com/version-test')
                funcaoGoogleChrome 'DIB' "${listaBubble[@]}"                                                                                             # Tecla 'b'
                ;;
                "key press   31")
                funcaoGoogleChrome 'Brenner' 'https://manual.bubble.io/help-guides/integrations/api/the-bubble-api/the-data-api/data-api-requests'       # Tecla 'i'
                ;;
                "key press   58") funcaoGoogleChrome 'Denilson' 'https://studio.moises.ai/player2/aff5fa2f-4534-4c8e-8ec5-856c68103736/?context=spliter' # Tecla 'm'
                ;;
                "key press   29") funcaoGoogleChrome 'Brenner' 'https://www.youtube.com/'                                                                # Tecla 'y'
                ;;
                "key press   27") funcaoGoogleChrome 'Brenner' 'https://web.telegram.org/a/'                                                             # Tecla 'y'
                ;;
                "key press   54") funcaoGoogleChrome 'Brenner' 'https://chatgpt.com/c/23e4078d-65e4-4d51-805d-02ef15c3bc80?oai-dm=1'                     # Tecla 'c'
                ;;
                "key press   55") funcaoGoogleChrome 'Brenner' 'https://app.botconversa.com.br/2547/flows'                                               # Tecla '55'
                ;;
                "key press   25") funcaoGoogleChrome 'DIB' 'https://web.whatsapp.com/'                                                                   # Tecla '25'
                ;;
        ############################################# FIM ################################################################################################################

        ############################ LISTA AÇÕES DO SISTEMA ##############################################################################################################
                "key press   90") funcaoAcaoDoSistema 'poweroff'                                                                                        # Tecla '0'
                ;;
                "key press   87") funcaoAcaoDoSistema 'reboot'                                                                                          # Tecla '1'
                ;;
                "key press   88") funcaoAcaoDoSistema 'suspend'                                                                                         # Tecla '2'
                ;;
                "key press   89") funcaoAcaoDoSistema 'qdbus org.kde.ksmserver /KSMServer logout 0 0 0'                                                 # Tecla '3'
                ;;
        ############################################# FIM ################################################################################################################

        ############################ LISTA DE FUNÇÔES PARA ABRIR ARQUIVOS ################################################################################################
                "key press   40") funcaoAbrirArquivos '/usr/bin/dibScripts/python/viverBemSeguros/deploy.py'                                            # Tecla 'd'
                ;;
                "key press   43") funcaoAbrirArquivos ~/.bashrc                                                                                         # Tecla 'h'
                ;;
        ############################################# FIM ###############################################################################################################

        ############################ LISTA FUNÇÃO ARQUIVOS EXECUTAVEIS ##################################################################################################
                "key press   46") funcaoArquivoExecutavel '/usr/bin/dibScripts/python/viverBemSeguros/loginViverBem.py'                                 # Tecla 'l' # Mostra um popup do python
                ;;
                "key press   80") funcaoArquivoExecutavel '/usr/bin/dibScripts/python/viverBemSeguros/backupBcDiario.py' # Tecla '8'
                ;;
                "key press   38") funcaoArquivoExecutavel '/usr/bin/dibScripts/python/viverBemSeguros/deploy.py' # Tecla '38'
                ;;
                "key press   26") funcaoArquivoExecutavel '/usr/bin/dibScripts/python/viverBemSeguros/etiquetas.py' # Tecla '26'
                ;;
        ############################################# FIM ##############################################################################################################
                "key press   39") funcao_loginViverBem # Tecla '39'
                ;;
        ############################ LISTA FUNÇÃO ARQUIVOS EXECUTAVEIS #################################################################################################
                "key press   41") funcaoAbrirProgramas 'flameshot gui -s &>- &' # Tecla 'f'
                ;;
                "key press   45") funcaoAbrirProgramas 'kdeconnect-app &>- &' # Tecla 'k'
                ;;
                "key press   32") funcaoAbrirProgramas 'plasma-systemmonitor --page-name Histórico &>- &' # Tecla 'o'
                ;;
                "key press   42") funcaoAbrirProgramas 'peek &>- &' # Tecla 'G'
                ;;
                "key press   30") funcaoAbrirProgramas 'plasma-discover &>- &' # Tecla 'G' # Tecla 'u'
                ;;
                "key press   28") funcaoAbrirProgramas 'konsole --workdir ${HOME}/Desktop &>- &' # Tecla 't'
                ;;
        ############################################# FIM #############################################################################################################
                "key press   57") funcao_katakana # Tecla 'n'
                ;;
                "key press   33") funcao_desativarScript # Tecla 'p'
                ;;

            esac
    fi
done
