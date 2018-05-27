# txtファイルを読み込み、
# 技術士回答HTMLを出力するスクリプト
# 原稿用紙は24*25

# 引数チェック
if ARGV[0] == nil
	raise "ARGS ERROR: ARGV[0] -> csv file name"
end

# txtファイル読み込み
str_ary = []
open(ARGV[0]) do |file|
	file.each do |line|
		str_ary << line.chomp
	end
end

# HTML出力
puts "<div class=\"sakubun\">"
puts "<p>"

paragraph_flag = true
line_no = 0
str_ary.each do |item|
	# 空行 -> パラグラフ変更
	if item == ""
		paragraph_flag = true
		puts "</p>"
		puts "<p>"
		next
	end

	# 行数取得。25行を超える場合、改ページ
	linesize = (item.size / 24) + 1
	if line_no + linesize > 25
		line_no = 0
		puts "</p>"
		puts "</div>"
		puts "<hr />"
		puts "<div class=\"sakubun\">"
		puts "<p>"
	end
	line_no = line_no + linesize

	if paragraph_flag == true
	  # パラグラフ変更直後->下線を引く
		puts "<u>#{item}</u><br />"
	else
	  # その他->普通に出力
		puts "#{item}<br />"
	end

	paragraph_flag = false
end
