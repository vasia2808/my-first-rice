PROMPT='%1~ %F{red}>%f '

alias clear='FIRST_PROMPT=true; clear'

FIRST_PROMPT=true

function add_newline() {
    if [ "$FIRST_PROMPT" = true ]; then
        FIRST_PROMPT=false
    else
        echo
    fi
}

precmd_functions+=(add_newline)
