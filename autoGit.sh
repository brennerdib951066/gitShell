#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
campanha='DIB'
arquivoDeErro=~/"Área de Trabalho/erroGit"
mensagemAviso=(
    'Seus arquivos foram enviados com sucesso para o github'
    'erro ao enviar arquivos para o github'
)
# Lista que receberá as pastas onde já tem todo o processo de git push configurado
listaPastaPush=(
    'gitAwk'
    'gitMarkdown'
    'gitPy'
    'gitShell'
    'gitVbs'
)
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

for ((i=0;i<="${#listaPastaPush[@]}"-1;i++)) ; do

    sleep 2s
    enviandoPush "${listaPastaPush[i]}"
    echo "${listaPastaPush[i]}"
    #pwd
done

notificar '385910829' "\`${mensagemAviso[0]^^}\`" # Se tudo for um sucesso a notificação será enviada
