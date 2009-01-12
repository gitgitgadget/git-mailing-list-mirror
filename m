From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009
Date: Mon, 12 Jan 2009 18:23:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901121811301.3586@pacific.mpi-cbg.de>
References: <20090107183033.GB10790@spearce.org> <496B2690.2010902@op5.se> <alpine.DEB.1.00.0901121421530.3586@pacific.mpi-cbg.de> <20090112153322.GA10179@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQWe-0000Kv-0l
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZALRXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbZALRXC
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:23:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:54448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbZALRXA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:23:00 -0500
Received: (qmail invoked by alias); 12 Jan 2009 17:22:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 12 Jan 2009 18:22:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZoR1cpekZQUrkmrLc/btjVvsnZ80hhEgNUUqcu9
	ZQtT5GSxB6C5pu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090112153322.GA10179@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105358>

Hi,

On Mon, 12 Jan 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 12 Jan 2009, Andreas Ericsson wrote:
> > 
> > > Just chiming in that I can probably help mentoring whoever goes with 
> > > libgit2. I do not have enough spare time for me to promise that I 
> > > can be there as much as I think is necessary and proper, but I'll 
> > > gladly help out.
> > 
> > I don't know if I like co-mentoring; I always had the impression that 
> > this does not work all that well.
> 
> I haven't tried it myself, so I can't comment.  I thought though that 
> Daniel and Christian's mentoring went rather well, but maybe that's just 
> me.

That impression came from a few conversations at the mentor summit, BTW.  
I cannot really comment on C & D...  as Christian pointed out, they are 
still a bit secretive, even long after the official end of the project.

However, I have to mention that some projects (SIP communicator for 
example) made it a _requirement_ to have pairs of mentors.  But then, they 
had the "disappearing mentor" syndrome already, so who can blame them for 
that.

> This year I may not be able to be a mentor for GSoC.

Pity.  But you started the preparation for the new application, thank you 
very much.  Will you be able to be administrator again?

> Heh.  I'd wager the most successful GSoC project was Marek's push 
> support for JGit.  Having ObjectWriter available has opened up the doors 
> to support a lot of code in JGit, like the full protocol suite, and 
> bundles.  Without it I wouldn't have gotten as far as I did in Gerrit.
> 
> In terms of value, to me as a contributor, Marek's work gave me a 
> foundation we could build on and get stuff done.  Miklos' merge is 
> great, but I don't think we gained nearly as many features as we did 
> with Marek's contribution.
> 
> Anyway, I don't want to get into a "my student was better!" contest.

Hehe.  I am very proud that we are able to hold such a contest.

> I just think that we had a very successful year this year, with a
> few really great projects being contributed to the community as a
> result of our students' hard work.
>  
> > The _communication_ should be open, and much of it on the mailing list, I 
> > agree, but _only_ after the student is familiar enough with the aspects of 
> > her project (including some familiarity with the source code).
> >
> > I will _not_ force a student to ask questions openly that he finds 
> > embarassing.
> 
> I agree.  The first few weeks are really critical to the student.  They
> are still trying to find their way around the code base and don't want
> to look like an idiot.  Nobody wants to look like an idiot, especially
> in public, and especially when they have been "hired" to do a particular
> job.
> 
> But... part of the reason GSoC exists is to get students involved
> in open source.  The rest of us don't come to Git with mentors we
> can ask the "stupid" questions to.  We come here and have to ask
> what we need to ask, on the public mailing list, complete with
> archives for the rest of time.  As mentors we should be trying to
> encourage our students to work in this, or any other, open source
> community.

I do not think that both of your paragraphs contradict each other.  Many 
students need a bit of hand-holding until they realize that everybody is 
cooking with water.  At the end of the day, everybody has some brilliant 
and some stupid ideas.

But it takes some getting used to to voice ideas in public, risking some 
friendly jokes about your mental state or the quality of your smokables.

I actually see a lot of value in GSoC as a tools to get more students 
through that period, especially students from parts of this planet whose 
culture is so different from the "Western" culture shaped by 
TV, consumism and the lack of physical insecurity, that they are rather 
intimidated by the ways of Open Source.

> GSoC is about getting these folks _involved_, so that 40 years from now, 
> open source is just as viable as it is today.

It will probably take over even more of our world.

Ciao,
Dscho
