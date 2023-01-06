@echo off				 			   
setlocal enabledelayedexpansion

set "host_file=C:\Windows\System32\drivers\etc\hosts"

set "start_flag=0"
set 换行符=^


rem 将 host1 文件中的内容复制到临时文件 temp 中
type %host_file% > temp

rem 使用 findstr /n 读取临时文件 temp 的每一行，并在行前添加行号
for /f "delims=" %%i in ('findstr /n .* temp') do (
set "line=%%i"
rem 删除行号
set "line=!line:*:=!"
rem 如果读到的行包含 "# GitHub520 Host Start"，设置开始标记
if not "!line:# GitHub520 Host Start=!" == "!line!" (
	rem 如果当前行不等于空行，则将该行写入新的 host1 文件中
	if not "!line!" == "" (
		set "start_flag=1"
		echo 从当前行开始删除
		echo %%i!换行符!
	)
)
if "!line:~0,22!" == "# GitHub520 Host Start" ( 
set "start_flag=1" 
echo !line!
)
rem 如果读到的行是 "# End"，设置结束标记
if "!line!" == "# End" set "start_flag=0"
rem 如果没有达到开始标记，则将该行写入新的 host1 文件中
)

rem 删除临时文件 temp
del temp
echo %start_flag%

echo Done.



