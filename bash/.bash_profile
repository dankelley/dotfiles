# bash does /etc/profile then looks for
#  ~/.bash_profile, ~/.bash_login, ~/.profile
# and does the first in that list ... the present file.
source ~/.aliases
source ~/.functions
HISTSIZE=500

export GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-completion.sh
##export PATH=$PATH:~/Library/Haskell/ghc-7.0.3/lib/pandoc-1.8.1.1/bin
export PATH=${PATH}:/Users/kelley/bin
export PATH="/usr/local/sbin:$PATH"
##export PATH=${PATH}:/Developer/usr/bin/
function parse_git_dirty {
    #[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
    [[ $(git status 2> /dev/null | tail -n1 | grep -v "nothing to commit") ]] && echo "*"
}
function parse_git_branch {
  #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}

### # obtain 't' from https://github.com/sjl/t
### function count_tasks {
###   ~/bin/t | wc -l | sed -e 's/ *//' 2> /dev/null | sed -e 's/^0$//' | sed -e 's/^/</' | sed -e 's/$/>/' | sed -e 's/<>//'
### }
### function nb_count {
###     nb --due today --count
### }

IGNOREEOF=3

export LANG="en_CA.UTF-8"
export LC_ALL="en_CA.UTF-8"
if [ ! -n "$SSH_TTY" ]; then
    #export EDITOR='/Users/kelley/bin/mvim'
    export EDITOR='/usr/bin/vim'
else
    export EDITOR='/usr/bin/vim'
    alias mvim=/usr/bin/vim
fi

# Setting PATH for EPD-6.1-1
# The orginal version is saved in .bash_profile.pysave
## PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

MKL_NUM_THREADS=1
export MKL_NUM_THREADS

## bashmarks
source ~/.local/bin/bashmarks.sh

### # pip bash completion start
### _pip_completion()
### {
###     COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
###                    COMP_CWORD=$COMP_CWORD \
###                    PIP_AUTO_COMPLETE=1 $1 ) )
### }
### complete -o default -F _pip_completion pip
### # pip bash completion end

function last_two_dirs {
pwd |rev| awk -F / '{print $1,$2}' | rev | sed s_\ _/_
}

### function mmold {
### pandoc -V geometry:margin=1in -o `basename $1 .md`.pdf $1
### }

function Rmd {
R --no-save -e 'library(rmarkdown); render("'$1'", "pdf_document")'
}

#PS1="\h:\W"
PS1="\h:"
export PS1="$PS1\$(last_two_dirs)"
export PS1="$PS1\$(parse_git_branch)"
#export PS1="$PS1<\$(nb_count)> "
export PS1="$PS1$ "
echo -n -e "\033]0;emit\007"

export _R_BUILD_COMPACT_VIGNETTES_=1
export _R_CHECK_FORCE_SUGGESTS_=0
#export R_ARCH=/x86_64

### # Setting PATH for Python 2.7
### # The orginal version is saved in .bash_profile.pysave
### PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
### export PATH

### # Setting PATH for Python 3.5
### # The orginal version is saved in .bash_profile.pysave
### PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
### export PATH

### export MAGICK_HOME="$HOME/ImageMagick-6.9.0"
### export PATH="$MAGICK_HOME/bin:$PATH"
### export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"


function ggg {
git add .
git commit -m "$1 added"
git push
}

