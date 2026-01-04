quantidade=$(curl -sX GET 'https://3c.fluxoti.com/api/v1/campaigns/229993/agents/qualifications?start_date=2025-12-01&end_date=2025-12-31&api_token=0ThoHgXPfj3rFp6EZdVc1811q8u7ujL4QcCdvJYOpi1AYe77dC2qIh1jQlbS' -H 'accept: application/json' | jq -r '.data.agents[] | select(.name | contains("Brenner")) | .calls')

qtdStatus=$(echo \*\"QUALIFICAÇÃO\*\"","\*\"TOTAL\*\" ;curl -sX GET "https://3c.fluxoti.com/api/v1/campaigns/229993/agents/qualifications?start_date=2025-12-01&end_date=2025-12-31&api_token=0ThoHgXPfj3rFp6EZdVc1811q8u7ujL4QcCdvJYOpi1AYe77dC2qIh1jQlbS" -H "accept: application/json" | jq -r '.data.agents[]
  | select(.name | contains("Brenner"))
  | .qualifications[]
  | [.name,.total] | @csv') #> 3cplus.csv

qtdStatus="${qtdStatus//,/= }"
quebraDeLInha=$'\n'
pwsh -File "/mnt/c/Users/brenner/Desktop/gitPowershell/notificarWhatsApp.ps1" "notificarWhatsApp" "${qtdStatus//\"/}${quebraDeLInha}${quebraDeLInha} \`TOTAL : ${quantidade}\`" "brenner"

