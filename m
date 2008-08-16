From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Fri, 15 Aug 2008 18:22:50 -0700
Message-ID: <20080816012250.GB17399@spearce.org>
References: <200807080227.43515.jnareb@gmail.com> <200808140457.56464.jnareb@gmail.com> <48A5DB4D.5060906@gmail.com> <200808152236.56479.jnareb@gmail.com> <20080816011633.GC17121@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Aug 16 03:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUAWP-0007Dw-8f
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 03:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbYHPBWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 21:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbYHPBWv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 21:22:51 -0400
Received: from george.spearce.org ([209.20.77.23]:52701 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYHPBWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 21:22:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 40D7C38375; Sat, 16 Aug 2008 01:22:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080816011633.GC17121@leksak.fem-net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92524>

Stephan Beyer <s-beyer@gmx.net> wrote:
> Jakub Narebski wrote:
> > Please remember that according to timeline in GSoC 2008 FAQ:
> >   http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
> > August 18: ~12 noon PDT / 19:00 UTC is "Firm 'pencils down' date."
> > (suggested pencils down date was August 11).  So you don't have much
> > time, and you don't leave much time for review, so I guess evaluation
> > would be "done, but nor merged in" or something like that.
> 
> I'm wondering about "and you don't leave much time for review".
> A comment on this:
> LH (from the Google Open Source Team) clarified that the state of
> Aug 18 is not the date where everything should be reviewed and merged
> in.  It is the date where the (following) evaluation (done by the mentor)
> of the code is based on.
> 
> See also
> http://groups.google.com/group/google-summer-of-code-announce/browse_thread/thread/df7278c6e027dee1

LH is correct.  A student doesn't have to get their code merged
just to have a successful project.  Perhaps the overall project is
in a frozen release candidate period and doesn't want to take _any_
new features until after the release is made.  That may be a full
month after the "pencils down" date.

Suppose even further that the project is on SVN, and has just one
branch, /trunk, such that even checking in the student's project
could break that release.

Clearly you cannot require the student to have their code merged
just to pass them.

However, I think it is reasonable to require that the student
has at least posted their patches for review and discussion, and
that the student has made a good-faith effort towards making those
patches something the community _might_ accept.  IOW it would be
good enough that Junio would consider slating it into "pu", even
though some final cleanup changes may be necessary.

-- 
Shawn.
