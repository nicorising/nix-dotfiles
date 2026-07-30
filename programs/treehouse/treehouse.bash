_treehouse_sync() {
    if [ -n "$TREEHOUSE_DIR" ] && [ -z "$_TREEHOUSE_DIR_HOOKED" ]; then
        return
    fi

    case "$PWD" in
    "$HOME/.treehouse"/*/*/*)
        local rel="${PWD#"$HOME/.treehouse/"}"
        local pool="${rel%%/*}"
        rel="${rel#*/}"
        local slot="${rel%%/*}"
        rel="${rel#*/}"
        export TREEHOUSE_DIR="$HOME/.treehouse/$pool/$slot/${rel%%/*}"
        export _TREEHOUSE_DIR_HOOKED=1
        ;;
    *)
        if [ -n "$_TREEHOUSE_DIR_HOOKED" ]; then
            unset TREEHOUSE_DIR _TREEHOUSE_DIR_HOOKED
        fi
        ;;
    esac
}
