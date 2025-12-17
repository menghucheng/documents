# Shell 常用命令

## 1. 文件和目录操作

### 1.1 查看目录内容

#### ls - 列出目录内容
**语法**：`ls [选项] [目录]`

**功能**：列出目录中的文件和子目录

**常用选项**：
- `-l`：以长格式显示（包含权限、所有者、大小、修改时间等）
- `-a`：显示所有文件和目录（包括隐藏文件，以 `.` 开头的文件）
- `-h`：以人性化方式显示文件大小（如 KB、MB、GB）
- `-t`：按修改时间排序（最新的文件排在前面）
- `-r`：反向排序

**示例**：
```bash
# 列出当前目录内容
ls

# 列出当前目录内容，包括隐藏文件
ls -a

# 以长格式显示当前目录内容
ls -l

# 以长格式显示 /home 目录内容，并按修改时间排序
ls -lt /home

# 以人性化方式显示文件大小
ls -lh
```

### 1.2 切换目录

#### cd - 切换工作目录
**语法**：`cd [目录]`

**功能**：切换当前工作目录

**特殊目录**：
- `cd` 或 `cd ~`：切换到用户主目录
- `cd -`：切换到上一个工作目录
- `cd ..`：切换到父目录
- `cd .`：切换到当前目录（无实际作用）

**示例**：
```bash
# 切换到 /home/user 目录
cd /home/user

# 切换到主目录
cd ~

# 切换到上一个目录
cd -

# 切换到父目录
cd ..
```

### 1.3 创建目录

#### mkdir - 创建目录
**语法**：`mkdir [选项] 目录名`

**常用选项**：
- `-p`：递归创建目录（如果父目录不存在，则自动创建）
- `-m`：设置目录权限（如 `-m 755`）

**示例**：
```bash
# 创建单个目录
mkdir test

# 递归创建目录结构
mkdir -p /home/user/docs/project

# 创建目录并设置权限
mkdir -m 755 public
```

### 1.4 删除目录

#### rmdir - 删除空目录
**语法**：`rmdir [选项] 目录名`

**常用选项**：
- `-p`：递归删除目录（如果父目录也为空）

**示例**：
```bash
# 删除空目录
rmdir test

# 递归删除目录结构
rmdir -p /home/user/docs/project
```

#### rm - 删除文件或目录
**语法**：`rm [选项] 文件或目录`

**常用选项**：
- `-f`：强制删除（不提示确认）
- `-r` 或 `-R`：递归删除目录及其内容
- `-i`：交互式删除（删除前提示确认）

**示例**：
```bash
# 删除单个文件
rm file.txt

# 强制删除文件
rm -f file.txt

# 递归删除目录及其内容
rm -r dir

# 强制递归删除目录
rm -rf dir
```

### 1.5 复制文件和目录

#### cp - 复制文件或目录
**语法**：`cp [选项] 源文件 目标文件` 或 `cp [选项] 源文件... 目标目录`

**常用选项**：
- `-r` 或 `-R`：递归复制目录及其内容
- `-f`：强制复制（覆盖已存在的文件）
- `-i`：交互式复制（覆盖前提示确认）
- `-p`：保留文件属性（权限、所有者、时间戳等）
- `-a`：归档复制（相当于 `-dpR`，保留所有属性并递归复制）

**示例**：
```bash
# 复制单个文件到目标位置
cp file.txt /home/user/

# 复制多个文件到目标目录
cp file1.txt file2.txt /home/user/

# 递归复制目录
cp -r dir /home/user/

# 保留属性复制目录
cp -a dir /home/user/
```

### 1.6 移动和重命名

#### mv - 移动或重命名文件/目录
**语法**：`mv [选项] 源文件 目标文件` 或 `mv [选项] 源文件... 目标目录`

**常用选项**：
- `-f`：强制移动（覆盖已存在的文件）
- `-i`：交互式移动（覆盖前提示确认）

**示例**：
```bash
# 重命名文件
mv oldname.txt newname.txt

# 移动文件到目标目录
mv file.txt /home/user/

# 移动多个文件到目标目录
mv file1.txt file2.txt /home/user/

# 移动目录
mv dir /home/user/
```

### 1.7 查看文件内容

#### cat - 查看文件内容
**语法**：`cat [选项] [文件]`

**功能**：连接并显示文件内容

**常用选项**：
- `-n`：显示行号
- `-b`：显示行号（不包括空行）

