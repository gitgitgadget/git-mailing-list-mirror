From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 4 Apr 2007 02:35:10 -0400
Message-ID: <20070404063510.GC30309@spearce.org>
References: <20070322104021.GJ29341@mellanox.co.il> <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net> <20070404060213.GB31984@mellanox.co.il> <7vircc8ybz.fsf@assigned-by-dhcp.cox.net> <20070404061958.GB30309@spearce.org> <7v3b3g8xl5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYz5V-0001CE-V2
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbXDDGfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992697AbXDDGfR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:35:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35535 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbXDDGfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:35:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYz5L-0003Wj-CK; Wed, 04 Apr 2007 02:35:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C1F7920FBAE; Wed,  4 Apr 2007 02:35:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v3b3g8xl5.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43716>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Me too.  And I *know* Junio amends my stuff after applying it to
> > git.git.  Just look back at the history to see how many thinkos
> > he's saved me from...  ;-)
> 
> Actually, you cannot know.  I may well be editing your mesage in
> my mailbox before applying, like Linus does.

OK, yes, good point.  So maybe my garbage is easier to fix in your
email client then with --amend.  ;-)

But the point of you saving me still holds!

Although 1510fea7 sadly was not one of those times...  ;-)
At least it was fixed by 5caf9232.

-- 
Shawn.
