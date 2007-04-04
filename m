From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 4 Apr 2007 02:19:58 -0400
Message-ID: <20070404061958.GB30309@spearce.org>
References: <20070322104021.GJ29341@mellanox.co.il> <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net> <20070404060213.GB31984@mellanox.co.il> <7vircc8ybz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYyrA-0001C9-QU
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992692AbXDDGUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992695AbXDDGUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:20:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35258 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992692AbXDDGUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:20:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYyqd-000319-SL; Wed, 04 Apr 2007 02:20:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0FED420FBAE; Wed,  4 Apr 2007 02:19:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vircc8ybz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43711>

Junio C Hamano <junkio@cox.net> wrote:
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> > *Maybe* git can be even smarter, and notice that only
> > commit message has changed, and preserve the author automatically
> > in this case? I haven't looked at how hard that would be to do.
> 
> Maybe you can try what you complain about out before you rant?
> I amend other people's commit messages after the fact almost
> *every* *day*.

Me too.  And I *know* Junio amends my stuff after applying it to
git.git.  Just look back at the history to see how many thinkos
he's saved me from...  ;-)

-- 
Shawn.
