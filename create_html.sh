#!/bin/bash

# 引数チェック
if [ $# -ne 1 ]; then
  echo "指定された引数は${#}個です。"
  echo "第一引数に過去問の年度を入力してください。"
  exit 1
fi

# ファイルの有無チェック
if [ ! -s $1_base.html ]; then
  echo "[ERROR] $1_base.htmlが存在しません。"
  exit 1
fi

ruby src/txt2html.rb $1_base.html $1.html

if [ $? -eq 0 ]; then
  echo "$1.htmlを正常に作成完了しました。"
else
  echo "[ERROR] $1.html作成に失敗しました。"
  exit 1
fi

