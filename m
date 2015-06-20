From: Jon <jon.forums@gmail.com>
Subject: Re: 3rd release candidate of Git for Windows 2.x, was Re:
 Release candidate of Git for Windows 2.x is out
Date: Sat, 20 Jun 2015 07:59:33 -0700 (PDT)
Message-ID: <1081c3a3-65d7-4065-9cf5-a88d966347b2@googlegroups.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56_602792659.1434812373568"
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBC3ZHK4B2AFBBVX7SWWAKGQEIJ3ZKQQ@googlegroups.com Sat Jun 20 16:59:36 2015
Return-path: <msysgit+bncBC3ZHK4B2AFBBVX7SWWAKGQEIJ3ZKQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f187.google.com ([209.85.216.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3ZHK4B2AFBBVX7SWWAKGQEIJ3ZKQQ@googlegroups.com>)
	id 1Z6KF6-0006ht-0K
	for gcvm-msysgit@m.gmane.org; Sat, 20 Jun 2015 16:59:36 +0200
Received: by qcvp6 with SMTP id p6sf38169816qcv.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Jun 2015 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=axgE3CmDnEJumCmVG3w4jYIenPSyCQCuw9sVred6IeE=;
        b=yjY1OgCeLvgHw5HTSr0RRI5HdaEgiVzwOf4FW2MFYzgboZs6Tw1t7kLHiopdbP6YfH
         k6NDHoXuGn1YPwuZdu5e0vzAiBB/SEpUC2JlHr21d/kaGXcqrY5FQRQWZ83Vo2nm2qol
         OfEJ473P8Wa5Lf9oS7bHtsJBdFdKyV0+E16PdgDOUykAAdbR1GKuYQNlsGrh6qNRQJIk
         dfga6FtvU24A4vLCAdZPkO1oUU8C1PCQpruHNu7pHycNU5iip8VAicEvvsiw/dHCHLzw
         r2owT1DcTOCGtuJ4sL4x66MzHEgoL4SU19zITR2yEwgd3ocMbLOirCc8Wcn0lbYHaHbL
         ifqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=axgE3CmDnEJumCmVG3w4jYIenPSyCQCuw9sVred6IeE=;
        b=zS9Xq6wMOUqa8YRdRJsVcJ9FfxSkuWlL93XGts/m1iq0/DyEM6vDHL3w5FhhzZH5/B
         Tt6HUbUov1jPcuQOnoT+QIDaWp56YNhl/wciQVeYicH8vshyzzvV5c6A3YZGYdfar49E
         v0Y2CveqYQl0GKqjsUwxx1eHU0iikojdotL0L8Wj38O9NKrR9YVPa/nZvShZMLAV5Y6v
         pRY20RXTp2HHp5RHnppY+QbVGCsoJHnT+SiaV1El7SbNoJNGSenrb67nyWQp/cCjVD1x
         OzVhlmS0zATmxI7UzhbwVcY6DbgkDiCzVWYM1IEvg9Z925ivVKEluSRdFkS97f43HTz9
         H2gg==
X-Received: by 10.182.91.80 with SMTP id cc16mr190933obb.21.1434812374699;
        Sat, 20 Jun 2015 07:59:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.213.98 with SMTP id nr2ls993155obc.73.gmail; Sat, 20 Jun
 2015 07:59:33 -0700 (PDT)
X-Received: by 10.182.221.129 with SMTP id qe1mr187105obc.2.1434812373953;
        Sat, 20 Jun 2015 07:59:33 -0700 (PDT)
In-Reply-To: <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
X-Original-Sender: jon.forums@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272230>

------=_Part_56_602792659.1434812373568
Content-Type: multipart/alternative; 
	boundary="----=_Part_57_1455856914.1434812373568"

------=_Part_57_1455856914.1434812373568
Content-Type: text/plain; charset=UTF-8


On Saturday, June 20, 2015 at 10:16:09 AM UTC-4, Johannes Schindelin wrote:
>
> Hi all, 
>
> I just uploaded the 3rd release candidate for the upcoming Git for Windows 
> 2.x release. Please find the download link here: 
>
> https://git-for-windows.github.io/#download 
>
> Lots of changes since the first release candidate (v2.4.2, I was too 
> swamped to announce the second release candidate -- v2.4.3 -- I published 
> Friday last week, my apologies). Please find them in the release notes: 
>
>
> https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md 
>
> We're getting closer! 
> Johannes 
>

Fantastic!

1) Why are there two ssl/certs trees? (e.g. - one is used by git-bash.exe 
and the other git-cmd.exe and cmd/git.exe?)
2) Why are INSTALL_DIR/usr/ssl/certs/ca-bundle.crt and 
INSTALL_DIR/mingw64/ssl/certs/ca-bundle.crt different?


