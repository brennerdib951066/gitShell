# ~/.bashrc: executed by bash(1) for non-login shells

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias cls='clear'
    alias firefox="env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/firefox_firefox.desktop /snap/bin/firefox %u &>- &"
    alias apt='sudo apt update -y && sudo apt upgrade -y && sleep 3s'
    alias meuIp='awk -F" " '\''/192/ {gsub(/\/.*/,"",$0);print("IP LOCAL:",$2)}'\'' <<< $(ip -c a)'

fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias mp='mpv --fs'
alias sai='sudo apt install'
alias sar='sudo apt remove'
alias spb='scp '"$1"' brenner@84.46.241.156'
alias lll='ls '"$1"''
alias sshb='ssh brennersshb@31.220.88.74'
alias sshbd='ssh brenner@192.168.0.5'
alias sshdib='ssh dib@192.168.0.8'
alias sshd='ssh denner@31.220.88.74'
alias pipi='pip install --break-system-packages'
alias dataAtual='date +%d-%m-%Y'
alias planilhaNotificacao='google-chrome-stable --profile-directory=Brenner https://docs.google.com/spreadsheets/d/1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc/edit?gid=0#gid=0 &>- &'
alias gitinit='git init'
alias gitadd='git add '${1}''
#alias gitr
alias gitc='git commit -m '${1}''
alias gitp='git push -u origin main'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export nome="Brenner"
export senha="652516"

readonly nome senha
if [[ $? -eq 0 ]]; then
	PS1='⚫ \[\033[01;34m\]${USER^} $? :  '
else
	PS1='⚫ \[\033[02;31m\]${USER^} $? :  '
fi

fla(){
((UID==0)) && { printf $'\E[31;1mSem root\E[m'; exit 1 ;}
listaMenu=("Salvar Localmente" "Salvar Copy")

#while :; do
#	[[ "${diretorio}" ]] && break # Se "${diretorio}" não for vazio prossiga
#	read -p $'\E[32;2mDiretorio para a imagem\E[m:   ' diretorio
#done
PS3=$'\E[37;1mOpção:\E[m   '
#read -p $'\E[37;1m Nome do arquivo:\E[m   ' nomeArquivo

#/usr/bin/flameshot config -f ${nomeArquivo} ## Mudando o nome do arquivo quando salvar
select menu in "${listaMenu[@]}"; do
    case $REPLY in
        "1") /usr/bin/flameshot gui    &>- & ;;
        "2") /usr/bin/flameshot gui -c &>- & ;;
        *) printf "Não existe essa opção\n"
    esac
done

} #####################################################FUNÇÂO FLAMESHOT###################################

bubble(){
local listaBuble=("https://bubble.io/page?type=page&name=setor_administrativo&id=viverbemseguroscrm&tab=tabs-1"\
 "https://bubble.io/page?type=page&name=setor_administrativo&id=viverbemseguroscrm&tab=tabs-3&subtab=Data+Types&type_id=user"\
 "https://www.sistemaviverbemseguros.com/version-test"
)
    case $1 in
        bc|BC) google-chrome-stable --profile-directory="DIB" "${listaBuble[1]}" &>- &    ;;
        * ) google-chrome-stable --profile-directory="DIB"    "${listaBuble[@]}" &>- &    ;;
    esac

}

youtube(){
	youtube="https://www.youtube.com/"
	case $1 in
	  debxp) google-chrome-stable --profile-directory='Brenner' $youtube/'watch?v=w6o_d9N0sEk&list=PLXoSGejyuQGr_ZbyClFpnz8K3Or2jK9cG&index=5' &>- & ;;
	  *) google-chrome-stable --profile-directory='Brenner' $youtube &>- & ;;


	esac

}

telegram(){
	telegram="https://web.telegram.org/k/"
	google-chrome-stable --profile-directory='Brenner' $telegram &>- &
}

gpt(){
	gpt="https://chat.openai.com/c/5225c496-49bb-45ff-a308-b079f005d2cb"
	google-chrome-stable --profile-directory='Profile 1' $gpt &>- &
}

botConversa(){
	botConversa="https://app.botconversa.com.br/2547/audience"
	google-chrome-stable --profile-directory="DIB" "${botConversa}" &>- &
}

