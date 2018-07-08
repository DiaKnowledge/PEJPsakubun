# 原稿用紙に記載する文字列を格納するクラス
class GenkoString < String
  COLUMN = 24

  def initialize(line)
    if line[0] != "・" and line[0] != "（" and line[0] != "１" and line[0] != "２" and line[0] != "３"
      line = "　" + line
    end
    super
  end

  def linesize
    if (size % COLUMN).zero?
      linesize = size / COLUMN
    else
      linesize = (size / COLUMN) + 1
    end
    linesize
  end

  def getline(no)
    self[(no - 1)*COLUMN, COLUMN]
  end
end

# 引数チェック
if ARGV[1].nil?
  raise "ARGS ERROR: ARGV[0]->input_base_txt ARGV[1]->output_txt"
end

open(ARGV[0]) do |input_file|
  open(ARGV[1], "w") do |output_file|
    output_file.puts "　１２３４５６７８９０１２３４５６７８９０１２３４"
    line_no = 1
    input_file.each do |line|
      # 先頭#はコメントとみなす
      if line[0] == "#"
        next
      end
      # 空行も飛ばす
      if line[0] == "\n"
        next
      end
      genko_line = GenkoString.new(line.chomp)
      for i in 1..(genko_line.linesize)
        output_file.puts "%02d"%[line_no] + genko_line.getline(i)
        line_no += 1
      end
    end
  end
end