C:\Apps\git2>mingw64\bin\git.exe version
git version 2.4.4.windows.2

C:\Apps\git2>usr\bin\diff.exe --brief usr\ssl\certs\ca-bundle.crt 
mingw64\ssl\certs\ca-bundle.crt
Files usr\ssl\certs\ca-bundle.crt and mingw64\ssl\certs\ca-bundle.crt 
differ 

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

------=_Part_57_1455856914.1434812373568
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br>On Saturday, June 20, 2015 at 10:16:09 AM UTC-4, Johannes Schindelin wr=
ote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex=
;border-left: 1px #ccc solid;padding-left: 1ex;">Hi all,
<br>
<br>I just uploaded the 3rd release candidate for the upcoming Git for Wind=
ows 2.x release. Please find the download link here:
<br>
<br><a href=3D"https://git-for-windows.github.io/#download" target=3D"_blan=
k" rel=3D"nofollow" onmousedown=3D"this.href=3D'https://www.google.com/url?=
q\75https%3A%2F%2Fgit-for-windows.github.io%2F%23download\46sa\75D\46sntz\0=
751\46usg\75AFQjCNH7Xr6ehKYvOq0YKmWM2A1d350WTQ';return true;" onclick=3D"th=
is.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgit-for-windows.git=
hub.io%2F%23download\46sa\75D\46sntz\0751\46usg\75AFQjCNH7Xr6ehKYvOq0YKmWM2=
A1d350WTQ';return true;">https://git-for-windows.<wbr>github.io/#download</=
a>
<br>
<br>Lots of changes since the first release candidate (v2.4.2, I was too sw=
amped to announce the second release candidate -- v2.4.3 -- I published Fri=
day last week, my apologies). Please find them in the release notes:
<br>
<br><a href=3D"https://github.com/git-for-windows/build-extra/blob/master/i=
nstaller/ReleaseNotes.md" target=3D"_blank" rel=3D"nofollow" onmousedown=3D=
"this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fgit=
-for-windows%2Fbuild-extra%2Fblob%2Fmaster%2Finstaller%2FReleaseNotes.md\46=
sa\75D\46sntz\0751\46usg\75AFQjCNGCVC5wwulUYt60rbp9xdQnodsBDA';return true;=
" onclick=3D"this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgith=
ub.com%2Fgit-for-windows%2Fbuild-extra%2Fblob%2Fmaster%2Finstaller%2FReleas=
eNotes.md\46sa\75D\46sntz\0751\46usg\75AFQjCNGCVC5wwulUYt60rbp9xdQnodsBDA';=
return true;">https://github.com/git-for-<wbr>windows/build-extra/blob/<wbr=
>master/installer/ReleaseNotes.<wbr>md</a>
<br>
<br>We're getting closer!
<br>Johannes
<br></blockquote><div><br>Fantastic!<br><br>1) Why are there two ssl/certs =
trees? (e.g. - one is used by git-bash.exe and the other git-cmd.exe and cm=
d/git.exe?)<br>2) Why are INSTALL_DIR/usr/ssl/certs/ca-bundle.crt and INSTA=
LL_DIR/mingw64/ssl/certs/ca-bundle.crt different?<br><br><br>C:\Apps\git2&g=
t;mingw64\bin\git.exe version<br>git version 2.4.4.windows.2<br><br>C:\Apps=
\git2&gt;usr\bin\diff.exe --brief usr\ssl\certs\ca-bundle.crt mingw64\ssl\c=
erts\ca-bundle.crt<br>Files usr\ssl\certs\ca-bundle.crt and mingw64\ssl\cer=
ts\ca-bundle.crt differ <br></div>

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

------=_Part_57_1455856914.1434812373568--
------=_Part_56_602792659.1434812373568--
