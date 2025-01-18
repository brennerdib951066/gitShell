#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
versao='1.0.0'
diretoriosGit=(
    'gitAwk'
    'gitMarkdown'
    'gitPowershell'
    'gitPy'
    'gitShell'
    'gitVbs'
)
tokenAtual='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'
mensagensAviso=(
    'Sua configuração de diretorios git foi realizado com sucesso!'
    'Erro ao configurar seus diretorios para automatizar o git hub'
)
campanha='DIB'
#echo "A quantidade de itens é: ${#diretoriosGit[@]}"

for ((i=0;i<=${#diretoriosGit[@]}-1;i++)); do
        #echo "Diretorio ${diretoriosGit[i]}"
        cd ~/Área\ de\ [tT]rabalho/${diretoriosGit[i]} || { . $arquivoNotificacao ; notificar '385910829' "*${mensagensAviso[1]} diretório atual de erro é:* \`${diretoriosGit[i]}"\` ;}
        pwd
        git remote set-url origin "https://${tokenAtual}@github.com/brennerdib951066/${diretoriosGit[i]}" || { . $arquivoNotificacao ; notificar '385910829' "${mensagensAviso[1]}; diretório atual de erro é ${diretoriosGit[i]}" ;}
        sleep 1.5s
done
