Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D50D20248
	for <e@80x24.org>; Fri,  8 Mar 2019 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCHUzz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 15:55:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:36573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCHUzy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 15:55:54 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1jKo-1gmDG424z4-00tnue; Fri, 08
 Mar 2019 21:55:46 +0100
Date:   Fri, 8 Mar 2019 21:55:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Garcia, Pierre" <pgarcia@trusimulation.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git for Windows spawning a lot of processes recursively
In-Reply-To: <SN6PR03MB3647F1CDFD95F29C86F54FF8BA7F0@SN6PR03MB3647.namprd03.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1903082154320.41@tvgsbejvaqbjf.bet>
References: <SN6PR03MB3647F1CDFD95F29C86F54FF8BA7F0@SN6PR03MB3647.namprd03.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-538475057-1552078546=:41"
X-Provags-ID: V03:K1:/cRmPBuI7QKK0X9l2EEiP/w1fQBFJEDVhWVXw5QE24+QJba8/f3
 cqV+Mub1L4NuOcgrsomAuZW7oVHq8z9yiliO/O6X6+6ubWo8GDd0FEgaql/Q1BIgFLJr1r6
 tayet8bzjkj/g7zGsghpqMsWoH1NsFjKobpfbycA3mf4c23z7ZSGDAXndQImJiX0/XL2ciO
 1/JivKV5mPXBF0DuvomRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L6cGYWWbFKg=:QQbYDg5aA1eSbpLAMvdcF6
 iO7/JQr8KSu6kJJnaE85sAH0SqiVE1lGc6ymqvJZ9QUVL6z+Zw711ou9XOI3Sy8+9NlZIr1EY
 msiTj20OX0CH0hC2oVCW39sg5gILgy1WboyM5p7W0m+cvUtm6nklEvv2YaD7qlbhU0Z8tM/Qq
 Za3/Up7tkOtKkLzCJXnejo2HB2AsbJ+vo0yg6YMMchvQPLXA7O8MQFQIYp0mJ59CRg6NILs0W
 0CQ7IUghYWiOTIoREYlBy3GLcyjfCyJWCzQfe4mpuV2OqAO4jlNKazHxszmkKm5+j+RzwxknN
 Fba9fVB7uAg7nX6y2nVWhzlpRurGjylcDESScNtgAs9WaeWA79cW4+3zjvgehJWae+XklemmR
 zCMXMEhC1TZJVfpgULJMqVSgHpzcdfYmVVXtN7STXQjq8oSt3rUXzo3zGJJyzli+BWFYq0nSM
 itwywE6GQdtXyPhTkaoURLS7FCfO7mWc3M38+sFrx6rJUiTbu51rFPRLyf0eqiBjO4S8+t8/Z
 TDaTDsxCOSvoLxN73RSdtCiOwP0tQjy8doWTeU3O0TS1aRVKP14MFTW8dMbt9dw5mC21wTagq
 UYPf3mbOeifA9samRAHaN/PuZ1O5gV3XHMpi67LYmy5PxEUAQro/XqEnlwsKtRqK3qYOqDDYd
 qPUF5M+T1AQbUW9HM4G0LGBztnPuZcR+yzwfPhgOnfipH1b+Zzn8YlZYtpwubQz03ATsIVkJb
 2qaVh0j7goOvKa5nn5i26A17JLOWdr2QWkN6GL10gIDrO5zIxWvGJig2mnSThJjR1L91DL2Ip
 vKrTPT0dJkHUlgfrdQy7hfnznsvjY0wRi9zsi8rAknwvvryXU7JXOjXy+vv2AW6mvfsZ6Mgiq
 SwKO2UJ2GU82JjGQidIQifVP9zJWWOeuPQy+QJkfl3IJ9Xqky8hfJrt6cVl+hyg1nBFPYIKUQ
 YuImzA7F+q45QzxYgBz7UwAhnRtA0nl8GodvZNoJef9AX68qvph5JOiCrghJkeBAqcU+FCqiy
 bEaYqPVgX2e0k59U8pEAJ18=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-538475057-1552078546=:41
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT

