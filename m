From: Ties <thijsbrobbel@gmail.com>
Subject: Re: Release candidate of Git for Windows 2.x is out
Date: Fri, 26 Jun 2015 04:06:20 -0700 (PDT)
Message-ID: <f80886fc-8c51-4af8-9472-23c5b9fbe2a6@googlegroups.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1718_1819692996.1435316780822"
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: git-for-windows@googlegroups.com
X-From: msysgit+bncBDPZZWNKLAINT55UVQCRUBDLUQVLC@googlegroups.com Fri Jun 26 13:47:41 2015
Return-path: <msysgit+bncBDPZZWNKLAINT55UVQCRUBDLUQVLC@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f55.google.com ([209.85.220.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDPZZWNKLAINT55UVQCRUBDLUQVLC@googlegroups.com>)
	id 1Z8S6c-00076P-GG
	for gcvm-msysgit@m.gmane.org; Fri, 26 Jun 2015 13:47:38 +0200
Received: by pabli10 with SMTP id li10sf24129817pab.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 26 Jun 2015 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=TY/+MuWpOW0Ubg6GE3r/P+sZrpcRR58+zW5CisIvi1A=;
        b=BCKJoiSMJxWCf7kZGBo/5Akl1omofH8F0W5CO+/T/qoshwFtIe3RwkOts9N0YgibJd
         LbPjRt9inJyhlokMsPqmK9aORSK/SMx92TeyMk9UW510cmKrEEg/xWnOmTIqy/rbXSMW
         NHzWO+eeY7ec/ocerJCV2u+FXu/5WlEeliyKyWmYcEFOQQj7ZHA2b433qFh+2nJOBlud
         gRDV6WSsjMRqBD9GD246+rcB8qPYLCmmGl+aRLc1NHd4D+mPO6D7OkwVSX0bYVHAsa8p
         rf6OAcVmNplMdnWYO2rXwlDS4y5DmxSVoB1DHN8jvJT2Myn4AOg9l1CLsfv2NIfDSZcU
         h2Jg==
X-Received: by 10.50.107.105 with SMTP id hb9mr30395igb.3.1435319257670;
        Fri, 26 Jun 2015 04:47:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.41.8 with SMTP id b8ls176977igl.33.gmail; Fri, 26 Jun 2015
 04:47:37 -0700 (PDT)
X-Received: by 10.68.143.129 with SMTP id se1mr1287896pbb.4.1435319257150;
        Fri, 26 Jun 2015 04:47:37 -0700 (PDT)
Received: by 10.50.65.195 with SMTP id z3msigs;
        Fri, 26 Jun 2015 04:06:21 -0700 (PDT)
X-Received: by 10.68.220.72 with SMTP id pu8mr1097152pbc.14.1435316780996;
        Fri, 26 Jun 2015 04:06:20 -0700 (PDT)
Received: from mail-vn0-x23f.google.com (mail-vn0-x23f.google.com. [2607:f8b0:400c:c0f::23f])
        by gmr-mx.google.com with ESMTPS id z9si452206vdj.0.2015.06.26.04.06.20
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2015 04:06:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of thijsbrobbel@gmail.com designates 2607:f8b0:400c:c0f::23f as permitted sender) client-ip=2607:f8b0:400c:c0f::23f;
Received: by vnav203 with SMTP id v203so24023217vna.0
        for <msysgit@googlegroups.com>; Fri, 26 Jun 2015 04:06:20 -0700 (PDT)
X-Received: by 10.140.86.105 with SMTP id o96mr8487qgd.11.1435316780908;
        Fri, 26 Jun 2015 04:06:20 -0700 (PDT)
In-Reply-To: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
X-Original-Sender: thijsbrobbel@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of thijsbrobbel@gmail.com designates 2607:f8b0:400c:c0f::23f
 as permitted sender) smtp.mail=thijsbrobbel@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272773>

------=_Part_1718_1819692996.1435316780822
Content-Type: multipart/alternative; 
	boundary="----=_Part_1719_1265566845.1435316780822"

------=_Part_1719_1265566845.1435316780822
Content-Type: text/plain; charset=UTF-8

Hi Johannes,

Do you have an ETA on the final release? 

Regards,
Ties

ps I just found out about these release candidates, and I was already 
wondering for a while why we didn't had git 2.x on Windows. I'm going to 
install the RC, and test during day to day usage ;)

On Thursday, May 28, 2015 at 12:11:34 AM UTC+2, Johannes Schindelin wrote:
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

------=_Part_1719_1265566845.1435316780822
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Johannes,<div><br></div><div>Do you have an ETA on the =
final release?&nbsp;</div><div><br></div><div>Regards,</div><div>Ties</div>=
<div><br></div><div>ps I just found out about these release candidates, and=
 I was already wondering for a while why we didn't had git 2.x on Windows. =
I'm going to install the RC, and test during day to day usage ;)</div><div>=
<br>On Thursday, May 28, 2015 at 12:11:34 AM UTC+2, Johannes Schindelin wro=
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
<br>
<br>Ciao,
<br>Johannes
<br></blockquote></div></div>

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

------=_Part_1719_1265566845.1435316780822--
------=_Part_1718_1819692996.1435316780822--
