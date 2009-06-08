From: Lee Henson <lee.m.henson@gmail.com>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 13:58:44 +0100
Message-ID: <935bb4150906080558p27b38435u7b3fae61ca6e1a06@mail.gmail.com>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=000e0cd1eb7060bca9046bd5cd2b
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Jun 08 15:01:57 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f187.google.com ([209.85.217.187])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDeU0-0000zt-Ka
	for gcvm-msysgit@m.gmane.org; Mon, 08 Jun 2009 15:01:52 +0200
Received: by gxk7 with SMTP id 7so3412774gxk.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Jun 2009 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=2ZGYT+hWM82ner5fjy5ObgfoIjHNdXA7c981BWVlmg8=;
        b=Cyf6rAUQJsDpgSHqA40QonrzViixzLpHai6qiDYHIu3vlFsFNqeD6ncFEMsDGd5Tsh
         I7PpyXtZzBwW6fkUsJqPYfkOb/faC9trwSxcnp/w8tjsV0tO0H6Fi3GQQ/3P9OqEkwM/
         CgR1MaWOGVDBxdme9+TvV7zZw56XVMugAFlDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=wIqVM/0RPRVGSHcXfQhLEcJRip+dSczmGntxFf/ROGPgWextLgiW3qPssWZXc7yGvy
         AGJzN4TXmo2HI53YOeYxQv6A1El2Z17BGiI2/b50olZXXRFBBjrC3lT5/8+ryE5h12q3
         fp6GaNtAJRJaT4gQLpTisK8qMPJvaRboSoBsY=
Received: by 10.100.216.12 with SMTP id o12mr401454ang.5.1244465926652;
        Mon, 08 Jun 2009 05:58:46 -0700 (PDT)
Received: by 10.107.155.38 with SMTP id h38gr5517pro.0;
	Mon, 08 Jun 2009 05:58:46 -0700 (PDT)
X-Sender: lee.m.henson@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.11.13 with SMTP id 13mr58636ebk.14.1244465925915; Mon, 08 Jun 2009 05:58:45 -0700 (PDT)
Received: from mail-ew0-f216.google.com (mail-ew0-f216.google.com [209.85.219.216]) by gmr-mx.google.com with ESMTP id 16si593723ewy.3.2009.06.08.05.58.44; Mon, 08 Jun 2009 05:58:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of lee.m.henson@gmail.com designates 209.85.219.216 as permitted sender) client-ip=209.85.219.216;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lee.m.henson@gmail.com designates 209.85.219.216 as permitted sender) smtp.mail=lee.m.henson@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f216.google.com with SMTP id 12so4778874ewy.11 for <msysgit@googlegroups.com>; Mon, 08 Jun 2009 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=dgQfTBCdUIFgXDFZURZVJ550cNPJNp6qhSB65q/zBZc=; b=OdptmLyUcLGCznWC/Gxpkd0N6PwrWEKk5Ly1Ztuq2dz6nxPT6ZE1JWLxpaWmhGNFq8 exqogvOKJc/6t15HeexNPrqQjxUsRFFKyURRluGkeGm7W1WsPDi9yftVye99BmQTZqQm Ppjy6OB+FkP7dnk0ktpt0tiWETluj1UlPzjAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=ePUDGGighWIqndSMAuZwJAyqfQUo2iUFcb2vDG6OdMm3O9ikxJ+CztGuUZzPM1lXgv iWJj+sAMOPSPJQwfgHlE4KovzNNXeZIS/jmlyk4QF6vhFdNhx9wdrnaQ2P7RH2gdMU6t lQRv0mcfYRleE37dG9KpTxKUWwzlF0y1dcCss=
Received: by 10.210.78.16 with SMTP id a16mr883311ebb.75.1244465924706; Mon,  08 Jun 2009 05:58:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121071>


--000e0cd1eb7060bca9046bd5cd2b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Many thanks, Johannes.

2009/6/7 Johannes Schindelin <Johannes.Schindelin@gmx.de>

