function bwssh --description "Run ssh retrieving password from BitWarden"
#    set VAULT_STATUS (bw status | egrep "{.*}" | jq -r .status)
#    if [ "$VAULT_STATUS" != "unlocked" ]
#       bwu
#    end 
    
#    set PASS (bw list items | jq -r ".[] | select (.name==\"Cuenta dominio\") | .login.password" )
#    echo $PASS | sudo -S $argv
    set -x SUDO_ASKPASS "/home/fernando.gil/.config/fish/functions/bwaskpass.sh"
    SSHPASS=(rbw get $argv[1]) sshpass -e ssh $argv[2..-1]
end
