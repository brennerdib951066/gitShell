#!/usr/bin/env -S bash -x

url='https://api.api4com.com/api/v1/users/login'

token=(
    'ny7Omg4rpWYj6ZdXPsCIWhE8tBGkj2pDMquVrq2PzbePTjrDJRlOohqRIhA5fAFK'
    '8ZeEm9eylvYJmbMmrRbxELVlTNTyokrbfbIpBkHbzJsFw4NJuj8Rq59r6dE361S6'
)

usuario=(
    'Denner'
    'Brenner'
)

ramal=(
    '1003'
    '1004'
)

data_json=(
    '{"email": "brennerbne@gmail.com","password": "652516"}'
    '{"email": "dnercred@gmail.com","password": "652516"}'
)

minutos="Minutagem API4com($(date +%d-%m-%Y))"$'\n\n'
dataAtual="$(date -u -d '-2 days' +"%Y-%m-%dT00:00:00.000Z")"
dataAmanha="$(date -u -d '+1 day'  +"%Y-%m-%dT23:59:59.999Z")"

for ((i=0;i<${#ramal[@]};i++)); do

    echo "🔐 Testando login do usuário ${usuario[i]}..."

    if ! curl -sf -X POST "$url" \
        -H 'Content-Type: application/json' \
        -H "Authorization: ${token[i]}" \
        -d "${data_json[i]}" > /dev/null; then

        echo -e "\E[31;1mErro ao efetuar o login no api4com (usuário ${usuario[i]})\E[m"
        continue
    fi

    echo "📞 Buscando chamadas do ramal ${ramal[i]}..."

    chamadas=$(curl -s -G 'https://api.api4com.com/api/v1/calls' \
        --data-urlencode 'filter={"where":{"from":"'"${ramal[i]}"'","duration":{"gt":30},"started_at":{"between":["'"${dataAtual}"'","'"${dataAmanha}"'"]}}}' \
        --data-urlencode 'page=1' \
        -H "Content-Type: application/json" \
        -H "Authorization: ${token[i]}" | jq -r '.data[] | .duration')

    soma=$(awk -v usuario="${usuario[i]}" '
        BEGIN { total=0 }
        { total += $1/60 }
        END { printf "%s\nTOTAL: %.2f\n", toupper(usuario), total }
    ' <<< "$chamadas")

    minutos+="$soma"$'\n\n'
    #totalMinutos+=$(awk 'BEGIN{FS=":"}{match($2,/([0-9]+.?)+/);print substr($2,RSTART,RLENGTH)}' <<< ${minutos})
    sleep 2
done

#echo "TOTAL MINUTOS ${totalMinutos}"
#exit

# 🔧 Escapar quebras para JSON (vira \\n)
mensagem=$(printf "%s" "$minutos")

# Criar JSON corretamente
json_msg=$(jq -Rn --arg v "$mensagem" '{type:"text", value:$v}')

echo "📨 Enviando mensagem ao BotConversa..."

curl -s -X POST \
  'https://backend.botconversa.com.br/api/v1/webhook/subscriber/385910829/send_message/' \
  -H 'accept: application/json' \
  -H 'API-KEY: c7e572f0-c17b-4304-9478-b68641234d6c' \
  -H 'Content-Type: application/json' \
  -d "$json_msg"

echo -e "\n✅ Finalizado!"
