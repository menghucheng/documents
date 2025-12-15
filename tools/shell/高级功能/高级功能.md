# Shell 高级功能

## 1. 进程管理和作业控制

### 1.1 后台运行和作业控制
- **后台运行**：使用 `&` 将命令放入后台运行
- **作业控制**：
  - `jobs`：查看后台作业
  - `fg %n`：将后台作业 n 切换到前台
  - `bg %n`：将前台作业 n 切换到后台
  - `Ctrl+Z`：将前台作业暂停并放入后台
  - `kill %n`：终止后台作业 n

```bash
# 后台运行命令
long_running_command &

# 查看后台作业
jobs

# 将作业 1 切换到前台
fg %1

# 将前台作业暂停并放入后台
# 按 Ctrl+Z

# 将作业 1 切换到后台继续运行
bg %1

# 终止作业 1
kill %1
```

### 1.2 进程监控和管理
- **pgrep**：根据进程名查找 PID
- **pkill**：根据进程名终止进程
- **top**：实时监控进程
- **htop**：交互式进程查看器（需要安装）
- **ps**：查看进程状态
- **kill**：终止进程
- **killall**：终止所有匹配的进程

```bash
# 根据进程名查找 PID
pgrep nginx

# 终止所有 nginx 进程
pkill nginx

# 查看进程树
ps auxf

# 查看进程的父进程和子进程
pstree -p <PID>

# 查看进程打开的文件
lsof -p <PID>

# 查看进程的网络连接
netstat -p | grep <PID>
# 或
ss -p | grep <PID>
```

### 1.3 进程间通信
- **管道**：使用 `|` 在进程间传递数据
- **命名管道（FIFO）**：创建一个命名管道用于进程间通信
- **信号**：使用 `kill` 命令发送信号
- **共享内存**：通过 `/dev/shm` 实现进程间共享内存

```bash
# 创建命名管道
mkfifo mypipe

# 在一个终端写入数据
echo "Hello from pipe" > mypipe

# 在另一个终端读取数据
cat < mypipe

# 删除命名管道
rm mypipe

# 使用信号通信
# 发送 SIGINT 信号（相当于 Ctrl+C）
kill -INT <PID>

# 发送 SIGTERM 信号（优雅终止）
kill -TERM <PID>

# 发送 SIGKILL 信号（强制终止）
kill -KILL <PID>
```

## 2. 网络编程

### 2.1 TCP 客户端和服务器
**TCP 服务器示例**：
```bash
#!/bin/bash

PORT=8080

# 创建 TCP 服务器
while true; do
    # 监听端口并接受连接
    echo "等待连接..."
    nc -l -p $PORT | while read line; do
        echo "收到：$line"
        echo "已处理：$line" >&0
    done
done
```

**TCP 客户端示例**：
```bash
#!/bin/bash

SERVER=localhost
PORT=8080

# 连接到 TCP 服务器
nc $SERVER $PORT << EOF
Hello Server
This is a test
EOF
```

### 2.2 UDP 客户端和服务器
**UDP 服务器示例**：
```bash
#!/bin/bash

PORT=8080

# 创建 UDP 服务器
while true; do
    nc -u -l -p $PORT | while read line; do
        echo "收到 UDP 消息：$line"
    done
done
```

**UDP 客户端示例**：
```bash
#!/bin/bash

SERVER=localhost
PORT=8080

# 发送 UDP 消息
nc -u $SERVER $PORT << EOF
Hello UDP Server
This is a test
EOF
```

### 2.3 HTTP 客户端
- **curl**：强大的 HTTP 客户端
- **wget**：用于下载文件
- **httpie**：现代化的 HTTP 客户端（需要安装）

```bash
# 使用 curl 发送 HTTP GET 请求
curl https://www.example.com

# 发送 HTTP POST 请求
curl -X POST -d "name=test&age=20" https://www.example.com/api

# 发送 JSON 数据
curl -X POST -H "Content-Type: application/json" -d '{"name":"test","age":20}' https://www.example.com/api

# 使用 wget 下载文件
wget https://www.example.com/file.zip

# 断点续传
wget -c https://www.example.com/largefile.zip
```

## 3. 多线程和并行处理

