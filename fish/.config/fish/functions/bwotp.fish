function bwotp --description "Copies a TOTP code from a Bitwarden entry to the clipboard"
  rbw get --full "$argv" &| grep -oP "(?<=TOTP Secret: ).*" | xargs oathtool --totp -b | xclip -r -selection clipboard
end
