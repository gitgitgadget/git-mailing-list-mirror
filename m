From: karsten.blees@dcon.de
Subject: Re: ANNOUNCE: Git for Windows 1.7.9
Date: Thu, 9 Feb 2012 14:00:06 +0100
Message-ID: <OF7242D083.08C458C8-ONC125799F.0043D7D2-C125799F.0047B5A4@dcon.de>
References: <4F337F97.8000903@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>
To: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
X-From: msysgit+bncCN2Jst6HAhDths_5BBoEqusXfQ@googlegroups.com Thu Feb 09 14:01:00 2012
Return-path: <msysgit+bncCN2Jst6HAhDths_5BBoEqusXfQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2Jst6HAhDths_5BBoEqusXfQ@googlegroups.com>)
	id 1RvTcS-0004MJ-24
	for gcvm-msysgit@m.gmane.org; Thu, 09 Feb 2012 14:01:00 +0100
Received: by werf1 with SMTP id f1sf4452568wer.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Feb 2012 05:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:in-reply-to:from:to:cc:subject
         :mime-version:x-mailer:message-id:sender:date:x-mimetrack
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=l8wWqIxGOrkiRO3NMWa/hZUpmy+vZ/t9fpH8mKiooxg=;
        b=KtkgG0yITg5Fv6wRkGUTW4aiiH7yqriWvRGa99ie9NjM+8a33LMHH9dEjHM2fPlJcR
         McOHzrwVXLZpKpTgiF+NUQop8VJslguZ2CwIivp6F7qtE3jqwhps4zg47SATf7VldFpQ
         KRta0+FJ2YrjVzQfEO5ttEFa+s7INDYiWgsGw=
Received: by 10.216.135.40 with SMTP id t40mr931749wei.40.1328792429727;
        Thu, 09 Feb 2012 05:00:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.32.204 with SMTP id e12ls1168245ebd.2.gmail; Thu, 09 Feb
 2012 05:00:28 -0800 (PST)
Received: by 10.213.113.196 with SMTP id b4mr1760034ebq.0.1328792428085;
        Thu, 09 Feb 2012 05:00:28 -0800 (PST)
Received: by 10.213.113.196 with SMTP id b4mr1760033ebq.0.1328792428046;
        Thu, 09 Feb 2012 05:00:28 -0800 (PST)
Received: from MAIL.DCON.DE (mail.dcon.de. [77.244.111.98])
        by gmr-mx.google.com with ESMTP id g43si1996988eea.0.2012.02.09.05.00.27;
        Thu, 09 Feb 2012 05:00:27 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@dcon.de designates 77.244.111.98 as permitted sender) client-ip=77.244.111.98;
In-Reply-To: <4F337F97.8000903@atlas-elektronik.com>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
Sender: msysgit@googlegroups.com
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 09.02.2012 14:00:08,
	Serialize complete at 09.02.2012 14:00:08
X-Original-Sender: karsten.blees@dcon.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@dcon.de designates 77.244.111.98 as permitted sender) smtp.mail=karsten.blees@dcon.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190289>

Stefan N=E4we <stefan.naewe@atlas-elektronik.com> wrote on 09.02.2012=20
09:11:03:

> Am 09.02.2012 08:45, schrieb Stefan N=E4we:
> > Am 01.02.2012 12:23, schrieb Pat Thoyts:
> >> This release brings the latest release of Git to Windows users.
> >>
> >> Pre-built installers are available from
> >> http://code.google.com/p/msysgit/downloads/list
> >>
> >> Further details about the Git for Windows project are at
> >> http://code.google.com/p/msysgit/
> >=20
> > I'm getting errors from 'git repack -Ad' with this version on Windows=
=20
XP:
> >=20
> > $ /bin/git repack -Ad
> > Counting objects: 147960, done.
> > Delta compression using up to 2 threads.
> > Compressing objects: 100% (35552/35552), done.
> > Writing objects: 100% (147960/147960), done.
> > Total 147960 (delta 110699), reused 147960 (delta 110699)
> > Deletion of directory '.git/objects/01/' failed. Should I try again?=20
(y/n)
> > Deletion of directory '.git/objects/05/' failed. Should I try again?=20
(y/n) n
> > Deletion of directory '.git/objects/07/' failed. Should I try again?=20
(y/n) n
> > Deletion of directory '.git/objects/0c/' failed. Should I try again?=20
(y/n) n
> > Deletion of directory '.git/objects/10/' failed. Should I try again?=20
(y/n)
> > ....
> >=20
> >=20
> > A bisection pointed me to this commit (https://github.
> com/msysgit/git/commit/19d1e75):
> >=20
> >  "Win32: Unicode file name support (except dirent)"
> >=20
> > When I reset "/git" to this commit and recompile, 'git gc' and=20
> 'git repack -Ad'
>=20
>   s/this commit/parent of this commit (c5d4ecfe)/
>=20

c5d4ecfe just adds unicode conversion functions without using them=20
anywhere, so I doubt that this commit has anything to do with the error.
Besides, that code was merged only this week, so its not even in the=20
pre-built v1.7.9 installer.

Have you checked virus scanners or other background jobs that might keep=20
the directories open?

> > don't raise this error anymore.
> >=20
> > Any ideas ?
> >=20
> >=20
> > Thanks,
> >   Stefan
>=20
>=20
> --=20
> ----------------------------------------------------------------
> /dev/random says: Take two crows and caw me in the morning
> python -c "print=20
> '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.
> decode('hex')"

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
