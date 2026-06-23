#! /usr/bin/env bash

declare -A programaDesktop

programaDesktop=(
    ['barrier']='Ctrl+Alt+B'
    ['com.obsproject.Studio']='Ctrl+Alt+O'
    ['org.flameshot.Flameshot']='Ctrl+Alt+F'
    ['org.kde.isoimagewriter']='Ctrl+Alt+I'
    ['org.kde.kate']='Ctrl+Alt+K'
    ['org.kde.kcalc.desktop']='Ctrl+Alt+C'
    ['org.kde.kdeconnect.app']='Ctrl+Alt+N'
    ['org.kde.plasma-systemmonitor']='Ctrl+Alt+M'
    ['peek']='Ctrl+Alt+P'
    ['libreoffice-calc']='Ctrl+Alt+L'
    ['youtube']='Ctrl+Alt+Y'
)
diretorioConfig="$HOME/.config"
arquivoGlobal="$diretorioConfig/kglobalshortcutsrc"
programaNecessario=(
    'notify-send'
    'barrier'
    'flameshot'
    'genisoimage'
    'peek'
)
# Criando os atalhos no arquivo de atalho

for ((i=0;i < ${#programaNecessario[@]};i++)); do
    if ! type -P ${programaNecessario[i]} >/dev/null; then
        ((i==0)) && { programaNecessario[0]='libnotify-bin' ;}
        sudo apt install ${programaNecessario[i]} -y
    fi

done

# Retomando o valor padrão desse array
programaNecessario[0]='notify-send'

for programa in "${!programaDesktop[@]}"; do
     echo ${programaDesktop[$programa]}
     if ! cat >> "$arquivoGlobal" << EOF
[${programa}.desktop]
_launch=${programaDesktop[$programa]},none,${programa}.desktop

EOF
    then
        echo "Erro"
        exit
    fi
done
if ! systemctl --user restart plasma-kglobalaccel.service; then
    notify-send -u critical -t 6000 "Erro para adicionar seus arquivos no serviço de atalhos"
    exit
fi
echo -e "Atalhos cadastrados com sucesso!"
#echo ${prgramaDesktop[barrier]}