japao(){
imagem="/home/brenner/Downloads/123Japones.pdf"
until false; do
    read -p 'Pagina:  ' pagina
    [[ "$pagina" ]] && break
done

okular -p "${pagina}" ${imagem} &>- &
}

hastag(){
    arquivoPython='/Imagens/hastagLogin/login.py'
    url="https://portalhashtag.com/login"
    google-chrome-stable --profile-directory="DIB" $url &>- &

}

moises(){
	url='https://studio.moises.ai/library/'
	google-chrome-stable --profile-directory='Denilson' $url &>- &
}

email(){
	url='https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox'
	google-chrome-stable --profile-directory='DIB' $url &>- &
}

arquivo(){
shibangBase='#!/usr/bin/env bash'
shopt -s extglob

criandoShell(){

arquivoLogin='/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh'
arquivoCor='/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt'
arquivoNotificacao='/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt'
cat>>"${1}"<<EOF
${shibangBase}


arquivoLogin="${arquivoLogin}"
arquivoCor="${arquivoCor}"
arquivoNotificacao="${arquivoNotificacao}"
EOF
chmod +x "${1}" && kate "${1}" &>- &

}

criandoPython(){

tipoArquivoPython=$(zenity --title='PYTHON' --text='Deseja criar um arquivo PYTHON para usar o CUSTOMTKINTER?' --question --ok-label='SIM' --cancel-label='Não')

if [[ $? -gt 0 ]]; then

cat>>"${1}"<<EOF
${shibangBase/bash/python3}


import pyautogui as bot
from time import sleep as s
import webbrowser as web
import requests as api
import flet as ft

EOF
chmod +x "${1}" && kate "${1}" &>- &


else
cat >>"${1}"<<'EOF'
#!/usr/bin/python3


import pyautogui as bot
from time import sleep as s
import webbrowser as web
import requests as api
import flet as ft
import customtkinter as ct
import subprocess as cmd

janela = ct.CTk()
janela.title('Testando shell')
janela.geometry('400x350')
janela.resizable(False,False)

botao = ct.CTkButton(
    janela,
    text = 'CHAMAR ZENITY',
    height= 45,
    command = shellZenity

)

botao.pack()
janela.mainloop()

EOF

chmod +x "${1}" && kate "${1}" &>- &

fi
}


criandoAwk(){

cat>>"${1}"<<EOF
${shibangBase/bash/-S awk -f}

@include "criarSubscriber.awk"
@include "enviarFluxos.awk"
@include "funcaoNotificarWhatsApp.awk"

# Aqui começa as funções
function nomeFuncao(){

}

BEGIN{
	FS=","
}

END{

}

EOF
chmod +x "${1}" && kate "${1}" &>- &

}

criandoMarkdown(){
dataAtual=$(date +%d-%m-%Y)

cat>>"${dataAtual}.md"<<EOF
# O que foi criado hoje? ${dataAtual}
### COMERCIAL
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  Editor
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  Banco de dados
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  BackEnd
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()

!["Visualização web"]()
#####  Visualização web comercial

### ADMINISTRATIVO
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  Editor
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  Banco de dados
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  BackEnd
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
!["Visualização web"]()
#####  Visualização web administrativo
### FIANANCEIRO
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  Editor
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  Banco de dados
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
#####  BackEnd
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
!["IMAGEM"]()
!["IMAGEM"]()
!["IMAGEM"]()
!["Visualização web"]()
#####  Visualização web financeiro
EOF
typora "${dataAtual}.md" &>- &

}

criandoDesktop(){


cat>>~/".config/autostart/${1}"<<EOF
[Desktop Entry]
Name=Nome do aplicativo
Type=Application
Exec='/home/brenner/Área de Trabalho/arquivoDesktop'

EOF

kate ~/".config/autostart/${1}"
}

[[ "${1}" ]] || { echo -e $'\E[41;1mVocê deve mandar o nome do arquivo ao chamar o executavél\E[m' ; exit 1; }

if [[ ! -e "${1}" ]];then
    case "${1}" in
        *".sh") echo -e "\E[31;1mÉ shell\E[m" ; criandoShell "${1}"
        ;;
        *".py") echo -e "\E[35;1mÉ python\E[m"; criandoPython "${1}"
        ;;
        *".awk") echo -e $'\E[32;1mAWKzinho\E[m'; criandoAwk "${1}"
        ;;
        *".md") echo -e $'\E[32;1mLinguagem markdown\E[m'; criandoMarkdown "${1}"
        ;;
        *".desktop") echo -e $'\E[32;1mARQUIVOS DESKTOP\E[m';sleep 10s; criandoDesktop "${1}"
        ;;
        *) echo -e "\E[31;1mNão existe essa opção\E[m"
        ;;

    esac
