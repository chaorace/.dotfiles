# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401
config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

from json import dumps
from os.path import expanduser
from glob import glob

# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Enable JavaScript on local files
config.set('content.javascript.enabled', True, 'file://*')

# Aliases
c.aliases['qmark'] = 'quickmark-add {url}'
c.aliases['!'] = 'spawn --output'
c.aliases['source'] = 'config-source --clear;;greasemonkey-reload'
c.aliases['help!'] = 'help'
c.aliases['help'] = 'help --tab'
c.aliases['open'] = 'open --secure'
c.aliases['nope'] = 'open --private'

# Navigation Bindings
config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('x', 'tab-close')
config.bind('X', 'undo')
config.bind('d', 'run-with-count 5 scroll down')
config.bind('u', 'run-with-count 5 scroll up')
config.bind('>', 'tab-move +')
config.bind('<', 'tab-move -')

# Editor
c.editor.command = ["emacsclient", "-c", "+{line}:{column}", "{file}"]
config.bind('<Ctrl-I>', "hint inputs userscript hintToEditor.py")
config.bind('<Ctrl-I>', 'open-editor', mode="insert")

# Password Manager
config.bind(';l', 'spawn --userscript qute-lastpass')
config.bind(';L', 'spawn --userscript qute-lastpass -w')

# Readability
config.bind(';z', 'spawn --userscript readability')

# Youtube
config.bind('gm', 'spawn --userscript view_in_mpv')

# Browser Behavior
c.content.notifications = False
c.new_instance_open_target = 'window'

# Ad Blocking
c.content.host_blocking.lists.extend([
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
    "https://raw.githubusercontent.com/HenningVanRaumle/pihole-ytadblock/master/ytadblock.txt",
    "https://raw.githubusercontent.com/anudeepND/youtubeadsblacklist/master/domainlist.txt"
])

# Theming
config.source('nord-qutebrowser.py')
config.source('gruvbox-dark.py')

# Global Dark Mode blacklist
# We send the blacklist to local storage for retrieval by the userscript.
# The blacklist is eventually evaluated against the href using the JS String.match method

# Load stylesheets from here
c.content.user_stylesheets = glob(expanduser('~/.local/share/qutebrowser/styles/*.user.css'))

# Blacklist of sites that the default.user.css stylesheet should not apply to
globaldarkBlacklist = [
    'duckduckgo.com',
    'google.com',
    'reddit.com',
    'news.ycombinator.com',
    'github.com',
    'wikipedia.org',
    'stackexchange.com',
    'stackoverflow.com',
    'askubuntu.com',
    'w3schools.com',
    'regexr.com',
    'userstyles.org',
    'twist.moe',
    'youtube.com',
    'dev.to'
]

# A dubious trick for smuggling persistent blacklist settings into Greasemonkey storage
writeBlacklist = f"jseval localStorage.setItem('__gm_https://github.com/chaorace/quteglobaldark:blacklist', '{dumps(globaldarkBlacklist)}')"
# Hacking around a lack of autocmds to make this convenient to use
config.bind(";j", writeBlacklist)
c.aliases['source'] += f";;{writeBlacklist};;reload"
