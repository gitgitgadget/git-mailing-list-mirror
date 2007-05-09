From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 11:33:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091127310.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <7vps5azlm1.fsf@assigned-by-dhcp.cox.net>
 <7v4pmmzivz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 11:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HliYZ-0005nE-Eb
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbXEIJdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbXEIJdy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:33:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:48234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754469AbXEIJdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:33:53 -0400
Received: (qmail invoked by alias); 09 May 2007 09:33:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 09 May 2007 11:33:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vODRLqh4v/Ex64k9TNXopNJVVr9j84pLSWft8Ca
	VenkBx85AElzqy
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pmmzivz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46690>

Hi,

On Tue, 8 May 2007, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > "J. Bruce Fields" <bfields@fieldses.org> writes:
> >
> >> The organization of the next bit is slightly confusing: we're set up 
> >> to expect a longer lecture on the revision walker, but instead 
> >> there's just the historical note on git-rev-list, a mention of 
> >> 'revision.c', 'revision.h', and 'struct rev_info', and then it 
> >> rapidly digresses into discussing builtins.
> >
> > I had the same impression.
> >
> > I was meaning to write a "code walkthru for git hackers and wannabes" 
> > with target audience quite different from the user-manual.  My idea of 
> > which areas to cover in what order seems to match with what Johannes 
> > started.
> 
> Having said that, I do not think the patch belongs to the "git USER'S 
> manual".  It is a very good introductory material for a separate "git 
> hackers manual", though.

That is what I was referring to when I mentioned "no outcry". Bruce said 
that he liked the idea to have something like that in the USER's manual. 

And I have to agree: There might be enough room to actually go and write a 
Git hacker's manual, but IMHO that takes a lot of time which has to be 
found at first.

And even if we actually have such a hacker's manual one day, this "sneak 
preview" in the user's manual does not hurt, but could actually entice 
people to read that manual, too.

Ciao,
Dscho
