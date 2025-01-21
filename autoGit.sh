#!/usr/bin/env bash


# versao='1.0.1' foi adicionado a variavel datasExpiracao para verificar a expiração do token atual
# versao='1.0.1' foi adicionado a case a verificação se a data passar do dia 19, ele enviará uma mensagem via whatsApp para dizer que expirou o token

arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"

dataAtual=$(date +%d-%m-%Y)
datasExpiracao=(
    '15-02-2025'
    '16-02-2025'
    '17-02-2025'
    '18-02-2025'
)
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
diaAnotificar='3'
# Lista que receberá as pastas onde já tem todo o processo de git push configurado
listaPastaPush=(
    'gitAwk'
    'gitMarkdown'
    'gitPy'
    'gitShell'
    'gitVbs'
)
versao='1.0.1'

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
    awk -v dia="${diaAnotificar}" 'BEGIN{FS="-";OFS="-"}{dia = int($1-dia);mes = int($2+1);ano = int($3);print dia"-0"mes"-"ano}' <<< "${1}"
}


for ((i=0;i<="${#listaPastaPush[@]}"-1;i++)) ; do

    sleep 2s
    enviandoPush "${listaPastaPush[i]}"
    echo "${listaPastaPush[i]}"
    #pwd
done

notificar '385910829' "\`${mensagemAviso[0]^^}\`" # Se tudo for um sucesso a notificação será enviada
#dataAtualAwk=$(dataVerificar )
#echo -e "\E[31;1m$dataAtualAwk\E[m"
#exit
case "${dataAtual}" in
    "${datasExpiracao[0]}")
        notificar '385910829' "\`${mensagemAvisoToken[0]^^}\`"
    ;;
    "${datasExpiracao[1]}")
       notificar '385910829' "\`${mensagemAvisoToken[1]^^}\`"
    ;;
    "${datasExpiracao[2]}")
        notificar '385910829' "\`${mensagemAvisoToken[2]^^}\`"
    ;;
    "${datasExpiracao[3]}")
        notificar '385910829' "\`*${mensagemAvisoToken[3]^^} ${dataAtual}*\`"
    ;;
    *)
        diaData=$(awk 'BEGIN {FS="-";OFS="-"}{dia = int($1); print $1}' <<< "${dataAtual}")
        mesData=$(awk 'BEGIN {FS="-";OFS="-"mes = int($1); print $2}' <<< "${dataAtual}")
        #notificar '385910829' "\`Não se preocupe seu token git está de boa\`"
        [[ "${diaData}" -ge 20 && "${mesData}" -ge 2 ]] && notificar '385910829' "\`Seu token ${tokenAtual} expirou\`" ||\
        notificar '385910829' "\`Token ainda é valido\`"
    ;;

esac
# TESTE 1
