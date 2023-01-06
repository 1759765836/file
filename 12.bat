@echo off
echo From https://raw.hellogithub.com/hosts Update the ip of github in to the hosts file.
echo Can be updated repeatedly.
setlocal enabledelayedexpansion

rem hosts文件路径
set "hosts_file=C:\Windows\System32\drivers\etc\hosts"
rem 通过url更新
set "update_url=https://raw.hellogithub.com/hosts"


rem 根据内容标记符号
set "start_flag=0"

rem 将 hosts 文件中的内容复制到临时文件 temp.txt 中, > temp表示覆盖文件
type %hosts_file% > temp.txt
rem 清空文件
::type null > %hosts_file%
cd. > %hosts_file%
::echo # > C:\Windows\System32\drivers\etc\hosts

rem 使用 findstr /n 读取临时文件 temp.txt 的每一行，并在行前添加行号
for /f "delims=" %%i in ('findstr /n .* temp.txt') do (
set "line=%%i"
rem 删除行号
set "line=!line:*:=!"
rem 如果读到的行是 "# Start"，设置开始标记
if "!line!" == "# GitHub520 Host Start" set "start_flag=1"
rem 如果没有达到开始标记，则将该行写入新的 hosts 文件中
if not "!start_flag!" == "1" echo.!line!>> %hosts_file%
rem 如果读到的行是 "# End"，设置结束标记
if "!line!" == "# GitHub520 Host End" set "start_flag=0"
)

rem  使用curl命令下载内容，并将其输出（覆盖）到文件中。
curl %update_url% --output temp.txt
rem 使用type命令将temp.txt追加到hosts文件中
type temp.txt >> %hosts_file%
rem 使用copy命令将temp.txt复制到hosts文件中，/y参数表示覆盖文件
::copy /y temp.txt %hosts_file%
rem 使用del命令删除temp.txt临时文件
del temp.txt
echo Done.
ipconfig -flushdns
pause