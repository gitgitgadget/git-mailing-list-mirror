From: Michael <michael@frog.wheelycreek.net>
Subject: Re: Re: git clone doesn't work in symlink dir roots on Windows
Date: Tue, 27 Aug 2013 17:54:37 -0700
Message-ID: <3d08cf46e3e08d948adeebacf491ef1b@wheelycreek.net>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
 <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
 <20130810163459.GE25779@paksenarrion.iveqy.com> <1928115.O1fVFY9Fid@majorie>
 <CALEirj-7GKvU2y0_9A+447YA_18JLZROfvMtBiDX3k=3DATmZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_aeb49c846159e7fd156f4043bdf7eda8"
Cc: <msysgit@googlegroups.com>, Fredrik Gustafsson <iveqy@iveqy.com>, Sedat
 Kapanoglu <sedat@eksiteknoloji.com>, <git@vger.kernel.org>
To: MNGoldenEagle <mngoldeneagle@gmail.com>
X-From: msysgit+bncBCLZXZ4RRAEBBWUU6WIAKGQEEEB2CGA@googlegroups.com Wed Aug 28 02:54:53 2013
Return-path: <msysgit+bncBCLZXZ4RRAEBBWUU6WIAKGQEEEB2CGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f191.google.com ([209.85.160.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCLZXZ4RRAEBBWUU6WIAKGQEEEB2CGA@googlegroups.com>)
	id 1VEU28-0004KY-0R
	for gcvm-msysgit@m.gmane.org; Wed, 28 Aug 2013 02:54:52 +0200
Received: by mail-gh0-f191.google.com with SMTP id f13sf1517950ghb.8
        for <gcvm-msysgit@m.gmane.org>; Tue, 27 Aug 2013 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:date:from:to:cc:subject:in-reply-to:references
         :message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=hFJAf572cNncK4omkBk7f9CZbeQZ9s6dnExGEYc5wIc=;
        b=jemZ1l7pmbIq9vVU7R07BrD8aCvJDFyxm7f01ZZzoK/I/6Shyo4zRc01I22qtVCVTY
         Wx2ea4WPpiA5ZVQGuvMr2d/4mrVv8ioMGu6gYk4jO+//tdBe2UQ0/iu9Jv4ziqvgiD5R
         WdJgKhU9yqbvn/iqA1Z+SYxT9RxvJFew+EV2VjBTdZQBBhMwFJOHFRYxcQJGhUJ/Dzfg
         KCtIhpejvLzxs1IaJEvSBAz9uXsvlbj7B0bjkLrm3SLhujtYNu9sgdHiSo54TSys4s5V
         g4fpQ5aSyPRDHp0Qr9/iNAY6Qi0QlXFSTohsvW820yOnvWp8tI7L0JEZ2EPikVy6RzUh
         aipA==
X-Received: by 10.50.62.20 with SMTP id u20mr790238igr.11.1377651291193;
        Tue, 27 Aug 2013 17:54:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.88.3 with SMTP id bc3ls199976igb.9.gmail; Tue, 27 Aug 2013
 17:54:50 -0700 (PDT)
X-Received: by 10.67.3.34 with SMTP id bt2mr70484pad.41.1377651290395;
        Tue, 27 Aug 2013 17:54:50 -0700 (PDT)
Received: from smtpauth.rollernet.us (smtpauth.rollernet.us. [2607:fe70:0:3::d])
        by gmr-mx.google.com with ESMTPS id ax8si1444537pbd.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Aug 2013 17:54:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of michael@frog.wheelycreek.net designates 2607:fe70:0:3::d as permitted sender) client-ip=2607:fe70:0:3::d;
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id 3E0F459403F;
	Tue, 27 Aug 2013 17:54:37 -0700 (PDT)
Received: from webmail.rollernet.us (webmail.rollernet.us [208.79.241.70])
	by smtpauth.rollernet.us (Postfix) with ESMTPA;
	Tue, 27 Aug 2013 17:54:37 -0700 (PDT)
Received: from
 woD+iKKgcTuwJk6uwHtXmVpEaDiadvBGb/uWD3etH/RrK3q3d/a7eP8Pu/2flJyT
 by webmail.rollernet.us
 with HTTP (HTTP/1.1 POST); Tue, 27 Aug 2013 17:54:37 -0700
In-Reply-To: <CALEirj-7GKvU2y0_9A+447YA_18JLZROfvMtBiDX3k=3DATmZA@mail.gmail.com>
X-Sender: michael@frog.wheelycreek.net
User-Agent: RoundCube Webmail/0.7.2
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 7bc2.521d4a4d.2d32c.0
X-Original-Sender: michael@frog.wheelycreek.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of michael@frog.wheelycreek.net designates
 2607:fe70:0:3::d as permitted sender) smtp.mail=michael@frog.wheelycreek.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233170>

