# ==================================================
# PATH
# ==================================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/home/mateus/.spicetify"

# ==================================================
# OH-MY-ZSH (SEM TEMA)
# ==================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="refined"

plugins=(
  git
  fast-syntax-highlighting
  zsh-autosuggestions
)

# ==================================================
# PYWAL16
# ==================================================
if [[ -f ~/.cache/wal/colors.sh ]]; then
  source ~/.cache/wal/colors.sh
fi


# ==================================================
# LOAD OH-MY-ZSH
# ==================================================
source $ZSH/oh-my-zsh.sh

# ==================================================
# FASTFETCH – apenas uma vez por sessão
# ==================================================
if [[ -o interactive && -z "$FASTFETCH_SHOWN" && -z "$SSH_CONNECTION" ]]; then
  export FASTFETCH_SHOWN=1
  fastfetch
fi
