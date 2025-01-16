#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
dataAtual="$(date +%Y-%m-%d)"
dataAnterior="$(date -d '-1 days' +%Y-%m-%d)"
diaDaSemana=$(date +%A)
dataAtualMaisUm="$(date -d '1 days' +%Y-%m-%d)"
headerText='menu get bubble tipo de cliente'
listaPerguntas=('micaelly ramos' 'thales ramalho' 'lais morais' 'nathália santos' 'calebe pascoal/césar/df' 'jully isabelle/pos vendas')
listaPerguntasReceber=('receber aqui no konsole' 'receber no whatsapp')
interativo='no'
teste='sim'
versao='1.0.5'
tipoDeVersao=(
    'beta'
    'completa'
)
# Na versão 1.0.2 foram adicionados adesão por cada gerente, adesão completo calculando todos os gerentes
# Na versão 1.0.3 foram adicionados está modo itálico o total de adesão, e modo negrito para os texto versão, adicioanado também a variavél tipoDeVersao
# Na versão 1.0.4 foi adicionado uma sintaxe de visualização no whatsapp onde a letra será destacado em branco, adicionado no total de vendas, total de adesão
# Na versão 1.0.5 foi adicionado na variavél count que busca a quantidade vendas do dia, agora faz outro filtro para buscar somente os não deletados

# INICIO DAS FUNÇÕES
receberNoKonsole(){
    echo -e "\E[42;1mNa data atual ${requisicao^^} registrou\E[m \E[41;1m$((${count#*:}))\E[m"
}