>
> Hi,
>
> this mail informs you that Git for Windows 1.6.3.2 is out.  Soon is the
> time that we switch to git.git's master.
>
> Git Release Notes (Git-1.6.3.2-preview20090607)
> Last update: 07 June 2009
>
> Introduction
> These release notes describe issues specific to the Windows release.
>
> General release notes covering the history of the core git commands are
> included in the subdirectory doc/git/html of the installation directory.
> Look for files starting with RelNotes.
>
> Known issues
> - Some commands are not yet supported on Windows and excluded from the
>  installation; namely: git archimport, git cvsexportcommit, git
>  cvsimport, git cvsserver, git instaweb, git send-email, git shell.
> - The Logitec QuickCam software can cause spurious crashes. See "Why does
>  make often crash creating a sh.exe.stackdump file when I try to compile
>  my source code?" on the MinGW Wiki
>  (http://www.mingw.org/wiki/Environment_issues)
> - The Quick Launch icon will only be installed for the user running setup
>  (typically the Administrator). This is a technical restriction and will
>  not change.
> - Git Bash launched through the Explorer shell extension does not have the
>  git icon in its taskbar. This is a technical restriction and will not
>  change.
> - git send-mail does not work properly (Issue 27).
> - curl uses $HOME/_netrc instead of $HOME/.netrc.
> - If you want to specify a different location for --upload-pack, you have
>  to start the absolute path with two slashes. Otherwise MSys will mangle
>  the path.
> - git and bash have serious problems with non-ASCII file names (Issue 80,
>  159).
> - If configured to use plink, you will have to connect with putty first.
> - MinGW does not support IPv6 yet (Issue 182).
> - When run from cmd.exe instead of Git Bash, some characters seem to be
>  "swallowed" from Git's output (Issue 192).
> - There are a spurious write errors during rebase (Issue 200) that seem
>  not to be reproducible on most computers.
> - As merge tools are executed using the MSys bash, options starting with
>  "/" need to be handled specially: MSys would interpret that as a POSIX
>  path, so you need to double the slash (Issue 226).  Example: instead of
>  "/base", say "//base".
> - Also, extra care has to be paid to pass Windows programs Windows paths,
>  as they have no clue about MSys style POSIX paths -- You can use
>  something like $(cmd //c echo "$POSIXPATH").
>
> Changes since Git-1.6.3-preview20090507
>
> New Features
> - Comes with official git 1.6.3.2.
> - Uses TortoisePlink instead of Plink if available.
>
> Bugfixes
> - Plink errors out rather than hanging when the user needs to accept a
>  host key first (Issue 96).
> - The user home directory is inferred from $HOMEDRIVE\$HOMEPATH instead of
>  $HOME (Issue 108).
> - The environment setting $CYGWIN=tty is ignored (Issues 138, 248 and
>  251).
> - The "ls" command shows non-ASCII filenames correctly now (Issue 188).
> - Adds more syntax files for vi (Issue 250).
> - $HOME/.bashrc is included last from /etc/profile, allowing .bashrc to
>  override all settings in /etc/profile (Issue 255).
> - Completion is case-insensitive again (Issue 256).
> - The "start" command can handle arguments with spaces now (Issue 258).
> - For some Git commands (such as "git commit"), vi no longer "restores"
>  the cursor position.
>
>
>

--000e0cd1eb7060bca9046bd5cd2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Many thanks, Johannes.<br><br><div class=3D"gmail_quote">2009/6/7 Johannes =
Schindelin <span dir=3D"ltr">&lt;<a href=3D"mailto:Johannes.Schindelin@gmx.=
de">Johannes.Schindelin@gmx.de</a>&gt;</span><br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex;">
<br>
Hi,<br>
<br>
this mail informs you that Git for Windows 1.6.3.2 is out. =A0Soon is the<b=
r>
time that we switch to git.git&#39;s master.<br>
<br>
Git Release Notes (Git-1.6.3.2-preview20090607)<br>
Last update: 07 June 2009<br>
<br>
Introduction<br>
These release notes describe issues specific to the Windows release.<br>
<br>
General release notes covering the history of the core git commands are<br>
included in the subdirectory doc/git/html of the installation directory.<br=
>
Look for files starting with RelNotes.<br>
<br>
Known issues<br>
- Some commands are not yet supported on Windows and excluded from the<br>
 =A0installation; namely: git archimport, git cvsexportcommit, git<br>
 =A0cvsimport, git cvsserver, git instaweb, git send-email, git shell.<br>
- The Logitec QuickCam software can cause spurious crashes. See &quot;Why d=
oes<br>
 =A0make often crash creating a sh.exe.stackdump file when I try to compile=
<br>
 =A0my source code?&quot; on the MinGW Wiki<br>
 =A0(<a href=3D"http://www.mingw.org/wiki/Environment_issues" target=3D"_bl=
ank">http://www.mingw.org/wiki/Environment_issues</a>)<br>
- The Quick Launch icon will only be installed for the user running setup<b=
r>
 =A0(typically the Administrator). This is a technical restriction and will=
<br>
 =A0not change.<br>
- Git Bash launched through the Explorer shell extension does not have the<=
br>
 =A0git icon in its taskbar. This is a technical restriction and will not<b=
r>
 =A0change.<br>
- git send-mail does not work properly (Issue 27).<br>
- curl uses $HOME/_netrc instead of $HOME/.netrc.<br>
- If you want to specify a different location for --upload-pack, you have<b=
r>
 =A0to start the absolute path with two slashes. Otherwise MSys will mangle=
<br>
 =A0the path.<br>
- git and bash have serious problems with non-ASCII file names (Issue 80,<b=
r>
 =A0159).<br>
- If configured to use plink, you will have to connect with putty first.<br=
>
- MinGW does not support IPv6 yet (Issue 182).<br>
- When run from cmd.exe instead of Git Bash, some characters seem to be<br>
 =A0&quot;swallowed&quot; from Git&#39;s output (Issue 192).<br>
- There are a spurious write errors during rebase (Issue 200) that seem<br>
 =A0not to be reproducible on most computers.<br>
- As merge tools are executed using the MSys bash, options starting with<br=
>
 =A0&quot;/&quot; need to be handled specially: MSys would interpret that a=
s a POSIX<br>
 =A0path, so you need to double the slash (Issue 226). =A0Example: instead =
of<br>
 =A0&quot;/base&quot;, say &quot;//base&quot;.<br>
- Also, extra care has to be paid to pass Windows programs Windows paths,<b=
r>
 =A0as they have no clue about MSys style POSIX paths -- You can use<br>
 =A0something like $(cmd //c echo &quot;$POSIXPATH&quot;).<br>
<br>
Changes since Git-1.6.3-preview20090507<br>
<br>
New Features<br>
- Comes with official git 1.6.3.2.<br>
- Uses TortoisePlink instead of Plink if available.<br>
<br>
Bugfixes<br>
- Plink errors out rather than hanging when the user needs to accept a<br>
 =A0host key first (Issue 96).<br>
- The user home directory is inferred from $HOMEDRIVE\$HOMEPATH instead of<=
br>
 =A0$HOME (Issue 108).<br>
- The environment setting $CYGWIN=3Dtty is ignored (Issues 138, 248 and<br>
 =A0251).<br>
- The &quot;ls&quot; command shows non-ASCII filenames correctly now (Issue=
 188).<br>
- Adds more syntax files for vi (Issue 250).<br>
- $HOME/.bashrc is included last from /etc/profile, allowing .bashrc to<br>
 =A0override all settings in /etc/profile (Issue 255).<br>
- Completion is case-insensitive again (Issue 256).<br>
- The &quot;start&quot; command can handle arguments with spaces now (Issue=
 258).<br>
- For some Git commands (such as &quot;git commit&quot;), vi no longer &quo=
t;restores&quot;<br>
 =A0the cursor position.<br>
<br>
<br>
</blockquote></div><br>

--000e0cd1eb7060bca9046bd5cd2b--
