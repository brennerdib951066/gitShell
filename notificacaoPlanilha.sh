#!/usr/bin/env bash

######################################### HEADER ######################################################################
# Nome         = 'Brenner Santos'
# Categoria    = 'Notificação'
# Versão       = '1.0.0.0.0'

# OBJETIVO
# Tem o objetivo de notificar o usuário que opera o sistema operacional, se houver alterações em planilha do google
# Nesta notificação deve conter informações sobre o total de vendas que lá contem

######################################################################################################################


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"

relatorio() {
    while :; do
        sleep 50s
        qtdDeLinhas=$(awk 'BEGIN { FS = ":" };$0 ~ /rowCount/ { gsub(/ |,/,"",$0); print $2}' <<<"$(curl -X GET https://sheets.googleapis.com/v4/spreadsheets/$1?key=$2 2>-)")
        colunaAdesao="$(curl -s -X GET https://sheets.googleapis.com/v4/spreadsheets/${1}/values/Y2:Y?key=${2})"
        colunaPlanos="$(curl -s -X GET https://sheets.googleapis.com/v4/spreadsheets/${1}/values/Z2:Z?key=${2})"

        # Quantidade total de somatoria das colunas correspondentes
        qtdTotalAdesao=$(awk '/^[0-9]/{gsub(/,/,".",$0); qtd += $0}END {printf "%.2f\n",qtd}' <<< $(sed -E 's/\[|\]|\{|\}| +|"|//g'  <<< "${colunaAdesao}"))
        qtdTotalPlanos=$(awk '/^[0-9]/{gsub(/,/,".",$0); qtd += $0}END {printf "%.2f\n",qtd}' <<< $(sed -E 's/\[|\]|\{|\}| +|"|//g'  <<< "${colunaPlanos}"))


        mapfile -t baseArquivoLinha < ~/"Área de Trabalho/txt/totalPlanilha.txt"
        if [[ ${#baseArquivoLinha[@]} -ge 1 && ${qtdDeLinhas} -gt ${baseArquivoLinha} ]];then
            sleep 1s
            echo $qtdDeLinhas > ~/"Área de Trabalho/txt/totalPlanilha.txt"
            #notify-send -t 5000 -u critical "RELATÓRIO NA ÁREA" "A quantidade é de ${qtdDeLinhas}"
            mpv '/home/brenner/Área de Trabalho/notificacao/dione.wav'
            sleep 2s
            notify-send -t 5000 -u critical -i 'iconeNotificacao.png' "RELATÓRIO" "O total de planos = <b>\"${qtdTotalPlanos}\"</b>\n\nO total de adesão = <b>\"${qtdTotalAdesao}\"</b>"
            #mpv '/home/brenner/Área de Trabalho/notificacao/dione.wav'
            #sleep 10s
        else
            echo -e $'\E[31;1mOpah não é igual ou maio que 1\E[m'
        fi

    done

}
relatorio '1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc' 'AIzaSyAPaCtTnZB-MGHxtjlOhlipvKmGQdnNY3k'