--=_aeb49c846159e7fd156f4043bdf7eda8
Content-Type: text/plain; charset=ISO-8859-1

 

I really don't know Jesse, 

The permissions issue keeps coming up,
but to me it seems a non-issue as there is a CLI command to issue the
appropriate permissions to a user. The directory link being separate is
a painful but known issue, and my solution should work in most every-day
ways, as long as the symlinks aren't dangling within the repository tree
itself. 

We could possibly limit the types of NTFS symbolic links that
would actually be embedded in a git database to relative links (or is
that done already?). I'm quite happy to have 'That type of NTFS symbolic
link is not supported' as a valid solution to anything that is outside
of simple symbolic links. 

Currently the biggest thing holding symlinks
back from being complete is lack of support in MSYS itself - which might
be solved by using MSYS2. I have worked around this in the tests by
overriding various commands with shell functions that implement
operations on symlinks via cmd.exe. The only current exception to this
is tar, which I can't do much about. 

I've just rebased my symlink
branch onto pt/tentative-1.8.4 and am chasing down test failures. 

The
tests like to make the symlinks before creating directories, or to
create dangling symlinks, which doesn't help my cause - but am working
through it. 

//. 

On 23.08.2013 12:12, MNGoldenEagle wrote: 

> Aside
from having to specify whether or not the symbolic link points to a file
or directory, what are the limitations of symlinks? I'm a bit curious,
having used them myself but never encountering any significant issues
with them. I remember hearing at one point that Windows Vista could only
create up to 31 links inside a directory, but I just checked on my
Windows 7 machine and was able to generate over 600 links to a directory
without a problem, so I'm guessing Windows 7 worked around this issue.
>

> Jesse 
> 
> On Tue, Aug 20, 2013 at 2:30 AM, Michael Geddes
<michael@frog.wheelycreek.net> wrote:
> 
>> This type of functionality
is directly supported by the work I've already done
>> on symlinks here:
https://github.com/frogonwheels/git [1]
>> (branches mrg/symlink-v* )
>>

>> Even if we agree that symlinks only work to a limited degree, or
that there
>> are definite limitations, and that the default should be
that symlinks NOT be
>> supported within repositories, I'm not sure why
people are against
>> incorporating what I've already implemented.. ok
well I guess I do - it's
>> about time.
>> 
>> Firstly, at the least it
means that symlinks like this example where they are
>> outside the
repository are supported. Secondly it means that people who are
>>
prepared to accept the limitations will be able to use (or at least
clone)
>> repositories containing symlinks.
>> 
>> One of the big,
painful limitations is that windoze symlinks need to be marked
>> as
directories at the time of creation. The code I have implemented does
it's
>> level best to create the correct type of NTFS symlink based on
repository
>> information and falling back on filesystem information.
>>

>> The argument about permissions is only partially valid, since that
can be
>> granted as an individual permission to the user without
permanent
>> administrator rights.
>> 
>> //.ichael G.
>> 
>> On Sat, 10
Aug 2013 06:34:59 PM Fredrik Gustafsson wrote:
>> > On Sat, Aug 10, 2013
at 07:22:03PM +0300, Sedat Kapanoglu wrote:
>> > > > git is a disk
intense program, so this setup is not sane at all. With
>> > > > that
said I know that git on windows historically had problems with
>> > > >
working on smb-mounted shares (sometimes you're forced to have stupid
>>
> > > setups). I doubt that git really is the right tool for your work,
since
>> > >
>> > > I reproduced the same problem in a regular symlink
directory. Repro steps:
>> > >
>> > > mkdir actualdir
>> > > mklink /d
symdir actualdir
>> > > cd symdir
>> > > git init .
>> > >
>> > > fatal:
Invalid symlink 'D:/gitto': Function not implemented
>> > >
>> > >
Thanks,
>> > >
>> > > Sedat
>> >
>> > Good, then we can determinate that
this is a symlink error, it seams
>> > that readlink() isn't implemented
in the msysgit version of msysgit.
>> >
>> > However msysgit should have
a implementation of readlink() according to:
>> >
http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html
[2]
>> >
>> > I've CC:ed the msysgit-maillist so that they can decide if
this is
>> > something they want to address in newer releases.
>> >
>> >
(In the git source code the readlink call in this abspath.c)
>> 
>> --

