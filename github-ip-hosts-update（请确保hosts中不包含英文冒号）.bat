@echo off
echo From https://raw.hellogithub.com/hosts Update the ip of github in to the hosts file.
echo Can be updated repeatedly.
setlocal enabledelayedexpansion

rem hosts�ļ�·��
set "hosts_file=C:\Windows\System32\drivers\etc\hosts"
rem ͨ��url����
set "update_url=https://raw.hellogithub.com/hosts"
rem �������ݱ�Ƿ���
set "start_flag=0"

rem �� hosts �ļ��е����ݸ��Ƶ���ʱ�ļ� temp ��, > temp��ʾ�����ļ�
type %hosts_file% > temp
rem ����ļ�
::type null > %hosts_file%
cd. > %hosts_file%
::echo # > C:\Windows\System32\drivers\etc\hosts

rem ʹ�� findstr /n ��ȡ��ʱ�ļ� temp ��ÿһ�У�������ǰ����к�
for /f "delims=" %%i in ('findstr /n .* temp') do (
set "line=%%i"
rem ɾ���к�
set "line=!line:*:=!"
rem ������������� "# Start"�����ÿ�ʼ���
if "!line!" == "# GitHub520 Host Start" set "start_flag=1"

rem ���û�дﵽ��ʼ��ǣ��򽫸���д���µ� hosts �ļ���
if not "!start_flag!" == "1" echo.!line!>> %hosts_file%

rem ������������� "# End"�����ý������
if "!line!" == "# GitHub520 Host End" set "start_flag=0"
)
rem ɾ����ʱ�ļ� temp
del temp

rem  ʹ��curl�����������ݣ���������������ǣ����ļ��С�
curl %update_url% --output temp.txt
rem ʹ��type���ԭ�е�hosts�ļ�����׷�ӵ�temp.txt��
::type %hosts_file% >> 
type temp.txt >> %hosts_file%
rem ʹ��copy���temp.txt���Ƶ�hosts�ļ��У�/y������ʾ�����ļ�
::copy /y temp.txt %hosts_file%
rem ʹ��del����ɾ��temp.txt��ʱ�ļ�
del temp.txt
echo Done.