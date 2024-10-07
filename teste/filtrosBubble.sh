#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="notificarWhatsApp.txt"
dataAtual="$(date +%Y-%m-%d)"
dataAnterior="$(date -d '-1 days' +%Y-%m-%d)"
diaDaSemana=$(date +%A)
dataAtualMaisUm="$(date -d '1 days' +%Y-%m-%d)"
headerText='brenner'
listaPerguntas=('micaelly ramos' 'thales ramalho' 'lais morais' 'nathália santos' 'calebe pascoal/césar/df' 'jully isabelle/pos vendas')
listaPerguntasReceber=('receber aqui no konsole' 'receber no whatsapp')
interativo='brenner'
versao='brenner'

# INICIO DAS FUNÇÕES
receberNoKonsole(){
    echo -e "\E[42;1mNa data atual ${requisicao^^} registrou\E[m \E[41;1m$((${count#*:}))\E[m"
}

enviarPeloServidor(){	
	dataBrasil=$(awk -F- '{print $3"-"$2"-"$1}' <<<$dataAtual)
	local totalDeVendas=(

	) # lista vazia para receber o valor total das vendas
	local notificarBrenner=(

	)
	local notificarDenner=(

	)
	local textoTopo='brenner'
   { echo "Chamando o servidor para enviar a notificação"; sleep 2s ; }
    #notificar "${idsBot[0]}" "AQUI ESTÁ O RELETÓRIO DE HOJE: (${diaDaSemana^^},${dataBrasil})"
    #notificar "${idsBot[1]}" "AQUI ESTÁ O RELETÓRIO DE HOJE: (${diaDaSemana^^},${datBrasil})"
    for i in "${!listaPerguntas[@]}"; do
        #sleep 2s
        echo "${listaPerguntas[i]}"
        count=$(curl -G -H "Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a" --data-urlencode 'constraints=[{"key":"gerente","constraint_type":"equals","value": "'"${listaPerguntas[i]}"'"},{"key":"Created Date","constraint_type":"greater than","value":"'"${dataAtual}"'T00:00:00Z"},{"key":"Created Date","constraint_type":"less than","value":"'"${dataAtualMaisUm}"'T00:00:00Z"}]' 'https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados' 2>- | awk -F':' 'gsub(/[ ",]/,"",$0)&& /count/ {print}')
        totalDeVendas[$i]=${count#*:} #$((${count#*:}))
        echo 'VALOr ATUAL '${totalDeVendas[$i]}''
        #sleep 5s
        for ((id=0;id<=1;id++)); do
            echo $'O ID É AGORA: '${id}''
            [[ ${id} -eq 0 ]] && notificarBrenner[i]=${count#*:}
            [[ ${id} -eq 1 ]] && notificarDenner[i]=${count#*:}
            #notificar "${idsBot[id]}" "${listaPerguntas[i]}, registrou: $((${count#*:}))"
        done
        echo "Todos venderam $((totalDeVendas[0]+totalDeVendas[1]+totalDeVendas[2]+totalDeVendas[3]+totalDeVendas[4]))"
        #echo "Todos venderam ${totalDeVendas[0]} ${totalDeVendas[1]} ${totalDeVendas[2]} ${totalDeVendas[3]}${totalDeVendas[4]}"
    done

echo $'o brenner recebe '${notificarBrenner[@]}''
echo $'o DENNER recebe '${notificarDenner[@]}''
tipoTexto='brenner'
campanha='brenner'

#$(notificar 2>-)
echo -e "\E[31;1m IDBOT: ${idsBot[0]}  \E[m"
    for ((i=0;i<=${#idsBot[@]}-2;i++)); do
        notificar "${idsBot[i]}" "${textoTopo^^}\n\n*${listaPerguntas[0]^^}*\n${notificarBrenner[0]}\n\n*${listaPerguntas[1]^^}*\n${notificarBrenner[1]}\n\n*${listaPerguntas[2]^^}*\n${notificarBrenner[2]}\n\n*${listaPerguntas[3]^^}*\n${notificarBrenner[3]}\n\n*${listaPerguntas[4]^^}*\n${notificarBrenner[4]}\n\n_TOTAL: $((totalDeVendas[0]+totalDeVendas[1]+totalDeVendas[2]+totalDeVendas[3]+totalDeVendas[4]))_\n\n\nVERSÃO: ${versao}"
        echo $i
    done

notificar "${idsBot[0]}" "${textoTopo^^}\n\n*${listaPerguntas[0]^^}*\n${notificarDenner[0]}\n\n*${listaPerguntas[1]^^}*\n${notificarDenner[1]}\n\n*${listaPerguntas[2]^^}*\n${notificarDenner[2]}\n\n*${listaPerguntas[3]^^}*\n${notificarDenner[3]}\n\n*${listaPerguntas[4]^^}*\n${notificarDenner[4]}\n\nTOTAL: _$((totalDeVendas[0]+totalDeVendas[1]+totalDeVendas[2]+totalDeVendas[3]+totalDeVendas[4]))_\n\n\nVERSÃO: ${versao}"

}
###############################################################
read -t 10 -p "você está no modo interativo ${interativo^^},Deseja mudar [S/n]" mudancaInterativo
[[ "${mudancaInterativo}" =~ (sim|SIM|s|S) ]] && interativo='brenner'
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


