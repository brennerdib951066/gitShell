#!/usr/bin/env bash

api='MzJiNzY4OTktNzA0Ni00MDcxLTg4ZWMtOWQ2N2NlMGFmYTM5Ok5JUWQwMHZyTExOK2ZFZ2EyYXhtUHc9PQ=='
status='conexão'
programas=(
    'ping'
    'curl'
)

# Verificações
if [[ $# -lt 2 ]]; then
    printf "%s\n%s\n"\
    "AJUDA:"\
    "------------------------------------"\
    "t.sh nomeContato numeroContato"\
    "------------------------------------"
    exit
fi
# Verifiacando se é root
((UID==0)) && { echo $'\E[31;1mNada de ROOT\E[m'; exit;}

# Verificando a instalação de programas
for ((i=0;i<${#programas[@]};i++)); do
     ! type -P "${programas[i]}" &>- && { echo -e "\E[31;2mPor favor instale o '${programas[i]^^}' para continuar!\E[m"; exit;}
done

# Verificando se o pc esta com acesso a internet
! ping -c 1 google.com.br &>/dev/null && { echo $'\E[31;3mNão encontrei conexão com internet!\E[m'  ;exit;}


[[ ${3} ]] &&\
case "${3}" in
    [cC]onexão)  status='conexão'
    ;;
    [Qq]ualificação)  status='qualificação'
    ;;
    *) { echo $'\E[36;1mPor favor use:\E[m\nCONEXÃO ou QUALIFICAÇÃO'; exit;}
esac



{ echo $'\E[33;2m👤 Criando o contato...\E[m'; sleep 1;}
idContato=$(awk 'BEGIN{FS=":"}{gsub(/"|,.*/,"",$0);print $2}' <<< $(curl -sX POST 'https://app.bolten.io/contact/api/v1/08286680-edb5-42f0-a275-42ebc75383ff/contacts' -H 'Content-Type: Application/json' -H "Authorization: Bearer ${api}" -d '{ "attributes": { "Nome": "'${1}'","Telefone": "'${2}'"} }'))

# Verificando se a variavel idCOntato esta vazio, se tiver algo deu errado!
[[ ! "${idContato}" ]] && { echo $'\E[31;2mErro ao criar seu IDCONTATO\E[m'; exit ;}

{ echo $'\E[33;1m🧑 Criando o Funil...\E[m'; sleep 1;}
curl -s POST 'https://app.bolten.io/kanban/api/v1/9e62ab95-e915-4f2d-a7bf-3b7a8a0932f1/opportunities'\
    -H 'Content-Type: Application/json'\
    -H "Authorization: Bearer ${api}"\
    -d '{
                "attributes":{
                    "Título": "'${1}'",
                    "Status": "'${status^}'",
                    "Contato": "'${idContato}'"
                }
        }' &>- || { echo $'\E[31;1mErro ao criar no funil do bolten\E[m'; exit;}

echo -e "\E[32;1m'👤 ${1^^}' 📞 '${2}', criado com sucesso na '${status^^}'\E[m"