**示例**：
```bash
# 查看文件内容
cat file.txt

# 查看文件内容并显示行号
cat -n file.txt

# 连接多个文件内容并显示
cat file1.txt file2.txt
```

#### head - 查看文件开头
**语法**：`head [选项] [文件]`

**功能**：显示文件的前几行

**常用选项**：
- `-n <行数>`：显示前 n 行（默认 10 行）

**示例**：
```bash
# 查看文件前 10 行
head file.txt

# 查看文件前 20 行
head -n 20 file.txt
```

#### tail - 查看文件结尾
**语法**：`tail [选项] [文件]`

**功能**：显示文件的最后几行

**常用选项**：
- `-n <行数>`：显示最后 n 行（默认 10 行）
- `-f`：实时跟踪文件内容变化（常用于查看日志文件）
- `-F`：与 `-f` 类似，但如果文件被删除并重新创建，会继续跟踪

**示例**：
```bash
# 查看文件最后 10 行
tail file.txt

# 查看文件最后 20 行
tail -n 20 file.txt

# 实时跟踪日志文件
tail -f /var/log/syslog
```

#### less - 分页查看文件内容
**语法**：`less [文件]`

**功能**：以分页方式查看文件内容，支持上下滚动、搜索等功能

**常用操作**：
- 空格键：向下翻页
- `b`：向上翻页
- `q`：退出
- `/关键词`：向下搜索关键词
- `?关键词`：向上搜索关键词
- `n`：继续搜索下一个匹配项
- `N`：继续搜索上一个匹配项

**示例**：
```bash
# 分页查看文件内容
less file.txt

# 分页查看命令输出
ls -la | less
```

### 1.8 创建文件

#### touch - 创建空文件或修改文件时间
**语法**：`touch [选项] 文件`

**功能**：
- 如果文件不存在，创建空文件
- 如果文件已存在，更新文件的访问时间和修改时间

**示例**：
```bash
# 创建空文件
touch file.txt

# 创建多个空文件
touch file1.txt file2.txt file3.txt
```

#### echo - 输出文本或创建文件
**语法**：`echo [选项] [字符串]`

**功能**：输出字符串到终端，或通过重定向创建文件

**常用选项**：
- `-n`：不输出换行符
- `-e`：启用转义字符（如 `\n` 换行、`\t` 制表符）

**示例**：
```bash
# 输出文本到终端
echo "Hello World"

# 创建文件并写入内容
echo "Hello World" > file.txt

# 追加内容到文件
echo "追加内容" >> file.txt

# 使用转义字符
echo -e "第一行\n第二行\t制表符"
```

## 2. 文本处理

### 2.1 grep - 搜索文本
**语法**：`grep [选项] 模式 [文件]`

**功能**：在文件或输入流中搜索匹配指定模式的行

**常用选项**：
- `-i`：忽略大小写
- `-n`：显示匹配行的行号
- `-v`：反向搜索（显示不匹配的行）
- `-r` 或 `-R`：递归搜索目录中的所有文件
- `-l`：只显示包含匹配模式的文件名
- `-c`：只显示匹配的行数
- `-A <行数>`：显示匹配行及其后的 n 行
- `-B <行数>`：显示匹配行及其前的 n 行
- `-C <行数>`：显示匹配行及其前后的 n 行

**示例**：
```bash
# 在 file.txt 中搜索 "error" 字符串
grep "error" file.txt

# 在 file.txt 中搜索 "error"，忽略大小写
grep -i "error" file.txt

# 在 file.txt 中搜索 "error"，并显示行号
grep -n "error" file.txt

# 递归搜索目录中所有文件的 "error"
grep -r "error" /home/user/

# 搜索 "error"，并显示匹配行及其前后 2 行
grep -C 2 "error" file.txt
```

### 2.2 sed - 流编辑器
**语法**：`sed [选项] [命令] [文件]`

**功能**：对文本进行编辑（替换、删除、插入等）

**常用选项**：
- `-i`：直接修改文件内容（不使用该选项则只输出到终端）
- `-e`：执行多个编辑命令

**常用命令**：
- `s/旧字符串/新字符串/`：替换匹配的字符串
- `d`：删除匹配的行
- `i\文本`：在匹配行前插入文本
- `a\文本`：在匹配行后追加文本

