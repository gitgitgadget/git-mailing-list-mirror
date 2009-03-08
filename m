From: Lee Henson <lee.m.henson@gmail.com>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 12:59:46 +0000
Message-ID: <935bb4150903080559s5cfc76e4u83d9ed8bb2becd0e@mail.gmail.com>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Reply-To: lee.m.henson@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0016e64c2718a49a7a04649b172b
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 08 14:01:25 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgId8-0008VY-0W
	for gcvm-msysgit@m.gmane.org; Sun, 08 Mar 2009 14:01:22 +0100
Received: by qyk35 with SMTP id 35so1612752qyk.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Mar 2009 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=ZqadKcCDlZUBCQT/M49jwEHMOAMYkK9pkSUUDxlSGxg=;
        b=IkJS1liklaNo5aeJ2CRM0wf6MwOSlQtxGpsF0Otve0yCpOFXwU4MY8ZJvDzlEc34zb
         vno8H/1sc7JR6O8swZA4kwa10FJbhQ565Sc8dYlv1RDcD4IvBG8F5RPXNC5sLJ197gRH
         H4XBK9Jo/wiIUMCUKA6oYt8vgMy5po3nuBImg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=audIzMgea5XUMPcwIhqGd6oVNUnEO9FNvUH9WKzcSy0fMgEdm0VUf5YQhVDOkHYPAN
         sjl6Tm8jNKyUuCEprPpGyJ8Y/IqU1K1eMgMdwcLTho/My5gbKhBrUQ9lOaKcGNBeMgKp
         NNl5w3KMk4AgElp5zPGgM9+hDntaC+xq1EaGo=
Received: by 10.229.73.145 with SMTP id q17mr438914qcj.27.1236517188098;
        Sun, 08 Mar 2009 05:59:48 -0700 (PDT)
Received: by 10.176.101.40 with SMTP id y40gr3863yqb.0;
	Sun, 08 Mar 2009 05:59:48 -0700 (PDT)
X-Sender: lee.m.henson@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.27.20 with SMTP id a20mr203992eba.6.1236517187311; Sun, 08 Mar 2009 05:59:47 -0700 (PDT)
Received: from mail-ew0-f170.google.com (mail-ew0-f170.google.com [209.85.219.170]) by gmr-mx.google.com with ESMTP id 15si350861ewy.0.2009.03.08.05.59.46; Sun, 08 Mar 2009 05:59:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of lee.m.henson@gmail.com designates 209.85.219.170 as permitted sender) client-ip=209.85.219.170;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lee.m.henson@gmail.com designates 209.85.219.170 as permitted sender) smtp.mail=lee.m.henson@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f170.google.com with SMTP id 18so633709ewy.25 for <msysgit@googlegroups.com>; Sun, 08 Mar 2009 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=H/fKerDoXDrJkoDD9ZfMZUQfMD0dBMCfW2876Ay2rIM=; b=laWZgYmukvhD9PIo6rb24GNbtMKXXLcJj9fTq2jJu+ggH+GILpFKLxJ90wYI+M3cTz x4vuuhuahfAtiZLnWOY672gmNJCB2vNXkYwqDlScYiiDqQnMcEdsxLTc2aeQqCKdBvK4 S5We6dU7FjgcGpYnqNT3uFbz/8GTeFckrgh+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=SoGBfnLUM/b4pZQamXcRo7k4eMFmxjZ2oaF5ZraOA2/JIIR5a6NCzYBh+KY8NZ1k0l AyIiPuF59T4Fv4NdwYILKoz5TbvtrwI7icCmE4SJXlyQ0Lx274VG1zibKvX3kWYBG1CP 2ix4i1+lWIGXQjbDRQx95C4vApxkUnVkFpfmA=
Received: by 10.216.19.68 with SMTP id m46mr1772770wem.7.1236517186214; Sun,  08 Mar 2009 05:59:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112618>


--0016e64c2718a49a7a04649b172b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks to everyone involved in the production of this installer!

2009/3/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>

