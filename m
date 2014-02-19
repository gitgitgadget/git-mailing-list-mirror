From: adam@adamralph.com
Subject: Re: Git for Windows 1.9.0
Date: Wed, 19 Feb 2014 04:00:22 -0800 (PST)
Message-ID: <59ab732f-f471-4586-90c3-b583000c4e50@googlegroups.com>
References: <alpine.DEB.1.00.1402180036150.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_341_11114406.1392811222416"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCRLFVN3TQCRBQGJSKMAKGQEFDYHDOA@googlegroups.com Wed Feb 19 13:34:11 2014
Return-path: <msysgit+bncBCRLFVN3TQCRBQGJSKMAKGQEFDYHDOA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f55.google.com ([209.85.219.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCRLFVN3TQCRBQGJSKMAKGQEFDYHDOA@googlegroups.com>)
	id 1WG6Lq-00067c-Nq
	for gcvm-msysgit@m.gmane.org; Wed, 19 Feb 2014 13:34:11 +0100
Received: by mail-oa0-f55.google.com with SMTP id l6sf85433oag.20
        for <gcvm-msysgit@m.gmane.org>; Wed, 19 Feb 2014 04:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=d+Wlf2FKJnbepnFNRpLFueCdMfgRovS+1mxSuOpzKDo=;
        b=I4nOne+jsJnS1dP52nkjfobVfj/IONBFZp4gMv1iUdhM4xXSDXqjV7P5QWeD6C93Zv
         FF/kQvXVVrqvNTOaAY0N3GAkSuuWfmDUw696nkmlWYHtBcqDkiXZAWcYVw+cw60OM715
         Y61xzAPc8uQWawWvfTUtBDvn1qjoDMebuMjg8X412DJU/wRewQZ6sB0xwPhfxuJtNktJ
         d9/oxyfZ/kvvIpM+CH1FfJLLAEVSaT1Prqq0XPCLBLALXHja997rKDciPI/wBNcSNyE7
         Wp+ismcOdMNnTTn1TJX20PxzWQMfhL1IYzzWM8ObGrLUPJ5tmN38WPPaPZaEwJh7K7jZ
         Pq6g==
X-Received: by 10.182.73.228 with SMTP id o4mr3000obv.34.1392813249558;
        Wed, 19 Feb 2014 04:34:09 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.39.67 with SMTP id n3ls26707obk.43.gmail; Wed, 19 Feb 2014
 04:34:08 -0800 (PST)
X-Received: by 10.182.65.168 with SMTP id y8mr15265976obs.38.1392813248268;
        Wed, 19 Feb 2014 04:34:08 -0800 (PST)
Received: by 10.224.156.133 with SMTP id x5msqaw;
        Wed, 19 Feb 2014 04:00:23 -0800 (PST)
X-Received: by 10.140.80.47 with SMTP id b44mr3125qgd.33.1392811222884;
        Wed, 19 Feb 2014 04:00:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1402180036150.14982@s15462909.onlinehome-server.info>
X-Original-Sender: adam@adamralph.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242389>

------=_Part_341_11114406.1392811222416
Content-Type: text/plain; charset=UTF-8

awesome work guys! thank you very much!

On Tuesday, 18 February 2014 00:38:54 UTC+1, Johannes Schindelin wrote:
>
> Dear Git fanbois, 
>
> this announcement informs you that the small team of volunteers who keep 
> the Git ship afloat for the most prevalent desktop operating system 
> managed to release yet another version of Git for Windows: 
>
> Git Release Notes (Git-1.9.0-preview20140217) 
> Last update: 17 February 2013 
>
> Changes since Git-1.8.5.2-preview20131230 
>
> New Features 
> - Comes with Git 1.9.0 plus Windows-specific patches. 
> - Better work-arounds for Windows-specific path length limitations (pull 
>   request #122) 
> - Uses optimized TortoiseGitPLink when detected (msysGit pull request 
>   #154) 
> - Allow Windows users to use Linux Git on their files, using Vagrant 
>   http://www.vagrantup.com/ (msysGit pull request #159) 
> - InnoSetup 5.5.4 is now used to generate the installer (msysGit pull 
>   request #167) 
>
> Bugfixes 
> - Fixed regression with interactive password prompt for remotes using the 
>   HTTPS protocol (issue #111) 
> - We now work around Subversion servers printing non-ISO-8601-compliant 
>   time stamps (pull request #126) 
> - The installer no longer sets the HOME environment variable (msysGit pull 
>   request #166) 
> - Perl no longer creates empty sys$command files when no stdin is 
>   connected (msysGit pull request #152) 
>
> Ciao, 
> Johannes 
>

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_341_11114406.1392811222416
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">awesome work guys! thank you very much!<br><br>On Tuesday,=
 18 February 2014 00:38:54 UTC+1, Johannes Schindelin  wrote:<blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px =
#ccc solid;padding-left: 1ex;">Dear Git fanbois,
<br>
<br>this announcement informs you that the small team of volunteers who kee=
p
<br>the Git ship afloat for the most prevalent desktop operating system
<br>managed to release yet another version of Git for Windows:
<br>
<br>Git Release Notes (Git-1.9.0-preview20140217)
<br>Last update: 17 February 2013
<br>
<br>Changes since Git-1.8.5.2-preview20131230
<br>
<br>New Features
<br>- Comes with Git 1.9.0 plus Windows-specific patches.
<br>- Better work-arounds for Windows-specific path length limitations (pul=
l
<br>&nbsp; request #122)
<br>- Uses optimized TortoiseGitPLink when detected (msysGit pull request
<br>&nbsp; #154)
<br>- Allow Windows users to use Linux Git on their files, using Vagrant
<br>&nbsp; <a href=3D"http://www.vagrantup.com/" target=3D"_blank" onmoused=
own=3D"this.href=3D'http://www.google.com/url?q\75http%3A%2F%2Fwww.vagrantu=
p.com%2F\46sa\75D\46sntz\0751\46usg\75AFQjCNGxfu7Iuf8icqlRcYwi3N2OnEHbhw';r=
eturn true;" onclick=3D"this.href=3D'http://www.google.com/url?q\75http%3A%=
2F%2Fwww.vagrantup.com%2F\46sa\75D\46sntz\0751\46usg\75AFQjCNGxfu7Iuf8icqlR=
cYwi3N2OnEHbhw';return true;">http://www.vagrantup.com/</a> (msysGit pull r=
equest #159)
<br>- InnoSetup 5.5.4 is now used to generate the installer (msysGit pull
<br>&nbsp; request #167)
<br>
<br>Bugfixes
<br>- Fixed regression with interactive password prompt for remotes using t=
he
<br>&nbsp; HTTPS protocol (issue #111)
<br>- We now work around Subversion servers printing non-ISO-8601-compliant
<br>&nbsp; time stamps (pull request #126)
<br>- The installer no longer sets the HOME environment variable (msysGit p=
ull
<br>&nbsp; request #166)
<br>- Perl no longer creates empty sys$command files when no stdin is
<br>&nbsp; connected (msysGit pull request #152)
<br>
<br>Ciao,
<br>Johannes
<br></blockquote></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_341_11114406.1392811222416--
