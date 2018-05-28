# HTMLベースファイルを読み込み、その中にある
# ％から始まる行については、dataフォルダ内の
# txtファイルからHTMLを生成する。
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
  def create_html(output_file)
    # HTML出力
    html_outputer = HTMLOutputer.new(output_file)
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
        output_file.puts "P#{page_no}(#{line_no}/#{ROW})行"
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
    output_file.puts "P#{page_no}(#{line_no}/#{ROW})行"
  end
end

class HTMLOutputer
  def initialize(o)
    @out = o
  end
  def start_genko
    @out.puts "<div class=\"sakubun\">"
  end
  def start_paragraph
    @out.puts "<p>"
  end
  def end_genko
    @out.puts "</div>"
  end
  def end_paragraph
    @out.puts "</p>"
  end
  def separate
    @out.puts "<hr />"
  end
  def title(item)
    @out.puts "<u>#{item}</u><br />"
  end
  def list(item)
    @out.puts "#{item}<br />"
  end
  def str(item)
    @out.puts "　#{item}<br />"
  end
end

def txt2data(filename, output_file)
  puts "[txt2data]" + filename
  # txtファイル読み込み
  ary = HTMLArray.new
  begin
    open(filename) do |file|
      file.each do |line|
        # 先頭#はコメントとみなす
        if line[0] == "#"
          next
        end
        ary << GenkoString.new(line.chomp)
      end
    end
  rescue
    puts "[WARNING] txt2data失敗"
  end

  # HTML文字列出力
  ary.create_html(output_file)
end

# 引数チェック
if ARGV[1] == nil
  raise "ARGS ERROR: ARGV[0]->input_HTML_base ARGV[1]->output_HTML"
end

open(ARGV[0]) do |input_file|
  open(ARGV[1], "w") do |output_file|
    input_file.each do |line|
      # 先頭%の場合、dataフォルダ内のtxtファイルから
      # HTMLを生成する。
      if line[0] == "%"
        txt2data(line[1..-1].chomp, output_file)
        next
      end
      output_file.puts line.chomp
    end
  end
end

