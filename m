From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 20:03:59 -0400
Message-ID: <20071016000359.GT27899@spearce.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org> <4713FA4A.5090501@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Pete/Piet Delaney <pete@bluelane.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:23:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhZva-0006mX-HD
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 02:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbXJPAE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbXJPAE2
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 20:04:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45780 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbXJPAE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 20:04:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhZuY-0008ER-TT; Mon, 15 Oct 2007 20:03:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 031B520FBAE; Mon, 15 Oct 2007 20:03:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4713FA4A.5090501@bluelane.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61056>

Pete/Piet Delaney <pete@bluelane.com> wrote:
> I imported the CVS repository to git and it worked great. Since all
> of our other repository are in bitkeeper the management would like to
> stick with CVS. With git apparently still being weak in the area of
> supporting difftool on different version that seems somewhat reasonable
> for the time being.
...
> I was curious why the difftool paradigm hasn't been integrated into
> the git GUIs. It's very comfortable and I think it has been used in
> other source code control systems, for example Sun Microsystems.

What's difftool?  What's so great about it?

Forgive my ignorance but it has been many years since I last used
BitKeeper and even when I did use it I didn't get into many of the
features it offered.  Its entirely possible I never learned about
difftool.

I've never found that I cannot get the information I need out of Git
when I need it.  Actually I've found it to be the easiest VCS to get
data out of, beating CVS, Perforce, BitKeeper, SVN, etc. hands down.
Of course I also know Git better than I know those tools...

-- 
Shawn.