### 3.1 后台并行处理
```bash
#!/bin/bash

# 并行运行多个命令
for i in {1..5}; do
    (echo "任务 $i 开始"; sleep 2; echo "任务 $i 结束") &
done

# 等待所有后台任务完成
wait

echo "所有任务完成"
```

### 3.2 使用 GNU Parallel
GNU Parallel 是一个强大的并行执行工具，需要安装：

```bash
# 安装 GNU Parallel（Ubuntu）
sudo apt-get install parallel

# 并行执行命令
parallel echo "任务 {}" ::: {1..10}

# 并行处理文件
parallel gzip {} ::: *.txt

# 从标准输入读取并并行处理
cat filelist.txt | parallel wget {}

# 限制并行数
parallel -j 4 echo "任务 {}" ::: {1..10}
```

### 3.3 进程池实现
```bash
#!/bin/bash

# 进程池大小
POOL_SIZE=4

# 任务队列
TASKS=(
    "任务 1"
    "任务 2"
    "任务 3"
    "任务 4"
    "任务 5"
    "任务 6"
    "任务 7"
    "任务 8"
)

# 进程池实现
run_task() {
    local task=$1
    echo "开始处理：$task"
    sleep 2  # 模拟耗时操作
    echo "完成处理：$task"
}

# 主循环
for task in "${TASKS[@]}"; do
    # 检查进程池是否已满
    while [[ $(jobs -r | wc -l) -ge $POOL_SIZE ]]; do
        sleep 0.1
    done
    
    # 启动新任务
    run_task "$task" &
done

# 等待所有任务完成
wait

echo "所有任务处理完毕"
```

## 4. 安全编程

### 4.1 输入验证
```bash
#!/bin/bash

# 验证整数输入
validate_integer() {
    local input=$1
    if [[ ! $input =~ ^[0-9]+$ ]]; then
        echo "错误：输入必须是整数"
        return 1
    fi
    return 0
}

# 验证 IP 地址
validate_ip() {
    local ip=$1
    if [[ ! $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "错误：不是有效的 IP 地址"
        return 1
    fi
    return 0
}

# 验证用户名
validate_username() {
    local username=$1
    if [[ ! $username =~ ^[a-zA-Z0-9_]{3,20}$ ]]; then
        echo "错误：用户名必须是 3-20 个字符，只能包含字母、数字和下划线"
        return 1
    fi
    return 0
}
```

### 4.2 密码处理
- 使用 `read -s` 隐藏密码输入
- 使用 `openssl` 进行密码哈希
- 使用 `passwd` 命令修改密码

```bash
#!/bin/bash

# 隐藏密码输入
read -s -p "请输入密码：" password
echo
read -s -p "请确认密码：" password_confirm
echo

if [[ $password != $password_confirm ]]; then
    echo "错误：两次输入的密码不一致"
    exit 1
fi

# 使用 openssl 生成密码哈希
hash=$(openssl passwd -1 "$password")
echo "密码哈希：$hash"

# 验证密码
echo -n "请再次输入密码进行验证："
read -s password_test
echo

test_hash=$(openssl passwd -1 -salt "${hash%%\$*}" "$password_test")
if [[ $test_hash == $hash ]]; then
    echo "密码验证成功"
else
    echo "密码验证失败"
fi
```

### 4.3 权限管理
- **最小权限原则**：脚本只授予必要的权限
- **临时文件安全**：使用 `mktemp` 创建安全的临时文件
- **敏感数据保护**：避免在日志中记录敏感数据

```bash
#!/bin/bash

# 创建安全的临时文件
TEMP_FILE=$(mktemp)
echo "临时文件：$TEMP_FILE"

# 写入敏感数据
echo "敏感数据" > "$TEMP_FILE"

# 处理数据
cat "$TEMP_FILE"

# 删除临时文件
rm "$TEMP_FILE"

# 更安全的方式：使用 trap 确保临时文件被删除
TEMP_FILE=$(mktemp)
trap "rm -f '$TEMP_FILE'" EXIT

echo "敏感数据" > "$TEMP_FILE"
# 处理数据
```

## 5. 性能优化

### 5.1 减少外部命令调用
- 外部命令比内部命令慢很多
- 使用内部命令和内置功能替代外部命令

