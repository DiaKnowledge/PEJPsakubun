# txtファイルを読み込み、
# 技術士回答HTMLを出力するスクリプト
# 原稿用紙は24*25

class GenkoString < String
  COLUMN = 24
  def linesize
    if self.size % COLUMN == 0
      linesize = self.size / COLUMN
    else
      linesize = (self.size / COLUMN) + 1
    end
    linesize
  end
end

class HTMLArray < Array
  ROW = 25
  def create_html
    # HTML出力
    html_outputer = HTMLOutputer.new
    html_outputer.start_genko
    html_outputer.start_paragraph

    paragraph_flag = true
    line_no = 0
    page_no = 1
    self.each do |item|
      # 空行 -> パラグラフ変更
      if item == ""
        paragraph_flag = true
        html_outputer.end_paragraph
        html_outputer.start_paragraph
        next
      end

      # 行数取得。25行を超える場合、改ページ
      if line_no + item.linesize > ROW
        html_outputer.end_paragraph
        html_outputer.end_genko
        puts "P#{page_no}(#{line_no}/#{ROW})行"
        html_outputer.separate
        html_outputer.start_genko
        html_outputer.start_paragraph
        line_no = 0
        page_no = page_no + 1
      end
      line_no = line_no + item.linesize

      if paragraph_flag == true
        # パラグラフ変更直後->下線を引く
        html_outputer.title(item)
      elsif item[0] == "・"
        # 箇条書き->普通に出力
        html_outputer.list(item)
      else
        # その他->先頭にスペース付けて、普通に出力
        html_outputer.str(item)
      end

      paragraph_flag = false
    end
    html_outputer.end_paragraph
    html_outputer.end_genko
    puts "P#{page_no}(#{line_no}/#{ROW})行"
  end
end

class HTMLOutputer
  def initialize
  end
  def start_genko
    puts "<div class=\"sakubun\">"
  end
  def start_paragraph
    puts "<p>"
  end
  def end_genko
    puts "</div>"
  end
  def end_paragraph
    puts "</p>"
  end
  def separate
    puts "<hr />"
  end
  def title(item)
    puts "<u>#{item}</u><br />"
  end
  def list(item)
    puts "#{item}<br />"
  end
  def str(item)
    puts "　#{item}<br />"
  end
end

# 引数チェック
if ARGV[0] == nil
  raise "ARGS ERROR: ARGV[0] -> csv file name"
end

# txtファイル読み込み
ary = HTMLArray.new
open(ARGV[0]) do |file|
  file.each do |line|
    # 先頭#はコメントとみなす
    if line[0] == "#"
      next
    end
    ary << GenkoString.new(line.chomp)
  end
end

# HTML文字列出力
ary.create_html

