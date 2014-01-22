From: grizzly.nyo@gmail.com
Subject: Re: Git for Windows 1.8.5.2 (preview)
Date: Wed, 22 Jan 2014 06:58:26 -0800 (PST)
Message-ID: <39bdacb2-8bda-4a70-ae12-f3ca6daec3ea@googlegroups.com>
References: <alpine.DEB.1.00.1312310043240.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_182_31100521.1390402706868"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBD2MXUUHXEEBB75276LAKGQE2T3UVFA@googlegroups.com Wed Jan 22 16:02:26 2014
Return-path: <msysgit+bncBD2MXUUHXEEBB75276LAKGQE2T3UVFA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f63.google.com ([209.85.160.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2MXUUHXEEBB75276LAKGQE2T3UVFA@googlegroups.com>)
	id 1W5zJx-0004X1-Bj
	for gcvm-msysgit@m.gmane.org; Wed, 22 Jan 2014 16:02:25 +0100
Received: by mail-pb0-f63.google.com with SMTP id md12sf117332pbc.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 22 Jan 2014 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=eka1tpC6obii66dlGTloc5hO16iy43EQkGYRf+XCgSY=;
        b=n3lIVyURY+2a6wFT8figBkAMHdRB9Ny+sbjwXmsIOgK76VuN43qgQJiYaFPBn/k9Rh
         1DRrczSQ+vuYEFX/J1WvfBHXxIvqFSIQ8ylnU7nrD27SvXxQ35Mj7O5kg+I+htWBk3f9
         d4Mz1wCEjzVRC63HvpEPcoL5heAImHm41nt9KqGXD375FivN4LiDcesiSXVE/DwuZpLO
         yENIagp6JYf45SaHyZ1azPkKgnAw03j44FWzOXhaWZDyqYZurq8pVz4yfHzymAW7z8gR
         e5NdG4s7ODd8EduSM+9KZtvc0jyOWKjUb8J5qTk9KH4/cCEgPtjhdWJvKgV6Te2ToGuh
         XNmQ==
X-Received: by 10.182.96.135 with SMTP id ds7mr13760obb.1.1390402943998;
        Wed, 22 Jan 2014 07:02:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.55.73 with SMTP id q9ls38079obp.98.gmail; Wed, 22 Jan 2014
 07:02:23 -0800 (PST)
X-Received: by 10.182.216.200 with SMTP id os8mr753003obc.0.1390402943353;
        Wed, 22 Jan 2014 07:02:23 -0800 (PST)
Received: by 10.224.127.199 with SMTP id h7msqas;
        Wed, 22 Jan 2014 06:58:27 -0800 (PST)
X-Received: by 10.140.96.37 with SMTP id j34mr10659qge.34.1390402707384;
        Wed, 22 Jan 2014 06:58:27 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1312310043240.1191@s15462909.onlinehome-server.info>
X-Original-Sender: grizzlynyo@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240827>

------=_Part_182_31100521.1390402706868
Content-Type: text/plain; charset=UTF-8

Hi All,

It would seem that the released binaries do not match the tag in github.

For example core.fscache is not listed in the documentation shipped with 
msysGit-fullinstall-1.8.5.2-preview20131230.exe.
Another is git-1.8.5.2.msysgit.0\Documentation\technical\api-hashmap.txt 
missing as well.

Was this intentional?

Thank you for all your hard work!

On Tuesday, December 31, 2013 1:57:20 AM UTC+2, Johannes Schindelin wrote:
>
> Dear fans of Git, 
>
> this mail brings to you the good news that Git for Windows is available in 
> a new version: 1.8.5.2-preview20131230 
>
> Many, many thanks go to the tireless developers working on this 
> particularly hard port of Git. 
>
> Changes since Git-1.8.4-preview20130916 
>
> New Features 
>
> - Comes with Git 1.8.5.2 plus Windows-specific patches. 
>
> - Windows-specific patches are now grouped into pseudo-branches which 
>   should make future development more robust despite the fact that we have 
>   had less than stellar success getting the Windows-specific patches 
> accepted 
>   by upstream git.git. 
>
> - Works around more path length limitations (pull request #86) 
>
> - Has an optional stat() cache toggled via core.fscache (pull request 
> #107) 
>
> Bugfixes 
>
> - Lots of installer fixes 
>
> - git-cmd: Handle home directory on a different drive correctly (pull 
>   request #146) 
>
> - git-cmd: add a helper to work with the ssh agent (pull request #135) 
>
> - Git-Cheetah: prevent duplicate menu entries (pull request #7) 
>
> - No longer replaces dos2unix with hd2u (a more powerful, but slightly 
>   incompatible version of dos2unix) 
>
> In keeping with the fine tradition of making a release on the eve of a 
> holiday, and immediately going on vacation, it is my pleasure to wish you 
> all a happy new year, 
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_182_31100521.1390402706868
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br><br>It would seem that the released binaries do=
 not match the tag in github.<br><br>For example core.fscache is not listed=
 in the documentation shipped with msysGit-fullinstall-1.8.5.2-preview20131=
230.exe.<br>Another is git-1.8.5.2.msysgit.0\Documentation\technical\api-ha=
shmap.txt missing as well.<br><br>Was this intentional?<br><br>Thank you fo=
r all your hard work!<br><br>On Tuesday, December 31, 2013 1:57:20 AM UTC+2=
, Johannes Schindelin wrote:<blockquote class=3D"gmail_quote" style=3D"marg=
in: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">De=
ar fans of Git,
<br>
<br>this mail brings to you the good news that Git for Windows is available=
 in
<br>a new version: 1.8.5.2-preview20131230
<br>
<br>Many, many thanks go to the tireless developers working on this
<br>particularly hard port of Git.
<br>
<br>Changes since Git-1.8.4-preview20130916
<br>
<br>New Features
<br>
<br>- Comes with Git 1.8.5.2 plus Windows-specific patches.
<br>
<br>- Windows-specific patches are now grouped into pseudo-branches which
<br>&nbsp; should make future development more robust despite the fact that=
 we have
<br>&nbsp; had less than stellar success getting the Windows-specific patch=
es accepted
<br>&nbsp; by upstream git.git.
<br>
<br>- Works around more path length limitations (pull request #86)
<br>
<br>- Has an optional stat() cache toggled via core.fscache (pull request #=
107)
<br>
<br>Bugfixes
<br>
<br>- Lots of installer fixes
<br>
<br>- git-cmd: Handle home directory on a different drive correctly (pull
<br>&nbsp; request #146)
<br>
<br>- git-cmd: add a helper to work with the ssh agent (pull request #135)
<br>
<br>- Git-Cheetah: prevent duplicate menu entries (pull request #7)
<br>
<br>- No longer replaces dos2unix with hd2u (a more powerful, but slightly
<br>&nbsp; incompatible version of dos2unix)
<br>
<br>In keeping with the fine tradition of making a release on the eve of a
<br>holiday, and immediately going on vacation, it is my pleasure to wish y=
ou
<br>all a happy new year,
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
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_182_31100521.1390402706868--
