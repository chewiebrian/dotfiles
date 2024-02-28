function bwu --description "Unlock the Bitwarden session"
    set -e BW_SESSION
    set -xU BW_SESSION (bw unlock --raw $argv[1])
end
