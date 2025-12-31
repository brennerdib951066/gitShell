#!/usr/bin/env -S bash

# Version: 1.0.1

#setxkbmap -layout br

# Testando python
areaDeTrabalho="$(xdg-user-dir DESKTOP)"
diretorioPythonBase="$areaDeTrabalho/gitPy"

status=(
    'desligouNaCara'
    'jaTemPlano'
    'contatoErrado'
    'mudo'
    'semInteresse'
    'atendeu'
    'listaNegra'
)

comentarios=(
    'desligou na cara'
    'ja tem plano'
    'contato errado'
    'mudo'
    'sem interesse'
    'atendeu'
    'lista Negra, nunca ligar!'
)

declare -A testeDimensional
testeDimensional=(
    [desligouNaCara]='desligou na cara'
    [jaTemPlano]='ja tem plano'
    [contatoErrado]='contato errado'
    [mudo]='mudo'
    [semInteresse]='sem interesse'
    [atendeu]='atendeu'
    [listaNegra]='lista Negra, nunca ligar!'
)

# Verificando se existe paramtro na linha de comando

[[ "${1:?$(echo $'\E[31;2mPor favor envie paramentro 1\E[m')}" ]] || exit

# Verificando se existe o primeiro argumento mandado na lista correspondente a status
grep -qiwE "${1}" <<< ${status[@]} || { echo $'\E[37;1mEnvie como paramentro ${1}: ['"${status[@]}"']'; exit ;}

sleep 1s

for ((i=0;i<"${#testeDimensional[@]}";i++)); do
    dimensaoAtual=$(cut -d' ' -f "$((i+1))" <<< "${!testeDimensional[@]}")
    [[ "${dimensaoAtual}" == ${1} && "${dimensaoAtual}" == "semInteresse" ]] && { echo -e "\E[31;1m${testeDimensional[$dimensaoAtual]^}\E[m"; xdotool type --delay 150 "# ${testeDimensional[$dimensaoAtual]^}" ; python3 "$diretorioPythonBase/clicarStatus.py" "${dimensaoAtual}" "0.8" ; continue;}

    [[ "${dimensaoAtual}" == ${1} ]] && { xdotool type --delay 150 "# ${testeDimensional[$dimensaoAtual]^}" ; python3 "$diretorioPythonBase/clicarStatus.py" "${dimensaoAtual}" "0.7" ; }
done

# for ((i=0;i<${#status[@]};i++)) ; do
#     #echo -e "Aqui é a lista: ${status[i]}"
#
#     # Se o comentario conter o semInteresse ele escreve
#     [[ "${status[i]}" == ${status[4]} && "${1}" == ${status[4]} ]] && { xdotool type --delay 150 "# ${comentarios[i]^}" ; python3 "$diretorioPythonBase/clicarStatus.py" "${status[i]}" "0.8" ; continue;}
#
#     [[ "${1}" == ${status[i]} ]] && { xdotool type --delay 150 "# ${comentarios[i]^}"
#     python3 "$diretorioPythonBase/clicarStatus.py" "${status[i]}" "0.7" ; }
#
#     sleep 0.5s
#
# done

# xdotool type --delay 100 "brennerbne@gmail.com"
# sleep 2
# xdotool key Return





