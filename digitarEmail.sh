#!/usr/bin/env -S bash

# Version: 1.0.3

#setxkbmap -layout br

# Testando python
areaDeTrabalho="$(xdg-user-dir DESKTOP)"
diretorioPythonBase="$areaDeTrabalho/gitPy"
plataforma=$(awk 'BEGIN {FS="="}$1 ~ /^ID$/ {plataforma = tolower($2); print plataforma}' /etc/os-release)
# status=(
#     'desligouNaCara'
#     'jaTemPlano'
#     'contatoErrado'
#     'mudo'
#     'semInteresse'
#     'atendeu'
#     'listaNegra'
# )
#
# comentarios=(
#     'desligou na cara'
#     'ja tem plano'
#     'contato errado'
#     'mudo'
#     'sem interesse'
#     'atendeu'
#     'lista Negra, nunca ligar!'
# )

declare -A testeDimensional=(
    [desligouNaCara]='desligou na cara'
    [jaTemPlano]='ja tem plano'
    [contatoErrado]='contato errado'
    [mudo]='mudo'
    [semInteresse]='sem interesse'
    [atendeu]='atendeu'
    [listaNegra]='lista Negra, nunca ligar!'
)

# Verificando se o usuario esta como root
((UID==0)) && { echo $'\E[31;1mNão usa-me como admistrador!\E[m'; exit ;}

# Verificando se existe paramtro na linha de comando

[[ "${1:?$(echo -e $'\E[31;1mPor favor use um desses parametros:\E[m\n\E[31;2m'${!testeDimensional[@]}'\E[m\E[m')}" ]] || exit

# Verificando se o diretorio padrao do PY existe!
[[ -d "${diretorioPythonBase}" ]] || { echo $'\E[31;1mO diretorio base do python não está no PC!\E[m'; exit; }

[[ "${plataforma}" ]] || { echo -e "\E[34;1mNão achei no arquivo realease o tipo de sistema!\E[m"; exit ;}

# Vericando se o xdotool esta instalado
type -P 'xdotool' >/dev/null || {
    printf '%b %s' '\e[34;1mO XDOTOOL não está instalado\e[m'
    read -p 'INSTALAR[s/n]: ' instalarXdotool
    [[ ${instalarXdotool} ]] || instalarXdotool='s'
    case "${instalarXdotool}" in
        's')
            [[ "${plataforma}" =~ ubuntu|debian ]] && {
                sudo apt install xdotool
                clear
            }
        ;;
        'n')
            echo "Preciso do xdotool instalado!"
            exit
        ;;
        *)
            echo "Escolha S para instalar ou n para sair"
            exit
        ;;
    esac
}


# Verificando se existe o primeiro argumento mandado na lista correspondente a status
grep -qiwE "${1}" <<< ${!testeDimensional[@]} || {
    echo $'\E[37;1mEnvie como paramentro ${1}: ['"${!testeDimensional[@]}"']'
    exit
}

sleep 1s

for ((i=0;i<"${#testeDimensional[@]}";i++)); do
    dimensaoAtual=$(cut -d' ' -f "$((i+1))" <<< "${!testeDimensional[@]}")
    [[ "${dimensaoAtual}" == ${1} && "${dimensaoAtual}" == "semInteresse" ]] && { echo -e "\E[31;1m${testeDimensional[$dimensaoAtual]^}\E[m"; xdotool type --delay 150 "# ${testeDimensional[$dimensaoAtual]^}" ; python3 "$diretorioPythonBase/clicarStatus.py" "${dimensaoAtual}" "0.8" ; continue;}

    [[ "${dimensaoAtual}" == ${1} ]] && { xdotool type --delay 150 "# ${testeDimensional[$dimensaoAtual]^}" ; python3 "$diretorioPythonBase/clicarStatus.py" "${dimensaoAtual}" "0.7" ; }
done
