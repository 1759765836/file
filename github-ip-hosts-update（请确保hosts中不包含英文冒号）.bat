@echo off
echo From https://raw.hellogithub.com/hosts Update the ip of github in to the hosts file.
echo Can be updated repeatedly.�����ظ�ִ��
setlocal enabledelayedexpansion

rem hosts�ļ�·��
set "hosts_file=C:\Windows\System32\drivers\etc\hosts"
rem ͨ��url����
set "update_url=https://raw.hellogithub.com/hosts"

rem �������ݱ�Ƿ���
set "start_flag=0"

rem �� hosts �ļ��е����ݸ��Ƶ���ʱ�ļ� temp.txt ��, > temp��ʾ�����ļ�
type %hosts_file% > temp.txt
rem ����ļ�
cd. > %hosts_file%
::type null > %hosts_file%
::echo # > C:\Windows\System32\drivers\etc\hosts
rem �Ƚ���һ�θ��µ�ɾ��������ԭ������ipӳ��
rem ʹ�� findstr /n ��ȡ��ʱ�ļ� temp.txt ��ÿһ�У�������ǰ����к�
for /f "delims=" %%i in ('findstr /n .* temp.txt') do (
set "line=%%i"
rem ɾ���к�
set "line=!line:*:=!"
rem ����������е�ǰ21���ַ��� "# GitHub520 Host Start"�����ÿ�ʼ��ǣ�ֹͣд��hosts
if "!line:~0,22!" == "# GitHub520 Host Start" set "start_flag=1"
rem ���û�дﵽ��ʼ��ǣ��򽫸���д��յ� hosts �ļ���
if not "!start_flag!" == "1" echo.!line! >> %hosts_file%
rem ������������� "# GitHub520 Host End"�����ý�����ǣ�����ѭ��д��hosts
if "!line!" == "# GitHub520 Host End" set "start_flag=0"
)
rem ��url����������׷�ӵ��ļ�ĩβ
rem  ʹ��curl�����������ݣ���������������ǣ����ļ��С�
curl %update_url% --output temp.txt
rem ʹ��type���temp.txt׷�ӵ�hosts�ļ���
type temp.txt >> %hosts_file%
rem ʹ��copy���temp.txt���Ƶ�hosts�ļ��У�/y������ʾ�����ļ�
::copy /y temp.txt %hosts_file%
rem ʹ��del����ɾ��temp.txt��ʱ�ļ�
del temp.txt
echo Done.
ipconfig -flushdns
pause