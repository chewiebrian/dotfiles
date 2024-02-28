function bwcopy --description "Find and copy a Bitwarden password"
    if command -sq bw and command -sq fzf-tmux and command -sq xclip
        if set -q argv[1]
          rbw get "$argv" | xclip -r -selection clipboard
        else
#        bw get item (
#            bw list items \
#            | jq -r '.[] | [.name, .login.username // "", .id] | @tsv' \
#            | column -t -s \t \
#            | fzf-tmux --with-nth 1..-2 --preview-window down:2 \
#                       --preview 'bw get item $(echo {} | awk \'{print $NF}\') | jq -r \'.login.uris | .[] | .uri // empty \'' \
#            | awk '{print $NF}'
#        ) | jq -r '.login.password' | xclip -r -selection clipboard
          rbw list --fields name | fzf-tmux --preview-window down:2 --preview 'rbw get --full {} | tail -n+2' |  awk '{print $NF}' | xargs rbw get | xclip -r -selection clipboard
        end
    end
end
