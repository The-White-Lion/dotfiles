$env.config.buffer_editor = "vim"

# alias
alias ll = ls -l
alias sshpi = ssh wolf@white-wolf
alias vim = nvim

def fzf_dir [] {
  ls -al
  | each {|row| $row.name }
  | str join (char nl)
  | fzf --height 40% --reverse
  | decode utf-8.
  | str trim
}

# Auto upgrade mise and clear cache
def mise-upgrade [] {
    mise upgrade
    mise prune
    mise cache clear
}

def chrome [] {
  ^open -b "com.google.Chrome" --args "--disable-features=ExtensionManifestV2Unsupported,ExtensionManifestV2Disabled"
}

# Keybindings
$env.config.keybindings ++= [
  {
    name: select_up
    modifier: control
    keycode: char_k
    mode: emacs
    event: {
      until: [
        {send: menuup}
        {send: up}
      ]
    }
  }
  {
    name: select_down
    modifier: control
    keycode: char_j
    mode: emacs
    event: {
      until: [
        {send: menunext}
        {send: down}
      ]
    }
  }
  {
    name: completion_with_fzf
    modifier: control
    keycode: char_t
    mode: emacs
    event: {
      send: executehostcommand
      cmd: "commandline edit --insert (fzf_dir)"
    }
  }
]
