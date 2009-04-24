From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 14:35:34 -0400
Message-ID: <20090424183534.GJ17365@fieldses.org>
References: <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <20090424141139.GC10761@coredump.intra.peff.net> <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com> <20090424150442.GA11245@coredump.intra.peff.net> <b4087cc50904240818w45bd1cfaq8bbc83e10a6e3781@mail.gmail.com> <20090424173852.GF17365@fieldses.org> <20090424182752.GC11360@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 20:37:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxQGs-0006WY-Lp
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 20:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757673AbZDXSfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbZDXSfh
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 14:35:37 -0400
Received: from mail.fieldses.org ([141.211.133.115]:36167 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbZDXSfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 14:35:36 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LxQFK-0005CB-R3; Fri, 24 Apr 2009 14:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20090424182752.GC11360@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117479>

On Fri, Apr 24, 2009 at 02:27:52PM -0400, Jeff King wrote:
> On Fri, Apr 24, 2009 at 01:38:52PM -0400, J. Bruce Fields wrote:
> 
> > On Fri, Apr 24, 2009 at 10:18:15AM -0500, Michael Witten wrote:
> > > I think that we've already got that tutorial-esque style covered (I
> > > haven't read it in a while):
> > > 
> > >     http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
> > > 
> > > However, the User Manual should make a Mathematician happy.
> > 
> > I'm all for making mathematicians happy.  But, again, help?:
> > 
> > 	- Specific examples?
> > 	- Patches?  Please, patches?
> > 	- Suggested text?
> > 	- Suggested outline?
> > 
> > There's no shortage of high-level ideas.  What there's always a need for
> > more of is people willing to submit patches, respond to review, etc.
> 
> I usually hate to "me too", but I really want to second this notion. We
> have been getting minor documentation fixups trickling in, and I think
> those really help, and maybe they eventually would make the
> documentation perfect. But I have the feeling we would benefit from
> somebody taking ownership and considering the big picture of how the
> documentation fits together, and then really pushing it forward with
> something concrete.

Yup, and dealing seriously with objections, getting concensus for the
resulting solutions, etc--in other words, being a maintainer.  I thought
I'd be able to do that at some point, but just haven't consistently had
the time.

That said, several smaller suggestions have been made which could be
handled now:

	- I don't think I've seen objections to the idea of a
	  git-revision-specifying manpage, whatever you want to call
	  it--so probably that just needs someone to write the patch.
	- There've been complaints about terms being used before they're
	  defined sufficiently well.  I can believe it, but: specific
	  examples would help!

--b.
