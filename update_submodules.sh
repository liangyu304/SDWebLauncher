#!/bin/bash

# 递归初始化和更新子模块及其子模块
recursive_update() {
  git submodule init
  git submodule update

  for submodule in $(git submodule --quiet foreach --recursive 'echo $path')
  do
    echo "Updating submodule: $submodule"
    cd "$submodule"
    git submodule init
    git submodule update
    recursive_update
    cd ..
  done
}

recursive_update

# 调用第二个脚本
bash modify_cmake.sh
