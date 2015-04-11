From: rupert thurner <rupert.thurner@gmail.com>
Subject: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Sat, 11 Apr 2015 01:37:07 -0700 (PDT)
Message-ID: <39e23864-b75b-4fef-ab90-3413e4e76900@googlegroups.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_0_23591479.1428741427175"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCBO3N6S34BRBM52UOUQKGQE53Q5SWY@googlegroups.com Sat Apr 11 10:37:09 2015
Return-path: <msysgit+bncBCBO3N6S34BRBM52UOUQKGQE53Q5SWY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBO3N6S34BRBM52UOUQKGQE53Q5SWY@googlegroups.com>)
	id 1Ygqua-0007Nc-Pp
	for gcvm-msysgit@m.gmane.org; Sat, 11 Apr 2015 10:37:08 +0200
Received: by qkbx191 with SMTP id x191sf62729909qkb.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 11 Apr 2015 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=9brCM62a26nQlpQ0R2dc21T409WRVyHDfiGmMFQRR4g=;
        b=h2/AH8/EI1D9oKyzXkoHiquB58cH5u2dm8zuxoLtJ3Spd1bvZH7yBEL+tGDCMawDIY
         IvoSJMLURmwXG+CE85CpilrcrO1bxyEXNfz9WGZxh8cbnGXLDkN0P9CV8rPNT5nl8hMd
         KXjzrpFjI8TdTxYkkk4sIUIiAMMhFZByg4EpfMruOsrun20UmiI9HFLwQCSEbvDU0G5Z
         jCoNzUt8/EyqSE/waHE0vH90oAVrgK+C0/uCyaC4xoXhVs4nC62tteVEALUkTu+O0biO
         VVZjWDiDOjeY/NK5ghddau436PS36dzOHkTYpFrckL8l7Gfur4q/ATKg6jY8BAaU3a1m
         MPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=9brCM62a26nQlpQ0R2dc21T409WRVyHDfiGmMFQRR4g=;
        b=zNs9IdX69gpgjx0H0Hobyh9F0MONXRTrf/9ndP8IUt94rtGhEzRSELHkUMk8nLOsh4
         HBlVdThWc9LZ6S7VkFMk4uVsfs38mC9dnqOeXuYFiTXpUFYiRjcjyr5zHGzOgILhuAOC
         bgOdYyS1+yRoyqU7pVrsiJy2I/p5tofxFEMR+NDHG3iXDtsuIqLbEF8zBxofCoy/ULCh
         SP/LzHyFMkvyiCqegBXArG7CJh8Ei1nQv+JEj0ml+YnVlgtY81MGbznncLKUJ//CWH4n
         vJmOy9TjqeuQjIsb9w9KMOK7lymf0DOxAoJ/t8watAIPxGaAjRe81qmwTZs/TPiPfVD3
         OGsA==
X-Received: by 10.140.98.116 with SMTP id n107mr72030qge.11.1428741428061;
        Sat, 11 Apr 2015 01:37:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.95.68 with SMTP id h62ls957128qge.55.gmail; Sat, 11 Apr
 2015 01:37:07 -0700 (PDT)
X-Received: by 10.140.21.111 with SMTP id 102mr72134qgk.4.1428741427634;
        Sat, 11 Apr 2015 01:37:07 -0700 (PDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267020>

------=_Part_0_23591479.1428741427175
Content-Type: multipart/alternative; 
	boundary="----=_Part_1_200354221.1428741427176"

------=_Part_1_200354221.1428741427176
Content-Type: text/plain; charset=UTF-8

excellent, i like it so much!! besides the obvious:
* the colors are fixed, so it is not any more dark red on black for added 
files, but red on black and readable
* installs with the necessary performance options
* the readme contains things i fell over in the past. 

three things i do not like it so much:
* the old distinct icon is replaced by a new one which looks similar to 
many other programs, like google chrome. would it be possible to set the 
old icon? 
* the prompt is still as slow as before, calculating the branch name on 
pressing return without option to turn it off
* it is talking german to me

would it be sufficient to delete
c:\Apps\gitwin\mingw64\share\locale\de\LC_MESSAGES\
resp the whole locale directory to let it speak english?

rupert.


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
> Enjoy, 
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

------=_Part_1_200354221.1428741427176
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">excellent, i like it so much!! besides the obvious:<div>* =
the colors are fixed, so it is not any more dark red on black for added fil=
es, but red on black and readable</div><div>* installs with the necessary p=
erformance options</div><div>* the readme contains things i fell over in th=
e past.&nbsp;</div><div><br></div><div>three things i do not like it so muc=
h:</div><div>* the old distinct icon is replaced by a new one which looks s=
imilar to many other programs, like google chrome. would it be possible to =
set the old icon?&nbsp;</div><div>* the prompt is still as slow as before, =
calculating the branch name on pressing return without option to turn it of=
f</div><div>* it is talking german to me<div><br></div><div>would it be suf=
ficient to delete<br></div><div><div>c:\Apps\gitwin\mingw64\share\locale\de=
\LC_MESSAGES\<br></div><div>resp the whole locale directory to let it speak=
 english?</div><div><br></div><div><div>rupert.</div><div><br><br>On Friday=
, April 10, 2015 at 1:43:30 PM UTC+2, Johannes Schindelin wrote:<blockquote=
 class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1=
px #ccc solid;padding-left: 1ex;">Dear all,
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
<br>
<br>Enjoy,
<br>Johannes
<br></blockquote></div></div></div></div></div>

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

------=_Part_1_200354221.1428741427176--
------=_Part_0_23591479.1428741427175--
