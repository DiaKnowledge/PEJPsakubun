#!/bin/bash

# 引数チェック
if [ $# -ne 1 ]; then
  echo "指定された引数は${#}個です。"
  echo "第一引数に過去問のファイル名を入力してください。"
  exit 1
fi

ruby src/txt2txt.rb data/$1 txt/$1

if [ $? -eq 0 ]; then
  echo "txt/$1.txtを正常に作成完了しました。"
else
  echo "[ERROR] txt/$1.txt作成に失敗しました。"
  exit 1
fi