```bash
#!/bin/bash

# 外部命令（慢）
start_time=$(date +%s)
for i in {1..1000}; do
    echo "$i" > /dev/null
done
end_time=$(date +%s)
echo "外部命令耗时：$((end_time - start_time)) 秒"

# 内部命令（快）
start_time=$(date +%s)
for ((i=1; i<=1000; i++)); do
    : "$i"  # : 是空命令，不执行任何操作，只进行参数扩展
done
end_time=$(date +%s)
echo "内部命令耗时：$((end_time - start_time)) 秒"
```

### 5.2 优化循环
- 减少循环内的操作
- 避免在循环中使用管道和重定向
- 使用更高效的循环结构

```bash
#!/bin/bash

# 优化前：循环中使用外部命令和重定向
start_time=$(date +%s)
for file in *.txt; do
    wc -l "$file" >> line_counts.txt
done
end_time=$(date +%s)
echo "优化前耗时：$((end_time - start_time)) 秒"

# 优化后：一次性处理所有文件
start_time=$(date +%s)
wc -l *.txt > line_counts.txt
end_time=$(date +%s)
echo "优化后耗时：$((end_time - start_time)) 秒"
```

### 5.3 使用更快的工具
- **grep** 比 **awk** 和 **sed** 更快用于简单匹配
- **awk** 比 **sed** 更快用于复杂文本处理
- **rsync** 比 **cp** 更快用于大量文件复制
- **tar** 比 **zip** 更快用于文件压缩

### 5.4 并行处理
- 使用后台进程并行处理任务
- 使用 GNU Parallel 工具
- 使用 xargs 的 `-P` 选项并行处理

```bash
#!/bin/bash

# 使用 xargs 并行处理
# -P 4：使用 4 个进程并行处理
# -I {}：替换占位符
echo "处理文件..."
find . -name "*.txt" -print0 | xargs -0 -P 4 -I {} gzip "{}"
echo "处理完成"
```

## 6. 高级正则表达式

### 6.1 零宽断言
- **正向先行断言**：`(?=pattern)`
- **负向先行断言**：`(?!pattern)`
- **正向后行断言**：`(?<=pattern)`（bash 3.0+）
- **负向后行断言**：`(?<!pattern)`（bash 3.0+）

```bash
#!/bin/bash

# 正向先行断言：匹配 "apple" 后面跟着 "pie"
str="apple pie apple cake"
if [[ $str =~ apple(?= pie) ]]; then
    echo "匹配到：${BASH_REMATCH[0]}"
fi

# 负向先行断言：匹配 "apple" 后面不跟着 "pie"
if [[ $str =~ apple(?! pie) ]]; then
    echo "匹配到：${BASH_REMATCH[0]}"
fi

# 正向后行断言：匹配 "pie" 前面跟着 "apple"
if [[ $str =~ (?<=apple )pie ]]; then
    echo "匹配到：${BASH_REMATCH[0]}"
fi

# 负向后行断言：匹配 "cake" 前面不跟着 "apple"
if [[ $str =~ (?<!apple )cake ]]; then
    echo "匹配到：${BASH_REMATCH[0]}"
fi
```

### 6.2 捕获组和反向引用
```bash
#!/bin/bash

# 捕获组：匹配日期格式 YYYY-MM-DD
str="今天是 2023-01-01，明天是 2023-01-02"
pattern="([0-9]{4})-([0-9]{2})-([0-9]{2})"

if [[ $str =~ $pattern ]]; then
    echo "完整匹配：${BASH_REMATCH[0]}"
    echo "年：${BASH_REMATCH[1]}"
    echo "月：${BASH_REMATCH[2]}"
    echo "日：${BASH_REMATCH[3]}"
fi

# 全局匹配所有日期
while [[ $str =~ $pattern ]]; do
    echo "找到日期：${BASH_REMATCH[0]}"
    # 移除已匹配的部分，继续查找
    str=${str#*${BASH_REMATCH[0]}}
done

# 反向引用：匹配重复的单词
str="hello hello world world"
if [[ $str =~ \b(\w+)\s+\1\b ]]; then
    echo "重复的单词：${BASH_REMATCH[1]}"
fi
```