else
    echo -e "\E[37;1mO arquivo ${1} já existe aqui\E[m"
fi
}

arqAwk(){
    until false; do
        read -p $'\E[42;1mArquivo:\E[m   ' arquivo
        [[ "${arquivo}" ]] && break || { echo -e $'\E[31;1mEscolha uma arquivo para continuar\E[m'; sleep 1.5s ;}
    done
    awk -v arquivo="${arquivo}" 'BEGIN{while((getline linhas < arquivo)>0){print linhas} }'
}

live(){
	arquivoAModificar='notificarBotConversa.py'
	((UID>0)) && { echo -e "\E[31;1mVocê de ser root para realizar a tal mudança\E[m"; exit 1 ;}
	[[ -z "${1}" ]] && { echo -e 'Mande o primeiro parametro [sim|nao]'; exit 1 ;}
	sed -E 's/((nao|sim))/nao/' "/usr/bin/dibScripts/python/bibliotecas/${arquivoAModificar}"
}

filtros(){ 
	 pesquisar=$1
	awk 'BEGIN{ 
			FS=",";ARGC=3;ARGV[1]="dados.csv"
		  } $2 == "'"$pesquisar"'" {
			busca="'"$pesquisar"'"
			valorTotal += $3*$4
			print
		 } END{
			print "_______________________________" 
			print ""
			print toupper("o valor total de:"),busca,valorTotal
			print "_______________________________"
		   }'
}

trocarARGV1Awk(){
    [[ ${2:?'mande algum paramentro(s,sn)'} ]]
    if [[ ${2,,} = "s" ]]; then
        sed -Ei 's/(ARGV\[1]=")(.)*(")/\1'"${1}"'\3/' ~/.bashrc
    else
        sed -E 's/(ARGV\[1]=")(.)*(")/\1'"${1}"'\3/' ~/.bashrc
    fi
}

sshbv() {
    cat ~/.ssh/config
}

luzNoturna(){
    [[ ${1:?"Mande algum parametro exemplo(luzNoturna 2600)"} ]]
    if [[ $DESKTOP_SESSION =~ plasma ]]; then
        sed -Ei 's/([Nn]ightTemperature)(=)(.)*/\1\2'$1'/' ~/.config/kwinrc
        qdbus org.kde.ksmserver /KSMServer logout 0 0 0
    else
        echo "Sua sessão não é om plasma, então nada foi feito!"
    fi
}
meuIdTeclado(){
    if ! type -P '/usr/bin/xinput' &>-; then
        programa='xinput'
        echo -e "Você precisa do programa ${programa^^}, por este motivo não consigo fornecer o seu ID!"
        exit 1
    fi
    id=$(awk -F'\t' '/SEMICO USB Keyboard/ {count++; if (count == 2) print $1,$2}' <<<$(xinput))
    id=${id^^}
    id=${id##*=}
    echo -e "\E[41;6m seu id de MACROS é: ${id}\E[m"
}


#familia(){
 #   alias f='echo familia dib'
    #f
#}

#familia
#f
desktopUsuario() {
    awk 'BEGIN { FS="/"  }; $0 ~ /DESKTOP/ {gsub(/"/,"",$0);print $2}' ~/.config/user-dirs.dirs
}
areaDeTrabalhoUsuario="$(desktopUsuario)"
#cd ~/"${areaDeTrabalhoUsuario}"
echo "$areaDeTrabalhoUsuario"
#export SHELL=/bin/bash

export PATH=~/.local/bin:/usr/local/bin:/usr/bin:/usr/local/games:snap/bin:${HOME}/'Área de Trabalho'/sh:${HOME}/'Área de Trabalho'/powershell
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