>
> Hi,
>
> I just released a new version of Git for Windows (TAFKA WinGit).  It is
> basically Git 1.6.2 plus a few patches.  Please find the installer here:
>
>        http://msysgit.googlecode.com/
>
> Disclaimer: Git for Windows is still in a state where I do _not_ recommend
> using it unless you have the means to fix issues.  Unlike git.git
> developer community, the msysGit team is heavily undermanned.
>
> Known issues
>
> - Some commands are not yet supported on Windows and excluded from the
>  installation; namely: git archimport, git cvsexportcommit, git
>  cvsimport, git cvsserver, git filter-branch, git instaweb, git
>  send-email, git shell.
>
> - The Logitec QuickCam software can cause spurious crashes. See "Why does
>  make often crash creating a sh.exe.stackdump file when I try to compile
>  my source code?" in the MinGW FAQs
>  (http://www.mingw.org/MinGWiki/index.php/FAQ).
>
> - The Quick Launch icon will only be installed for the user running setup
>  (typically the Administrator). This is a technical restriction and will
>  not change.
>
> - Git Bash launched through the Explorer shell extension does not have the
>  git icon in its taskbar. This is a technical restriction and will not
>  change.
>
> - git send-mail does not work properly (Issue 27).
>
> - curl uses $HOME/_netrc instead of $HOME/.netrc.
>
> - If you want to specify a different location for --upload-pack, you have
>  to start the absolute path with two slashes. Otherwise MSys will mangle
>  the path.
>
> - git clone fails when the repository contains UTF-8 filepaths (Issue 80).
>
> Changes since Git-1.6.1-preview20081225
>
> New Features
> - Comes with official git 1.6.2.
> - Comes with upgraded vim 7.2.
> - Compiled with GCC 4.3.3.
> - The user can choose the preferred CR/LF behavior in the installer now.
> - Peter Kodl contributed support for hardlinks on Windows.
> - The bash prompt now shows information about the current repository.
>
> Bugfixes
> - If supported by the file system, pack files can grow larger than 2gb.
> - Comes with updated msys-1.0.dll (should fix some Vista issues).
> - Assorted fixes to support the new libexec/git-core/ layout better.
> - Read-only files can be properly replaced now.
> - git-svn is included again (original caveats still apply).
> - Obsolete programs from previous installations are cleaned up.
>
>
> So what are the next steps?
>
> Hannes is busy sorting out the differences between the test suites in
> git.git and mingw.git.
>
> Thanks to the awesome efforts of both Hannes and Steffen, the rest of the
> differences are really small (the biggest being Peter's hard link patch).
> I'll try to put together a patch series in the next few weeks.
>
> Ciao,
> Dscho
>
>

--0016e64c2718a49a7a04649b172b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks to everyone involved in the production of this installer!<br><br><di=
v class=3D"gmail_quote">2009/3/8 Johannes Schindelin <span dir=3D"ltr">&lt;=
<a href=3D"mailto:Johannes.Schindelin@gmx.de">Johannes.Schindelin@gmx.de</a=
>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
Hi,<br>
<br>
I just released a new version of Git for Windows (TAFKA WinGit). =A0It is<b=
r>
basically Git 1.6.2 plus a few patches. =A0Please find the installer here:<=
br>
<br>
 =A0 =A0 =A0 =A0<a href=3D"http://msysgit.googlecode.com/" target=3D"_blank=
">http://msysgit.googlecode.com/</a><br>
<br>
Disclaimer: Git for Windows is still in a state where I do _not_ recommend<=
br>
using it unless you have the means to fix issues. =A0Unlike git.git<br>
developer community, the msysGit team is heavily undermanned.<br>
<br>
Known issues<br>
<br>
- Some commands are not yet supported on Windows and excluded from the<br>
 =A0installation; namely: git archimport, git cvsexportcommit, git<br>
 =A0cvsimport, git cvsserver, git filter-branch, git instaweb, git<br>
 =A0send-email, git shell.<br>
<br>
- The Logitec QuickCam software can cause spurious crashes. See &quot;Why d=
oes<br>
 =A0make often crash creating a sh.exe.stackdump file when I try to compile=
<br>
 =A0my source code?&quot; in the MinGW FAQs<br>
 =A0(<a href=3D"http://www.mingw.org/MinGWiki/index.php/FAQ" target=3D"_bla=
nk">http://www.mingw.org/MinGWiki/index.php/FAQ</a>).<br>
<br>
- The Quick Launch icon will only be installed for the user running setup<b=
r>
 =A0(typically the Administrator). This is a technical restriction and will=
<br>
 =A0not change.<br>
<br>
- Git Bash launched through the Explorer shell extension does not have the<=
br>
 =A0git icon in its taskbar. This is a technical restriction and will not<b=
r>
 =A0change.<br>
<br>
- git send-mail does not work properly (Issue 27).<br>
<br>
- curl uses $HOME/_netrc instead of $HOME/.netrc.<br>
<br>
- If you want to specify a different location for --upload-pack, you have<b=
r>
 =A0to start the absolute path with two slashes. Otherwise MSys will mangle=
<br>
 =A0the path.<br>
<br>
- git clone fails when the repository contains UTF-8 filepaths (Issue 80).<=
br>
<br>
Changes since Git-1.6.1-preview20081225<br>
<br>
New Features<br>
- Comes with official git 1.6.2.<br>
- Comes with upgraded vim 7.2.<br>
- Compiled with GCC 4.3.3.<br>
- The user can choose the preferred CR/LF behavior in the installer now.<br=
>
- Peter Kodl contributed support for hardlinks on Windows.<br>
- The bash prompt now shows information about the current repository.<br>
<br>
Bugfixes<br>
- If supported by the file system, pack files can grow larger than 2gb.<br>
- Comes with updated msys-1.0.dll (should fix some Vista issues).<br>
- Assorted fixes to support the new libexec/git-core/ layout better.<br>
- Read-only files can be properly replaced now.<br>
- git-svn is included again (original caveats still apply).<br>
- Obsolete programs from previous installations are cleaned up.<br>
<br>
<br>
So what are the next steps?<br>
<br>
Hannes is busy sorting out the differences between the test suites in<br>
git.git and mingw.git.<br>
<br>
Thanks to the awesome efforts of both Hannes and Steffen, the rest of the<b=
r>
differences are really small (the biggest being Peter&#39;s hard link patch=
).<br>
I&#39;ll try to put together a patch series in the next few weeks.<br>
<br>
Ciao,<br>
Dscho<br>
<br>
</blockquote></div><br>

--0016e64c2718a49a7a04649b172b--
