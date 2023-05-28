#!/bin/bash

# 等待目标文件生成
target_file="3trdparty/FluentUI/CMakeLists.txt"
full_path="$(pwd)/$target_file"
echo "Target file path: $full_path"

while [ ! -f "$full_path" ]; do
  echo "Waiting for target file to be generated..."
  sleep 1
done

# 修改指定文件的内容
sed -i '6s/^/#/' "$full_path"
