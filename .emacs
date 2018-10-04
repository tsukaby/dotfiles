;; スタート時のスプラッシュ非表示
(setq inhibit-startup-message t)

;;; キーバインド
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-for-help) ; ヘルプ
(define-key global-map "\C-\\" nil) ; \C-\の日本語入力の設定を無効にする

;;; 色を付ける
(global-font-lock-mode t)

;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)

;;; スクロールを一行ずつにする
(setq scroll-step 1)

;;; スクロールバーを右側に表示する
(cond (window-system
       (set-scroll-bar-mode 'right))) 

;;; 画面右端で折り返さない
(setq-default truncate-lines t)
(setq truncate-partial-width-windows t)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)

;;; モードラインに情報を表示
(display-time)
(line-number-mode 1)
(column-number-mode 1)

;;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;;; タブをスペース2字
(setq-default tab-width 2 indent-tabs-mode nil)

;;; 選択範囲に色をつける
(transient-mark-mode t)

;;; ビープ音を消す
(setq visible-bell t)