### 6.3 贪婪和非贪婪匹配
- 默认是贪婪匹配
- 使用 `*?`、`+?`、`??`、`{n,m}?` 进行非贪婪匹配（bash 3.0+）

```bash
#!/bin/bash

# 贪婪匹配：匹配最长的字符串
str="<div>内容1</div><div>内容2</div>"
if [[ $str =~ <div>(.*)</div> ]]; then
    echo "贪婪匹配：${BASH_REMATCH[0]}"
fi

# 非贪婪匹配：匹配最短的字符串
if [[ $str =~ <div>(.*?)</div> ]]; then
    echo "非贪婪匹配：${BASH_REMATCH[0]}"
fi
```

## 7. 高级调试技巧

### 7.1 使用 `set -x` 进行详细调试
```bash
#!/bin/bash

# 详细调试模式
set -x

# 调试输出格式设置（bash 4.4+）
# PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

# 脚本内容
var1=10
var2=20
result=$((var1 + var2))
echo "结果：$result"

set +x  # 关闭调试模式
```

### 7.2 使用 `trap` 进行错误跟踪
```bash
#!/bin/bash

# 错误跟踪函数
trap_error() {
    local exit_code=$?
    local line_no=$1
    local command="$2"
    echo "错误：在第 $line_no 行，命令 '$command' 执行失败，退出码：$exit_code"
}

# 设置错误跟踪
trap 'trap_error $LINENO "$BASH_COMMAND"' ERR

# 脚本内容
non_existent_command  # 这会失败
echo "这行不会执行"
```

### 7.3 使用 `bashdb` 进行交互式调试
`bashdb` 是 Bash 脚本的交互式调试器，需要安装：

```bash
# 安装 bashdb（Ubuntu）
sudo apt-get install bashdb

# 使用 bashdb 调试脚本
bashdb script.sh

# bashdb 命令
# break <line>：设置断点
# run：开始运行脚本
# next：执行下一行
# step：进入函数
# continue：继续执行
# print <var>：打印变量值
# quit：退出调试器
```

## 8. 脚本模块化和库

### 8.1 创建和使用库
**创建库文件 `lib/utils.sh`**：
```bash
#!/bin/bash

# 日志函数
log() {
    local level=$1
    local message=$2
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message"
}

# 错误处理函数
error_exit() {
    log "ERROR" "$1"
    exit 1
}

# 文件检查函数
check_file() {
    local file=$1
    if [[ ! -f "$file" ]]; then
        error_exit "文件不存在：$file"
    fi
}

# 目录检查函数
check_dir() {
    local dir=$1
    if [[ ! -d "$dir" ]]; then
        error_exit "目录不存在：$dir"
    fi
}

# 导出函数
export -f log error_exit check_file check_dir
```

**使用库文件**：
```bash
#!/bin/bash

# 导入库文件
source ./lib/utils.sh

# 使用库函数
log "INFO" "开始执行脚本"

# 检查文件
check_file "input.txt"

# 检查目录
check_dir "output"

log "INFO" "脚本执行完成"
```

### 8.2 动态加载库
```bash
#!/bin/bash

# 动态加载库
load_library() {
    local lib_path=$1
    if [[ -f "$lib_path" ]]; then
        source "$lib_path"
        log "INFO" "加载库成功：$lib_path"
    else
        echo "错误：库文件不存在：$lib_path"
        exit 1
    fi
}

# 加载多个库
for lib in ./lib/*.sh; do
    load_library "$lib"
done
```

## 9. 系统编程接口

### 9.1 使用 `/proc` 文件系统
`/proc` 文件系统提供了访问系统信息的接口：

```bash
#!/bin/bash

# 获取系统信息
echo "=== 系统信息 ==="
echo "内核版本：$(cat /proc/version)"
echo "CPU 信息：$(cat /proc/cpuinfo | grep "model name" | head -1 | cut -d: -f2)"
echo "内存总量：$(cat /proc/meminfo | grep "MemTotal" | cut -d: -f2)"
echo "系统负载：$(cat /proc/loadavg)"

# 获取进程信息
pid=$$
echo -e "\n=== 进程 $pid 信息 ==="
echo "进程命令：$(cat /proc/$pid/cmdline | tr '\0' ' ')"
echo "进程状态：$(cat /proc/$pid/status | grep State | cut -d: -f2)"
echo "进程内存：$(cat /proc/$pid/status | grep VmRSS | cut -d: -f2)"
```

