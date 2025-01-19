#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
dataAtual=$(date +%d-%m-%Y)
campanha='DIB'
arquivoDeErro=~/"Área de Trabalho/erroGit"
mensagemAviso=(
    'Seus arquivos foram enviados com sucesso para o github'
    'erro ao enviar arquivos para o github'
)
mensagemAvisoToken=(
    'Faltam 3 dias para o seu tokem expirar'
    'Faltam 2 dias para o seu tokem expirar'
    'Faltam 1 dias para o seu tokem expirar'
    'Hoje irá expirar seu token'
)
diaAnotificar=(
    '3'
    '2'
    '1'
    '0'
)
diasFaltante=(

)
# Lista que receberá as pastas onde já tem todo o processo de git push configurado
listaPastaPush=(
    'gitAwk'
    'gitMarkdown'
    'gitPy'
    'gitShell'
    'gitVbs'
)
versao='1.0.0'
# Função de notificar via botConversa para whatsApp
notificar(){
        chaveApi='c7e572f0-c17b-4304-9478-b68641234d6c'
        urlApi='https://backend.botconversa.com.br/api/v1/webhook/subscriber/subscriber_id/send_message/'
        curl -X POST\
        -H 'Content-Type: application/json'\
        -H 'API-KEY: '${chaveApi}''\
        -d "{\"type\": \"text\",\"value\": \"${2}\"}" "${urlApi/subscriber_id/${1}}"
}

# Função de enviar o push para o gitHub
enviandoPush(){

    cd ~/"Área de Trabalho/${1}" 2>>/"${arquivoDeErro}" && { git add .; git commit -m "Nova atualização"; git push origin main;} || { notificar '385910829' "${mensagemAviso[1]^^} ${1}"; exit 1 ;}
    echo $i


}
# Função para verificar a data atual para manda para o case já dinamicamente, através do awk
dataVerificar(){
    for ((d=0;d<=${#diaAnotificar[@]};d++)) ; do
        diasFaltante[d]=$(awk -v dia="${diaAnotificar[d]}" 'BEGIN{FS="-";OFS="-"}{dia = int($1-dia);mes = int($2+1);ano = int($3);print dia"-0"mes"-"ano}' <<< "${1}")
        #echo ${diasFaltante[d]}
    done
} # FUNCAO DATAVERIFICAR


for ((i=0;i<="${#listaPastaPush[@]}"-1;i++)) ; do

    sleep 2s
    enviandoPush "${listaPastaPush[i]}"
    echo "${listaPastaPush[i]}"
    #pwd
done

notificar '385910829' "\`${mensagemAviso[0]^^}\`" # Se tudo for um sucesso a notificação será enviada
dataVerificar "${dataAtual}"
echo ${diasFaltante[0]}
echo ${diasFaltante[1]}
echo ${diasFaltante[3]}
echo ${diasFaltante[4]}
exit
case "${dataAtual}" in
    "${diasFaltante[0]}")
        notificar '385910829' "\`${mensagemAvisoToken[0]^^}\`"
    ;;
    "${diasFaltante[1]}")
        notificar '385910829' "\`${mensagemAvisoToken[1]^^}\`"
    ;;
    "${diasFaltante[2]}")
        notificar '385910829' "\`${mensagemAvisoToken[2]^^}\`"
    ;;
    "${diasFaltante[3]}")
        notificar '385910829' "\`*${mensagemAvisoToken[3]^^} ${dataAtual}*\`"
    ;;
    *)
        notificar '385910829' "\`Não se preocupe seu token git está de boa\`"
    ;;

esac
# TESTE 1
