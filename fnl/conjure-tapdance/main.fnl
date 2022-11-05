(module conjure-tapdance.main
  {autoload {a aniseed.core
             nvim aniseed.nvim
             bridge conjure.bridge
             eval conjure.eval
             extract conjure.extract
             text conjure.text}})

(defn- tap-str [code]
  (a.str "(tap> " code ")"))

(defn tap [code range origin]
  (when (not (a.empty? code))
    (let [code (tap-str code)
          e {: code : range : origin}]
      ; (pr-debug e)
      (eval.eval-str e))))

(defn tap-word []
  (let [{: content : range} (extract.word)]
    (tap content range :word)))

(defn tap-form []
  (let [{: content : range} (extract.form {})]
    (tap content range :form)))

(defn tap-visual []
  (let [{: content : range} (extract.selection
                              {:kind (nvim.fn.visualmode)
                               :visual? true})]
    (tap content range :selection)))

(defn tap-*exc []
  (tap "*e" nil "*e"))

(defn on-filetype []
  (nvim.buf_create_user_command
    0 :TapForm #(tap-form)
    {:desc "Tap the form under the cursor"})
  (nvim.buf_create_user_command
    0 :TapWord #(tap-word)
    {:desc "Tap the symbol under the cursor"})
  (nvim.buf_create_user_command
    0 :TapV #(tap-visual)
    {:range true
     :desc "Tap the selection"})
  (nvim.buf_create_user_command 0 :TapExc #(tap-*exc) {:desc "Tap *e"}))

(defn init []
  (nvim.ex.augroup :tapdance_init_filetypes)
  (nvim.ex.autocmd_)
  (nvim.ex.autocmd
    :FileType "clojure"
    (bridge.viml->lua :conjure-tapdance.main :on-filetype))
  (nvim.ex.augroup :END))

(comment
  (on-filetype)
  )