**示例**：
```bash
# 替换文件中的字符串（只输出到终端）
sed 's/old/new/' file.txt

# 替换文件中的所有匹配项（全局替换）
sed 's/old/new/g' file.txt

# 直接修改文件内容
sed -i 's/old/new/g' file.txt

# 删除包含 "error" 的行
sed '/error/d' file.txt

# 在包含 "title" 的行前插入文本
sed '/title/i\# 这是标题' file.txt
```

### 2.3 awk - 文本处理工具
**语法**：`awk [选项] '命令' [文件]`

**功能**：强大的文本处理工具，用于处理结构化数据

**常用选项**：
- `-F`：指定字段分隔符（默认是空格）

**示例**：
```bash
# 输出文件的第一列和第三列
awk '{print $1, $3}' file.txt

# 指定分隔符为逗号
awk -F ',' '{print $1, $2}' csvfile.csv

# 输出包含 "error" 的行
awk '/error/ {print}' file.txt

# 计算文件第一列的总和
awk '{sum += $1} END {print sum}' numbers.txt

# 统计文件行数
awk 'END {print NR}' file.txt
```

### 2.4 sort - 排序文本
**语法**：`sort [选项] [文件]`

**功能**：对文本行进行排序

**常用选项**：
- `-n`：按数值排序（默认按字典序排序）
- `-r`：反向排序
- `-k <列号>`：按指定列排序
- `-t <分隔符>`：指定字段分隔符
- `-u`：去除重复行

**示例**：
```bash
# 对文件内容进行排序
sort file.txt

# 按数值排序
sort -n numbers.txt

# 反向排序
sort -r file.txt

# 按第二列排序（以空格为分隔符）
sort -k 2 file.txt

# 按逗号分隔的第二列排序
sort -t ',' -k 2 csvfile.csv

# 去除重复行
sort -u file.txt
```

### 2.5 uniq - 去除重复行
**语法**：`uniq [选项] [文件]`

**功能**：去除连续的重复行

**注意**：`uniq` 只能去除连续的重复行，所以通常与 `sort` 结合使用

**常用选项**：
- `-c`：显示每行出现的次数
- `-u`：只显示出现一次的行
- `-d`：只显示重复的行

**示例**：
```bash
# 去除连续重复行
uniq file.txt

# 统计每行出现次数
sort file.txt | uniq -c

# 只显示出现一次的行
sort file.txt | uniq -u

# 只显示重复的行
sort file.txt | uniq -d
```

## 3. 系统管理

### 3.1 查看系统信息

#### uname - 查看系统信息
**语法**：`uname [选项]`

**功能**：显示系统信息

**常用选项**：
- `-a`：显示所有系统信息
- `-s`：显示内核名称
- `-n`：显示主机名
- `-r`：显示内核版本
- `-v`：显示内核编译日期
- `-m`：显示硬件架构

**示例**：
```bash
# 显示所有系统信息
uname -a

# 显示内核名称
uname -s

# 显示主机名
uname -n
```

#### hostname - 查看或设置主机名
**语法**：`hostname [选项] [新主机名]`

**功能**：查看当前主机名或设置新主机名

**示例**：
```bash
# 查看当前主机名
hostname

# 设置新主机名（需要 root 权限）
hostname new-hostname
```

#### uptime - 查看系统运行时间
**语法**：`uptime`

**功能**：显示系统运行时间、登录用户数和系统负载

**示例**：
```bash
# 查看系统运行时间
uptime
```

#### who - 查看登录用户
**语法**：`who [选项]`

**功能**：显示当前登录系统的用户信息

**常用选项**：
- `-a`：显示所有信息
- `-b`：显示系统启动时间

**示例**：
```bash
# 查看当前登录用户
who

# 查看系统启动时间
who -b
```

### 3.2 查看和管理用户

#### id - 查看用户ID和组ID
**语法**：`id [用户名]`

**功能**：显示用户的UID、GID和所属的组

**示例**：
```bash
# 查看当前用户的ID信息
id

# 查看指定用户的ID信息
id username
```

#### whoami - 查看当前用户名
**语法**：`whoami`

**功能**：显示当前登录用户的用户名

**示例**：
```bash
# 查看当前用户名
whoami
```

#### passwd - 更改用户密码
**语法**：`passwd [用户名]`

**功能**：更改用户密码

**示例**：
```bash
# 更改当前用户密码
passwd

# 更改指定用户密码（需要 root 权限）
passwd username
```

