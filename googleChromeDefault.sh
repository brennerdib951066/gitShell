#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"



defaultar=(
    'x-scheme-handler/https'
    'x-scheme-handler/http'
    'text/html'
)

for default in "${defaultar[@]}"; do
    xdg-mime default google-chrome.desktop "${default}"
done