>> 
>> --
>> *** Please reply-to-all at all times ***
>> *** (do not
pretend to know who is subscribed and who is not) ***
>> *** Please
avoid top-posting. ***
>> The msysGit Wiki is here:
https://github.com/msysgit/msysgit/wiki [3] - Github accounts are
free.
>> 
>> You received this message because you are subscribed to the
Google
>> Groups "msysGit" group.
>> To post to this group, send email
to msysgit@googlegroups.com
>> To unsubscribe from this group, send
email to
>> msysgit+unsubscribe@googlegroups.com
>> For more options,
and view previous threads, visit this group at
>>
http://groups.google.com/group/msysgit?hl=en_US?hl=en [4]
>> 
>> ---
>>
You received this message because you are subscribed to the Google
Groups "msysGit" group.
>> To unsubscribe from this group and stop
receiving emails from it, send an email to
msysgit+unsubscribe@googlegroups.com.
>> For more options, visit
https://groups.google.com/groups/opt_out [5].

 

Links:
------
[1]
https://github.com/frogonwheels/git
[2]
http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html
[3]
https://github.com/msysgit/msysgit/wiki
[4]
http://groups.google.com/group/msysgit?hl=en_US?hl=en
[5]
https://groups.google.com/groups/opt_out

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

--=_aeb49c846159e7fd156f4043bdf7eda8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=ISO-8859-1

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html><body>
<p>I really don't know Jesse,</p>
<p>The permissions issue keeps coming up, but to me it seems a non-issue as=
 there is a CLI command to issue the appropriate permissions to a user. &nb=
sp;The directory link being separate is a painful but known issue, and my s=
olution should work in most every-day ways, as long as the symlinks aren't =
dangling within the repository tree itself.</p>
<p>We could possibly limit the types of NTFS symbolic links that would actu=
ally be embedded in a git database to relative links (or is that done alrea=
dy?). &nbsp;I'm quite happy to have 'That type of NTFS symbolic link is not=
 supported' as a valid solution to anything that is outside of simple symbo=
lic links.</p>
<p>Currently the biggest thing holding symlinks back from being complete is=
 lack of support in MSYS itself - which might be solved by using MSYS2. &nb=
sp; I have worked around this in the tests by overriding various commands w=
ith shell functions that implement operations on symlinks via cmd.exe. &nbs=
p;The only current exception to this is tar, which I can't do much about.</=
p>
<p>I've just rebased my symlink branch onto pt/tentative-1.8.4 and am chasi=
ng down test failures.</p>
<p>The tests like to make the symlinks before creating directories, or to c=
reate dangling symlinks, which doesn't help my cause - but am working throu=
gh it.</p>
<p>//.</p>
<p>On 23.08.2013 12:12, MNGoldenEagle wrote:</p>
<blockquote type=3D"cite" style=3D"padding-left:5px; border-left:#1010ff 2p=
x solid; margin-left:5px; width:100%"><!-- html ignored --><!-- head ignore=
d --><!-- meta ignored -->
<div dir=3D"ltr">
<div>Aside from having to specify whether or not the symbolic link points t=
o a file or directory, what are the limitations of symlinks?&nbsp; I'm a bi=
t curious, having used them myself but never encountering any significant i=
ssues with them.&nbsp; I remember hearing at one point that Windows Vista c=
ould only create up to 31 links inside a directory, but I just checked on m=
y Windows 7 machine and was able to generate over 600 links to a directory =
without a problem, so I'm guessing Windows 7 worked around this issue.<br /=
><br /></div>
Jesse</div>
<div class=3D"gmail_extra"><br /><br />
<div class=3D"gmail_quote">On Tue, Aug 20, 2013 at 2:30 AM, Michael Geddes =
<span>&lt;<a href=3D"mailto:michael@frog.wheelycreek.net">michael@frog.whee=
lycreek.net</a>&gt;</span> wrote:<br />
<blockquote class=3D"gmail_quote" style=3D"margin: 0  0  0  .8ex; border-le=
ft: 1px  #ccc  solid; padding-left: 1ex;">This type of functionality is dir=
ectly supported by the work I've already done<br /> on symlinks here: &nbsp=
; <a href=3D"https://github.com/frogonwheels/git">https://github.com/frogon=
wheels/git</a><br /> (branches mrg/symlink-v* &nbsp;)<br /><br /> Even if w=
e agree that symlinks only work to a limited degree, or that there<br /> ar=
e definite limitations, and that the default should be that symlinks NOT be=
<br /> supported within repositories, I'm not sure why people are against<b=
r /> incorporating what I've already implemented.. ok well I guess I do - i=
t's<br /> about time.<br /><br /> Firstly, at the least it means that symli=
nks like this example where they are<br /> outside the repository are suppo=
rted. &nbsp;Secondly it means that people who are<br /> prepared to accept =
the limitations will be able to use (or at least clone)<br /> repositories =
containing symlinks.<br /><br /> One of the big, painful limitations is tha=
t windoze symlinks need to be marked<br /> as directories at the time of cr=
eation. &nbsp;The code I have implemented does it's<br /> level best to cre=
ate the correct type of NTFS symlink based on repository<br /> information =
and falling back on filesystem information.<br /><br /> The argument about =
permissions is only partially valid, since that can be<br /> granted as an =
individual permission to the user without permanent<br /> administrator rig=
hts.<br /><br /> //.ichael G.<br />
<div class=3D"im HOEnZb"><br /> On Sat, 10 Aug 2013 06:34:59 PM Fredrik Gus=
tafsson wrote:<br /> &gt; On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat K=
apanoglu wrote:<br /> &gt; &gt; &gt; git is a disk intense program, so this=
 setup is not sane at all. With<br /> &gt; &gt; &gt; that said I know that =
