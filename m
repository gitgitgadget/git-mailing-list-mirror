From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 12:37:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031224530.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <46B2D547.6050406@trolltech.com> <fcaeb9bf0708030417y39f84db2lb0b202af57d8fccb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 13:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGvU1-00055w-OG
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 13:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760663AbXHCLiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 07:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbXHCLiP
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 07:38:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:57331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760635AbXHCLiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 07:38:14 -0400
Received: (qmail invoked by alias); 03 Aug 2007 11:38:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 03 Aug 2007 13:38:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hnTtx03ohvSRiD6qJgOU+36g6gGurzqacPiPzBF
	ecyTbLdKkbWHd1
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0708030417y39f84db2lb0b202af57d8fccb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54706>

Hi,

On Fri, 3 Aug 2007, Nguyen Thai Ngoc Duy wrote:

> On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > > I finally broke down, waiting for the sourceforge project to get
> > > granted. In the meantime, I registered a project at
> > >
> > > http://code.google.com/p/msysgit/
> > >
> > > (WARNING: temporary only!)
> > >
> > > Would you believe that Google code has a restriction to 20MB per
> > > file, and 100MB in total, and you cannot remove files?  The same
> > > Google that gives you 1TB mail space and counting?  Yes, it is
> > > ludicrous.
> > >
> > > Anyway, you can get a complete Development environment in 3 files
> > > (because one would be too large), and... oh well, just read what is
> > > written on the website if you're really interested.
> >
> > Great effort Johannes!
> > The package work perfectly on XP.
> > I'm trying to get it to work under Wine, but it (Wine) is not playing
> > nice with me at the moment. (The whole system barfs of "Access Denied"
> > and other things. Grrr)
> 
> Even if it installs ok under Wine, git may not work properly because a
> bug in dup2() not duplicating to 0-2 and some others that I think only
> affect tests. So get XP if you can or prepare to fix Wine along the
> way.

I do not have XP.  So I very much would appreciate any work done on Wine.  

As it happens, I have a hanging rxvt now (still investigating what causes 
it; ever since wine-0.9.30-466-gb0e9d7e it stopped working for me).

Ciao,
Dscho
