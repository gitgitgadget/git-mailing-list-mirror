From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Tue, 24 Mar 2009 03:04:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903240259460.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de> <200903240235.25192.markus.heidelberg@web.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Mar 24 03:03:44 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvzU-0001Ze-7O
	for gcvm-msysgit@m.gmane.org; Tue, 24 Mar 2009 03:03:44 +0100
Received: by qyk35 with SMTP id 35so3684824qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 23 Mar 2009 19:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ry59SafamYj8TJ068wGW1n/r7pP3x/ka9w9+m75MLqQ=;
        b=1RY1wUvDGnAE6rcRt9dNDS6enxzp97ktZ8CL/6qNbzZpl7NYVJSnFOuDxU7La9keck
         +RAFz7LbgyRiZXBIbzpHWnNhqH83BE9BE+JFw3K01Dxfx672PQm6sa95BIEu0mbHXqlH
         p9aF1mN9f7iHNJZZF5a5kgsBV2r+QEq1m7G38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ypreZwqvAwbHjupAvT8NOFG4UqWtn/fa44ywRKWpPTdvCAYx5+VqBTdRqcfgr70kPA
         lvXnr5egM3Ao8qDXxDDTk5UDUicvJnTh35YNve6ZXnh/DNAnPlHayNNT7tY9W9+/oe6G
         ZM/1BdXL5G2JZp0B1iHZNdS0nJ3AB2mNcUW9g=
Received: by 10.224.20.13 with SMTP id d13mr1019457qab.24.1237860129644;
        Mon, 23 Mar 2009 19:02:09 -0700 (PDT)
Received: by 10.176.92.38 with SMTP id p38gr4392yqb.0;
	Mon, 23 Mar 2009 19:02:09 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.77.75 with SMTP id f11mr187582bkk.12.1237860128923; Mon, 23 Mar 2009 19:02:08 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si367764bwz.6.2009.03.23.19.02.08; Mon, 23 Mar 2009 19:02:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 24 Mar 2009 02:02:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp053) with SMTP; 24 Mar 2009 03:02:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U3uwDf0mUsuNtJIvDUt2Od4QwxJCe09tlYTN89f K7SNMfbY4gYUsY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200903240235.25192.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114390>


Hi,

On Tue, 24 Mar 2009, Markus Heidelberg wrote:

> the company I'm working for plans to switch from our current commercial 
> VCS, now I have the job to compare different tools (svn, git). Our 
> clients run on Windows and probably our offices in foreign countries 
> should work on our repository, too.

This...

> Johannes Schindelin, 22.03.2009:
> > Disclaimer: Git for Windows is still in a state where I do _not_ 
> > recommend using it unless you have the means to fix issues.  Unlike 
> > the git.git developer community, the msysGit team is heavily 
> > undermanned.

... and this make me believe that Git for Windows is not at all what you 
want.  You seem to want to purely _use_ Git, and at this time, it is just 
not there.

It would be different if you/your company were willing to pay for support, 
but I just do not see from your mail that you are willing to contribute to 
Git for Windows.

> > - If you want to specify a different location for --upload-pack, you 
> >   have to start the absolute path with two slashes. Otherwise MSys 
> >   will mangle the path.
> 
> Only for msysgit on the server side, right? Then, never mind.

Nope.  There is no msysgit on the server side.  So no, it applies to the 
client side.

> > - git and bash have serious problems with non-ASCII file names (Issue 
> >   80, 108, 149, 159, 188).
> 
> This may be a problem.

Indeed.  I mean, 5 issues, and none of them resolved.

> > - If configured to use plink, you will have to connect with putty 
> >   first, as you cannot accept the host key due to the console window 
> >   being blocked (Issue 96).
> 
> Just use OpenSSH?
> Problem in GUIs or only CLI?

See the issue if you want to know more.

> > - There are a few issues with ssh hanging (Issue 197), permission 
> >   denied on renaming pack files (mentioned in Issue 194), and spurious 
> >   write errors during rebase (Issue 200) that seem not to be 
> >   reproducible on most computers.
> 
> OK, strange and not reproducible errors are a little bit scary.

A little scary?  No.  _Very_ scary.

Especially since the involved parties either do not have the time or the 
willingness to investigate in detail.

As these issues are not reproducible on my side, it also does not make me 
think more highly of that particular Operating System.

> I suppose there are already people using msysgit productive at work, are 
> these only people who know how to fix such problems?

Yes.

> Regardless of git's Windows problems, another problem will probably be 
> finding a decent GUI that suits my colleagues.

Yes.

Ciao,
Dscho