### 9.2 使用 `sysctl` 命令
`sysctl` 命令用于配置内核参数：

```bash
#!/bin/bash

# 查看所有内核参数
sysctl -a

# 查看特定参数
sysctl kernel.version
sysctl vm.swappiness

# 修改内核参数（临时）
sudo sysctl -w vm.swappiness=10

# 永久修改内核参数
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### 9.3 使用 `ioctl` 和 `fcntl`
`ioctl` 和 `fcntl` 是用于设备控制的系统调用，可以通过 `dd`、`stty` 等命令间接使用：

```bash
#!/bin/bash

# 获取终端大小
rows=$(tput lines)
cols=$(tput cols)
echo "终端大小：$rows 行，$cols 列"

# 设置终端属性
stty -echo  # 关闭回显
read -s -p "请输入密码：" password
echo
stty echo  # 开启回显
```

## 10. 高级字符串和数组操作

### 10.1 字符串高级操作
```bash
#!/bin/bash

str="Hello World"

# 字符串反转
reverse_str() {
    local str=$1
    echo $str | rev
}

echo "反转字符串：$(reverse_str "$str")"

# 字符串替换（使用正则表达式）
echo "替换所有空格：${str// /_}"

# 字符串大小写转换
echo "大写：${str^^}"
echo "小写：${str,,}"
echo "首字母大写：${str^}"

# 字符串分割为数组
IFS=' ' read -r -a str_array <<< "$str"
echo "数组元素：${str_array[@]}"
```

### 10.2 数组高级操作
```bash
#!/bin/bash

# 创建数组
array=(apple banana orange grape)

# 数组排序
sorted_array=($(printf '%s\n' "${array[@]}" | sort))
echo "排序后：${sorted_array[@]}"

# 数组去重
dup_array=(apple banana apple orange banana)
unique_array=($(printf '%s\n' "${dup_array[@]}" | sort | uniq))
echo "去重后：${unique_array[@]}"

# 数组过滤
even_array=($(for i in {1..10}; do echo $i; done | grep -E '[02468]$'))
echo "偶数数组：${even_array[@]}"

# 数组映射
doubled_array=($(for i in {1..5}; do echo $((i * 2)); done))
echo "加倍数组：${doubled_array[@]}"

# 数组归约（求和）
sum=0
for i in {1..5}; do sum=$((sum + i)); done
echo "数组求和：$sum"
```

## 11. 最佳实践

1. **使用 `set -euxo pipefail`**：提高脚本健壮性
2. **使用函数封装重复代码**：提高代码复用性和可维护性
3. **使用局部变量**：避免变量名冲突
4. **使用有意义的变量名**：提高代码可读性
5. **编写详细的注释**：解释复杂逻辑
6. **使用版本控制**：管理脚本版本
7. **测试脚本**：在不同环境中测试
8. **处理错误情况**：使用 `trap` 捕获错误
9. **使用安全的临时文件**：使用 `mktemp` 创建临时文件
10. **限制权限**：脚本只授予必要的执行权限
11. **避免硬编码**：使用配置文件或命令行参数
12. **使用日志记录**：记录脚本执行过程
13. **优化性能**：减少外部命令调用，使用高效算法
14. **遵循编码规范**：统一的代码风格

## 12. 资源推荐

- [Bash 官方文档](https://www.gnu.org/software/bash/manual/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Bash Hackers Wiki](https://wiki.bash-hackers.org/)
- [ShellCheck](https://www.shellcheck.net/)：Shell 脚本静态分析工具
- [GNU Parallel 文档](https://www.gnu.org/software/parallel/)
- [Bashdb 文档](https://bashdb.sourceforge.net/)
- [Linux 系统编程](https://man7.org/linux/man-pages/)

## 13. 总结

Shell 脚本是一种强大的工具，可以用于自动化各种系统任务。通过掌握高级功能，您可以编写更高效、更安全、更可维护的脚本。本文介绍了 Shell 脚本的高级功能，包括进程管理、网络编程、多线程、安全编程、性能优化等。希望这些内容对您有所帮助，让您能够编写更强大的 Shell 脚本。