From: rupert thurner <rupert.thurner@gmail.com>
Subject: Re: Re: Sneak peek of the upcoming Git for Windows 2.x
Date: Wed, 29 Apr 2015 15:12:03 -0700 (PDT)
Message-ID: <b11d6532-23e6-43ab-b615-20f04a29df6c@googlegroups.com>
References: <72d57a68ab32619769d5671d39505db8@www.dscho.org>
 <bf54ac53-8550-404c-afb2-d0d7257eb4dc@googlegroups.com>
 <de8efc157fa301ffbe3cecd8f5c04fdc@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_906_1106434695.1430345523982"
Cc: git@vger.kernel.org, rupert.thurner@gmail.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCBO3N6S34BRBNFOQWVAKGQEJZOSP3Y@googlegroups.com Thu Apr 30 00:12:07 2015
Return-path: <msysgit+bncBCBO3N6S34BRBNFOQWVAKGQEJZOSP3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBO3N6S34BRBNFOQWVAKGQEJZOSP3Y@googlegroups.com>)
	id 1YnaD7-0002RS-In
	for gcvm-msysgit@m.gmane.org; Thu, 30 Apr 2015 00:12:05 +0200
Received: by obcwm4 with SMTP id wm4sf10477774obc.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 Apr 2015 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=+KirzOaRQ33qVnSfPyzMrZRNbrIbA/sbWPpMlCwjz1w=;
        b=g43nGR2zpOrwSPvICw69sywnd3z+TGrDH56kAgQIn0vumj0SMnxiWjVqD5kzMXl6cL
         1ymPBaATkmJf1wnAkx9v1Fed1hqT11hDY4Ec9uLydllNZyjrilywgC3s2XKRWU/bClR1
         xxU9Jui6/jmz8gzcSJJzEBcsUblRpPaZbpF+RfPqicor/gwfJ/s9A7DDbuHFTWhFq8Yy
         FegT/1m036jDhp0mKchdnYMCZntlBLmM9XIMDtjBs8dIh4eSMkWpam7QjkieiObJXB6K
         vmCP6+0X0VjubVec+Zk85cJZTzlm3Cderz4DBK6O2uPX3/pWvHD9b2t3PLLf0jU67ddZ
         Jozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=+KirzOaRQ33qVnSfPyzMrZRNbrIbA/sbWPpMlCwjz1w=;
        b=bX14bDVdLsJezrCYR2NJAmEnwc5YK7cN9MifZBCutRSqOpg0KWY81YJTep8+44AMe7
         2WD+5VuXrUBTFzUD8P1/XrICJ3nkNLrIcrOqpwa7EwaKMKgNw15fMmZsIFmh34aTvFrS
         T7sd+5RbPVWbivO4rkhij4AylVF0hnVXUOQRDSLSsduYXOATYYj5Us4M9qD09Lb4KnXG
         Raqn+WinAK+QfBYsZKqC36cGfEV1vyYGkNny6oUh0TKS4bsjob8h1prqw53B4prKU1HF
         Zdz96MbtAZSxBS4nPV/koGWnvFM/iJaYAzatmqCa+OUp6HgRiyzrtTK+T1HFR9BFJfFu
         fGJQ==
X-Received: by 10.140.36.232 with SMTP id p95mr25341qgp.17.1430345524762;
        Wed, 29 Apr 2015 15:12:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.20.231 with SMTP id 94ls1032499qgj.92.gmail; Wed, 29 Apr
 2015 15:12:04 -0700 (PDT)
X-Received: by 10.140.107.226 with SMTP id h89mr25930qgf.32.1430345524405;
        Wed, 29 Apr 2015 15:12:04 -0700 (PDT)
In-Reply-To: <de8efc157fa301ffbe3cecd8f5c04fdc@www.dscho.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268029>

------=_Part_906_1106434695.1430345523982
Content-Type: multipart/alternative; 
	boundary="----=_Part_907_787019492.1430345523982"

------=_Part_907_787019492.1430345523982
Content-Type: text/plain; charset=UTF-8

On Wednesday, April 29, 2015 at 5:40:52 PM UTC+2, Johannes Schindelin wrote:
>
> Hi Rupert, 
>
> On 2015-04-29 17:23, rupert thurner wrote: 
> > On Friday, April 10, 2015 at 1:43:30 PM UTC+2, Johannes Schindelin 
> wrote: 
> >> 
> >> during the really exciting Git Merge conference, the Git for Windows 
> >> developers had the opportunity to meet and we managed to whip out a 
> >> *really* early beta of the upcoming Git for Windows 2.x series. 
> >> 
> >> Please keep in mind that we not only changed our entire development 
> >> environment, but that this change also affects end user installations 
> quite 
> >> a bit: as parts of Git are still written in shell and Perl, we have to 
> ship 
> >> a shell and Perl interpreter, too, which are naturally plucked from the 
> >> development environment. 
> >> 
> >> Of course that implies that there are probably still quite a couple of 
> >> rough edges. Nevertheless, if you want to have a *really* early glimpse 
> at 
> >> the upcoming major release, feel free to give it a spin: 
> >> https://git-for-windows.github.io/#download 
> >> 
> >> 
> > after using it now for a couple of weeks every week or so, on windows-7, 
> > git-receive-pack.exe hangs from time to time and cannot be killed any 
> more. 
> > i start it either with 
> >   git fetch --all -p 
> >   git push 
> > 
> > it looks like it does not take any signals at all. no ctrl-c in the 
> mintty, 
> > nor a kill via sysinternals process explorer. up to now only reboot 
> helped, 
> > but pretty sure i miss something here. 
>
> Please, it is really, really crucial that you specify precisely what 
> version of the package you talk about. It is tempting to say something like 
> "windows-7" or "I used Git for Windows", but please keep in mind that this 
> is hardly specific. Windows 7 can be anything between 32-bit and 64-bit, 
> with or without service packs, in administrator mode or user mode. Git for 
> Windows is even worse because we bundle packages into a single installer. 
> However, from the way you describe things I imagine that you used a version 
> of the installer. The installer contains a file that lists the individual 
> package versions, therefore it should be good enough to specify which 
> version `git version` reports. 
>
> Please make a point of including all of this information in your bug 
> reports to make it easier for the people who you ask for help.

