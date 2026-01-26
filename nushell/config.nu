# https://www.nushell.sh/book/configuration.html

$env.config.buffer_editor = "vim"

# setup-starship.nu
# mkdir ($nu.data-dir | path join "vendor/autoload")
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# mise
# let mise_path = $nu.default-config-dir | path join mise.nu
# '
# ^mise activate nu | save $mise_path --force
# ' | save $nu.env-path --append
# "\nuse ($nu.default-config-dir | path join mise.nu)" | save $nu.config-path --append

# alias
alias ll = ls -l
alias sshpi = ssh wolf@white-wolf

def fzf_dir [] {
  ls -al
  | each {|row| $row.name }
  | str join (char nl)
  | fzf --height 40% --reverse
  | decode utf-8.
  | str trim
}

# keybinding
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
