From: Robert Dailey <rcdailey@gmail.com>
Subject: Re: Release candidate of Git for Windows 2.x is out
Date: Fri, 12 Jun 2015 09:30:11 -0700 (PDT)
Message-ID: <e2d218c4-efe2-457f-9acb-a35fb779b573@googlegroups.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_655_1661722492.1434126611325"
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCKNPCNAWECRBFES5SVQKGQEAFWLGZY@googlegroups.com Fri Jun 12 18:30:20 2015
Return-path: <msysgit+bncBCKNPCNAWECRBFES5SVQKGQEAFWLGZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f192.google.com ([209.85.214.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCKNPCNAWECRBFES5SVQKGQEAFWLGZY@googlegroups.com>)
	id 1Z3RqV-0003nB-8C
	for gcvm-msysgit@m.gmane.org; Fri, 12 Jun 2015 18:30:19 +0200
Received: by obcwm4 with SMTP id wm4sf10452013obc.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 12 Jun 2015 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=fVKvwFo+gzxjG+0Lq0ckjwxInvKxd8DnTtgbKCWcy1M=;
        b=S4D1LuLNSFjcs08fBMnBhHqvUA76BpnpfcodXjJ1QDf0++gzmVObV+pAT9muKvhnwP
         +Knp0/bieiYhDStj0FbJXq+SNEXvTWTatuXqhsmow2JIMtwaDRD3MGnFDiIG+5mr8f9x
         y0zlqKc5MbYwBAAUUZDPf19Vl3vPTZrZfaWD4iwy0S0OqHyTxdn4ooP1N99j98D2AnBI
         XkDZOerB2X5wLlZEaIo2ONkYfy6Wa40W/pCETGIUvBQaL96JYUdpyUudF6+zJvhA6qqo
         wScul5lgBH9kYmCd3K5Jvmlz0Yv51cjYZ1IJaLV4s8by1axiTJ+v26pe0iD18yWRdeJJ
         2iKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=fVKvwFo+gzxjG+0Lq0ckjwxInvKxd8DnTtgbKCWcy1M=;
        b=JhAdptUM6oxoisV+05F45hy2dP0aW6qOqaWUyIZWTAqL61HH2rpdY1upqxNEWOsdgl
         fEHn4Vx+jAa+oRfMhdVZr3LCaaoHcg3x9/h7aSSaZvZjenWqgNjorB59Uq14ZKliwpCb
         Z/Ayv5viIMc+EGgmQTY9WGFTHIhc9MNI3oUJEKRnQjbmHjg9+8WSUwoEqvYzw6FQywL8
         xnOSoJ442KLeNDeH1lBmbnj/gp9injRAlF9LvSri7nhdhSuSBfxMbsEERfLKZIbLv2yG
         Eq5+0PipwLYKos1WnWc7BpEl004ij4yofSLm3k53fWf/r3UxYuTyzECvyd2zKO1m2NFY
         ggJQ==
X-Received: by 10.182.213.199 with SMTP id nu7mr124316obc.39.1434126613588;
        Fri, 12 Jun 2015 09:30:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.53.135 with SMTP id b7ls830164obp.45.gmail; Fri, 12 Jun
 2015 09:30:11 -0700 (PDT)
X-Received: by 10.182.181.10 with SMTP id ds10mr125965obc.12.1434126611942;
        Fri, 12 Jun 2015 09:30:11 -0700 (PDT)
In-Reply-To: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
X-Original-Sender: rcdailey@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271497>

------=_Part_655_1661722492.1434126611325
Content-Type: multipart/alternative; 
	boundary="----=_Part_656_545093809.1434126611325"

------=_Part_656_545093809.1434126611325
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

It's no longer clear exactly how to setup self-signed certificates in this 
new version of Git:

$ git fetch origin
fatal: unable to access 'https://mygitserver/myrepo.git/': SSL certificate 
problem: self signed certificate in certificate chain

No one on my team at $DAYJOB uses SSH, they all use HTTPS. Switching 
everyone to SSH certainly won't be an option either. So prior to asking 
everyone to upgrade, I'll need to be able to provide them instruction on 
how to properly setup our cert so that HTTPS works properly.

Ideally the solution will be done in such a way that when installing newer 
versions of Git for Windows, that the keys are not overwritten. Using the 
normal Git config approach won't work either since when you get the CA cert 
path to our key, it no longer knows about the other built-in certs, so 
fetches from github.com and the like will also fail.

Maybe there is an elegant or easy solution to this. But I just haven't 
found it yet.

 

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

------=_Part_656_545093809.1434126611325
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br>On Wednesday, May 27, 2015 at 5:11:37 PM UTC-5, Johannes Schindelin wro=
te:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;=
border-left: 1px #ccc solid;padding-left: 1ex;">Hi all,
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
<br></blockquote><div><br></div><div>It's no longer clear exactly how to se=
tup self-signed certificates in this new version of Git:</div><div><br></di=
v><div><div>$ git fetch origin</div><div>fatal: unable to access 'https://m=
ygitserver/myrepo.git/': SSL certificate problem: self signed certificate i=
n certificate chain</div></div><div><br></div><div>No one on my team at $DA=
YJOB uses SSH, they all use HTTPS. Switching everyone to SSH certainly won'=
t be an option either. So prior to asking everyone to upgrade, I'll need to=
 be able to provide them instruction on how to properly setup our cert so t=
hat HTTPS works properly.</div><div><br></div><div>Ideally the solution wil=
l be done in such a way that when installing newer versions of Git for Wind=
ows, that the keys are not overwritten. Using the normal Git config approac=
h won't work either since when you get the CA cert path to our key, it no l=
onger knows about the other built-in certs, so fetches from github.com and =
the like will also fail.</div><div><br></div><div>Maybe there is an elegant=
 or easy solution to this. But I just haven't found it yet.</div><div><br><=
/div><div>&nbsp;</div>

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

------=_Part_656_545093809.1434126611325--
------=_Part_655_1661722492.1434126611325--