uh, yes, you are right, there are 2 other releases since you wrote this 
mail. windows 7 enterprise, service pack 1, 64 bit
Git-2.3.5.8-dev-preview-64-bit.exe
   $ git --version
   git version 2.3.5.windows.8
the user is non-administrative, which is able to intall apps as admin after 
clicking. i'll install Git-2.3.7.1-dev-preview-64-bit.exe and write again 
if the behaviour is still there.

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

------=_Part_907_787019492.1430345523982
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wednesday, April 29, 2015 at 5:40:52 PM UTC+2, Johannes=
 Schindelin wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;marg=
in-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi Rupert,
<br>
<br>On 2015-04-29 17:23, rupert thurner wrote:
<br>&gt; On Friday, April 10, 2015 at 1:43:30 PM UTC+2, Johannes Schindelin=
 wrote:
<br>&gt;&gt;
<br>&gt;&gt; during the really exciting Git Merge conference, the Git for W=
indows
<br>&gt;&gt; developers had the opportunity to meet and we managed to whip =
out a
<br>&gt;&gt; *really* early beta of the upcoming Git for Windows 2.x series=
.
<br>&gt;&gt;
<br>&gt;&gt; Please keep in mind that we not only changed our entire develo=
pment
<br>&gt;&gt; environment, but that this change also affects end user instal=
lations quite
<br>&gt;&gt; a bit: as parts of Git are still written in shell and Perl, we=
 have to ship
<br>&gt;&gt; a shell and Perl interpreter, too, which are naturally plucked=
 from the
<br>&gt;&gt; development environment.
<br>&gt;&gt;
<br>&gt;&gt; Of course that implies that there are probably still quite a c=
ouple of
<br>&gt;&gt; rough edges. Nevertheless, if you want to have a *really* earl=
y glimpse at
<br>&gt;&gt; the upcoming major release, feel free to give it a spin:
<br>&gt;&gt; <a href=3D"https://git-for-windows.github.io/#download" target=
=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D'https://www.google=
.com/url?q\75https%3A%2F%2Fgit-for-windows.github.io%2F%23download\46sa\75D=
\46sntz\0751\46usg\75AFQjCNH7Xr6ehKYvOq0YKmWM2A1d350WTQ';return true;" oncl=
ick=3D"this.href=3D'https://www.google.com/url?q\75https%3A%2F%2Fgit-for-wi=
ndows.github.io%2F%23download\46sa\75D\46sntz\0751\46usg\75AFQjCNH7Xr6ehKYv=
Oq0YKmWM2A1d350WTQ';return true;">https://git-for-windows.<wbr>github.io/#d=
ownload</a>
<br>&gt;&gt;
<br>&gt;&gt;
<br>&gt; after using it now for a couple of weeks every week or so, on wind=
ows-7,=20
<br>&gt; git-receive-pack.exe hangs from time to time and cannot be killed =
any more.=20
<br>&gt; i start it either with
<br>&gt; &nbsp; git fetch --all -p
<br>&gt; &nbsp; git push
<br>&gt;=20
<br>&gt; it looks like it does not take any signals at all. no ctrl-c in th=
e mintty,=20
<br>&gt; nor a kill via sysinternals process explorer. up to now only reboo=
t helped,=20
<br>&gt; but pretty sure i miss something here.
<br>
<br>Please, it is really, really crucial that you specify precisely what ve=
rsion of the package you talk about. It is tempting to say something like "=
windows-7" or "I used Git for Windows", but please keep in mind that this i=
s hardly specific. Windows 7 can be anything between 32-bit and 64-bit, wit=
h or without service packs, in administrator mode or user mode. Git for Win=
dows is even worse because we bundle packages into a single installer. Howe=
ver, from the way you describe things I imagine that you used a version of =
the installer. The installer contains a file that lists the individual pack=
age versions, therefore it should be good enough to specify which version `=
git version` reports.
<br>
<br>Please make a point of including all of this information in your bug re=
ports to make it easier for the people who you ask for help.</blockquote><d=
iv>uh, yes, you are right, there are 2 other releases since you wrote this =
mail. windows 7 enterprise, service pack 1, 64 bit</div><div>Git-2.3.5.8-de=
v-preview-64-bit.exe<br></div><div>&nbsp; &nbsp;$ git --version</div><div>&=
nbsp; &nbsp;git version 2.3.5.windows.8</div><div>the user is non-administr=
ative, which is able to intall apps as admin after clicking. i'll install&n=
bsp;Git-2.3.7.1-dev-preview-64-bit.exe and write again if the behaviour is =
still there.<br></div><div><br></div><div>rupert</div><div><br></div><div><=
br></div><div><br></div></div>

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

------=_Part_907_787019492.1430345523982--
------=_Part_906_1106434695.1430345523982--