git on windows historically had problems with<br /> &gt; &gt; &gt; working =
on smb-mounted shares (sometimes you're forced to have stupid<br /> &gt; &g=
t; &gt; setups). I doubt that git really is the right tool for your work, s=
ince<br /> &gt; &gt;<br /> &gt; &gt; I reproduced the same problem in a reg=
ular symlink directory. Repro steps:<br /> &gt; &gt;<br /> &gt; &gt; mkdir =
actualdir<br /> &gt; &gt; mklink /d symdir actualdir<br /> &gt; &gt; cd sym=
dir<br /> &gt; &gt; git init .<br /> &gt; &gt;<br /> &gt; &gt; fatal: Inval=
id symlink 'D:/gitto': Function not implemented<br /> &gt; &gt;<br /> &gt; =
&gt; Thanks,<br /> &gt; &gt;<br /> &gt; &gt; Sedat<br /> &gt;<br /> &gt; Go=
od, then we can determinate that this is a symlink error, it seams<br /> &g=
t; that readlink() isn't implemented in the msysgit version of msysgit.<br =
/> &gt;<br /> &gt; However msysgit should have a implementation of readlink=
() according to:<br /> &gt; <a href=3D"http://mingw.5.n7.nabble.com/Replace=
ment-for-readlink-td30679.html">http://mingw.5.n7.nabble.com/Replacement-fo=
r-readlink-td30679.html</a><br /> &gt;<br /> &gt; I've CC:ed the msysgit-ma=
illist so that they can decide if this is<br /> &gt; something they want to=
 address in newer releases.<br /> &gt;<br /> &gt; (In the git source code t=
he readlink call in this abspath.c)<br /><br /> --</div>
<div class=3D"HOEnZb">
<div class=3D"h5">--<br /> *** Please reply-to-all at all times ***<br /> *=
** (do not pretend to know who is subscribed and who is not) ***<br /> *** =
Please avoid top-posting. ***<br /> The msysGit Wiki is here: <a href=3D"ht=
tps://github.com/msysgit/msysgit/wiki">https://github.com/msysgit/msysgit/w=
iki</a> - Github accounts are free.<br /><br /> You received this message b=
ecause you are subscribed to the Google<br /> Groups "msysGit" group.<br />=
 To post to this group, send email to <a href=3D"mailto:msysgit@googlegroup=
s.com">msysgit@googlegroups.com</a><br /> To unsubscribe from this group, s=
end email to<br /><a href=3D"mailto:msysgit%2Bunsubscribe@googlegroups.com"=
>msysgit+unsubscribe@googlegroups.com</a><br /> For more options, and view =
previous threads, visit this group at<br /><a href=3D"http://groups.google.=
com/group/msysgit?hl=3Den_US?hl=3Den">http://groups.google.com/group/msysgi=
t?hl=3Den_US?hl=3Den</a><br /><br /> ---<br /> You received this message be=
cause you are subscribed to the Google Groups "msysGit" group.<br /> To uns=
ubscribe from this group and stop receiving emails from it, send an email t=
o <a href=3D"mailto:msysgit%2Bunsubscribe@googlegroups.com">msysgit+unsubsc=
ribe@googlegroups.com</a>.<br /> For more options, visit <a href=3D"https:/=
/groups.google.com/groups/opt_out">https://groups.google.com/groups/opt_out=
</a>.</div>
</div>
</blockquote>
</div>
</div>
</blockquote>
<p>&nbsp;</p>
<div>&nbsp;</div>
</body></html>

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

--=_aeb49c846159e7fd156f4043bdf7eda8--
