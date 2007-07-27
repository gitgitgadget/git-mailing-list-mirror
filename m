From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: gitk screenshots of complex history
Date: Fri, 27 Jul 2007 00:13:01 -0400
Message-ID: <20070727041300.GD20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 06:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHCR-0002QD-BB
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbXG0ENI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXG0ENH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:13:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50116 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbXG0ENF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:13:05 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEHCI-0008HL-RW
	for git@vger.kernel.org; Fri, 27 Jul 2007 00:13:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2395720FBAE; Fri, 27 Jul 2007 00:13:01 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53879>

I've mentioned both on list and on #git that one of my production
repositories has a few weird points in time.  Some folks have asked
to see at least screenshots of the line part of the gitk output,
as apparently they've never seen ugly history in Git.  Lucky them.

The images are rather large so I have posted them on my website
with a bit longer explanation of each:

  http://www.spearce.org/2007/07/difficult-gitk-graphs.html


I just compared my own history to Linus' linux-2.6 history.
The kernel team can't hold a candle to this mess.  Remember,
this is *with* me involved in the project on a daily basis.  Me.
Someone who knows Git fairly well...

OK, no more screenshots from *that* repository!  I don't ever want
to run `gitk --all` there again.  Ever.

PS: The really interesting data (subject lines, authors, dates)
has all been redacted from the images.  I can't publish that stuff.

-- 
Shawn.
