// ==UserScript==
// @name          Amazon All Dark
// @namespace     http://userstyles.org
// @description	  I wasnt satisfied with the top few Dark themes for Amazon. They all did good things, but here I've combined them. From reduced banners to increased font sizes and dark backgrounds, it's all good things.
// @author        weasel0
// @homepage      https://userstyles.org/styles/137882
// @include       https://www.amazon.com/dp*
// @include       https://www.amazon.com/gp/video/*
// @include       https://www.amazon.com/gp/product/*
// @include       http://amazon.com/*
// @include       https://amazon.com/*
// @include       http://*.amazon.com/*
// @include       https://*.amazon.com/*
// @include       http://amazon.com.br/*
// @include       https://amazon.com.br/*
// @include       http://*.amazon.com.br/*
// @include       https://*.amazon.com.br/*
// @include       http://amazon.ca/*
// @include       https://amazon.ca/*
// @include       http://*.amazon.ca/*
// @include       https://*.amazon.ca/*
// @include       http://amazon.cn/*
// @include       https://amazon.cn/*
// @include       http://*.amazon.cn/*
// @include       https://*.amazon.cn/*
// @include       http://amazon.fr/*
// @include       https://amazon.fr/*
// @include       http://*.amazon.fr/*
// @include       https://*.amazon.fr/*
// @include       http://amazon.de/*
// @include       https://amazon.de/*
// @include       http://*.amazon.de/*
// @include       https://*.amazon.de/*
// @include       http://amazon.it/*
// @include       https://amazon.it/*
// @include       http://*.amazon.it/*
// @include       https://*.amazon.it/*
// @include       http://amazon.co.jp/*
// @include       https://amazon.co.jp/*
// @include       http://*.amazon.co.jp/*
// @include       https://*.amazon.co.jp/*
// @include       http://amazon.es/*
// @include       https://amazon.es/*
// @include       http://*.amazon.es/*
// @include       https://*.amazon.es/*
// @include       http://amazon.co.uk/*
// @include       https://amazon.co.uk/*
// @include       http://*.amazon.co.uk/*
// @include       https://*.amazon.co.uk/*
// @include       http://smile.amazon.com/*
// @include       https://smile.amazon.com/*
// @include       http://*.smile.amazon.com/*
// @include       https://*.smile.amazon.com/*
// @run-at        document-start
// @version       0.20180909220930
// ==/UserScript==
(function() {var css = [
	"a, a:link, a:visited {color: #fb0 !important;}",
	"",
	"a.dv-play-btn-content, .a-dropdown-common .a-dropdown-link, a#uh-title {color: #000 !important;}",
	"",
	"html, .dv-episode-container, .main-tv .dv-dp-top-wrapper, #nav-subnav, #dv-cl-breadcrumb,",
	"#dv-cl-top-bar, #aiv-cl .dv-cl-grid-outer {background: #232F3E !important;}",
	"",
	".dv-el-title, p.a-color-base, .a-checkbox label, .a-radio label, .dv-simple-synopsis p, #dv-cl-breadcrumb .dv-cl-breadcrumb-text ",
	"	{color: #f1f1f1 !important; font-size: x-large; line-height: 125%;}",
	"",
	".a-size-mini {font-size: x-large; line-height: 125%;}",
	"",
	".dp-main h1 .num-of-seasons, .dp-main h1 .release-year, .dv-el-badge, .dv-el-attr-key, ",
	".dv-el-attr-value, .aiv-container-limited.tancaccept {color: #feb !important;}",
	"",
	"#ybh.desktop .asin-title, #ybh.tablet .asin-title, #rhf .ybh-fresh-link {color: #7b81ff !important;}",
	"",
	"#navbar, #nav-main, body, html, .a-popover-inner, #suggestions-template, .dv-dp-top-wrapper,.nav-search-submit, #pagn, #hows-my-search, .rhfWrapper, .rhfHistoryWrapper, #rhfDividerColumn, #white-mask, .history-text, .nav-flyout-sidePanel-content, #nav-flyout-yourAccount, #nav-flyout-wishlist, #nav-flyout-cart, .click_region, #cbcc_banner, #hl-confirm-text, .a-box, .benefits-container, #spc-imb, .nav-catFlyout, .nav-flyout-content, .nav-promo, .small, #nav-subnav, a.a-link-section-expander, #nav-belt, .nav-signin-tt, .a-alert-info .a-alert-container, .a-box-group > .a-box:first-child > .a-box-inner, #bbopAndCartBox, .nav-bluebeacon .ewc-beacon #ewc #ewc-checkout, .ewc-style .ewc-section-expander > .ewc-expander-header a, #btfContent, .a-box-title .a-box-inner, #actionPanelWrapper, .payment-row, .a-box-inner, .a-form-actions, ul.a-tabs li:first-child a, #huc-v2-order-row-items, #huc-v2-order-row-messages, .huc-v2-upsell-item-slide, input[type=\"text\"], .a-search input, .nav-flyout, .hud-feed-carousel .hud-feed-carousel-viewport, .feed-carousel .feed-carousel-viewport, .deals-shoveler.fresh-shoveler, #btfContent, .btfContent, #gw-content-grid-bottom > div, #gw-content-grid-top > div, .displayAd, .s-item-container, .imageInformation, table.a-keyvalue th, #pageContent, .gw-card-layout .a-cardui, .adcenterRowWrapper, .billboardRowWrapper, .desktop-row",
	"  {background: black !important;}",
	"",
	".a-price",
	"	{color: #f07700;}",
	"",
	"ul.a-tabs li:first-child a",
	"  {border-color: #d2d2d2 #ddd #ddd !important;}",
	"",
	"#pageContent .sidebar, #sidebar, .landingpage .white-gray-bg, #hud-dashboard, .a-accordion, .a-accordion-active, .a-accordion-inner ",
	"	{",
	"		background-color: rgba(0,0,0,0);",
	"        background:rgba(0,0,0,0) !important",
	"}",
	"",
	".rhf-divider-inner, #upsell-section-divider, .a-divider-inner, .cbcc_box, .adStripe2, .poll-widget, #nav-flyout-prime, .srch_sggst_flyout, #nav-upnav, #sidebar, #sidebar::before, a.iss-banner-ad, #header.a-row.banner-border, #smTabCDiv, .rhf-divider, .a-button-primary::after, .a-button::after ",
	"	{display: none !important;}",
	"",
	"",
	"",
	"#main, #suggestions-template, .a-color-base, #leftNav a:hover, #nav-search, .click_region, h3, .upsell_title_post, .a-carousel-pagination, .a-alert-container, #sc-about, h2, .byline, .a-checkbox-label, .sc-product-creator, #spc-order-summary, .a-size-medium, .a-text-center, .a-fixed-right-flipped-grid, #centerCol, #feature-bullets, .a-list-item, .a-section, .small, .nav-a:hover, .a-spacing-medium, .num-orders-for-orders-by-date, a.item:hover, .a-text-bold, .a-spacing-extra-large, .a-row, #miniATF_titleLink:hover, .navFooterColHead, .nav-tpl-itemList .nav-link:hover .nav-text, #feature-bullets-atf li span, ul.a-tabs li:first-child a, a:link, .nav-tpl-itemList .nav-link .nav-text, .huc-v2-order-row .huc-v2-scarcity, #productDescription .aplus p, #gw-content-grid .fresh-shoveler .as-title-block .a-color-base",
	"  {color: #d2d2d2 !important;}",
	"",
	".s-selected, ul.a-tabs",
	"  {background: #161616 !important;}",
	"",
	"#leftNav a, #rhf_nav_back, a.item, #signin-slot, #nav-cart-flyout.nav-empty .nav-dynamic-empty, .postContent, #quickPromoBucketContent .qpUL, #fbt_x_title, .bxgy-byline-text, div.bucket, #miniATF_titleLink, body, .rhf-sign-in-title",
	"  {color: gray !important;}",
	"",
	".nav-search-field, .nav-searchbar .nav-active, .nav-search-scope, .nav-search-label, .nav-search-facade, .nav-searchbar, #twotabsearchtextbox, .nav-focus, #searchOrdersInput",
	"  {background: #161616 !important;",
	"  color: white !important;",
	"  border: none !important;",
	"  box-shadow: none !important;}",
	"",
	"#leftNav .seeMore, .boldRefinementLink, .a-color-state, #leftNav h2",
	"  {color: #4682B4 !important;}",
	"",
	"#s-result-info-bar, .a-alert-info .a-alert-container",
	"  {border: 1px #161616 solid !important;",
	"  box-shadow: none!important;}",
	"",
	".s-suggestion:hover, #miniATFUDP, .wl-list.selected {",
	"  background: black !important;",
	"  border: 1px white solid !important;}",
	"",
	".s-highlight-primary",
	"  {color: #4682B4 !important;}",
	"",
	"#navbar #nav-flyout-ewc .nav-flyout-tail",
	"  {background: #404040 !important;}",
	"",
	"#nav-logo-borderfade",
	"  {background: gray !important;}",
	"",
	".a-button, .a-button-text, .nav-action-button, .nav-action-button:link, .rhf-sign-in-button .action-inner, span.btn-prim-med-ra span input {",
	"  -moz-appearance: none !important;",
	"  background: linear-gradient(#333, #000) !important;",
	"  border: 1px #444 solid !important;",
	"  color: #999 !important;",
	"  box-shadow: none !important;}",
	"",
	".nav-action-button .nav-action-inner, .nav-action-button:link .nav-action-inner",
	"  {color: #999 !important;}",
	"",
	".rhf-sign-in-button .action-inner",
	"  {text-shadow: unset !important;}",
	"",
	".a-button:hover, .a-button-text:hover, .nav-action-button:hover, .nav-action-button:link:hover, .rhf-sign-in-button .action-inner:hover, span.btn-prim-med-ra span input:hover",
	"  {background: #222 !important;}",
	"",
	".list-address-selected {",
	"    background-color: #3030D8;",
	"}"
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
