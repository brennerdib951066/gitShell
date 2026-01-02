#!/usr/bin/env bash

#########################HEAD########################################################



#####################################################################################

####################VARIAVEIS COMUNS DO PROGRAMA#####################################
firefox="https://www.mozilla.org/pt-BR/firefox/download/thanks/"
mysql="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.34-1ubuntu22.04_amd64.deb"
googleChrome="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
reapper="https://www.reaper.fm/files/7.x/reaper716_linux_x86_64.tar.xz"
diretoriosInstalacoes=("/tmp/code" "/tmp/firefox" "/tmp/mysql" "/tmp/googleChrome" "/tmp/reapper")
#####################################################################################

####################VARIAVEIS ESPECIAIS DO PROGRAMA##################################
listaMenu=('visual code' 'firefox' 'mysql' 'google-chrome' 'flameshot' 'Obs Studio' 'reapper' 'Sair')
arquivoLogin='/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh'

#####################################################################################

###########################VERIFICAÇÕES###############################################
source "${arquivoLogin}"
#if ! verificarCredenciais; then notify-send -u normal -t 6000 "Erro fatal" "Suas credenciais estão erradas\nInsire-as corretamente"; exit 1; fi
for diretorio in "${diretoriosInstalacoes[@]}"; do
	[[ ! -e "${diretorio}" ]] && { mkdir "${diretorio}"; echo "\E[31;1mO ${diretorio} Criado com sucesso!\E[m" ;}
done


#####################################################################################

PS3="Opção :   "
select menu in "${listaMenu[@]}"; do
	case $REPLY in
				1) if ! wget "${visualCode}" -O "${diretoriosInstalacoes[0]}/${visualCode##*/}"; then
									echo "A instalação de Visual Studio falhou" 
					 fi
					 if ! pkexec dpkg -i "${diretoriosInstalacoes[0]}/${visualCode##*/}"; then
										echo "Falhou a sua instalção de visual!"
					 fi  
				   ;;
				2) if ! snap install "${listaMenu[1]}"; then
									echo "A instalação de firefox falhou"
					 fi
				   ;;
				3) if ! pkexec dpkg -i "${diretoriosInstalacoes[2]}/${mysql##*/}"; then
									echo "Falhou a instalação de mysql"
					 fi
					 ;;
				4) if ! wget "${googleChrome}" -O "${diretoriosInstalacoes[3]}/${googleChrome##*/}"; then
									echo "Sua instalação do chrome falhou"
					fi
					if ! pkexec dpkg -i "${diretoriosInstalacoes[3]}/${googleChrome##*/}"; then
									echo "Google iinstalado com sucesso!" ;
					fi
					;;
					5) pkexec apt install flameshot -y
					;;
					6) pkexec apt install obs-studio -y
					;;
					7) if ! wget "${reapper}" -O "${diretoriosInstalacoes[4]}/${reapper##*/}"; then
									echo "A instalação de REAPPER falhou"
					 fi
					 if [[ ${reapper##*/} =~ .deb$ ]]; then
						echo "Termina com deb"
						dpkg -i "${diretoriosInstalacoes[4]}/${reapper##*/}"
					 elif [[ ${reapper##*/} =~ (.gz|.xz)$ ]]; then
						echo "Termina com gz ou xz"
						tar -xvf "${diretoriosInstalacoes[4]}/${reapper##*/}" -C "/home/brenner/Área de trabalho"
						reapperExtraido="${reapper##*/}"
						reapper="${reapperExtraido%%.*}"
						reapper="${reapper/716/}"
						"/home/brenner/Área de trabalho/${reapper}/install-reaper.sh"
					 fi
					;;
					8) { echo "Saindo"; sleep 2s ;}
					;;
					*) echo "Não encontrei essa opção!"
					;;
	esac

done
