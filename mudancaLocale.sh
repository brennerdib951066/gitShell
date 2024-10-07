#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"

sudo timedatectl set-timezone America/Sao_Paulo
timedatectl
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
date
locale -a
sudo dpkg-reconfigure locales

