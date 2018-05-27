add # PEJPsakubun

技術士二次試験(情報工学：ソフトウェア工学）の過去問に挑戦するプロジェクトです。
回答は順次公開します。

作成手順は以下の通りです。

(1) data/以下に「Hnn-X-Y-Z.txt」を作成する。
nn: 平成何年か
X-Y-Z: どの問題か
(2) ruby src/txt2html.rb data/Hnn-X-Y-Z.txt
を実行し、HTMLを生成
(3) 生成したHTMLをhtmlファイルに転記する

