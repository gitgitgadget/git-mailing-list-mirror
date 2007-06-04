From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [RFC PATCH] Add git quick reference
Date: Mon, 4 Jun 2007 20:45:46 +0200
Message-ID: <20070604184546.GA27088@diku.dk>
References: <20070602182423.GC19952@diku.dk> <20070603171547.GA1965@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 20:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvHZ0-0006qQ-Q0
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 20:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758308AbXFDSpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 14:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbXFDSpu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 14:45:50 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:50543 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758308AbXFDSpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 14:45:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9EB67F0021;
	Mon,  4 Jun 2007 20:45:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v7yqsH3wsnqd; Mon,  4 Jun 2007 20:45:46 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4FD12F001C;
	Mon,  4 Jun 2007 20:45:46 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0C0B66DF823; Mon,  4 Jun 2007 20:43:37 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3CD5362A5D; Mon,  4 Jun 2007 20:45:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603171547.GA1965@fieldses.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49124>

J. Bruce Fields <bfields@fieldses.org> wrote Sun, Jun 03, 2007:
> On Sat, Jun 02, 2007 at 08:24:23PM +0200, Jonas Fonseca wrote:
> > It attempts to list some of the most commonly used commands, which should
> > give new users an idea of how to get started.
> > 
> > Available both as a manpage (generated via a script) and HTML page.
> 
> We have a "git quick start" here:
> 
> 	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#git-quick-start
> 
> and there's one on the wiki:
> 
> 	http://git.or.cz/gitwiki/QuickStart
> 
> I think the one in the manual tries to follow the organization of the
> manual more closely.

I like the manual version best. However, it is not as "visually" clean
and simple as I would like, but perhaps this sort of "use case" approach
is better.

> I haven't tried to compare those two recently, or to compare yours to
> either of them.  If you could compare and suggest any improvements,
> that'd be helpful.

I will see what I can do when I get the time and courage. :)

> I like your name better ("quick reference" as opposed to "quick start").

Yes, "quick start" suggest (at least to me) that it is a tutorial and it
seems far from that.

> Having it as a man page may be a good idea too.  I'd like to keep a copy
> in the manual as well, though, so we'd have to include from some common
> file.

The main idea was to have the reference in a printable format similar to
svn-ref. But the man page was easy to do, although it might not be
something that users would stumble upon.

-- 
Jonas Fonseca
