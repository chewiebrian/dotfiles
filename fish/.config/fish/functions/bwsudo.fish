function bwsudo --description "Run sudo retrieving password from BitWarden"
#    set VAULT_STATUS (bw status | egrep "{.*}" | jq -r .status)
#    if [ "$VAULT_STATUS" != "unlocked" ]
#       bwu
#    end 
    
#    set PASS (bw list items | jq -r ".[] | select (.name==\"Cuenta dominio\") | .login.password" )
#    echo $PASS | sudo -S $argv
    set -x SUDO_ASKPASS "/home/fernando.gil/.config/fish/functions/bwaskpass.sh"
    sudo -A $argv
end
