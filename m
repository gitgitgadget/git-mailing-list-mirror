From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 3 Jul 2007 15:21:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031518380.4071@racer.site>
References: <46893F61.5060401@jaeger.mine.nu>
 <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <vpq7ipittl2.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707022205210.4071@racer.site>
 <vpqoditkc23.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707031308170.4071@racer.site>
 <vpqir91hagz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:21:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jFu-00051E-TR
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758290AbXGCOVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 10:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758231AbXGCOVX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:21:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:36814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757556AbXGCOVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 10:21:21 -0400
Received: (qmail invoked by alias); 03 Jul 2007 14:21:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 03 Jul 2007 16:21:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RTwFQv0LRv2cLnVthPhj338STSfkgXlm7cgJ6r/
	3NtYeKBGgNIg8u
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqir91hagz.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51498>

Hi,

On Tue, 3 Jul 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 3 Jul 2007, Matthieu Moy wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > What's so wrong with our man pages? You know, there have been man 
> >> > hours invested in them, and they are exclusively meant for 
> >> > consumption by people who do not know about the usage of the 
> >> > commands...
> >> 
> >> What's wrong is just that I shouldn't have to read a man page to 
> >> avoid data-loss.
> >
> > Okay, Mr Moy.
> 
> Glad to be called by my name. Is it a tradition here, or a way to make 
> fun of me?

I tried to be funny, by introducing some diversity...

> > How did you learn that "rm" leads to data-loss? Because it does.
> 
> It obviously does, and I can't imagine any other behavior than deleting 
> the file for a command like "rm".
> 
> > Hmm. How did you expect then, that git-rm does _not_ lead to data
> > loss? 
> 
> Because there are tons of possible behaviors for "$VCS rm", and I'd 
> expect it to be safe even if VCS=git, since it is with all the other VCS 
> I know.

Which proves exactly my point. There are a ton of interpretations that 
make sense. So I would always look into the man page.

> What's wrong with the behavior of "hg rm"?
> What's wrong with the behavior of "svn rm"?
> What's wrong with the behavior of "bzr rm"?
> (no, I won't do it with CVS ;-) )
> 
> None of these commands have the problem that git-rm has.

Guess what. I do not know how they operate! I have no idea what the 
behaviour of the commands you mentioned is. So before I would answer (if 
they were not rethoric questions), I would actually really read the man 
page to know what they are supposed to do.

Ciao,
Dscho
