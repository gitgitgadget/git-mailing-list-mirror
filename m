From: frederic.fanchamps@gmail.com
Subject: Re: Announcing Git for Windows 1.9.5
Date: Fri, 19 Dec 2014 09:46:46 -0800 (PST)
Message-ID: <1df5faaf-f670-4be7-a17a-e57cce178113@googlegroups.com>
References: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_771_392948930.1419011206878"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCUKRDVFY4OBBEXJ2GSAKGQEJFKUGLI@googlegroups.com Fri Dec 19 19:55:17 2014
Return-path: <msysgit+bncBCUKRDVFY4OBBEXJ2GSAKGQEJFKUGLI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f187.google.com ([209.85.192.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUKRDVFY4OBBEXJ2GSAKGQEJFKUGLI@googlegroups.com>)
	id 1Y22ho-0001fo-7T
	for gcvm-msysgit@m.gmane.org; Fri, 19 Dec 2014 19:55:16 +0100
Received: by mail-pd0-f187.google.com with SMTP id fp1sf147959pdb.14
        for <gcvm-msysgit@m.gmane.org>; Fri, 19 Dec 2014 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=xzqLlhzygGilhrXizVrE6UBdvQ1kFeGhxUh0c5L3oYs=;
        b=MDVjxO+QX8OKua+YVYfwuc1t6uRuBlJbhKuGjD5LZReqencJqao0g6aLa7idxZMvOp
         SFSSCBwjOlsOWVxZWQBnr1cfH5K1QGZffr5hstj5KeL61LsgGpQTjkeyfhC7Ejdd0x3l
         0Gcu9OPNoRcoZcUH+NnktkrJp7UIBsLFCPbGe9tY6tJrROHDWyjBzBONFxpbqttj+0UG
         TR87LtCa/NfITuukbG+jhR6jitYxlXAetTB9El6jDQr9i9+fJPt3cT8Ll1AYI8WeU0ss
         nV7fZgwvJVj2ymaIlgaVjdpnjmG5elppYd6K1AHSWGNyTAgL9lMfJEMUICLjSGV9ryXq
         Wrvg==
X-Received: by 10.50.178.180 with SMTP id cz20mr76229igc.14.1419015315119;
        Fri, 19 Dec 2014 10:55:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.87.10 with SMTP id t10ls304651igz.2.gmail; Fri, 19 Dec 2014
 10:55:14 -0800 (PST)
X-Received: by 10.50.78.136 with SMTP id b8mr3602275igx.4.1419015314779;
        Fri, 19 Dec 2014 10:55:14 -0800 (PST)
Received: by 10.224.214.72 with SMTP id gz8msqab;
        Fri, 19 Dec 2014 09:46:47 -0800 (PST)
X-Received: by 10.140.81.169 with SMTP id f38mr175607qgd.3.1419011207216;
        Fri, 19 Dec 2014 09:46:47 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
X-Original-Sender: frederic.fanchamps@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261584>

------=_Part_771_392948930.1419011206878
Content-Type: multipart/alternative; 
	boundary="----=_Part_772_1844352496.1419011206878"

------=_Part_772_1844352496.1419011206878
Content-Type: text/plain; charset=UTF-8

<<a new Git for Windows version has been released, and we urge everybody to 
update because it fixes some critical bugs. >>

Great for the bug fixes, thanks.

And... any possibility to switch to 2.1 instead of 1.9 ?

Or do you think there are still some problems with GIT 2.x on windows 
making better to stay in 1.x?

Fred


On Thursday, December 18, 2014 10:47:56 PM UTC+1, Johannes Schindelin wrote:
>
> Dear users of Git for Windows, 
>
> a new Git for Windows version has been released, and we urge everybody to 
> update because it fixes some critical bugs. 
>
> Please download the new version from: 
>
> https://github.com/msysgit/msysgit/releases/Git-1.9.5-preview20141217 
>
> The installer is called Git-1.9.5-preview20141217.exe, with checksums: 
>
>         SHA-1: 21bd5187ef2f7e5124dd7bf1a0a8b7713a7c4953 
>         MD5: b962aee34e84a749e4951237fb04ac39 
>
> Short release notes: 
>
>         Git Release Notes (Git-1.9.5-preview20141217) 
>         Last update: 17 December 2014 
>
>         Changes since Git-1.9.4-preview20140929 
>
>         New Features 
>         - Comes with Git 1.9.5 plus Windows-specific patches. 
>
>         Bugfixes 
>         - Safeguards against bogus file names on NTFS (CVE-2014-9390). 
>
> For detailed release notes, please have a look here: 
>
> https://github.com/msysgit/msysgit/raw/master/share/WinGit/ReleaseNotes.rtf 
>
> On behalf of the Git for Windows developers, 
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

------=_Part_772_1844352496.1419011206878
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&lt;&lt;a new Git for Windows version has been released, a=
nd we urge everybody to
<br>update because it fixes some critical bugs.
&gt;&gt;<br><br>Great for the bug fixes, thanks.<br><br>And... any possibil=
ity to switch to 2.1 instead of 1.9 ?<br><br>Or do you think there are stil=
l some problems with GIT 2.x on windows making better to stay in 1.x?<br><b=
r>Fred<br>
<br><br>On Thursday, December 18, 2014 10:47:56 PM UTC+1, Johannes Schindel=
in wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: =
0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Dear users of Git for=
 Windows,
<br>
<br>a new Git for Windows version has been released, and we urge everybody =
to
<br>update because it fixes some critical bugs.
<br>
<br>Please download the new version from:
<br>
<br><a href=3D"https://github.com/msysgit/msysgit/releases/Git-1.9.5-previe=
w20141217" target=3D"_blank" onmousedown=3D"this.href=3D'https://www.google=
.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fmsysgit%2Freleases%2FGit-=
1.9.5-preview20141217\46sa\75D\46sntz\0751\46usg\75AFQjCNHjrDoPwONcY1V34p8t=
q6hjHKk3eA';return true;" onclick=3D"this.href=3D'https://www.google.com/ur=
l?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fmsysgit%2Freleases%2FGit-1.9.5-p=
review20141217\46sa\75D\46sntz\0751\46usg\75AFQjCNHjrDoPwONcY1V34p8tq6hjHKk=
3eA';return true;">https://github.com/msysgit/<wbr>msysgit/releases/Git-1.9=
.5-<wbr>preview20141217</a>
<br>
<br>The installer is called Git-1.9.5-preview20141217.exe, with checksums:
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SHA-1: 21bd5187ef2f7e51=
24dd7bf1a0a8b7<wbr>713a7c4953
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MD5: b962aee34e84a749e4=
951237fb04ac<wbr>39
<br>
<br>Short release notes:
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Git Release Notes (Git-=
1.9.5-preview20141217)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Last update: 17 Decembe=
r 2014
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Changes since Git-1.9.4=
-preview20140929
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;New Features
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Comes with Git 1.9.5 =
plus Windows-specific patches.
<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bugfixes
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Safeguards against bo=
gus file names on NTFS (CVE-2014-9390).
<br>
<br>For detailed release notes, please have a look here:
<br>
<br><a href=3D"https://github.com/msysgit/msysgit/raw/master/share/WinGit/R=
eleaseNotes.rtf" target=3D"_blank" onmousedown=3D"this.href=3D'https://www.=
google.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fmsysgit%2Fraw%2Fmas=
ter%2Fshare%2FWinGit%2FReleaseNotes.rtf\46sa\75D\46sntz\0751\46usg\75AFQjCN=
GH9RhnXmyjTE2mrlS7q0tqC_VDXw';return true;" onclick=3D"this.href=3D'https:/=
/www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fmsysgit%2Fraw%=
2Fmaster%2Fshare%2FWinGit%2FReleaseNotes.rtf\46sa\75D\46sntz\0751\46usg\75A=
FQjCNGH9RhnXmyjTE2mrlS7q0tqC_VDXw';return true;">https://github.com/msysgit=
/<wbr>msysgit/raw/master/share/<wbr>WinGit/ReleaseNotes.rtf</a>
<br>
<br>On behalf of the Git for Windows developers,
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
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_772_1844352496.1419011206878--
------=_Part_771_392948930.1419011206878--
