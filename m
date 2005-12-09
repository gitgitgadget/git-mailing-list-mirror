From: Petr Baudis <pasky@suse.cz>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 9 Dec 2005 10:43:28 +0100
Message-ID: <20051209094328.GT22159@pasky.or.cz>
References: <7vbqzrcmgr.fsf@assigned-by-dhcp.cox.net> <20051209054304.3908.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alan@chandlerfamily.org.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 10:43:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekema-0007BW-FF
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 10:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVLIJnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 04:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVLIJnN
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 04:43:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:31694 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751184AbVLIJnN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 04:43:13 -0500
Received: (qmail 25687 invoked by uid 2001); 9 Dec 2005 10:43:28 +0100
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20051209054304.3908.qmail@science.horizon.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13421>

  BTW, such a "wide" reply is a bit hard to handle - it might be perhaps
more practical to make separate replies at least to the mails whose
contents does not overlap. Also, people would not get Cc's of subthreads
they are not involved with.

Dear diary, on Fri, Dec 09, 2005 at 06:43:04AM CET, I got a letter
where linux@horizon.com said that...
> Finally, pasky@suse.de wrote:
> > That said, the "git for the confused" contains a lot of nice points, but
> > I don't think it's a good approach to just have extra document for
> > clarifying this stuff. It would be much better if the stock
> > documentation itself would not be confusing in the first place. Same
> > goes for the "commands overview" (BOUND to get out-of-date over time
> > since it's detached from the normal per-command documentation; we have
> > troubles huge enough to keep usage strings in sync, let alone the
> > manpages).
> 
> I don't think it's the ideal solution either, but the idea of trying to
> supplant Linus' tutorial is a bit alarming given my current still-novice
> state.  I've been dabbling with git for a few weeks; many of the people
> on this list have been using git in earnest for most of its life.

Now that's precisely what's most precious on you :-) - you have a fresh
perspective (and you don't seem to appear as a bad writer, at least to
me), actually much more important that technical correctness especially
for non-reference documentation like this; we'll catch possible
inaccuracies while reviewing, that's the least thing.

> Unfortunately, given the number of commands, you can't just document
> them well individually.  Some overview of how they fit together into
> a system is required.

Hmm. Well, actually... what's the point? If I want to get a really quick
overview, I do

	whatis git

and it will DTRT. But when do I need something more detailed but not yet
the manual page of the given command?

Now, having a task-based structured documentation (also called "user
manual" ;-) is an entirely different story and yes, that would be
extremely useful.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
