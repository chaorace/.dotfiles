// ==UserScript==
// @name quteglobaldark:
// @namespace   https://github.com/chaorace
// @description Removes the default theme if site is blacklisted
// @include *
// @grant GM_getValue
// @noframes
// ==/UserScript==
(function(){
  //DDG aggressively wipes out LocaLStorage, so I manually added an exception here
  const blacklist = JSON.parse(GM_getValue('blacklist', '["duckduckgo.com"]'))
  if(blacklist.some(pattern => document.location.href.match(pattern))){
    const mainStyleNode = Array.from(document.querySelectorAll('body+style'))
                         .find(node => node.innerText.includes('/* QUTE-DEFAULT-STYLE */'))
    mainStyleNode.innerHTML = mainStyleNode.innerHTML.replace(
      /^\/\* QUTE-DEFAULT-STYLE \*\/.*\/\* END \*\//s, ''
    )
  }
})();
