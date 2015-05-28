From: Robert Dailey <rcdailey@gmail.com>
Subject: Re: Release candidate of Git for Windows 2.x is out
Date: Thu, 28 May 2015 09:25:56 -0700 (PDT)
Message-ID: <0efdc7c9-b982-4134-8128-d2a7d84f9a66@googlegroups.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_207_285538310.1432830356253"
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCKNPCNAWECRBFEDTWVQKGQEFIRKO5Y@googlegroups.com Thu May 28 18:26:00 2015
Return-path: <msysgit+bncBCKNPCNAWECRBFEDTWVQKGQEFIRKO5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f59.google.com ([209.85.192.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCKNPCNAWECRBFEDTWVQKGQEFIRKO5Y@googlegroups.com>)
	id 1Yy0d4-00088I-0G
	for gcvm-msysgit@m.gmane.org; Thu, 28 May 2015 18:25:58 +0200
Received: by qgdz60 with SMTP id z60sf12319458qgd.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 28 May 2015 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=FKp8XaYRcIstidgrLsIMb4uHESTJbUq4H7cK0MoXt2c=;
        b=tJBcVmPSPA7/YbOPaxZVmEOYlzNeJq3sDIzoE3g3PFvohqdN/B+/E7QqmT9yJWOvwA
         SICz/GGsnc9xS4nzcTV3RtKqugG2iez6Gcp8kzx2p1qpysKaipjyJz7fyzXCKY9q0FIu
         oCETFF/wzhuKWJrdPySyZsuHb3YjFBdv3wXMUsG+ljJL0u2ziKV5IHtb1qWA6j5IH5Ve
         GrMJiubm9T60f3fjnZ1AMuSw14Gb4tlcP7Lc8bkvLNub9LOmsAAx9b/IPkvE2IoQ8aYt
         3/djekarO9Ri77RurNWP+BJURGQZMd7p7pJqHmtC3DorbeKzgMcDgU+ZguBcgVeT2KXn
         m+KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=FKp8XaYRcIstidgrLsIMb4uHESTJbUq4H7cK0MoXt2c=;
        b=RHpl5EbhZmqNz1xE8aLztsrU4L/TOfzLIeWdIIck352WZ5rNljy9Sz9hZaY1S8P/Fj
         wE60+jFcFd7y3DrfBFDbCGRwr8CHAGzp2kkTRLEMnH/nTThsM3JoIXj3HiTD1L0WidM3
         4QoJe4raOh/Pf36Sy4vPzNRxEhp1Tacrb8utLbN0trPUKkz97KvX2wj00786GnGZihUC
         V1PgGE1I8vN8xg4sE0Fw4dGTubE1aYh8jxu90qfhdqRQr2A+5Vokv5y3BmxkjDm+NsgQ
         xGbrs7BmBX8wPpsLskNfT9suQk0C9cxGQjw613oUczefnsB3XSJ0zQqOWnAi4f9KqPET
         W2FA==
X-Received: by 10.182.28.6 with SMTP id x6mr32023obg.37.1432830357214;
        Thu, 28 May 2015 09:25:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.230.168 with SMTP id sz8ls295845obc.14.gmail; Thu, 28 May
 2015 09:25:56 -0700 (PDT)
X-Received: by 10.182.20.212 with SMTP id p20mr30703obe.11.1432830356604;
        Thu, 28 May 2015 09:25:56 -0700 (PDT)
In-Reply-To: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
X-Original-Sender: rcdailey@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270157>

------=_Part_207_285538310.1432830356253
Content-Type: multipart/alternative; 
	boundary="----=_Part_208_1563908772.1432830356253"

------=_Part_208_1563908772.1432830356253
Content-Type: text/plain; charset=UTF-8

On Wednesday, May 27, 2015 at 5:11:37 PM UTC-5, Johannes Schindelin wrote:
>
> Hi all, 
>
> I just uploaded release candidates for the upcoming Git for Windows 2.x 
> release. Please find the download link here: 
>
> https://git-for-windows.github.io/#download 
>
> There are 32-bit and 64-bit versions both of regular installers and 
> portable installers ("portable" meaning that they are .7z archives that can 
> be unpacked anywhere and run in place, without any need for running an 
> installer). 
>
> My projected time line is to hammer out the last kinks until Friday, and 
> then continue after a one-week leave, if needed, and then finally retire 
> msysGit and start the official 2.x release cycle of Git for Windows. 
>
> If you are running Windows and have a little time to spare, please test 
> this release candidate thoroughly. If you find bugs, please first look at 
> https://github.com/git-for-windows/git/issues (even the closed ones), and 
> comment either on existing tickets or open new ones. It would be even 
> cooler, of course, if you could open Pull Requests with fixes :-) 
>
> Ciao, 
> Johannes 
>

