// for phoenix_html support, including form and button helpers
// copy the following scripts into your javascript bundle:
// * https://raw.githubusercontent.com/phoenixframework/phoenix_html/v2.3.0/priv/static/phoenix_html.js

var mobileUserAgentRE = /Android|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i
if( mobileUserAgentRE.test(navigator.userAgent) ) {
  document.body.className += " is-mobile-phone"
}