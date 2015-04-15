From: Vitaly <vitalyster@gmail.com>
Subject: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Wed, 15 Apr 2015 00:17:42 -0700 (PDT)
Message-ID: <00ecdadf-8bcb-4ade-a2fd-46d866a66be8@googlegroups.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_75_1437648194.1429082263020"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBC34VAHX6MORBF5BXCUQKGQE4DSDTBQ@googlegroups.com Wed Apr 15 09:17:47 2015
Return-path: <msysgit+bncBC34VAHX6MORBF5BXCUQKGQE4DSDTBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f189.google.com ([209.85.220.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC34VAHX6MORBF5BXCUQKGQE4DSDTBQ@googlegroups.com>)
	id 1YiHZx-0000IF-1V
	for gcvm-msysgit@m.gmane.org; Wed, 15 Apr 2015 09:17:45 +0200
Received: by qkbw1 with SMTP id w1sf51205256qkb.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Apr 2015 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=CyKDM9J5oRo5nPIJqKGobqNx4x9a54P+5G04J2k0JrM=;
        b=OhjVygox21JYq5C92t8zFj9wC6qB1k9V+B5XT0EJpoeCCzgcR5t+EYurcCFmD97sv3
         UGwr5IMEiM2hjHDqUfcYf9wG/niXArVIESpCicrJAf7pAIl1fL1LPIXtaOhlUS4sp6YN
         J1aS9d0vHPgLkug13k50htJYt7uVkUhqz0g7eiRL/TiVEbStnoTEkvcaKVsRJjhTbnam
         TOS5x8R3ZhYm4dE1qvF+RPOd+qB/Mxx5YcdPnOKr1Q3K1rl+istYM/cTLUx3zgJHhf32
         jzpnOG7hgwldCFXFs+3Y5uWoQy2qEafEg37knQxsA50fiFWOS0VpfWqNiIwpBk6rnHA8
         YWkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=CyKDM9J5oRo5nPIJqKGobqNx4x9a54P+5G04J2k0JrM=;
        b=y12wczD16+tttdegeNHjaJ6sbfWC3vQ4Qsp0DvgyX79yovz9dtq7HAihIDUwPe6+II
         Szu2722vkdEjkhYEijAL7rlqc/1ZFoDT+UJlYn40k/CoegMS8BqMMz907GmGg0kAygvm
         VNVaDLH7fm0NlhoAPx5g9KGwA6hhvNM5VgQ6DIwb1p5ZyjR2qJWuTVQwhoZhqU4Uzzme
         xkWTEWxL9LUto032hm+Pp7gmYSaL2mLifCYZPp82x1hb6ygtT48TH+MARc9F76W3LZYU
         p9tnL2ZbY+lHd+jFXoLnO/TkRrfMQchATaYk4CtoMmxrmdTCSbg4+Y4tM8r+vfDV/Ziw
         IT5Q==
X-Received: by 10.140.96.79 with SMTP id j73mr311552qge.9.1429082263906;
        Wed, 15 Apr 2015 00:17:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.90.239 with SMTP id x102ls542156qgd.86.gmail; Wed, 15 Apr
 2015 00:17:43 -0700 (PDT)
X-Received: by 10.140.84.213 with SMTP id l79mr298955qgd.41.1429082263424;
        Wed, 15 Apr 2015 00:17:43 -0700 (PDT)
In-Reply-To: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
X-Original-Sender: vitalyster@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267187>

------=_Part_75_1437648194.1429082263020
Content-Type: multipart/alternative; 
	boundary="----=_Part_76_1214684161.1429082263020"

------=_Part_76_1214684161.1429082263020
Content-Type: text/plain; charset=UTF-8


>
>  feel free to give it a spin: https://git-for-windows.github.io/#download 
>

I have installed msysgit 1.9.4, installing git for windows 2.3.5.8 (into 
default localtion and with "use from Windows command prompt") and call "git 
--version" still give me  msysgit1.9.4
I have delete gfw 2.3.5.8 and msysgit 1.9.4, install gfw 2.3.5.8 once again 
(and check "use from Windows command prompt") and now I have:
C:\>git
error launching git:      .

I see C:\Program Files (x86)\Git\bin in my PATH (from old installs?), but 
did not see this directory (bin) under Git installation

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

------=_Part_76_1214684161.1429082263020
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin: 0;margi=
n-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">&nbsp;feel fr=
ee to give it a spin: <a href=3D"https://git-for-windows.github.io/#downloa=
d" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D'https://w=
ww.google.com/url?q\75https%3A%2F%2Fgit-for-windows.github.io%2F%23download=
\46sa\75D\46sntz\0751\46usg\75AFQjCNH7Xr6ehKYvOq0YKmWM2A1d350WTQ';return tr=
ue;" onclick=3D"this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fg=
it-for-windows.github.io%2F%23download\46sa\75D\46sntz\0751\46usg\75AFQjCNH=
7Xr6ehKYvOq0YKmWM2A1d350WTQ';return true;">https://git-for-windows.<wbr>git=
hub.io/#download</a>
<br></blockquote><div><br></div><div>I have installed msysgit 1.9.4, instal=
ling git for windows 2.3.5.8 (into default localtion and with "use from Win=
dows command prompt") and call "git --version" still give me &nbsp;msysgit1=
.9.4<br>I have delete gfw 2.3.5.8 and msysgit 1.9.4, install gfw 2.3.5.8 on=
ce again (and check "use from Windows command prompt") and now I have:<br><=
div>C:\&gt;git</div><div>error launching git: &nbsp; &nbsp; &nbsp;.</div></=
div><div><br></div><div>I see C:\Program Files (x86)\Git\bin in my PATH (fr=
om old installs?), but did not see this directory (bin) under Git installat=
ion</div></div>

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

------=_Part_76_1214684161.1429082263020--
------=_Part_75_1437648194.1429082263020--