## 4. 网络命令

### 4.1 ping - 测试网络连接
**语法**：`ping [选项] 主机名或IP地址`

**功能**：测试与目标主机的网络连接

**常用选项**：
- `-c <次数>`：发送指定次数的ICMP请求后停止
- `-i <间隔>`：设置发送ICMP请求的间隔时间（秒）
- `-s <大小>`：设置ICMP请求的数据包大小

**示例**：
```bash
# 测试与 www.baidu.com 的连接
ping www.baidu.com

# 发送 5 次 ICMP 请求后停止
ping -c 5 www.baidu.com

# 设置间隔为 2 秒，发送 3 次请求
ping -c 3 -i 2 www.baidu.com
```

### 4.2 ifconfig - 配置网络接口（旧版）
**语法**：`ifconfig [接口] [选项]`

**功能**：查看或配置网络接口（在新版本系统中被 `ip` 命令替代）

**示例**：
```bash
# 查看所有网络接口信息
ifconfig

# 查看指定接口信息
ifconfig eth0
```

### 4.3 ip - 配置网络接口（新版）
**语法**：`ip [选项] [命令] [参数]`

**功能**：查看或配置网络接口、路由、ARP表等

**常用命令**：
- `link`：查看或配置网络接口
- `addr`：查看或配置IP地址
- `route`：查看或配置路由表
- `neigh`：查看或配置ARP表

**示例**：
```bash
# 查看所有网络接口信息
ip link

# 查看所有IP地址
ip addr

# 查看路由表
ip route

# 查看ARP表
ip neigh
```

### 4.4 netstat - 查看网络状态
**语法**：`netstat [选项]`

**功能**：查看网络连接、路由表、接口统计等

**常用选项**：
- `-t`：显示TCP连接
- `-u`：显示UDP连接
- `-n`：以数字形式显示地址和端口
- `-l`：显示监听状态的连接
- `-p`：显示进程ID和进程名
- `-a`：显示所有连接

**示例**：
```bash
# 查看所有TCP连接
netstat -t

# 查看监听状态的TCP连接
netstat -tl

# 查看所有连接，包括进程信息
netstat -tulpn
```

### 4.5 ss - 查看网络状态（新版）
**语法**：`ss [选项]`

**功能**：查看网络连接、套接字等（替代 `netstat`）

**常用选项**：
- `-t`：显示TCP连接
- `-u`：显示UDP连接
- `-n`：以数字形式显示
- `-l`：显示监听状态
- `-p`：显示进程信息
- `-a`：显示所有连接

**示例**：
```bash
# 查看所有TCP连接
ss -t

# 查看监听状态的TCP连接
ss -tl

# 查看所有连接，包括进程信息
ss -tulpn
```

### 4.6 curl - 网络请求工具
**语法**：`curl [选项] URL`

**功能**：发送HTTP请求，下载文件等

**常用选项**：
- `-O`：将输出保存为文件名与URL中的文件名相同的文件
- `-o <文件名>`：将输出保存为指定文件名
- `-L`：跟随重定向
- `-s`：静默模式（不显示进度和错误信息）
- `-i`：显示响应头信息
- `-X <方法>`：指定HTTP请求方法（GET、POST、PUT、DELETE等）
- `-d <数据>`：发送POST数据

**示例**：
```bash
# 发送GET请求并显示响应
curl https://www.example.com

# 下载文件
curl -O https://www.example.com/file.txt

# 保存为指定文件名
curl -o localfile.txt https://www.example.com/file.txt

# 发送POST请求
curl -X POST -d "name=test&age=20" https://www.example.com/api

# 显示响应头信息
curl -i https://www.example.com
```

### 4.7 wget - 下载文件工具
**语法**：`wget [选项] URL`

**功能**：从网络上下载文件

**常用选项**：
- `-O <文件名>`：将输出保存为指定文件名
- `-P <目录>`：将文件保存到指定目录
- `-c`：断点续传
- `-r`：递归下载（下载整个网站）
- `-np`：不跟随父目录
- `-nH`：不创建以主机名为名的目录

**示例**：
```bash
# 下载文件
wget https://www.example.com/file.txt

# 保存为指定文件名
wget -O localfile.txt https://www.example.com/file.txt

# 保存到指定目录
wget -P /home/user/downloads https://www.example.com/file.txt

# 断点续传
wget -c https://www.example.com/largefile.zip
```

