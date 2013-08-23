From: MNGoldenEagle <mngoldeneagle@gmail.com>
Subject: Re: Re: git clone doesn't work in symlink dir roots on Windows
Date: Fri, 23 Aug 2013 14:12:10 -0500
Message-ID: <CALEirj-7GKvU2y0_9A+447YA_18JLZROfvMtBiDX3k=3DATmZA@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
 <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
 <20130810163459.GE25779@paksenarrion.iveqy.com> <1928115.O1fVFY9Fid@majorie>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=089e01183a182dd12904e4a230a1
Cc: msysgit@googlegroups.com, Fredrik Gustafsson <iveqy@iveqy.com>, 
	Sedat Kapanoglu <sedat@eksiteknoloji.com>, git@vger.kernel.org
To: Michael Geddes <michael@frog.wheelycreek.net>
X-From: msysgit+bncBDHI5E5R2QPBBH7I32IAKGQE6M5TLDA@googlegroups.com Fri Aug 23 21:12:35 2013
Return-path: <msysgit+bncBDHI5E5R2QPBBH7I32IAKGQE6M5TLDA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f64.google.com ([209.85.219.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDHI5E5R2QPBBH7I32IAKGQE6M5TLDA@googlegroups.com>)
	id 1VCwmf-0004jg-4F
	for gcvm-msysgit@m.gmane.org; Fri, 23 Aug 2013 21:12:33 +0200
Received: by mail-oa0-f64.google.com with SMTP id l20sf242911oag.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 23 Aug 2013 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tglopRdqfYFpvvSkj/ccuO0Wzbs6ZgiXNBwpfdWjhG8=;
        b=IoQWR5VJyqrmDvBPs5hQYnybb23kDdf0twrEo2YISnsvPaQ4UTjyBxaJDCfYh8jTrp
         0eu58DlR6jb+q4Wz2hBGcDAo2aP3keMbzDNlq6mWJMHQ6cZVqgV6HamlSHlrnyOxD/Nk
         iwMmj7oVmN8SZaT8dILdaYcjg7jU+4nj2qvjN8ed4Vq/kpIw+xvhenFtazG6WpU6DbCR
         KuyWdAc3Xl2+N7Jx7OkF0xNgDj96nPfQs47rXIjQNZqfm2rsKc7ZKFCBP7IFCPy7Sjuv
         bR1BasDY/jZoW6+nJnFReaWOiKy2u/Mq4dwtwK25esF3D69A8l/hXlVnDA4gypkzIiDC
         2ZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tglopRdqfYFpvvSkj/ccuO0Wzbs6ZgiXNBwpfdWjhG8=;
        b=es2Aslwc9XFtH3xlyxsH1YK3agZLYTqq/g2IfMBS1mlcy3BkKIooHOeMqbdZzuAAc/
         MkulMqkeHfhDlojwJMcR/XhgLi3BVJFocgSPPg03DC1NM9PwNmC2fFpukFWVAEQySHXR
         gFJusXll8D8pOeIlzzQUFQEz73lW3VU1QBi9FRln9TQSxwOE3yUOuYOC0li6+qjnDz3b
         2Fpupixp9oFy2GnPTl+qO3Ijm5ojN5YH88vDenquCXGRod6Sm0ih3MZPu4heEk7CRq+7
         NrFbtFS7rvcjb5vZpbR05pCNC58tKJKz0GSI3Lyg8/2AhDhG/5+f1hx6Lppd8pWvI2DR
         7uiA==
X-Received: by 10.50.13.105 with SMTP id g9mr209976igc.9.1377285152099;
        Fri, 23 Aug 2013 12:12:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.23.17 with SMTP id i17ls1051357igf.8.canary; Fri, 23 Aug
 2013 12:12:31 -0700 (PDT)
X-Received: by 10.43.140.69 with SMTP id iz5mr729280icc.14.1377285151323;
        Fri, 23 Aug 2013 12:12:31 -0700 (PDT)
Received: from mail-oa0-x236.google.com (mail-oa0-x236.google.com [2607:f8b0:4003:c02::236])
        by gmr-mx.google.com with ESMTPS id c7si144657igm.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 12:12:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of mngoldeneagle@gmail.com designates 2607:f8b0:4003:c02::236 as permitted sender) client-ip=2607:f8b0:4003:c02::236;
Received: by mail-oa0-f54.google.com with SMTP id o6so1210221oag.41
        for <msysgit@googlegroups.com>; Fri, 23 Aug 2013 12:12:31 -0700 (PDT)
X-Received: by 10.60.161.136 with SMTP id xs8mr963475oeb.77.1377285150963;
 Fri, 23 Aug 2013 12:12:30 -0700 (PDT)