Hi Pierre,

On Fri, 22 Feb 2019, Garcia, Pierre wrote:

> I'd like to report an issue with git for Windows
> 
> Git version 2.20.1
> Windows 7 x64 (Build 7601: Service Pack 1)
> 
> ----------------------------------------------------------------------------
> Issue:
> When running from Git-bash (not even inside a repo), git commands from
> built-in are OK, but if I use the exe that is located at C:\Program
> Files\Git\bin\git.exe, the process takes long to execute and then exits
> with error "error launching git: The filename or extension is too
> long.":

Is this still happening with v2.21.0? Or for that matter, with the latest
snapshot at https://wingit.blob.core.windows.net/files/index.html?

Ciao,
Johannes

> 
> $ git --version
> git version 2.20.1.windows.1
> 
> $ which git
> /mingw64/bin/git
> 
> $ /c/Program\ Files/Git/bin/git.exe --version
> error launching git: The filename or extension is too long.
> 
> ----------------------------------------------------------------------------
> It started out of the blue, nothing special was done on the computer, the previous day I cloned some repos, the next it was not working anymore.
> I tried uninstall-reinstall with no success.
> I'm using Gitextensions as well, but I verified that the problem was occurring without Gitextensions (uninstalled at the time the traces were taken).
> 
> ----------------------------------------------------------------------------
> I ran procmon.exe to monitor the activity of the process and I found out that git.exe was spawning itself 385 times in total in the trace I took, until all processes exit with error code 1, here is an extract of the procmon trace, showing thread and process activity for git.exe (I have more exhaustive trace but the file is quite big), I included the environment variables on the first call:
> 
> Time of Day	Process Name	PID	Operation	Path	Result	Detail
> 8:57:20.7	git.exe	12744	Process Start		SUCCESS	"Parent PID: 8412, Command line: ""C:\Program Files\Git\bin\git.exe""  --version, Current directory: C:\Users\gpierre\Desktop\, Environment: 
> ;	=::=::\
> ;	=C:=C:\Users\gpierre\Desktop
> ;	=ExitCode=00000001
> ;	ALLUSERSPROFILE=C:\ProgramData
> ;	CommonProgramFiles=C:\Program Files\Common Files
> ;	CommonProgramFiles(x86)=C:\Program Files (x86)\Common Files
> ;	CommonProgramW6432=C:\Program Files\Common Files
> ;	ComSpec=C:\windows\system32\cmd.exe
> ;	DEFLOGDIR=C:\ProgramData\McAfee\Endpoint Security\Logs
> ;	FP_NO_HOST_CHECK=NO
> ;	GTK_BASEPATH=C:\Program Files (x86)\GtkSharp\2.12\
> ;	HasSCCM2012Client=1
> ;	HOME=C:\Users\gpierre
> ;	HOMEDRIVE=C:
> ;	HOMEPATH=\Users\gpierre
> ;	HOMESHARE=C:\Users\gpierre
> ;	LOCALAPPDATA=C:\Users\gpierre\AppData\Local
> ;	NUMBER_OF_PROCESSORS=4
> ;	OS=Windows_NT
> ;	Path=C:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Dell\Dell Data Protection\Encryption\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;C:\Program Files\dotnet\;C:\Program Files (x86)\GtkSharp\2.12\bin;C:\windows\system32\config\systemprofile\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm\;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Program Files\PuTTY\;C:\windows\System32\WindowsPowerShell\v1.0\;C:\windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\1E\NomadBranch\;C:\HashiCorp\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0\
> ;	PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
> ;	PROCESSOR_ARCHITECTURE=AMD64
> ;	PROCESSOR_IDENTIFIER=Intel64 Family 6 Model 94 Stepping 3, GenuineIntel
> ;	PROCESSOR_LEVEL=6
> ;	PROCESSOR_REVISION=5e03
> ;	ProgramData=C:\ProgramData
> ;	ProgramFiles=C:\Program Files
> ;	ProgramFiles(x86)=C:\Program Files (x86)
> ;	ProgramW6432=C:\Program Files
> ;	PROMPT=$P$G
> ;	PSModulePath=C:\Program Files\WindowsPowerShell\Modules;C:\windows\system32\WindowsPowerShell\v1.0\Modules
> ;	PUBLIC=C:\Users\Public
> ;	SESSIONNAME=Console
> ;	SNC_LIB=gsskrb5.dll
> ;	SOEDataPartition=C:
> ;	SOEDesktopAdminModel=User
> ;	SOESystemPartitionLabel=SOE-Disk
> ;	SystemDrive=C:
> ;	SystemRoot=C:\windows
> ;	TEMP=C:\Users\gpierre\AppData\Local\Temp
> ;	TMP=C:\Users\gpierre\AppData\Local\Temp
> ;	USERNAME=gpierre
> ;	USERPROFILE=C:\Users\gpierre
> ;	VBOX_MSI_INSTALL_PATH=C:\Program Files\Oracle\VirtualBox\
> ;	VS140COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\
> ;	VS80COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio 8\Common7\Tools\
> ;	windir=C:\windows
> ;	windows_tracing_flags=3
> ;	windows_tracing_logfile=C:\BVTBin\Tests\installpackage\csilogfile.log"
> 8:57:20.7	git.exe	12744	Thread Create		SUCCESS	Thread ID: 12748
> 8:57:20.7	git.exe	12744	Load Image	C:\Program Files\Git\bin\git.exe	SUCCESS	Image Base: 0x13a0000, Image Size: 0x52000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	Image Base: 0x77b70000, Image Size: 0x19f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\kernel32.dll	SUCCESS	Image Base: 0x77950000, Image Size: 0x11f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\KernelBase.dll	SUCCESS	Image Base: 0x7fefd860000, Image Size: 0x6a000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	Image Base: 0x7fefef60000, Image Size: 0x9f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shell32.dll	SUCCESS	Image Base: 0x7fefdc20000, Image Size: 0xd8a000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\shlwapi.dll	SUCCESS	Image Base: 0x7feffde0000, Image Size: 0x71000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	Image Base: 0x7fefdae0000, Image Size: 0x67000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\user32.dll	SUCCESS	Image Base: 0x77a70000, Image Size: 0xfa000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Image Base: 0x7fefed30000, Image Size: 0xe000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	Image Base: 0x7fefdb50000, Image Size: 0xcb000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	Image Base: 0x7fefe9b0000, Image Size: 0x2e000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	Image Base: 0x7fefed40000, Image Size: 0x109000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS	Image Base: 0x7fefd5f0000, Image Size: 0x31000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\version.dll	SUCCESS	Image Base: 0x7fefd5e0000, Image Size: 0xc000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\advapi32.dll	SUCCESS	Image Base: 0x7fefec50000, Image Size: 0xdb000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\sechost.dll	SUCCESS	Image Base: 0x7fefee50000, Image Size: 0x1f000
> 8:57:20.7	git.exe	12744	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	Image Base: 0x7feff6b0000, Image Size: 0x12d000
> 8:57:20.8	git.exe	12744	Process Create	C:\Program Files\Git\bin\git.exe	SUCCESS	PID: 12756, Command line: git.exe  --version
> 8:57:20.8	git.exe	12756	Process Start		SUCCESS	"Parent PID: 12744, Command line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Environment: 
> 8:57:20.8	git.exe	12756	Thread Create		SUCCESS	Thread ID: 12760
> 
> This repeats 385 times (I removed the Load Image lines):
> 
> 8:57:20.9	git.exe	12756	Process Create	C:\Program Files\Git\bin\git.exe	SUCCESS	PID: 12764, Command line: git.exe  --version
> 8:57:20.9	git.exe	12764	Process Start		SUCCESS	"Parent PID: 12756, Command line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Environment: 
> 8:57:20.9	git.exe	12764	Thread Create		SUCCESS	Thread ID: 12768
> 8:57:20.9	git.exe	12764	Process Create	C:\Program Files\Git\bin\git.exe	SUCCESS	PID: 12772, Command line: git.exe  --version
> 8:57:20.9	git.exe	12772	Process Start		SUCCESS	"Parent PID: 12764, Command line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Environment: 
> 8:57:20.9	git.exe	12772	Thread Create		SUCCESS	Thread ID: 12776
> 8:57:21.0	git.exe	12772	Process Create	C:\Program Files\Git\bin\git.exe	SUCCESS	PID: 12780, Command line: git.exe  --version
> 8:57:21.0	git.exe	12780	Process Start		SUCCESS	"Parent PID: 12772, Command line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Environment: 
> 8:57:21.0	git.exe	12780	Thread Create		SUCCESS	Thread ID: 12784
> 8:57:21.0	git.exe	12780	Process Create	C:\Program Files\Git\bin\git.exe	SUCCESS	PID: 12788, Command line: git.exe  --version
> 8:57:21.0	git.exe	12788	Process Start		SUCCESS	"Parent PID: 12780, Command line: git.exe  --version, Current directory: C:\Users\gpierre\Desktop\, Environment: 
> 8:57:21.0	git.exe	12788	Thread Create		SUCCESS	Thread ID: 12792
> ...
> 
> After that the processes exit one by one (all with error code 1) in reverse order:
> 
> ...
> 8:57:48.6	git.exe	12788	Thread Exit		SUCCESS	Thread ID: 12792, User Time: 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12788	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,576,960, Peak Private Bytes: 1,654,784, Working Set: 4,235,264, Peak Working Set: 4,272,128
> 8:57:48.6	git.exe	12780	Thread Exit		SUCCESS	Thread ID: 12784, User Time: 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12780	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,597,440, Peak Private Bytes: 1,654,784, Working Set: 4,251,648, Peak Working Set: 4,288,512
> 8:57:48.6	git.exe	12772	Thread Exit		SUCCESS	Thread ID: 12776, User Time: 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12772	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,601,536, Peak Private Bytes: 1,642,496, Working Set: 4,304,896, Peak Working Set: 4,341,760
> 8:57:48.6	git.exe	12764	Thread Exit		SUCCESS	Thread ID: 12768, User Time: 0.0156001, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12764	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.0156001 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 1,597,440, Peak Private Bytes: 1,638,400, Working Set: 4,263,936, Peak Working Set: 4,300,800
> 8:57:48.6	git.exe	12756	Thread Exit		SUCCESS	Thread ID: 12760, User Time: 0.0000000, Kernel Time: 0.0156001
> 8:57:48.6	git.exe	12756	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.0000000 seconds, Kernel Time: 0.0156001 seconds, Private Bytes: 1,581,056, Peak Private Bytes: 1,642,496, Working Set: 4,222,976, Peak Working Set: 4,259,840
> 8:57:48.6	git.exe	12744	Thread Exit		SUCCESS	Thread ID: 12748, User Time: 0.0000000, Kernel Time: 0.0312002
> 8:57:48.6	git.exe	12744	Process Exit		SUCCESS	Exit Status: 1, User Time: 0.0000000 seconds, Kernel Time: 0.0312002 seconds, Private Bytes: 1,560,576, Peak Private Bytes: 1,650,688, Working Set: 4,231,168, Peak Working Set: 4,308,992
> 
> ----------------------------------------------------------------------------
> I never saw that before, it seems every command is doing that (tried status, log, init, fetch).
> It happened to me before that GitExtensions or Visual Studio would spawn a lot of git processes, but nothing like this.
> I'm wondering if there is a glitch in the code that would allow git.exe to call itself with same arguments, leading to an (quasi) endless loop of calls.
> Let me know what I can do to help isolating the problem, I'll assist if possible.
> 
> ----------------------------------------------------------------------------
> For reference, here is what the built-in git --version is doing from git bash, only two processes are spawned, git --version first (the command line), then git rev-parse, and then the process exits:
> 
> 9:55:51.2	git.exe	5604	Process Start		SUCCESS	"Parent PID: 752, Command line: ""C:\Program Files\Git\mingw64\bin\git.exe"" --version, Current directory: C:\Users\gpierre\, Environment: 
> ;	ACLOCAL_PATH=C:\Program Files\Git\mingw64\share\aclocal;C:\Program Files\Git\usr\share\aclocal
> ;	ALLUSERSPROFILE=C:\ProgramData
> ;	APPDATA=C:\Users\gpierre\AppData\Roaming
> ;	COMMONPROGRAMFILES=C:\Program Files\Common Files
> ;	COMPUTERNAME=
> ;	COMSPEC=C:\windows\system32\cmd.exe
> ;	CONFIG_SITE=C:/Program Files/Git/mingw64/etc/config.site
> ;	CommonProgramFiles(x86)=C:\Program Files (x86)\Common Files
> ;	CommonProgramW6432=C:\Program Files\Common Files
> ;	DEFLOGDIR=C:\ProgramData\McAfee\Endpoint Security\Logs
> ;	DISPLAY=needs-to-be-defined
> ;	EXEPATH=C:\Program Files\Git
> ;	FP_NO_HOST_CHECK=NO
> ;	GTK_BASEPATH=C:\Program Files (x86)\GtkSharp\2.12\
> ;	HOME=C:\Users\gpierre
> ;	HOMEDRIVE=C:
> ;	HOMEPATH=\Users\gpierre
> ;	HOSTNAME=
> ;	HasSCCM2012Client=1
> ;	INFOPATH=C:\Program Files\Git\usr\local\info;C:\Program Files\Git\usr\share\info;C:\Program Files\Git\usr\info;C:\Program Files\Git\share\info
> ;	LANG=en_US.UTF-8
> ;	LOCALAPPDATA=C:\Users\gpierre\AppData\Local
> ;	LOGONSERVER=\\
> ;	MANPATH=C:\Program Files\Git\mingw64\local\man;C:\Program Files\Git\mingw64\share\man;C:\Program Files\Git\usr\local\man;C:\Program Files\Git\usr\share\man;C:\Program Files\Git\usr\man;C:\Program Files\Git\share\man
> ;	MINGW_CHOST=x86_64-w64-mingw32
> ;	MINGW_PACKAGE_PREFIX=mingw-w64-x86_64
> ;	MINGW_PREFIX=C:/Program Files/Git/mingw64
> ;	MSYSTEM=MINGW64
> ;	MSYSTEM_CARCH=x86_64
> ;	MSYSTEM_CHOST=x86_64-w64-mingw32
> ;	MSYSTEM_PREFIX=C:/Program Files/Git/mingw64
> ;	NUMBER_OF_PROCESSORS=4
> ;	ORIGINAL_PATH=C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\bin;C:\Users\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\GtkSharp\2.12\bin;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Program Files\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0
> ;	ORIGINAL_TEMP=C:/Users/gpierre/AppData/Local/Temp
> ;	ORIGINAL_TMP=C:/Users/gpierre/AppData/Local/Temp
> ;	OS=Windows_NT
> ;	PATH=C:\Users\gpierre\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\local\bin;C:\Program Files\Git\usr\bin;C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\bin;C:\Users\gpierre\bin;C:\ProgramData\Oracle\Java\javapath;C:\windows\system32;C:\windows;C:\windows\System32\Wbem;C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Dell\Dell Data Protection\Encryption;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft SQL Server\130\Tools\Binn;C:\Program Files\dotnet;C:\Program Files (x86)\GtkSharp\2.12\bin;C:\Users\gpierre\.dnx\bin;C:\Program Files\Microsoft DNX\Dnvm;C:\EASE\APEX12-4.4.0\bin;C:\EASE\APEX12-4.4.0\platforms\default\DEOS;C:\Program Files\PuTTY;C:\windows\System32\WindowsPowerShell\v1.0;C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\1E\NomadBranch;C:\HashiCorp\Vagrant\bin;C:\windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\usr\bin\vendor_perl;C:\Program Files\Git\usr\bin\core_perl
> ;	PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
> ;	PKG_CONFIG_PATH=C:\Program Files\Git\mingw64\lib\pkgconfig;C:\Program Files\Git\mingw64\share\pkgconfig
> ;	PLINK_PROTOCOL=ssh
> ;	PROCESSOR_ARCHITECTURE=AMD64
> ;	PROCESSOR_IDENTIFIER=Intel64 Family 6 Model 94 Stepping 3, GenuineIntel
> ;"
> 9:55:51.2	git.exe	5604	Thread Create		SUCCESS	Thread ID: 8844
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\git.exe	SUCCESS	Image Base: 0x1160000, Image Size: 0x2f0000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	Image Base: 0x77250000, Image Size: 0x19f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\kernel32.dll	SUCCESS	Image Base: 0x77130000, Image Size: 0x11f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\KernelBase.dll	SUCCESS	Image Base: 0x7fefcde0000, Image Size: 0x6a000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libiconv-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	Image Base: 0x7fefd950000, Image Size: 0x9f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libintl-8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\advapi32.dll	SUCCESS	Image Base: 0x7fefd7d0000, Image Size: 0xdb000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\sechost.dll	SUCCESS	Image Base: 0x7feff520000, Image Size: 0x1f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	Image Base: 0x7fefebf0000, Image Size: 0x12d000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libpcre2-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\zlib1.dll	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\user32.dll	SUCCESS	Image Base: 0x77030000, Image Size: 0xfa000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	Image Base: 0x7fefd6c0000, Image Size: 0x67000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Image Base: 0x7fefd290000, Image Size: 0xe000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	Image Base: 0x7fefd5f0000, Image Size: 0xcb000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\ws2_32.dll	SUCCESS	Image Base: 0x7fefd240000, Image Size: 0x4d000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	Image Base: 0x7fefed50000, Image Size: 0x8000
> 9:55:51.2	git.exe	5604	Load Image	C:\Program Files\Git\mingw64\bin\libssp-0.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	Image Base: 0x7fefed20000, Image Size: 0x2e000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	Image Base: 0x7feff410000, Image Size: 0x109000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS	Image Base: 0x7fefccd0000, Image Size: 0x31000
> 9:55:51.2	git.exe	5604	Load Image	C:\Windows\System32\version.dll	SUCCESS	Image Base: 0x7fefccc0000, Image Size: 0xc000
> 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptsp.dll	SUCCESS	Image Base: 0x7fefc530000, Image Size: 0x18000
> 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\rsaenh.dll	SUCCESS	Image Base: 0x7fefc230000, Image Size: 0x47000
> 9:55:51.3	git.exe	5604	Load Image	C:\Windows\System32\cryptbase.dll	SUCCESS	Image Base: 0x7fefcbf0000, Image Size: 0xf000
> 9:55:51.3	git.exe	5604	Thread Exit		SUCCESS	Thread ID: 8844, User Time: 0.0000000, Kernel Time: 0.0468003
> 9:55:51.3	git.exe	5604	Process Exit		SUCCESS	Exit Status: 0, User Time: 0.0000000 seconds, Kernel Time: 0.0468003 seconds, Private Bytes: 2,940,928, Peak Private Bytes: 2,981,888, Working Set: 4,980,736, Peak Working Set: 4,980,736
> 9:55:51.6	git.exe	5560	Process Start		SUCCESS	"Parent PID: 9080, Command line: ""C:\Program Files\Git\mingw64\bin\git.exe"" rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree --short HEAD, Current directory: C:\Users\gpierre\, Environment: 
> 9:55:51.6	git.exe	5560	Thread Create		SUCCESS	Thread ID: 5248
> 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\git.exe	SUCCESS	Image Base: 0x190000, Image Size: 0x2f0000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\ntdll.dll	SUCCESS	Image Base: 0x77250000, Image Size: 0x19f000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\kernel32.dll	SUCCESS	Image Base: 0x77130000, Image Size: 0x11f000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\KernelBase.dll	SUCCESS	Image Base: 0x7fefcde0000, Image Size: 0x6a000
> 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libiconv-2.dll	SUCCESS	Image Base: 0x66000000, Image Size: 0x10b000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\msvcrt.dll	SUCCESS	Image Base: 0x7fefd950000, Image Size: 0x9f000
> 9:55:51.6	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libintl-8.dll	SUCCESS	Image Base: 0x61cc0000, Image Size: 0x28000
> 9:55:51.6	git.exe	5560	Load Image	C:\Windows\System32\advapi32.dll	SUCCESS	Image Base: 0x7fefd7d0000, Image Size: 0xdb000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\sechost.dll	SUCCESS	Image Base: 0x7feff520000, Image Size: 0x1f000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rpcrt4.dll	SUCCESS	Image Base: 0x7fefebf0000, Image Size: 0x12d000
> 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libpcre2-8-0.dll	SUCCESS	Image Base: 0x64380000, Image Size: 0x54000
> 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\zlib1.dll	SUCCESS	Image Base: 0x62e80000, Image Size: 0x1f000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\user32.dll	SUCCESS	Image Base: 0x77030000, Image Size: 0xfa000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\gdi32.dll	SUCCESS	Image Base: 0x7fefd6c0000, Image Size: 0x67000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\lpk.dll	SUCCESS	Image Base: 0x7fefd290000, Image Size: 0xe000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\usp10.dll	SUCCESS	Image Base: 0x7fefd5f0000, Image Size: 0xcb000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\ws2_32.dll	SUCCESS	Image Base: 0x7fefd240000, Image Size: 0x4d000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nsi.dll	SUCCESS	Image Base: 0x7fefed50000, Image Size: 0x8000
> 9:55:51.7	git.exe	5560	Load Image	C:\Program Files\Git\mingw64\bin\libssp-0.dll	SUCCESS	Image Base: 0x68ac0000, Image Size: 0xe000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\imm32.dll	SUCCESS	Image Base: 0x7fefed20000, Image Size: 0x2e000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\msctf.dll	SUCCESS	Image Base: 0x7feff410000, Image Size: 0x109000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\nvinitx.dll	SUCCESS	Image Base: 0x7fefccd0000, Image Size: 0x31000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\version.dll	SUCCESS	Image Base: 0x7fefccc0000, Image Size: 0xc000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptsp.dll	SUCCESS	Image Base: 0x7fefc530000, Image Size: 0x18000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\rsaenh.dll	SUCCESS	Image Base: 0x7fefc230000, Image Size: 0x47000
> 9:55:51.7	git.exe	5560	Load Image	C:\Windows\System32\cryptbase.dll	SUCCESS	Image Base: 0x7fefcbf0000, Image Size: 0xf000
> 9:55:51.7	git.exe	5560	Thread Exit		SUCCESS	Thread ID: 5248, User Time: 0.0000000, Kernel Time: 0.0780005
> 9:55:51.7	git.exe	5560	Process Exit		SUCCESS	Exit Status: 128, User Time: 0.0000000 seconds, Kernel Time: 0.0780005 seconds, Private Bytes: 2,932,736, Peak Private Bytes: 2,973,696, Working Set: 5,062,656, Peak Working Set: 5,062,656
> 
> 
> Thanks a lot! Cheers,
> Pierre G.
> 
> 
--8323328-538475057-1552078546=:41--
