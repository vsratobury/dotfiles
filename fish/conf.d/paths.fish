# configure path variable
if status is-login
    # Настройка MacPorts
    fish_add_path /opt/local/bin
    # Установка директории для поиска программ пользователя
    fish_add_path $HOME/.tools
end

