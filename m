From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fsck objects and timestamp ordering
Date: Mon, 25 Sep 2006 12:48:55 -0400
Message-ID: <20060925164855.GC27043@spearce.org>
References: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com> <20060925164004.GB27043@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 25 18:49:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRtdn-0007Rt-BX
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 18:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWIYQtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 12:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWIYQtD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 12:49:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:3491 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751252AbWIYQtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 12:49:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRtdT-0004al-9c; Mon, 25 Sep 2006 12:48:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DDCBF20FB28; Mon, 25 Sep 2006 12:48:55 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060925164004.GB27043@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27744>

Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > I am having trouble with a CVS repository where the timestamp ordering
> > and dependency order are in conflict. It would be best if git didn't
> > experience the same problem.
> 
> It would be best if Git didn't experience a lot of the weird stuff
> people were able to do to their CVS repositories.  Fortunately the
> friendly folks on this mailing list have put the better part of a
> year and a half into doing just that.  :)

Wow, on reread that last sentance seems to imply that the fine
people who have contributed to Git have spent the past year and a
half making sure Git has plenty of weird stuff contained within it.
Which is not what I meant at all.  :)

My brain's just not working today (some sort of head cold thing
going on).  Its probably best that I stay away from anything that
requires any sort of logic...  such as English.

-- 
Shawn.
