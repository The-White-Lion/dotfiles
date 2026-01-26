# PATH
$env.PATH = (
  $env.PATH
  | prepend "/opt/homebrew/bin"
  | prepend "/usr/local/bin"
)

# global editor
$env.EDITOR = "vim"
$env.VISUAL = "vim"

# proxies
$env.all_proxy = "socks5://127.0.0.1:7897"
$env.http_proxy = "http://127.0.0.1:7897"
$env.https_proxy = "http://127.0.0.1:7897"

# starship
$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/starship.toml")

# mise
use ($nu.default-config-dir | path join mise.nu)

# zoxide
source ($nu.default-config-dir | path join zoxide.nu)

# carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
source ($nu.default-config-dir | path join carapace.nu)

# topiary-nushell
$env.TOPIARY_CONFIG_FILE = ($env.HOME | path join github topiary-nushell languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.HOME | path join github topiary-nushell languages)

# eza config path
$env.EZA_CONFIG_DIR = ($env.home | path join .config eza)