## 5. 进程管理

### 5.1 ps - 查看进程
**语法**：`ps [选项]`

**功能**：查看当前运行的进程

**常用选项**：
- `-e` 或 `-A`：显示所有进程
- `-f`：显示完整格式的进程信息
- `-l`：显示长格式的进程信息
- `-u <用户名>`：显示指定用户的进程
- `-p <PID>`：显示指定PID的进程
- `aux`：BSD风格的进程列表（常用组合）

**示例**：
```bash
# 查看当前终端的进程
ps

# 查看所有进程
ps -e

# 查看所有进程的完整信息
ps -ef

# 查看指定用户的进程
ps -u username

# 常用组合：查看所有进程的详细信息
ps aux
```

### 5.2 top - 实时查看进程
**语法**：`top [选项]`

**功能**：实时显示系统中占用资源最多的进程

**常用操作**：
- `q`：退出
- `P`：按CPU使用率排序
- `M`：按内存使用率排序
- `T`：按运行时间排序
- `k`：终止指定PID的进程
- `1`：显示所有CPU核心的使用率

**示例**：
```bash
# 启动top

# 按CPU使用率排序
top

# 显示所有CPU核心
top -1
```

### 5.3 kill - 终止进程
**语法**：`kill [选项] PID`

**功能**：向进程发送信号，默认发送SIGTERM（终止）信号

**常用信号**：
- `15` 或 `SIGTERM`：终止进程（默认）
- `9` 或 `SIGKILL`：强制终止进程
- `2` 或 `SIGINT`：中断进程（相当于Ctrl+C）

**示例**：
```bash
# 终止指定PID的进程
kill 1234

# 强制终止进程
kill -9 1234

# 向进程发送中断信号
kill -2 1234
```

### 5.4 pkill - 根据进程名终止进程
**语法**：`pkill [选项] 进程名`

**功能**：根据进程名终止匹配的进程

**常用选项**：
- `-i`：忽略大小写

**示例**：
```bash
# 终止所有名为 "chrome" 的进程
pkill chrome

# 忽略大小写终止进程
pkill -i chrome
```

### 5.5 pgrep - 根据进程名查找PID
**语法**：`pgrep [选项] 进程名`

**功能**：根据进程名查找匹配的进程PID

**常用选项**：
- `-i`：忽略大小写
- `-l`：显示进程名和PID

**示例**：
```bash
# 查找所有名为 "chrome" 的进程PID
pgrep chrome

# 显示进程名和PID
pgrep -l chrome
```

## 6. 权限管理

### 6.1 chmod - 修改文件权限
**语法**：`chmod [选项] 权限 文件`

**功能**：修改文件或目录的访问权限

**权限表示方法**：
- **数字表示法**：
  - r（读）：4
  - w（写）：2
  - x（执行）：1
  - 无权限：0
  - 权限组合：rwx=7, rw-=6, r-x=5, r--=4, -wx=3, -w-=2, --x=1, ---=0
- **符号表示法**：
  - u：所有者
  - g：所属组
  - o：其他用户
  - a：所有用户
  - +：添加权限
  - -：移除权限
  - =：设置权限

**示例**：
```bash
# 使用数字表示法设置权限（所有者可读可写可执行，所属组可读可执行，其他用户可读）
chmod 754 file.txt

# 使用符号表示法添加执行权限
chmod +x script.sh

# 移除其他用户的写权限
chmod o-w file.txt

# 设置所有者可读可写，所属组和其他用户可读
chmod u=rw,go=r file.txt

# 递归修改目录及其内容的权限
chmod -R 755 dir
```

### 6.2 chown - 修改文件所有者
**语法**：`chown [选项] 所有者[:所属组] 文件`

**功能**：修改文件或目录的所有者和所属组

**常用选项**：
- `-R`：递归修改目录及其内容的所有者

**示例**：
```bash
# 修改文件所有者
chown username file.txt

# 修改文件所有者和所属组
chown username:groupname file.txt

# 只修改所属组
chown :groupname file.txt

# 递归修改目录及其内容的所有者
chown -R username dir
```

### 6.3 chgrp - 修改文件所属组
**语法**：`chgrp [选项] 所属组 文件`

**功能**：修改文件或目录的所属组

**常用选项**：
- `-R`：递归修改目录及其内容的所属组

