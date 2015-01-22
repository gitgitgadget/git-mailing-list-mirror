From: lucas.gary@gmail.com
Subject: Re: Announcing Git for Windows 1.9.5
Date: Thu, 22 Jan 2015 08:03:18 -0800 (PST)
Message-ID: <a4295cc3-165d-4801-8c35-dde68e6a80f2@googlegroups.com>
References: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_784_1617078015.1421942598817"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBDLPHSEM2EKRBR56QSTAKGQEXBONTGI@googlegroups.com Thu Jan 22 17:03:21 2015
Return-path: <msysgit+bncBDLPHSEM2EKRBR56QSTAKGQEXBONTGI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f59.google.com ([209.85.192.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDLPHSEM2EKRBR56QSTAKGQEXBONTGI@googlegroups.com>)
	id 1YEKE5-0005tz-3l
	for gcvm-msysgit@m.gmane.org; Thu, 22 Jan 2015 17:03:21 +0100
Received: by mail-qg0-f59.google.com with SMTP id a108sf381928qge.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 22 Jan 2015 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=tslte6eR924a76rUUsKzqxhiDkTjGSWA+C23nP8mrV8=;
        b=a/t14ZMokehSo5XBDIePwf4415VffhWkKVv74DGrWK9aN6/88AXzLOuKR6iLSqLs/A
         bfk1dPxV4pQy9u68thSHxrT5o8aoDNmQuuLSb2oBPMEKPFh46XDuje0r3xA70IApCxZt
         0eWj0tpamdx7276gbkTfPtbVn+v8Tj9aOFHzo0BwPfhqsQ18+/G+g/N6aBtDWLW+BZgg
         RI2HQHh02f3zTGrr0qesPdd1dXHrUIRjxkQ2ZAmBaTl7zYmis519IWHkVZo1mE7tTM8G
         RzTvXljwG/0kYouIBpEZHF1rNAViA4OvkDFC2FPUztN9rmKlUg+LjJf1Lfx8NKupMjA2
         aPZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=tslte6eR924a76rUUsKzqxhiDkTjGSWA+C23nP8mrV8=;
        b=axQZbbKgg6WpB4xJa+k60YHL+d16CFuQCZd+fQOEMi2bjyz+fL6YCEeNkpAPzmwP65
         TvYuhUo+EMr8Ui5BHMzYk5vMF3t3UKRSPIAJifbUWdKcWAdx/WjXIRsjBwH7q6gJf/TF
         BLdn5cEaaP1Dd+04uHp+2oMxETpRNJeSO2qpJuYSQBCVsQhF0C+5nOwCaDOpJ0fi7r4A
         Nr/depb7rLtAzBMALOixIxbpGc7H6J2KsiC53YKmeazFIS8Ey7bQ3QAtWLswIaWNfSGH
         8/ptSbni9oqwlVLAdLozTe6KywjFjAdwrPBEvL7fgj5TOOXpnm+5q6qmYymFQdLxTZaB
         qlng==
X-Received: by 10.50.154.34 with SMTP id vl2mr600795igb.9.1421942600506;
        Thu, 22 Jan 2015 08:03:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.134.99 with SMTP id pj3ls1202973igb.5.gmail; Thu, 22 Jan
 2015 08:03:19 -0800 (PST)
X-Received: by 10.50.253.1 with SMTP id zw1mr599624igc.11.1421942599747;
        Thu, 22 Jan 2015 08:03:19 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
X-Original-Sender: lucas.gary@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262843>

------=_Part_784_1617078015.1421942598817
Content-Type: multipart/alternative; 
	boundary="----=_Part_785_1824645320.1421942598817"

------=_Part_785_1824645320.1421942598817
Content-Type: text/plain; charset=UTF-8

I'm not sure if it was a change in this version or a previous version, but 
in gitk tags are now condensed down into 'n tags' instead of a list.

Is there a way to change the view to see all tags?

<https://lh4.googleusercontent.com/-_YM-4DPJRHU/VMEfPE5y21I/AAAAAAAAHMY/eOEsBoVJA_Y/s1600/gitk.JPG>


On Thursday, 18 December 2014 13:47:56 UTC-8, Johannes Schindelin wrote:
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

------=_Part_785_1824645320.1421942598817
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I'm not sure if it was a change in this version or a previ=
ous version, but in gitk tags are now condensed down into 'n tags' instead =
of a list.<div><br></div><div>Is there a way to change the view to see all =
tags?</div><div><br></div><p class=3D"separator" style=3D"text-align: cente=
r; clear: both;"><a imageanchor=3D"1" href=3D"https://lh4.googleusercontent=
.com/-_YM-4DPJRHU/VMEfPE5y21I/AAAAAAAAHMY/eOEsBoVJA_Y/s1600/gitk.JPG" style=
=3D"margin-left: 1em; margin-right: 1em;"><img src=3D"https://lh4.googleuse=
rcontent.com/-_YM-4DPJRHU/VMEfPE5y21I/AAAAAAAAHMY/eOEsBoVJA_Y/s1600/gitk.JP=
G" border=3D"0" style=3D""></a></p><div><br><br>On Thursday, 18 December 20=
14 13:47:56 UTC-8, Johannes Schindelin  wrote:<blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padd=
ing-left: 1ex;">Dear users of Git for Windows,
<br>
<br>a new Git for Windows version has been released, and we urge everybody =
to
<br>update because it fixes some critical bugs.
<br>
<br>Please download the new version from:
<br>
<br><a href=3D"https://github.com/msysgit/msysgit/releases/Git-1.9.5-previe=
w20141217" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D'h=
ttps://www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fmsysgit%=
2Freleases%2FGit-1.9.5-preview20141217\46sa\75D\46sntz\0751\46usg\75AFQjCNH=
jrDoPwONcY1V34p8tq6hjHKk3eA';return true;" onclick=3D"this.href=3D'https://=
www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fmsysgit%2Frelea=
ses%2FGit-1.9.5-preview20141217\46sa\75D\46sntz\0751\46usg\75AFQjCNHjrDoPwO=
NcY1V34p8tq6hjHKk3eA';return true;">https://github.com/msysgit/<wbr>msysgit=
/releases/Git-1.9.5-<wbr>preview20141217</a>
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
eleaseNotes.rtf" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.hre=
f=3D'https://www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit%2Fms=
ysgit%2Fraw%2Fmaster%2Fshare%2FWinGit%2FReleaseNotes.rtf\46sa\75D\46sntz\07=
51\46usg\75AFQjCNGH9RhnXmyjTE2mrlS7q0tqC_VDXw';return true;" onclick=3D"thi=
s.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgithub.com%2Fmsysgit=
%2Fmsysgit%2Fraw%2Fmaster%2Fshare%2FWinGit%2FReleaseNotes.rtf\46sa\75D\46sn=
tz\0751\46usg\75AFQjCNGH9RhnXmyjTE2mrlS7q0tqC_VDXw';return true;">https://g=
ithub.com/msysgit/<wbr>msysgit/raw/master/share/<wbr>WinGit/ReleaseNotes.rt=
f</a>
<br>
<br>On behalf of the Git for Windows developers,
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

------=_Part_785_1824645320.1421942598817--
------=_Part_784_1617078015.1421942598817--
