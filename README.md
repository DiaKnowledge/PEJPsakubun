# PEJPsakubun 概要
技術士二次試験(情報工学：ソフトウェア工学）の過去問に挑戦するプロジェクトです。
回答は順次公開します。

# PEJPsakubun 回答(案）の確認方法
cssとHTMLファイルをローカルにダウンロードして、
同一フォルダに格納した上で、HTMLファイルを開いてください。

Safari(Mac), IE9(Windows 7), Firefox(Windows7), Chrome(Windows 7)
にて動作確認済みです。

# PEJPsakubun 回答作成手順
(1) Hnn_base.htmlを作成する。回答については、行の先頭に%を入れて、データファイル名を記入する。

nn: 平成何年か

(2) data/以下に「Hnn-X-Y-Z.txt」を作成する。

X-Y-Z: どの問題か

(3) 「./create_html.sh Hnn」にて、HTMLファイルを作成する。

