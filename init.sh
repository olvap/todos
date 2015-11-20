export TODOS="${HOME}/.todos/todos"

_t(){
  _arguments -s : \
    '-e[Open editor.]' \
    '-d[Delete task.]'
  _files -W "$TODOS"/
}

t() {
  edit(){
    $EDITOR "$1"
  }

  delete(){
    rm "$1"
  }

  all(){
    ls "$TODOS" -1
  }

  show(){
    cat $1
  }

  new(){
    touch $1
  }

  show_or_create(){
    if test -f $1
    then
      show $1
    else
      new $1
    fi
  }

  analize_options(){
    file_name="$TODOS"/"$2"
    while getopts ed opt
    do
      case "$opt" in
        e) edit $file_name;;
        d) delete $file_name;;
      esac
    done
  }

  case $# in
    0) all;;
    1) show_or_create "$TODOS"/"$1";;
    2) analize_options $1 $2 ;;
  esac
}
