From: Stanzilla <staneck@gmail.com>
Subject: Re: Announcing Git for Windows 1.9.5
Date: Thu, 18 Dec 2014 14:01:53 -0800 (PST)
Message-ID: <1e42d971-8785-4fcc-b623-d42245c8f7da@googlegroups.com>
References: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_135_548718165.1418940113262"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBDM2BP4N2YERBH5FZWSAKGQESBURHVQ@googlegroups.com Thu Dec 18 23:18:09 2014
Return-path: <msysgit+bncBDM2BP4N2YERBH5FZWSAKGQESBURHVQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f187.google.com ([209.85.214.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDM2BP4N2YERBH5FZWSAKGQESBURHVQ@googlegroups.com>)
	id 1Y1jOa-000884-HH
	for gcvm-msysgit@m.gmane.org; Thu, 18 Dec 2014 23:18:08 +0100
Received: by mail-ob0-f187.google.com with SMTP id uz6sf1439326obc.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 18 Dec 2014 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=tP6hcBkfoamkPplkJkBdNdRcz5zbYVwpDsEkxWm3Xew=;
        b=DMH40LbmEZiuhouJu6mNaMuoV3FmZUNrjyWvPmYiizANIntLK6XQB8tOQERyY1qfbZ
         VErNi9I2Cztu3DjMwe4V5Sx+wTQCRQ79HHuh4M01r2B/gSK94j0Qb+Q07mC47onz6e47
         Uty/bnH5zB69d9iKqhb1vxbZOhu+5+KNZ4ZkIUs+MTw8HBiptiQykDn+F2ZA2katVnmk
         uPWKTzCkvGNFQidWHPZ6R4Z/I0bZ0XTeCOasooeb1Nk8nyjtcMBnurk2bhLty/5fkUuQ
         GYpMpmrskfgPQecgrq3wffXa3nFsA0pA2Aa1XIHo9byjQF1Vt5LLOrV89qfgdEsIxncS
         G+ZA==
X-Received: by 10.50.61.135 with SMTP id p7mr67igr.9.1418941087773;
        Thu, 18 Dec 2014 14:18:07 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.88.34 with SMTP id bd2ls9904igb.20.gmail; Thu, 18 Dec 2014
 14:18:07 -0800 (PST)
X-Received: by 10.66.150.162 with SMTP id uj2mr3630158pab.35.1418941087237;
        Thu, 18 Dec 2014 14:18:07 -0800 (PST)
Received: by 10.224.163.71 with SMTP id z7msqax;
        Thu, 18 Dec 2014 14:01:54 -0800 (PST)
X-Received: by 10.140.42.229 with SMTP id c92mr14849qga.29.1418940113716;
        Thu, 18 Dec 2014 14:01:53 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
X-Original-Sender: Staneck@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261538>

------=_Part_135_548718165.1418940113262
Content-Type: multipart/alternative; 
	boundary="----=_Part_136_1011418937.1418940113262"

------=_Part_136_1011418937.1418940113262
Content-Type: text/plain; charset=UTF-8

Release notes at https://github.com/msysgit/msysgit/raw/master/share/WinGit/ReleaseNotes.rtf 
are *not* up to date.

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

------=_Part_136_1011418937.1418940113262
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Release notes at&nbsp;<span style=3D"color: rgb(0, 0, 0); =
font-family: 'Times New Roman'; font-size: medium;">https://github.com/msys=
git/msysgit/raw/master/share/WinGit/ReleaseNotes.rtf are *not* up to date.<=
/span><br><br>On Thursday, December 18, 2014 10:47:56 PM UTC+1, Johannes Sc=
hindelin wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-=
left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Dear users of G=
it for Windows,
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

------=_Part_136_1011418937.1418940113262--
------=_Part_135_548718165.1418940113262--
