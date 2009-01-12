From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Google Summer of Code 2009
Date: Mon, 12 Jan 2009 07:33:22 -0800
Message-ID: <20090112153322.GA10179@spearce.org>
References: <20090107183033.GB10790@spearce.org> <496B2690.2010902@op5.se> <alpine.DEB.1.00.0901121421530.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 16:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMOoU-0006bN-Hd
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 16:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbZALPd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 10:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZALPdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 10:33:25 -0500
Received: from george.spearce.org ([209.20.77.23]:51916 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbZALPdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 10:33:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 038EA38210; Mon, 12 Jan 2009 15:33:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901121421530.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105349>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 12 Jan 2009, Andreas Ericsson wrote:
> 
> > Just chiming in that I can probably help mentoring whoever goes with 
> > libgit2. I do not have enough spare time for me to promise that I can be 
> > there as much as I think is necessary and proper, but I'll gladly help 
> > out.
> 
> I don't know if I like co-mentoring; I always had the impression that this 
> does not work all that well.

I haven't tried it myself, so I can't comment.  I thought though
that Daniel and Christian's mentoring went rather well, but maybe
that's just me.

This year I may not be able to be a mentor for GSoC.  Even assuming
we are selected again we're likely to only have two students, given
the size of the program and the size of our organization's community.
I will most likely be hosting an intern at day-job, and I do want
to maintain some sort of contribution to Git, without hurting my
day job performance... so my time this summer is probably going to
be somewhat limited.

> > On a side-note, I think all mentors should urge the students in the 
> > strongest possible terms to deliver their work to git@vger as soon as 
> > possible. From previous years experience, successful projects are those 
> > that the list sees code from within a week or two after the project's 
> > started, while the projects that are kept in the dark rarely (if ever?) 
> > finish successfully.
> 
> Nope, that is just plainly incorrect.
> 
> The most successful GSoC project we had was Miklos' builtin-merge, but the 
> code had to grow to a state that both him and me were comfortable with a 
> submission to git@vger.

Heh.  I'd wager the most successful GSoC project was Marek's push
support for JGit.  Having ObjectWriter available has opened up
the doors to support a lot of code in JGit, like the full protocol
suite, and bundles.  Without it I wouldn't have gotten as far as
I did in Gerrit.

In terms of value, to me as a contributor, Marek's work gave me a
foundation we could build on and get stuff done.  Miklos' merge is
great, but I don't think we gained nearly as many features as we
did with Marek's contribution.

Anyway, I don't want to get into a "my student was better!" contest.
I just think that we had a very successful year this year, with a
few really great projects being contributed to the community as a
result of our students' hard work.
 
> The _communication_ should be open, and much of it on the mailing list, I 
> agree, but _only_ after the student is familiar enough with the aspects of 
> her project (including some familiarity with the source code).
>
> I will _not_ force a student to ask questions openly that he finds 
> embarassing.

I agree.  The first few weeks are really critical to the student.  They
are still trying to find their way around the code base and don't want
to look like an idiot.  Nobody wants to look like an idiot, especially
in public, and especially when they have been "hired" to do a particular
job.

But... part of the reason GSoC exists is to get students involved
in open source.  The rest of us don't come to Git with mentors we
can ask the "stupid" questions to.  We come here and have to ask
what we need to ask, on the public mailing list, complete with
archives for the rest of time.  As mentors we should be trying to
encourage our students to work in this, or any other, open source
community.  GSoC is about getting these folks _involved_, so that
40 years from now, open source is just as viable as it is today.

-- 
Shawn.