**示例**：
```bash
# 修改文件所属组
chgrp groupname file.txt

# 递归修改目录及其内容的所属组
chgrp -R groupname dir
```

## 7. 压缩和解压缩

### 7.1 tar - 归档工具
**语法**：`tar [选项] 归档文件 [文件或目录]`

**功能**：创建、查看或提取归档文件

**常用选项**：
- `-c`：创建归档文件
- `-x`：提取归档文件
- `-v`：显示详细信息
- `-f`：指定归档文件名
- `-z`：使用gzip压缩
- `-j`：使用bzip2压缩
- `-J`：使用xz压缩
- `-t`：查看归档文件内容
- `-C`：指定提取目录

**示例**：
```bash
# 创建tar归档文件
tar -cvf archive.tar file1.txt file2.txt dir

# 创建gzip压缩的tar文件（.tar.gz 或 .tgz）
tar -czvf archive.tar.gz file1.txt file2.txt dir

# 创建bzip2压缩的tar文件（.tar.bz2 或 .tbz2）
tar -cjvf archive.tar.bz2 file1.txt file2.txt dir

# 查看归档文件内容
tar -tvf archive.tar

# 提取归档文件到当前目录
tar -xvf archive.tar

# 提取归档文件到指定目录
tar -xvf archive.tar.gz -C /home/user/

# 只提取归档文件中的特定文件
tar -xvf archive.tar file1.txt
```

### 7.2 gzip - 压缩文件
**语法**：`gzip [选项] 文件`

**功能**：使用gzip算法压缩文件

**常用选项**：
- `-d`：解压缩文件
- `-r`：递归压缩目录中的文件
- `-l`：显示压缩文件的详细信息

**示例**：
```bash
# 压缩文件（生成 file.txt.gz，原文件被删除）
gzip file.txt

# 解压缩文件
gzip -d file.txt.gz

# 递归压缩目录中的文件
gzip -r dir
```

### 7.3 gunzip - 解压缩gzip文件
**语法**：`gunzip [选项] 文件`

**功能**：解压缩gzip压缩的文件

**示例**：
```bash
# 解压缩文件
gunzip file.txt.gz
```

### 7.4 zip - 压缩文件
**语法**：`zip [选项] 压缩文件 [文件或目录]`

**功能**：创建ZIP格式的压缩文件

**常用选项**：
- `-r`：递归压缩目录中的文件
- `-m`：压缩后删除原文件
- `-q`：静默模式
- `-9`：最高压缩比

**示例**：
```bash
# 创建zip压缩文件
zip archive.zip file1.txt file2.txt

# 递归压缩目录
zip -r archive.zip dir

# 压缩后删除原文件
zip -m archive.zip file.txt
```

### 7.5 unzip - 解压缩zip文件
**语法**：`unzip [选项] 压缩文件`

**功能**：解压缩ZIP格式的压缩文件

**常用选项**：
- `-d <目录>`：指定解压缩目录
- `-l`：查看压缩文件内容
- `-q`：静默模式

**示例**：
```bash
# 解压缩文件到当前目录
unzip archive.zip

# 解压缩文件到指定目录
unzip archive.zip -d /home/user/

# 查看压缩文件内容
unzip -l archive.zip
```

## 8. 磁盘管理

### 8.1 df - 查看磁盘空间
**语法**：`df [选项] [文件或目录]`

**功能**：显示文件系统的磁盘空间使用情况

**常用选项**：
- `-h`：以人性化方式显示磁盘大小
- `-T`：显示文件系统类型

**示例**：
```bash
# 查看所有文件系统的磁盘空间使用情况
df

# 以人性化方式显示
df -h

# 显示文件系统类型
df -T

# 查看指定目录所在文件系统的磁盘空间
df -h /home
```

### 8.2 du - 查看目录大小
**语法**：`du [选项] [文件或目录]`

**功能**：显示文件或目录的磁盘使用情况

**常用选项**：
- `-h`：以人性化方式显示大小
- `-s`：只显示总计大小
- `-a`：显示所有文件和目录的大小
- `-c`：显示总计大小

**示例**：
```bash
# 查看当前目录的大小
du -sh

# 查看指定目录的大小
du -sh /home/user

# 查看目录中所有文件和子目录的大小
du -h dir

# 显示目录大小并显示总计
du -ch dir
```

### 8.3 mount - 挂载文件系统
**语法**：`mount [选项] 设备 挂载点`