enviarPeloServidor(){
        dataBrasil=$(awk -F- '{print $3"-"$2"-"$1}' <<<$dataAtual)
        local totalDeVendas=(

        ) # lista vazia para receber o valor total das vendas
        local totalDeValorDeAdesao=(

        ) # lista vazia para receber o valor total das vendas
        local notificarBrenner=(

        )
        local notificarDenner=(

        )
        local notificarDaniele=(

        )
        local textoTopo='registro de etiquetas viver bem seguros *('$dataBrasil')*'
   { echo "Chamando o servidor para enviar a notificação"; sleep 2s ; }
    #notificar "${idsBot[0]}" "AQUI ESTÁ O RELETÓRIO DE HOJE: (${diaDaSemana^^},${dataBrasil})"
    #notificar "${idsBot[1]}" "AQUI ESTÁ O RELETÓRIO DE HOJE: (${diaDaSemana^^},${datBrasil})"
    for i in "${!listaPerguntas[@]}"; do
        #sleep 2s
        echo "${listaPerguntas[i]}"
        count=$(curl -G -H "Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a" --data-urlencode 'constraints=[{"key":"gerente","constraint_type":"equals","value": "'"${listaPerguntas[i]}"'"},{"key":"Created Date","constraint_type":"greater than","value":"'"${dataAtual}"'T00:00:00Z"},{"key":"Created Date","constraint_type":"less than","value":"'"${dataAtualMaisUm}"'T00:00:00Z"},{"key":"deletee","constraint_type":"equals","value":"não"}]' 'https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados' 2>- | awk -F':' 'gsub(/[ ",]/,"",$0)&& /count/ {print}')

        valorAdesao=$(curl -G -H "Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a" --data-urlencode 'constraints=[{"key":"gerente","constraint_type":"equals","value": "'"${listaPerguntas[i]}"'"},{"key":"Created Date","constraint_type":"greater than","value":"'"${dataAtual}"'T00:00:00Z"},{"key":"Created Date","constraint_type":"less than","value":"'"${dataAtualMaisUm}"'T00:00:00Z"},{"key":"deletee","constraint_type":"equals","value":"não"}]' 'https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados' 2>- | awk -F':' 'gsub(/[ ",]/,"",$0)&& /valorDaAdesao/ {gsub(/[A-Za-z:]/,"",$0);valorDaAdeso += $0}END{print valorDaAdeso}')
        #vidas=$(curl -G -H "Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a" --data-urlencode 'constraints=[{"key":"gerente","constraint_type":"equals","value": "'"${listaPerguntas[i]}"'"},{"key":"Created Date","constraint_type":"greater than","value":"'"${dataAtual}"'T00:00:00Z"},{"key":"Created Date","constraint_type":"less than","value":"'"${dataAtualMaisUm}"'T00:00:00Z"},{"key":"deletee","constraint_type":"equals","value":"não"},{"key":"qtds.VIdas","constraint_type":"greater than","value":"0"}]' 'https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados' 2>- | awk -F':' 'gsub(/[ ",]/,"",$0)&& /qtds.VIdas/ {gsub(/[A-Za-z:]/,"",$0);vidas += $0}END{print vidas}')
        vidas=$(curl -G -H "Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a" --data-urlencode 'constraints=[{"key":"gerente","constraint_type":"equals","value": "'"${listaPerguntas[i]}"'"},{"key":"Created Date","constraint_type":"greater than","value":"'"${dataAtual}"'T00:00:00Z"},{"key":"Created Date","constraint_type":"less than","value":"'"${dataAtualMaisUm}"'T00:00:00Z"},{"key":"deletee","constraint_type":"equals","value":"não"},{"key":"qtds.VIdas","constraint_type":"greater than","value":"0"}]' 'https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados' 2>- | awk -F':' 'gsub(/[ ",.]/,"",$0)&& /qtdsVIdas/ {gsub(/[A-Za-z:]/,"",$0);vida += $0}END{print vida}')
        echo "VIDAS $vidas"
        echo "TOTAL: ${valorAdesao}"
        #sleep 5s
        totalDeVendas[$i]=${count#*:} #$((${count#*:}))
        totalDeValorDeAdesao[$i]=${valorAdesao}
        totalDeVidas[$i]=${vidas}

        echo 'VALOr ATUAL '${totalDeVendas[$i]}''
        #sleep 5s
        for ((id=0;id<=2;id++)); do
            echo $'O ID É AGORA: '${id}''
            [[ ${id} -eq 0 ]] && notificarBrenner[i]=${count#*:}
            [[ ${id} -eq 1 ]] && notificarDenner[i]=${count#*:}
            [[ ${id} -eq 2 ]] && notificarDaniele[i]=${count#*:}
            #notificar "${idsBot[id]}" "${listaPerguntas[i]}, registrou: $((${count#*:}))"
        done
        echo "Todos venderam $((totalDeVendas[0]+totalDeVendas[1]+totalDeVendas[2]+totalDeVendas[3]+totalDeVendas[4]))"
        #echo "Todos venderam ${totalDeVendas[0]} ${totalDeVendas[1]} ${totalDeVendas[2]} ${totalDeVendas[3]}${totalDeVendas[4]}"
    done

echo $'o brenner recebe '${notificarBrenner[@]}''
echo $'o DENNER recebe '${notificarDenner[@]}''
tipoTexto='custom'
campanha='centralDeAtendimento'
# Calculando o valor total de todos os gerentes em relação a adesão
totalAdesao=$(
    awk -F',' -v adesao1=${totalDeValorDeAdesao[0]} -v adesao2=${totalDeValorDeAdesao[1]} -v adesao3=${totalDeValorDeAdesao[2]} -v adesao4=${totalDeValorDeAdesao[3]} -v adesao5=${totalDeValorDeAdesao[4]} -v adesao6=${totalDeValorDeAdesao[5]} 'BEGIN {print adesao1+adesao2+adesao3+adesao4+adesao5+adesao6}'
)

totalVidas=$(
    awk -F',' -v vida1=${totalDeVidas[0]} -v vida2=${totalDeVidas[1]} -v vida3=${totalDeValorDeAdesao[2]} -v vida4=${totalDeVidas[3]} -v vida5=${totalDeVidas[4]} -v vida6=${totalDeVidas[5]} 'BEGIN {print vida1+vida2+vida3+vida4+vida5+vida6}'
)
echo "VALOR TOTAL DE ADESAO PARA TODOS: ${totalAdesao}"
echo "TOTAL VIDAS: ${totalVidas}"

#sleep 10s
#$(notificar 2>-)
echo -e "\E[31;1m IDBOT: ${idsBot[0]}  \E[m"
    for ((i=0;i<=${#idsBot[@]}-1;i++)); do
        notificar "${idsBot[i]}" "${textoTopo^^}\n\n*${listaPerguntas[0]^^}*\n${notificarBrenner[0]}\n${totalDeValorDeAdesao[0]}\n\n*${listaPerguntas[1]^^}*\n${notificarBrenner[1]}\n${totalDeValorDeAdesao[1]}\n\n*${listaPerguntas[2]^^}*\n${notificarBrenner[2]}\n${totalDeValorDeAdesao[2]}\n\n*${listaPerguntas[3]^^}*\n${notificarBrenner[3]}\n${totalDeValorDeAdesao[3]}\n\n*${listaPerguntas[4]^^}*\n${notificarBrenner[4]}\n${totalDeValorDeAdesao[4]}\n\n*${listaPerguntas[5]^^}*\n${notificarBrenner[5]}\n${totalDeValorDeAdesao[5]}\n\n_TOTAL DE VENDAS:_  *\`$((totalDeVendas[0]+totalDeVendas[1]+totalDeVendas[2]+totalDeVendas[3]+totalDeVendas[4]+totalDeVendas[5]))\`*\n_TOTAL VIDAS:_ *\`$((totalDeVidas[0]+totalDeVidas[1]+totalDeVidas[2]+totalDeVidas[3]+totalDeVidas[4]+totalDeVidas[5]))\`*\n_TOTAL ADESÃO: *\`R\$ ${totalAdesao}\`*_\n\n*VERSÃO: ${versao} \`${tipoDeVersao[0]^^}\`*"
        echo $i
    done
[[ "${teste,,}" == "sim" || "${1,,}" == 'teste' ]] && exit
# Aqui é para caso precise de receber
#notificar "${idsBot[0]}" "${textoTopo^^}\n\n*${listaPerguntas[0]^^}*\n${notificarBrenner[0]}\n\n*${listaPerguntas[1]^^}*\n${notificarBrenner[1]}\n\n*${listaPerguntas[2]^^}*\n${notificarBrenner[2]}\n\n*${listaPerguntas[3]^^}*\n${notificarBrenner[3]}\n\n*${listaPerguntas[4]^^}*\n${notificarBrenner[4]}\n\n*${listaPerguntas[5]^^}*\n${notificarBrenner[5]}\n\n_TOTAL: $((totalDeVendas[0]+totalDeVendas[1]+totalDeVendas[2]+totalDeVendas[3]+totalDeVendas[4]+totalDeVendas[5]))_\n\n\nVERSÃO: ${versao}"

}
###############################################################
read -t 10 -p "você está no modo interativo ${interativo^^},Deseja mudar [S/n]" mudancaInterativo
[[ "${mudancaInterativo}" =~ (sim|SIM|s|S) ]] && interativo='yes'
if [[ "${interativo}" = 'yes' ]]; then
    if [[ -z $1 ]]; then
        echo $'\E[37;1mOnde deseja receber o total de vendas dos gerentes:\E[m'
        PS3=$'\E[37;1mOPÇÃO:\E[m   '
        select menu in "${listaPerguntasReceber[@]^^}"; do
            case $REPLY in
                1) { echo -e "Escolheu receber em ${REPLY^}" ; receber="${listaPerguntasReceber[0]}"; break  ; }
                ;;
                2) { echo -e "Escolheu receber em ${REPLY^^}"; receber="${listaPerguntasReceber[1]}"; break ; }
            esac

        done
    else
            case $1 in
                1) { echo -e "Escolheu receber em ${REPLY^}"; receber="${listaPerguntasReceber[0]}" ; }
                ;;
                2) { echo -e "Escolheu receber em ${REPLY^^}"; receber="${listaPerguntasReceber[1]}"; }
            esac
    fi

    PS3=$'\E[36;1mOpção:\E[m   '
    echo "${headerText^^}"
    select menu in "${listaPerguntas[@]^^}"; do
        case $REPLY in
            1) { echo -e "\E[33;1mVoce escolheu ${REPLY} ${listaPerguntas[0]^}\E[m";  requisicao="${listaPerguntas[0]}"   ; break ;}
            ;;
            2) { echo -e "\E[33;1m Voce escolheu ${REPLY} ${listaPerguntas[1]^}\E[m"; requisicao="${listaPerguntas[1]}"   ; break ;}
            ;;
            3) { echo -e "\E[33;1m Voce escolheu ${REPLY} ${listaPerguntas[2]^}\E[m"; requisicao="${listaPerguntas[2]}"   ; break ;}
            ;;
            4) { echo -e "\E[33;1m Voce escolheu ${REPLY} ${listaPerguntas[3]^}\E[m"; requisicao="${listaPerguntas[3]}"   ; break ;}
            ;;
            5) { echo -e "\E[33;1m Voce escolheu ${REPLY} ${listaPerguntas[3]^}\E[m"; requisicao="${listaPerguntas[4]}"   ; break ;}
            ;;
            *) echo -e 'Escolha uma opção válida'
        esac
    done

    count=$(curl -G -H "Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a" --data-urlencode 'constraints=[{"key":"gerente","constraint_type":"equals","value": "'"${requisicao}"'"},{"key":"Created Date","constraint_type":"greater than","value":"'"${dataAtual}"'T00:00:00Z"},{"key":"Created Date","constraint_type":"less than","value":"'"${dataAtualMaisUm}"'T00:00:00Z"}]' 'https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados' 2>- | awk -F':' 'gsub(/[ ",]/,"",$0)&& /count/ {print}')

    if [[ "${receber}" == "${listaPerguntasReceber[0]}" ]]; then
        receberNoKonsole
    else
        source "${arquivoNotificacao}"
        notificar "${idsBot[1]}" "Na data atual ${requisicao^^} registrou $((1+${count#*:}))"
    fi
else
    sleep 5s
    source "${arquivoNotificacao}"

    enviarPeloServidor
fi

