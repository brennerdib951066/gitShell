#!/usr/bin/env bash


arquivoLogin="/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh"
arquivoCor="/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt"
arquivoNotificacao="/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt"
#arquivoDeLog=

listaDeArquivos=(
    'awk'
    'csv'
    'py'
    'sh'
    #'txt'
    'md'
    'ps1'
    'vbs'
)

listaDePastas=(
    'awk'
    'csv'
    'py'
    'sh'
    #'txt'
    'markdown'
    'powershell'
    'vbs'
)
incrementoArquivos=0
pastaAtual=0
for arquivo in "${listaDeArquivos[@]}";do

    if ! ls $HOME/"Área de Trabalho"/*.$arquivo > $HOME/Área\ de\ Trabalho/teste.txt; then
        ((incrementoArquivos++))
        continue
    fi
    mapfile -t arquivos < $HOME/Área\ de\ Trabalho/teste.txt
    pastaAtual="${incrementoArquivos}"
    #sleep 10s
    #cat "teste.txt"
        for i in "${!arquivos[@]}"; do
            if [[ "${arquivos[i]}" =~ '.md' ]]; then
                ## Se a pasta conter markdown ele ira mover para a pasta viver bem
                ((pastaAtual++))
                mv "${arquivos[i]}" $HOME/Área\ de\ Trabalho/${listaDePastas[pastaAtual]}/viverBem
            else
                mv "${arquivos[i]}" $HOME/Área\ de\ Trabalho/"${listaDePastas[pastaAtual]}"
                echo "Movendo"
            fi
            sleep 5s
        done

done

