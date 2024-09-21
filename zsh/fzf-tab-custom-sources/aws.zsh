# :fzf-tab:complete:aws:*
if [[ ${#words} == 2 ]]; then
    grc --colour on aws $word help
fi
if [[ ${#words} > 2 ]]; then
    echo "aws $words[2] $word help"
    grc --colour on aws "$words[2]" "$word" help
fi
