From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final
	evaluation
Date: Mon, 15 Sep 2008 07:08:11 -0700
Message-ID: <20080915140811.GA6320@spearce.org>
References: <200809042315.58898.jnareb@gmail.com> <200809151413.37628.jnareb@gmail.com> <alpine.DEB.1.00.0809151434280.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 15 16:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfElX-0006WD-FP
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 16:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYIOOIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 10:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYIOOIN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 10:08:13 -0400
Received: from george.spearce.org ([209.20.77.23]:56031 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbYIOOIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 10:08:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EEDFE3835F; Mon, 15 Sep 2008 14:08:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809151434280.13830@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95910>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 15 Sep 2008, Jakub Narebski wrote:
> > On Thu, 4 Sep 2008, Jakub Narebski wrote:
> > 
> > > Mentors, could you tell us your side about how it was working as a 
> > > mentor for Google Summer of Code? Perhaps some tricks of trade?
> > 
> > By the way, I have found via LWN that Perl has written nice summary of 
> > theirs Google Summer of Code projects[1].  Among other they very much 
> > praise that students did blogging about their progress:
...
> > What do you think about it (for example about doing it in a future
> > if our informal Git Development Community would participate in next
> > Google Summer of Code programs)?
> 
> I think that it is better to require frequent interaction on the mailing 
> list, or at least on IRC.

I agree with Dscho completely.  We are an email based community.
Students should be involved by email, not by blogs.  If we were
the Ruby community (which near as I can tell is blog based) then
blogging might make more sense.  We're not.  We're an offshoot of
the Linux community, which is very much email-centric.

> Blogging is nice for those who want to follow the progress of a project, 
> but do not want to get involved.  In this case, it is even better than 
> having the people discuss the issues of the project openly, as reading a 
> blog does not require constant monitoring like the list does.
> 
> However, blogging costs time.

Exactly.  Email also costs time, but typically we don't see
traffic on the list that is just broadcasting something pointless.
In general people only start a topic if there is going to be
worthwhile discussion attached to it, and often that results in a
useful patch being applied at some point in the future.  IOW that
time for email is just necessary in the course of development,
so it isn't wasted.

If the community of semi-interested people really wants blogs to
read, RSS scrape a news feed like Gmane.  Ohloh already has an
RSS feed defined around the emails sent to git ML with the subject
"[ANNOUNCE]".

I however prefer email, and dislike blogging, so I'll continue
to use the git ML in the future, and so will any student I mentor
in any potential future GSoC program.  FWIW I blogged here at new
day-job on company internal blog for about a half day before I gave
up and said "damn, that really is stupid".

-- 
Shawn.
