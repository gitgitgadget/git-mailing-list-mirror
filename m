From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Thu, 18 Oct 2007 01:04:56 -0400
Message-ID: <20071018050456.GD14735@spearce.org>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <20071017190646.GC9041@planck.djpig.de> <98FA3712-B4E5-499A-B3E5-818FC33833DA@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNZL-0001mZ-UO
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXJRFFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbXJRFFF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:05:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50880 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbXJRFFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:05:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNZ1-0005oN-Bk; Thu, 18 Oct 2007 01:04:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 46DE420FBAE; Thu, 18 Oct 2007 01:04:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <98FA3712-B4E5-499A-B3E5-818FC33833DA@silverinsanity.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61474>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> On Oct 17, 2007, at 3:06 PM, Frank Lichtenheld wrote:
> 
> >I have this in my repo and will submit this with the other git- 
> >cvsserver
> >changes. I was just waiting for either Junio to return or someone else
> >stepping up.
> 
> Ah.  I had missed that.  I just dug up the patch when switching to  
> Shawn's repo gave me those old testing errors.  Had thought it had  
> gotten lost in the shuffle.

It did.  I have your resubmit that started this thread in my INQ and
will try to get to it today.  But if Frank has a queue of stuff I've
missed I'd like a pointer to it so I can also try to start working
through it.  I know I also have some other topics that Lars Hjemli
accumlated in his tree that I still need to cherry-pick over into
mine, but I don't see the one we are talking about in there.

-- 
Shawn.
