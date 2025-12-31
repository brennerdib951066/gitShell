#!/usr/bin/env -S bash
#setxkbmap -layout br

# Testando python
areaDeTrabalho="$(xdg-user-dir DESKTOP)"
diretorioPythonBase="$areaDeTrabalho/gitPy"

sleep 1

status=(
    'desligouNaCara'
    'jaTemPlano'
    'contatoErrado'
    'mudo'
    'semInteresse'
    'atendeu'
)

comentarios=(
    'desligou na cara'
    'ja tem plano'
    'contato errado'
    'mudo'
    'sem interesse'
    'atendeu'
)

# Verificando se existe paramtro na linha de comando

[[ "${1:?$(echo $'\E[31;2mPor favor envie paramentro 1\E[m')}" ]] || exit

# Verificando se existe o primeiro argumento mandado na lista correspondente a status
grep -qiwE "${1}" <<< ${status[@]} || { echo $'\E[37;1mEnvie como paramentro ${1}: ['"${status[@]}"']'; exit ;}
#[[ "${1}" =~ "${status[@]//^${1}$/"asdasd"}" ]] && { echo "contem"; exit ;}

for ((i=0;i<${#status[@]};i++)) ; do
    #echo -e "Aqui é a lista: ${status[i]}"

    # Se o comentario conter o semInteresse ele escreve
    [[ "${status[i]}" == ${status[4]} ]] && { xdotool type --delay 150 "# ${comentarios[i]^}" ; python3 "$diretorioPythonBase/clicarStatus.py" "${status[i]}" ; continue;}

    [[ "${1}" == ${status[i]} ]] && { xdotool type --delay 150 "# ${comentarios[i]^}"
    python3 "$diretorioPythonBase/clicarStatus.py" "${status[i]}" ; }

    sleep 1s

done

# xdotool type --delay 100 "brennerbne@gmail.com"
# sleep 2
# xdotool key Return





