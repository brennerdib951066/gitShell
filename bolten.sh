#!/usr/bin/env bash

api='MzJiNzY4OTktNzA0Ni00MDcxLTg4ZWMtOWQ2N2NlMGFmYTM5Ok5JUWQwMHZyTExOK2ZFZ2EyYXhtUHc9PQ=='
status='conexão'
if [[ $# -lt 2 ]]; then
    printf "%s\n%s\n"\
    "AJUDA:"\
    "------------------------------------"\
    "t.sh nomeContato numeroContato"\
    "------------------------------------"
    exit
fi

[[ ${3} ]] &&\
case "${3}" in
    'Conexão')  status='conexao'
    ;;
    'Qualificação')  status='qualificação'
    ;;
    *) { echo $'\E[36;1mPor favor use:\E[m\nCONEXÃO ou QUALIFICAÇÃO'; exit;}
esac



idContato=$(awk 'BEGIN{FS=":"}{gsub(/"|,.*/,"",$0);print $2}' <<< $(curl -X POST 'https://app.bolten.io/contact/api/v1/08286680-edb5-42f0-a275-42ebc75383ff/contacts' -H 'Content-Type: Application/json' -H "Authorization: Bearer ${api}" -d '{ "attributes": { "Nome": "'${1}'","Telefone": "'${2}'"} }'))
export idContato
sleep 2s
curl -s POST 'https://app.bolten.io/kanban/api/v1/9e62ab95-e915-4f2d-a7bf-3b7a8a0932f1/opportunities'\
    -H 'Content-Type: Application/json'\
    -H "Authorization: Bearer ${api}"\
    -d '{
                "attributes":{
                    "Título": "'${1}'",
                    "Status": "'${status^}'",
                    "Contato": "'${idContato}'"
                }
        }'