Received: by 10.76.34.66 with HTTP; Fri, 23 Aug 2013 12:12:10 -0700 (PDT)
In-Reply-To: <1928115.O1fVFY9Fid@majorie>
X-Original-Sender: mngoldeneagle@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mngoldeneagle@gmail.com designates 2607:f8b0:4003:c02::236
 as permitted sender) smtp.mail=mngoldeneagle@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) d=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232826>

--089e01183a182dd12904e4a230a1
Content-Type: text/plain; charset=ISO-8859-1

Aside from having to specify whether or not the symbolic link points to a
file or directory, what are the limitations of symlinks?  I'm a bit
curious, having used them myself but never encountering any significant
issues with them.  I remember hearing at one point that Windows Vista could
only create up to 31 links inside a directory, but I just checked on my
Windows 7 machine and was able to generate over 600 links to a directory
without a problem, so I'm guessing Windows 7 worked around this issue.

Jesse


On Tue, Aug 20, 2013 at 2:30 AM, Michael Geddes <
michael@frog.wheelycreek.net> wrote:

> This type of functionality is directly supported by the work I've already
> done
> on symlinks here:   https://github.com/frogonwheels/git
> (branches mrg/symlink-v*  )
>
> Even if we agree that symlinks only work to a limited degree, or that there
> are definite limitations, and that the default should be that symlinks NOT
> be
> supported within repositories, I'm not sure why people are against
> incorporating what I've already implemented.. ok well I guess I do - it's
> about time.
>
> Firstly, at the least it means that symlinks like this example where they
> are
> outside the repository are supported.  Secondly it means that people who
> are
> prepared to accept the limitations will be able to use (or at least clone)
> repositories containing symlinks.
>
> One of the big, painful limitations is that windoze symlinks need to be
> marked
> as directories at the time of creation.  The code I have implemented does
> it's
> level best to create the correct type of NTFS symlink based on repository
> information and falling back on filesystem information.
>
> The argument about permissions is only partially valid, since that can be
> granted as an individual permission to the user without permanent
> administrator rights.
>
> //.ichael G.
>
> On Sat, 10 Aug 2013 06:34:59 PM Fredrik Gustafsson wrote:
> > On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:
> > > > git is a disk intense program, so this setup is not sane at all. With
> > > > that said I know that git on windows historically had problems with
> > > > working on smb-mounted shares (sometimes you're forced to have stupid
> > > > setups). I doubt that git really is the right tool for your work,
> since
> > >
> > > I reproduced the same problem in a regular symlink directory. Repro
> steps:
> > >
> > > mkdir actualdir
> > > mklink /d symdir actualdir
> > > cd symdir
> > > git init .
> > >
> > > fatal: Invalid symlink 'D:/gitto': Function not implemented
> > >
> > > Thanks,
> > >
> > > Sedat
> >
> > Good, then we can determinate that this is a symlink error, it seams
> > that readlink() isn't implemented in the msysgit version of msysgit.
> >
> > However msysgit should have a implementation of readlink() according to:
> > http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html
> >
> > I've CC:ed the msysgit-maillist so that they can decide if this is
> > something they want to address in newer releases.
> >
> > (In the git source code the readlink call in this abspath.c)
>
> --
> --
> *** Please reply-to-all at all times ***
> *** (do not pretend to know who is subscribed and who is not) ***
> *** Please avoid top-posting. ***
> The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki -
> Github accounts are free.
>
> You received this message because you are subscribed to the Google
> Groups "msysGit" group.
> To post to this group, send email to msysgit@googlegroups.com
> To unsubscribe from this group, send email to
> msysgit+unsubscribe@googlegroups.com
> For more options, and view previous threads, visit this group at
> http://groups.google.com/group/msysgit?hl=en_US?hl=en
>
> ---
> You received this message because you are subscribed to the Google Groups
> "msysGit" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to msysgit+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/groups/opt_out.
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

--089e01183a182dd12904e4a230a1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Aside from having to specify whether or not the symbo=
lic link points to a file or directory, what are the limitations of symlink=
s?=A0 I&#39;m a bit curious, having used them myself but never encountering=
 any significant issues with them.=A0 I remember hearing at one point that =
Windows Vista could only create up to 31 links inside a directory, but I ju=
st checked on my Windows 7 machine and was able to generate over 600 links =
to a directory without a problem, so I&#39;m guessing Windows 7 worked arou=
nd this issue.<br>

