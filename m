From: Jim Raden <james.raden@gmail.com>
Subject: Re: Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 15:25:02 -0400
Message-ID: <5fc54b450907301225q5bdd696bs316bad5ceeec0271@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>  <40aa078e0907291705r65feae3au1dfc5b6400f4e434@mail.gmail.com>  <40aa078e0907291710j23695160q34541e4dc5943f3d@mail.gmail.com>  <alpine.DEB.1.00.0907300226510.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0015175ccf16cbea68046ff143dc
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 30 21:34:46 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f166.google.com ([209.85.212.166])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWbOo-000611-2k
	for gcvm-msysgit@m.gmane.org; Thu, 30 Jul 2009 21:34:46 +0200
Received: by vws38 with SMTP id 38so14843vws.16
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 Jul 2009 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=JpX5MZJNrhWIBO4F0jMaZ+ui8PL8ZHENxpY34Wvn3SA=;
        b=fAHZj8LpnZSgv+QKsD44fNfWwh8xQ695tYeqdfLt1XowW8dBuGMbM3wWrCDiLNbBZk
         8FORi/RQhs/qnFvaWXBnbjQFPW9BwzKs3qvJk/7tNIrK7Z1u3jkhtr7HQDA790FXyrU2
         uLGwBh7GFY21zXLX9rmKeLXvI38zZuyNaXjMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=1GtSIqjmOgo3ZBFZa1mc7P6wh3WDBuuryFG+CE4uxK66+IIwRdDriacpc0t3fPb3tF
         I1ltGfXFd/FOqXpJgbl3mYv82/u7OA6gLzUO8n2d7IsL55MSjZfgpgrx1yrIHFJF3I0b
         oRb4MPbsQgbKz87ag+sY/9FvYDqJrQgC566Cc=
Received: by 10.220.87.74 with SMTP id v10mr344898vcl.21.1248981933033;
        Thu, 30 Jul 2009 12:25:33 -0700 (PDT)
Received: by 10.230.7.196 with SMTP id e4gr6028vbe.0;
	Thu, 30 Jul 2009 12:25:23 -0700 (PDT)
X-Sender: james.raden@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.229.88.67 with SMTP id z3mr281867qcl.5.1248981923156; Thu, 30 Jul 2009 12:25:23 -0700 (PDT)
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147]) by gmr-mx.google.com with ESMTP id 19si299497qyk.15.2009.07.30.12.25.22; Thu, 30 Jul 2009 12:25:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of james.raden@gmail.com designates 74.125.92.147 as permitted sender) client-ip=74.125.92.147;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of james.raden@gmail.com designates 74.125.92.147 as permitted sender) smtp.mail=james.raden@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by qw-out-1920.google.com with SMTP id 5so962163qwf.52 for <msysgit@googlegroups.com>; Thu, 30 Jul 2009 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :from:date:message-id:subject:to:cc:content-type; bh=8Bi8GGTSx+3uNvXrXecqvOOYWpu8cpNvawOX1zLnyWs=; b=bjb0LDOgQ23HRv+yBSbYXaU5FugPxqhTx+3UlIyfmKmOTVKqed4ifOvw9Ltca873yT c3kBIYjrCW41ST9PjiR6b5UJcvCmuSZse0RXVfrIb2BTbsXdkLgqV3lsdk55C7/+J5bR Tl9VdveE9gpovHu893/CR5GZa7zBC950U3SE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:from:date:message-id:subject:to :cc:content-type; b=Hl54qJdImcSFsgKNgxbGO4NrnLrKdzfcm55jHPRDmXknLEytKLhuoieXiUgktc73lS 10u57qwhluWi1WuGBLTo0EfpywZIT5rf0lEdm2dblgsb+RCmtlNTiw4ktt+9dndoio7d zXiVlaGsNKLxSn5BdXo+xyMXCGlfbP8Zzoxes=
Received: by 10.224.46.2 with SMTP id h2mr1157893qaf.198.1248981922078; Thu,  30 Jul 2009 12:25:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907300226510.8306@pacific.mpi-cbg.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124479>


--0015175ccf16cbea68046ff143dc
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

My compliments on the latest installer.
I believe you forgot to mention one very nice improvement: the installer
seems smart enough to read my previous installation settings, for instance
the location of my plink.exe. Nice touch!
Also I am pleased that the PS1 environment variable has been restored to
what I felt was a useful setting. There's now a newline before the "$",
which improves the shell usage in many ways.

Just my $.02 worth. (I wish my thoughts were worth =80.02, but I live in th=
e
dollar zone.)

On Wed, Jul 29, 2009 at 8:34 PM, Johannes Schindelin <
Johannes.Schindelin@gmx.de> wrote:

>
> Hi,
>
> On Thu, 30 Jul 2009, Erik Faye-Lund wrote:
>
> > On Thu, Jul 30, 2009 at 2:05 AM, Erik
> > Faye-Lund<kusmabite@googlemail.com> wrote:
> > > I'm having issues installing msysGit-netinstall-1.6.4-preview20090729=
,
> > > due to lack of libcrypto.dll during installation.
>
> Just to be sure, I tried the same, but it worked here!  Of course, that
> was due to me making a new net installer...
>
> Oh well, please find a new net installer (that I briefly tested,
> actually).
>
> Hopefully by now everybody understands that Git for Windows is Beta for a
> reason.
>
> Ciao,
> Dscho
>
>

--0015175ccf16cbea68046ff143dc
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

My compliments on the latest installer.<div><br></div><div>I believe you fo=
rgot to mention one very nice improvement: the installer seems smart enough=
 to read my previous installation settings, for instance the location of my=
 plink.exe. Nice touch!<div>

<br></div><div>Also I am pleased that the PS1 environment variable has been=
 restored to what I felt was a useful setting. There&#39;s now a newline be=
fore the &quot;$&quot;, which improves the shell usage in many ways.</div>

<div><br></div><div>Just my $.02 worth. (I wish my thoughts were worth=A0=
=80.02, but I live in the dollar zone.)</div></div><br><div class=3D"gmail_=
quote">On Wed, Jul 29, 2009 at 8:34 PM, Johannes Schindelin <span dir=3D"lt=
r">&lt;<a href=3D"mailto:Johannes.Schindelin@gmx.de">Johannes.Schindelin@gm=
x.de</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im"><br>
Hi,<br>
<br>
On Thu, 30 Jul 2009, Erik Faye-Lund wrote:<br>
<br>
</div><div class=3D"im">&gt; On Thu, Jul 30, 2009 at 2:05 AM, Erik<br>
&gt; Faye-Lund&lt;<a href=3D"mailto:kusmabite@googlemail.com">kusmabite@goo=
glemail.com</a>&gt; wrote:<br>
&gt; &gt; I&#39;m having issues installing msysGit-netinstall-1.6.4-preview=
20090729,<br>
&gt; &gt; due to lack of libcrypto.dll during installation.<br>
<br>
</div>Just to be sure, I tried the same, but it worked here! =A0Of course, =
that<br>
was due to me making a new net installer...<br>
<br>
Oh well, please find a new net installer (that I briefly tested,<br>
actually).<br>
<br>
Hopefully by now everybody understands that Git for Windows is Beta for a<b=
r>
reason.<br>
<br>
Ciao,<br>
Dscho<br>
<br>
</blockquote></div><br>

--0015175ccf16cbea68046ff143dc--