**功能**：挂载文件系统到指定挂载点

**常用选项**：
- `-t <类型>`：指定文件系统类型
- `-o <选项>`：挂载选项（如 rw 读写，ro 只读）

**示例**：
```bash
# 挂载USB设备
t mount /dev/sdb1 /mnt/usb

# 挂载ISO文件
mount -o loop /path/to/file.iso /mnt/iso

# 查看已挂载的文件系统
mount
```

### 8.4 umount - 卸载文件系统
**语法**：`umount [选项] 挂载点或设备`

**功能**：卸载已挂载的文件系统

**常用选项**：
- `-f`：强制卸载

**示例**：
```bash
# 卸载挂载点
umount /mnt/usb

# 卸载设备
umount /dev/sdb1

# 强制卸载
umount -f /mnt/usb
```

## 9. 环境变量

### 9.1 env - 查看环境变量
**语法**：`env [选项]`

**功能**：显示当前环境变量

**示例**：
```bash
# 查看所有环境变量
env

# 查看指定环境变量
echo $PATH
echo $HOME
echo $USER
```

### 9.2 export - 设置环境变量
**语法**：`export 变量名=值`

**功能**：设置环境变量

**示例**：
```bash
# 设置临时环境变量
export PATH=$PATH:/new/path

# 设置永久环境变量（需要写入配置文件）
echo "export PATH=$PATH:/new/path" >> ~/.bashrc
# 或
echo "export PATH=$PATH:/new/path" >> ~/.profile

# 使配置文件立即生效
source ~/.bashrc
# 或
. ~/.bashrc
```

## 10. 其他常用命令

### 10.1 clear - 清屏
**语法**：`clear`

**功能**：清除终端屏幕内容

**示例**：
```bash
# 清屏
clear
```

### 10.2 history - 查看命令历史
**语法**：`history [选项]`

**功能**：显示命令历史记录

**常用选项**：
- `-c`：清除命令历史
- `-d <偏移量>`：删除指定位置的历史命令

**示例**：
```bash
# 查看命令历史
history

# 执行历史中的第 100 条命令
!100

# 执行上一条命令
!!

# 执行以 "ls" 开头的最后一条命令
!ls

# 清除命令历史
history -c
```

### 10.3 alias - 设置命令别名
**语法**：`alias [别名=命令]`

**功能**：设置或查看命令别名

**示例**：
```bash
# 设置别名
alias ll='ls -la'
alias grep='grep --color=auto'

# 查看所有别名
alias

# 取消别名
unalias ll
```

### 10.4 which - 查找命令位置
**语法**：`which [命令]`

**功能**：显示命令的完整路径

**示例**：
```bash
# 查找 ls 命令的位置
which ls

# 查找 grep 命令的位置
which grep
```

### 10.5 locate - 查找文件
**语法**：`locate [选项] 文件名`

**功能**：根据数据库快速查找文件

**常用选项**：
- `-i`：忽略大小写
- `-r`：使用正则表达式

**注意**：locate 使用的数据库需要定期更新，使用 `updatedb` 命令更新（需要 root 权限）

**示例**：
```bash
# 查找包含 "file" 的文件
locate file

# 忽略大小写查找
locate -i file

# 更新数据库
updatedb
```

### 10.6 find - 查找文件
**语法**：`find [路径] [选项] [表达式]`

**功能**：在指定路径下查找文件

**常用选项**：
- `-name <文件名>`：按文件名查找
- `-type <类型>`：按文件类型查找（f 普通文件，d 目录，l 符号链接）
- `-size <大小>`：按文件大小查找（如 +100M 大于100MB，-10K 小于10KB）
- `-mtime <天数>`：按修改时间查找（如 +7 超过7天，-7 少于7天）
- `-user <用户名>`：按所有者查找
- `-exec <命令> {} \;`：对查找结果执行命令

**示例**：
```bash
# 在当前目录查找文件名包含 "file" 的文件
find . -name "*file*"

# 在 /home 目录查找所有普通文件
find /home -type f

# 查找大于 100MB 的文件
find / -type f -size +100M

# 查找最近7天修改过的文件
find . -type f -mtime -7

# 查找文件并删除（谨慎使用）
find . -name "*.tmp" -type f -exec rm {} \;

# 查找文件并显示详细信息
find . -name "*.txt" -type f -exec ls -la {} \;```