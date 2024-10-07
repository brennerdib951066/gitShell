#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"

read -p 'mensagem:   ' mensagem
mensagem="${mensagem,,}"
read -p 'enviar aviso[no/yes]:   ' enviarAviso
enviarAviso=${enviarAviso,,}
curl -X PATCH -F "avisoUniversalText= ${mensagem}" -H'Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a'  'https://www.sistemaviverbemseguros.com/version-test/api/1.1/obj/lead/1723476243383x434371790053661440'

curl -X PATCH -F "avisoUniversalEnviado= ${enviarAviso}" -H'Authorization: Bearer 5b2a5efbc5fda2ffff948979031ac33a' 'https://www.sistemaviverbemseguros.com/version-test/api/1.1/obj/lead/1723476243383x434371790053661440'

