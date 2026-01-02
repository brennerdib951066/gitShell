#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"

perfis=('Brenner' 'DIB' 'Denilson' 'programacaoViverBem')

for perfil in "${perfis[@]}"; do
    google-chrome-stable --profile-directory="${perfil}" "https://www.youtube.com/"
    sleep 120s
done
