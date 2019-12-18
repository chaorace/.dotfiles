// ==UserScript==
// @name          Regexr Dark
// @namespace     http://userstyles.org
// @description	  A dark theme for the regular expression testing website <a href="https://regexr.com/">Regexr</a>.
// @author        Calinou
// @homepage      https://userstyles.org/styles/169465
// @include       http://regexr.com/*
// @include       https://regexr.com/*
// @include       http://*.regexr.com/*
// @include       https://*.regexr.com/*
// @run-at        document-start
// @version       0.20190228184544
// ==/UserScript==
(function() {var css = [
	".exp-anchor {",
	"    color: hsl(15, 60%, 70%);",
	"  }",
	"  .exp-char {",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .exp-charclass {",
	"    color: hsl(5, 80%, 60%);",
	"  }",
	"  .exp-decorator {",
	"    color: hsl(0, 0%, 49%);",
	"  }",
	"  .exp-esc {",
	"    color: hsl(300, 80%, 80%);",
	"  }",
	"  .exp-group {",
	"    color: hsl(125, 70%, 70%);",
	"  }",
	"  .exp-quant {",
	"    color: hsl(210, 95%, 66%);",
	"  }",
	"  .exp-set {",
	"    color: hsl(50, 80%, 75%);",
	"  }",
	"  .CodeMirror pre {",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .CodeMirror-cursor {",
	"    border-left: 1px solid hsl(0, 0%, 91%);",
	"  }",
	"  .inputtool .CodeMirror {",
	"    background-color: hsl(210, 7%, 20%);",
	"  }",
	"  span.match {",
	"    background-color: hsl(210, 50%, 38%);",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .doc > section {",
	"    background-color: hsl(210, 7%, 20%);",
	"  }",
	"  .doc > section > header {",
	"    background-color: hsl(210, 7%, 29%);",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .doc > section.expression > header {",
	"    background-color: hsl(210, 7%, 29%);",
	"  }",
	"  .doc > section.tools > article {",
	"    background-color: hsl(210, 7%, 20%);",
	"  }",
	"  .doc > section.tools > article .details > div.desc,",
	"  .doc > section.tools > article .details > div.desc code {",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .doc > section.tools > article .inputtool .result textarea {",
	"    background-color: hsl(210, 7%, 26%);",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .doc > section.tools > article .inputtool .editor {",
	"    border-bottom: 1px solid hsl(210, 7%, 35%);",
	"  }",
	"  .doc > section.tools > article .explain div {",
	"    border-color: hsl(210, 7%, 35%);",
	"    background-color: hsl(210, 7%, 20%);",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .doc > section.text > .editor > .pad > canvas.highlights {",
	"    filter: brightness(0.7);",
	"  }",
	"  .segcontrol > .selected {",
	"    background-color: hsl(210, 7%, 65%);",
	"  }",
	"  .doc > section.tools > article .explain .exp-group-0 {",
	"    background-color: #44504b;",
	"    color: #ddfbdf;",
	"  }",
	"  .doc > section.tools > article .explain .exp-group-1 {",
	"    background-color: #3d5045;",
	"    color: #c6f9ca;",
	"  }",
	"  .doc > section.tools > article .explain .exp-group-2 {",
	"    background-color: #364f3e;",
	"    color: #aff6b5;",
	"  }",
	"  .doc > section.tools > article .explain .exp-group-3 {",
	"    background-color: #304e38;",
	"    color: #98f49f;",
	"  }",
	"  .doc > section.tools > article .explain .exp-group-set {",
	"    background-color: #4c4d38;",
	"    color: #f7f0a1;",
	"  }",
	"  .sidebar > .full > .content code em {",
	"    background-color: hsl(210, 50%, 38%);",
	"    color: hsl(0, 0%, 91%);",
	"  }",
	"  .sidebar > .full > .hello {",
	"    border-top: 3px solid hsl(210, 7%, 36%);",
	"  }"
].join("\n");
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var node = document.createElement("style");
	node.type = "text/css";
	node.appendChild(document.createTextNode(css));
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		heads[0].appendChild(node);
	} else {
		// no head yet, stick it whereever
		document.documentElement.appendChild(node);
	}
}
})();
