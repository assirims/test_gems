# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.3.0/js/all.js"

# gem "chartkick"
pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.esm.js"
pin "Chart.bundle", to: "Chart.bundle.js"

# https://dev.to/timnans/implementing-videojs-in-ruby-on-rails-72h
pin "video.js", to: "https://ga.jspm.io/npm:video.js@7.18.1/dist/video.es.js"
pin "@babel/runtime/helpers/assertThisInitialized", to: "https://ga.jspm.io/npm:@babel/runtime@7.21.0/helpers/esm/assertThisInitialized.js"
pin "@babel/runtime/helpers/construct", to: "https://ga.jspm.io/npm:@babel/runtime@7.21.0/helpers/esm/construct.js"
pin "@babel/runtime/helpers/extends", to: "https://ga.jspm.io/npm:@babel/runtime@7.21.0/helpers/esm/extends.js"
pin "@babel/runtime/helpers/inherits", to: "https://ga.jspm.io/npm:@babel/runtime@7.21.0/helpers/esm/inherits.js"
pin "@babel/runtime/helpers/inheritsLoose", to: "https://ga.jspm.io/npm:@babel/runtime@7.21.0/helpers/esm/inheritsLoose.js"
pin "@videojs/vhs-utils/es/byte-helpers", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/byte-helpers.js"
pin "@videojs/vhs-utils/es/containers", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/containers.js"
pin "@videojs/vhs-utils/es/decode-b64-to-uint8-array", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/decode-b64-to-uint8-array.js"
pin "@videojs/vhs-utils/es/", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/"
pin "@videojs/vhs-utils/es/id3-helpers", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/id3-helpers.js"
pin "@videojs/vhs-utils/es/media-groups", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/media-groups.js"
pin "@videojs/vhs-utils/es/resolve-url", to: "https://ga.jspm.io/npm:@videojs/vhs-utils@3.0.5/es/resolve-url.js"
pin "@videojs/xhr", to: "https://ga.jspm.io/npm:@videojs/xhr@2.6.0/lib/index.js"
pin "@xmldom/xmldom", to: "https://ga.jspm.io/npm:@xmldom/xmldom@0.7.10/lib/index.js"
pin "dom-walk", to: "https://ga.jspm.io/npm:dom-walk@0.1.2/index.js"
pin "global/document", to: "https://ga.jspm.io/npm:global@4.4.0/document.js"
pin "global/window", to: "https://ga.jspm.io/npm:global@4.4.0/window.js"
pin "is-function", to: "https://ga.jspm.io/npm:is-function@1.0.2/index.js"
pin "keycode", to: "https://ga.jspm.io/npm:keycode@2.2.1/index.js"
pin "m3u8-parser", to: "https://ga.jspm.io/npm:m3u8-parser@4.7.0/dist/m3u8-parser.es.js"
pin "min-document", to: "https://ga.jspm.io/npm:min-document@2.19.0/index.js"
pin "mpd-parser", to: "https://ga.jspm.io/npm:mpd-parser@0.21.0/dist/mpd-parser.es.js"
pin "mux.js/lib/tools/parse-sidx", to: "https://ga.jspm.io/npm:mux.js@6.0.1/lib/tools/parse-sidx.js"
pin "mux.js/lib/utils/clock", to: "https://ga.jspm.io/npm:mux.js@6.0.1/lib/utils/clock.js"
pin "safe-json-parse/tuple", to: "https://ga.jspm.io/npm:safe-json-parse@4.0.0/tuple.js"
pin "url-toolkit", to: "https://ga.jspm.io/npm:url-toolkit@2.2.5/src/url-toolkit.js"
pin "videojs-vtt.js", to: "https://ga.jspm.io/npm:videojs-vtt.js@0.15.4/lib/browser-index.js"