When adding self-signed certificates, I see two locations:

E:\Git\usr\ssl\certs\ca-bundle.crt
E:\Git\mingw64\ssl\certs\ca-bundle.crt

It seems the 2nd one is the one used by git commands. I have to access a 
git server over HTTPS that uses a self-signed certificate. What is the 
purpose of the 1st ca-bundle.crt file? It would be more ideal to add to the 
first one since it doesn't depend on architecture (the path changes for 
32-bit installs).

Do you have a recommended process for this?

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

------=_Part_208_1563908772.1432830356253
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wednesday, May 27, 2015 at 5:11:37 PM UTC-5, Johannes S=
chindelin wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin=
-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi all,
<br>
<br>I just uploaded release candidates for the upcoming Git for Windows 2.x=
 release. Please find the download link here:
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
<br>There are 32-bit and 64-bit versions both of regular installers and por=
table installers ("portable" meaning that they are .7z archives that can be=
 unpacked anywhere and run in place, without any need for running an instal=
ler).
<br>
<br>My projected time line is to hammer out the last kinks until Friday, an=
d then continue after a one-week leave, if needed, and then finally retire =
msysGit and start the official 2.x release cycle of Git for Windows.
<br>
<br>If you are running Windows and have a little time to spare, please test=
 this release candidate thoroughly. If you find bugs, please first look at =
<a href=3D"https://github.com/git-for-windows/git/issues" target=3D"_blank"=
 rel=3D"nofollow" onmousedown=3D"this.href=3D'https://www.google.com/url?q\=
75https%3A%2F%2Fgithub.com%2Fgit-for-windows%2Fgit%2Fissues\46sa\75D\46sntz=
\0751\46usg\75AFQjCNH6XxulA5MmlpLkhQVoy3XchJhA8A';return true;" onclick=3D"=
this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fgit-=
for-windows%2Fgit%2Fissues\46sa\75D\46sntz\0751\46usg\75AFQjCNH6XxulA5MmlpL=
khQVoy3XchJhA8A';return true;">https://github.com/git-for-<wbr>windows/git/=
issues</a> (even the closed ones), and comment either on existing tickets o=
r open new ones. It would be even cooler, of course, if you could open Pull=
 Requests with fixes :-)
<br>
<br>Ciao,
<br>Johannes
<br></blockquote><div><br></div><div>When adding self-signed certificates, =
I see two locations:</div><div><br></div><div>E:\Git\usr\ssl\certs\ca-bundl=
e.crt</div><div>E:\Git\mingw64\ssl\certs\ca-bundle.crt<br></div><div><br></=
div><div>It seems the 2nd one is the one used by git commands. I have to ac=
cess a git server over HTTPS that uses a self-signed certificate. What is t=
he purpose of the 1st ca-bundle.crt file? It would be more ideal to add to =
the first one since it doesn't depend on architecture (the path changes for=
 32-bit installs).</div><div><br></div><div>Do you have a recommended proce=
ss for this?</div></div>

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

------=_Part_208_1563908772.1432830356253--
------=_Part_207_285538310.1432830356253--
