#!/usr/bin/fish

# bass is a fish plugin that allows executing bash from fish. We use this to
# source all files in /etc/profile.d. if not present, it can be installed
# through fisher, a fish plugin manager.
if functions -q bass
    bass source /etc/profile
end

if status --is-interactive
    # Z directory jumping
    if type -q zoxide
        zoxide init fish | source
    end

    # Setup prompt
    if type -q starship
        starship init fish | source
    end

    # Use gpg-agent for ssh-agent
    set -e SSH_AGENT_PID
    set -e SSH_AUTH_SOCK
    set -g -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    set -g -x GPG_TTY (tty)
    systemctl --user start gpg-agent.service
    dbus-update-activation-environment --systemd --all
end
