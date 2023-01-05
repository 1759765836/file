@echo off
echo From https://raw.hellogithub.com/hosts Update the ip of github in to the hosts file.
echo Can be updated repeatedly.
setlocal enabledelayedexpansion

rem 根据内容标记符号
set "start_flag=0"

rem 将 hosts 文件中的内容覆盖（单个大于号）到临时文件 temp 中
type C:\Windows\System32\drivers\etc\hosts > temp
rem 清空文件
::type null > C:\Windows\System32\drivers\etc\hosts
cd. > C:\Windows\System32\drivers\etc\hosts

rem 使用 findstr /n 读取临时文件 temp 的每一行，并在行前添加行号
for /f "delims=" %%i in ('findstr /n .* temp') do (
set "line=%%i"
rem 删除行号
set "line=!line:*:=!"
rem 如果读到的行是 "# Start"，设置开始标记
if "!line!" == "# GitHub520 Host Start" set "start_flag=1"

rem 如果没有达到开始标记，则将该行写入新的 hosts 文件中
if not "!start_flag!" == "1" echo.!line!>> hosts

rem 如果读到的行是 "# End"，设置结束标记
if "!line!" == "# GitHub520 Host End" set "start_flag=0"
)

rem 删除临时文件 temp
del temp

rem  使用curl命令下载内容，并将其输出到文件中。
curl https://raw.hellogithub.com/hosts --output temp.txt
rem 使用type命令将原有的hosts文件内容追加到temp.txt中
type "C:\Windows\System32\drivers\etc\hosts" >> temp.txt
rem 使用copy命令将temp.txt复制到hosts文件中，/y参数表示覆盖文件
copy /y temp.txt "C:\Windows\System32\drivers\etc\hosts"
rem 使用del命令删除temp.txt临时文件
del temp.txt

echo Done.
ipconfig -flushdns
pause