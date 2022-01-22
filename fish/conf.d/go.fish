if status is-login
    set -q GOPATH; or set -xU GOPATH $HOME/.local/go
    set -q GOBIN; or set -xU GOBIN $HOME/.tools
end

