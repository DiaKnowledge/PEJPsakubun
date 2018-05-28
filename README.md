# PEJPsakubun 概要
技術士二次試験(情報工学：ソフトウェア工学）の過去問に挑戦するプロジェクトです。
回答は順次公開します。

# PEJPsakubun 回答(案）の確認方法
cssとHTMLファイルをローカルにダウンロードして、
同一フォルダに格納した上で、HTMLファイルを開いてください。

Safari(Mac), IE9(Windows 7), Firefox(Windows7), Chrome(Windows 7)
にて動作確認済みです。

# PEJPsakubun 回答作成手順
(1) data/以下に「Hnn-X-Y-Z.txt」を作成する。

nn: 平成何年か

X-Y-Z: どの問題か

(2) ruby src/txt2html.rb data/Hnn-X-Y-Z.txtを実行し、HTMLを生成

(3) 生成したHTMLをhtmlファイルに転記する

