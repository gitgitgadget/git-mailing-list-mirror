From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Fri, 12 Oct 2007 22:53:05 -0400
Message-ID: <20071013025305.GI27899@spearce.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 13 04:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgX7x-0003nr-Pb
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 04:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbXJMCxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 22:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbXJMCxM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 22:53:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47210 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbXJMCxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 22:53:11 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgX7X-0006nw-Ht; Fri, 12 Oct 2007 22:52:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5122320FBAE; Fri, 12 Oct 2007 22:53:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710130130380.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60714>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 13 Oct 2007, Jakub Narebski wrote:
> >  * I'm wondering what the overall goal is - git's origin as a neutral
> >    ground was fine but it hasn't seemed to take off as a viable
> >    alternative for general use.  Do you care about that?  Is it ok
> >    that git is it's own little niche?
> > 
> >    (Junio, Linus?)
> 
> I am neither, but FWIW I did not have the impression that it is in its own 
> little niche.

I'm neither too.  But I don't think Git is in a niche.  OK, well,
in the overall world of software development its certainly in the
niche of version control, as uh, it doesn't do Enterprise Resource
Planning and Large Scale Embezzlement of Monies (ERPaLSEM).

Actually I've seen a number of people on the interweb saying things
like they were switching their project to Git because they felt
it had more staying power than say Monotone or Mercurial, partly
because the kernel devs were actively using it, partly because the
file formats are so simple and sane, and partly because lots of
other projects are using it or are seriously considering it.

> At the GSoC mentor summit, I encountered a rather different stance: people 
> did not _know_ what distributed SCM means, and were rather afraid of the 
> concept.  Some of them seemed to fight changing their known procedures 
> tooth and nail.  Which is fine by me (I don't have to force anybody to 
> use git, thankyouverymuch).

Yes, this attitude *shocked the hell out of me*.  I really did not
expect it.  I nearly keeled over and died when I realized what the
folks in the back corner of the room were saying.

WINE uses Git.  Some folks were outright pissed off that there
was only one committer in WINE.  I think they felt the project
was maybe going to die because there was only one committer who
could apply patches.  That may wind up being true (there's only so
far that one human can scale without trusted helpers for different
submodules of a large system) but its not Git's fault, or any other
DVCS's fault for that matter.  At least its easy to fork WINE.

On the other hand active participants of two major organizations (KDE
and Eclipse) are starting to seriously look at Git.  The interest
in Git is growing in both of those groups, which can only be good
for us.  We'll learn more about how these groups do development,
and how we can best help them to accomplish more.
 
-- 
Shawn.