<br></div>Jesse<br></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">On Tue, Aug 20, 2013 at 2:30 AM, Michael Geddes <span dir=3D"lt=
r">&lt;<a href=3D"mailto:michael@frog.wheelycreek.net" target=3D"_blank">mi=
chael@frog.wheelycreek.net</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This type of functionality is directly suppo=
rted by the work I&#39;ve already done<br>
on symlinks here: =A0 <a href=3D"https://github.com/frogonwheels/git" targe=
t=3D"_blank">https://github.com/frogonwheels/git</a><br>
(branches mrg/symlink-v* =A0)<br>
<br>
Even if we agree that symlinks only work to a limited degree, or that there=
<br>
are definite limitations, and that the default should be that symlinks NOT =
be<br>
supported within repositories, I&#39;m not sure why people are against<br>
incorporating what I&#39;ve already implemented.. ok well I guess I do - it=
&#39;s<br>
about time.<br>
<br>
Firstly, at the least it means that symlinks like this example where they a=
re<br>
outside the repository are supported. =A0Secondly it means that people who =
are<br>
prepared to accept the limitations will be able to use (or at least clone)<=
br>
repositories containing symlinks.<br>
<br>
One of the big, painful limitations is that windoze symlinks need to be mar=
ked<br>
as directories at the time of creation. =A0The code I have implemented does=
 it&#39;s<br>
level best to create the correct type of NTFS symlink based on repository<b=
r>
information and falling back on filesystem information.<br>
<br>
The argument about permissions is only partially valid, since that can be<b=
r>
granted as an individual permission to the user without permanent<br>
administrator rights.<br>
<br>
//.ichael G.<br>
<div class=3D"im HOEnZb"><br>
On Sat, 10 Aug 2013 06:34:59 PM Fredrik Gustafsson wrote:<br>
&gt; On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:<br>
&gt; &gt; &gt; git is a disk intense program, so this setup is not sane at =
all. With<br>
&gt; &gt; &gt; that said I know that git on windows historically had proble=
ms with<br>
&gt; &gt; &gt; working on smb-mounted shares (sometimes you&#39;re forced t=
o have stupid<br>
&gt; &gt; &gt; setups). I doubt that git really is the right tool for your =
work, since<br>
&gt; &gt;<br>
&gt; &gt; I reproduced the same problem in a regular symlink directory. Rep=
ro steps:<br>
&gt; &gt;<br>
&gt; &gt; mkdir actualdir<br>
&gt; &gt; mklink /d symdir actualdir<br>
&gt; &gt; cd symdir<br>
&gt; &gt; git init .<br>
&gt; &gt;<br>
&gt; &gt; fatal: Invalid symlink &#39;D:/gitto&#39;: Function not implement=
ed<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Sedat<br>
&gt;<br>
&gt; Good, then we can determinate that this is a symlink error, it seams<b=
r>
&gt; that readlink() isn&#39;t implemented in the msysgit version of msysgi=
t.<br>
&gt;<br>
&gt; However msysgit should have a implementation of readlink() according t=
o:<br>
&gt; <a href=3D"http://mingw.5.n7.nabble.com/Replacement-for-readlink-td306=
79.html" target=3D"_blank">http://mingw.5.n7.nabble.com/Replacement-for-rea=
dlink-td30679.html</a><br>
&gt;<br>
&gt; I&#39;ve CC:ed the msysgit-maillist so that they can decide if this is=
<br>
&gt; something they want to address in newer releases.<br>
&gt;<br>
&gt; (In the git source code the readlink call in this abspath.c)<br>
<br>
--<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
*** Please reply-to-all at all times ***<br>
*** (do not pretend to know who is subscribed and who is not) ***<br>
*** Please avoid top-posting. ***<br>
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i" target=3D"_blank">https://github.com/msysgit/msysgit/wiki</a> - Github a=
ccounts are free.<br>
<br>
You received this message because you are subscribed to the Google<br>
Groups &quot;msysGit&quot; group.<br>
To post to this group, send email to <a href=3D"mailto:msysgit@googlegroups=
.com">msysgit@googlegroups.com</a><br>
To unsubscribe from this group, send email to<br>
<a href=3D"mailto:msysgit%2Bunsubscribe@googlegroups.com">msysgit+unsubscri=
be@googlegroups.com</a><br>
For more options, and view previous threads, visit this group at<br>
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den" targe=
t=3D"_blank">http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><=
br>
<br>
---<br>
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit%2Bunsubscribe@googlegroups.com">msysgit+u=
nsubscribe@googlegroups.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
" target=3D"_blank">https://groups.google.com/groups/opt_out</a>.<br>
</div></div></blockquote></div><br></div>

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
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

--089e01183a182dd12904e4a230a1--
