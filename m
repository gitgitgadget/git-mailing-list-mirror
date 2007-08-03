From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Thu, 2 Aug 2007 23:04:59 -0400
Message-ID: <20070803030459.GJ20052@spearce.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 05:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGnTc-0001IV-Rx
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 05:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392AbXHCDFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 23:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758315AbXHCDFF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 23:05:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56651 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbXHCDFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 23:05:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGnT7-0005Po-Tl; Thu, 02 Aug 2007 23:04:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 60C7A20FBAE; Thu,  2 Aug 2007 23:05:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070802181853.GB31885@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54663>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> > +Beyond the basic operation of staging and unstaging complete files,
> > +git gui can also selectively stage diff hunks.  You can do so by
...
> 
> I wonder whether we could get away with just the brief list of features
> ("lets you view changes in the index and the working file, lets you
> individually select diff hunks for inclusion in the index"), and leave
> the how-to stuff to online guit-gui help, if it's necessary?

Online help?  In git-gui?  :-)

We don't have an online help system yet.  Basically no documentation
has been written for git-gui.  No thought has been put into how one
should be organized, maintained, or displayed to the poor human
who is just trying to learn more about Git and this gui thing it
came with.

Yes, Help->Online Documentation is abvailable to most users, but
that just opens your web browser (if it can find one) and points
it to kernel.org's git manual.  Not exactly the best material for
learning more about git-gui itself.

-- 
Shawn.
