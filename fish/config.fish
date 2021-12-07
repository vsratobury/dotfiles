if status is-interactive
    # Commands to run in interactive sessions can go here
    # setup vi key bindings if not setup
    if test (bind -L | grep -c visual) -eq 0
        fish_vi_key_bindings
    end

    # Emulates vim's cursor shape behavior
    fish_vi_cursor --force-iterm
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block
end
