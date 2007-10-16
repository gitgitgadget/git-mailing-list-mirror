From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 16 Oct 2007 19:40:40 -0400
Message-ID: <20071016234040.GF13801@spearce.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihw1v-0007eM-CG
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 01:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbXJPXkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 19:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760403AbXJPXkp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 19:40:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46185 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbXJPXko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 19:40:44 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ihw1X-0008SM-Na; Tue, 16 Oct 2007 19:40:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9E9C620FBAE; Tue, 16 Oct 2007 19:40:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710161209480.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61280>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> first let me thank you for being the interim maintainer.  I know it is 
> much work, and I frankly do not have the time, or nerve, to do it.

Heh.  In the past 24 hours I've really learned how much I appreciate
the work that Junio does, and how infrequently I make it known that
I'm happy he's doing it for us.  Nothing like understanding what
the guy goes through then to walk a day in his shoes.  :-)

> Out of 
> curiousity: did you use the scripts in "todo" to send these emails?

Yes.  Took me a few minutes to figure out which scripts did
what magic.  Junio likes two character script names, because uh,
they are short to type.  Then I hand modified the output to say
git/spearce.git and appear from me, not Junio.  But otherwise they
are the same scripts available from his Meta repository (aka the
todo branch).
 
> On Tue, 16 Oct 2007, Shawn O. Pearce wrote:
> 
> > * lt/diff-rename (Tue Oct 2 19:28:19 2007 -0700) 1 commit
> 
> AFAIR this was ready to go to master, with a 5-10% speedup or so, just 
> needing a bit of testing.  Which it should have gotten by now.

OK.  I'll look at it tomorrow and consider moving it.  I recall the
context of this discussion now that you mention it, and I've been
running this in production use since Junio committed it to next
so I'm certainly not seeing any downsides to having this patch in
the tree.
 
> > * kh/commit (Mon Sep 17 20:06:47 2007 -0400) 4 commits
> > * js/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits

Thanks for the summary on these two topics.  They are going to stay
parked in next for a while then.  :-)

-- 
Shawn.
