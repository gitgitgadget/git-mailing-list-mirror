From: rupert thurner <rupert.thurner@gmail.com>
Subject: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Wed, 29 Apr 2015 08:23:13 -0700 (PDT)
Message-ID: <bf54ac53-8550-404c-afb2-d0d7257eb4dc@googlegroups.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_282_1983333081.1430320993796"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCBO3N6S34BRBYXOQOVAKGQEDTGERVI@googlegroups.com Wed Apr 29 17:23:18 2015
Return-path: <msysgit+bncBCBO3N6S34BRBYXOQOVAKGQEDTGERVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f192.google.com ([209.85.213.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBO3N6S34BRBYXOQOVAKGQEDTGERVI@googlegroups.com>)
	id 1YnTpT-0005xg-Hl
	for gcvm-msysgit@m.gmane.org; Wed, 29 Apr 2015 17:23:15 +0200
Received: by igdh15 with SMTP id h15sf15326690igd.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 Apr 2015 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=mD42EHafD+r8Q6gEFWAJSxKcGduGEUGXNZcEqR43gsg=;
        b=FPt7sCluFYw5G1kWgIX6tfrXcJCYzlTvqpSRl4C1+ICr8p9e17j1wKHR5vyoBg0gi2
         cFK7ZIUjeMN5jqj7z1CTaz+AkxlZdbTZRsSzZhibVAFaOz6PmwbLq5El3Deq8WO2QPqb
         S1r1wQngNgBRs0QbNupEhrEhisaMneJQBOTs+H+6nYOgsHu7g6Pd/xwRMvYSkxoJkgIx
         Fu44VpHUXv4oDnuSJVsWRR4Jgnkjx7OWm3DXlQylWct7ysmfRLWUTdzf0KJZbF5x50E1
         qUwTId/TqL16mDdX0AgnWGlNtSKfHUea71CXsT7FGFY2a8/p8BobxXyLL9TSiKDXfOm1
         c0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=mD42EHafD+r8Q6gEFWAJSxKcGduGEUGXNZcEqR43gsg=;
        b=KK6+r8hzP8hT1k8Bke4C2Ax6CvThcNwjBx1NK4IioegrcOv9pZVfS783nPHhO+Wh4h
         +EGFwt7GlLVe02FoI/9QcpLsKY1N/6hIxtH+mbCso1x72y60VVvHnvOSHilb1rzJueUA
         wAb0DQBoKB2k0UU7nELRhIDkYQbePAzP+lib5NSI3u4qxPytWv/juv2lESf2kJUwX+TJ
         UBa1GHL6KFPqRJDk5O9PYmLbDmVWO28HLjGwI/OhmrDC2STXSEGB/xSfKsDTWbXall3V
         d9kqXW9nxWmkJ1tfZoNXnaio6p+zqmPrNdI37JxxGcH2ymUkeQ3KuyF+MheW3fwV04Zq
         1KDQ==
X-Received: by 10.140.104.211 with SMTP id a77mr288510qgf.34.1430320994587;
        Wed, 29 Apr 2015 08:23:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.81.40 with SMTP id e37ls865122qgd.4.gmail; Wed, 29 Apr
 2015 08:23:14 -0700 (PDT)
X-Received: by 10.140.95.135 with SMTP id i7mr305963qge.27.1430320994178;
        Wed, 29 Apr 2015 08:23:14 -0700 (PDT)
In-Reply-To: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
X-Original-Sender: rupert.thurner@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267972>

------=_Part_282_1983333081.1430320993796
Content-Type: multipart/alternative; 
	boundary="----=_Part_283_637923633.1430320993796"

------=_Part_283_637923633.1430320993796
Content-Type: text/plain; charset=UTF-8


On Friday, April 10, 2015 at 1:43:30 PM UTC+2, Johannes Schindelin wrote:
>
> Dear all, 
>
> during the really exciting Git Merge conference, the Git for Windows 
> developers had the opportunity to meet and we managed to whip out a 
> *really* early beta of the upcoming Git for Windows 2.x series. 
>
> Please keep in mind that we not only changed our entire development 
> environment, but that this change also affects end user installations quite 
> a bit: as parts of Git are still written in shell and Perl, we have to ship 
> a shell and Perl interpreter, too, which are naturally plucked from the 
> development environment. 
>
> Of course that implies that there are probably still quite a couple of 
> rough edges. Nevertheless, if you want to have a *really* early glimpse at 
> the upcoming major release, feel free to give it a spin: 
> https://git-for-windows.github.io/#download 
>
>
after using it now for a couple of weeks every week or so, on windows-7, 
git-receive-pack.exe hangs from time to time and cannot be killed any more. 
i start it either with
  git fetch --all -p
  git push

it looks like it does not take any signals at all. no ctrl-c in the mintty, 
nor a kill via sysinternals process explorer. up to now only reboot helped, 
but pretty sure i miss something here.

best,
rupert
 

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_283_637923633.1430320993796
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Friday, April 10, 2015 at 1:43:30 PM UTC+2, Johanne=
s Schindelin wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;mar=
gin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Dear all,
<br>
<br>during the really exciting Git Merge conference, the Git for Windows de=
velopers had the opportunity to meet and we managed to whip out a *really* =
early beta of the upcoming Git for Windows 2.x series.
<br>
<br>Please keep in mind that we not only changed our entire development env=
ironment, but that this change also affects end user installations quite a =
bit: as parts of Git are still written in shell and Perl, we have to ship a=
 shell and Perl interpreter, too, which are naturally plucked from the deve=
lopment environment.
<br>
<br>Of course that implies that there are probably still quite a couple of =
rough edges. Nevertheless, if you want to have a *really* early glimpse at =
the upcoming major release, feel free to give it a spin: <a href=3D"https:/=
/git-for-windows.github.io/#download" target=3D"_blank" rel=3D"nofollow" on=
mousedown=3D"this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgit-=
for-windows.github.io%2F%23download\46sa\75D\46sntz\0751\46usg\75AFQjCNH7Xr=
6ehKYvOq0YKmWM2A1d350WTQ';return true;" onclick=3D"this.href=3D'https://www=
.google.com/url?q\75https%3A%2F%2Fgit-for-windows.github.io%2F%23download\4=
6sa\75D\46sntz\0751\46usg\75AFQjCNH7Xr6ehKYvOq0YKmWM2A1d350WTQ';return true=
;">https://git-for-windows.<wbr>github.io/#download</a>
<br><br></blockquote><div><br></div><div>after using it now for a couple of=
 weeks every week or so, on windows-7, git-receive-pack.exe hangs from time=
 to time and cannot be killed any more. i start it either with</div><div>&n=
bsp; git fetch --all -p</div><div>&nbsp; git push</div><div><br></div><div>=
it looks like it does not take any signals at all. no ctrl-c in the mintty,=
 nor a kill via sysinternals process explorer. up to now only reboot helped=
, but pretty sure i miss something here.</div><div><br></div><div>best,</di=
v><div>rupert</div><div>&nbsp;</div></div>

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
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_283_637923633.1430320993796--
------=_Part_282_1983333081.1430320993796--
