From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Thu, 28 Dec 2006 23:53:27 -0500
Message-ID: <20061229045327.GD12072@spearce.org>
References: <20061228073441.GB17304@spearce.org> <7vmz58whnx.fsf@assigned-by-dhcp.cox.net> <20061228084245.GA18150@spearce.org> <7vtzzguvrp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 05:54:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H09ky-0002SJ-Rt
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 05:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWL2Exc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWL2Exc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 23:53:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33180 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbWL2Exb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 23:53:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H09jf-00011X-Mq; Thu, 28 Dec 2006 23:52:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E0BE20FB65; Thu, 28 Dec 2006 23:53:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vtzzguvrp.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35581>

Junio C Hamano <junkio@cox.net> wrote:
> While I was looking at the problem, I noticed something a bit
> easier to reproduce and should be lot easier to diagnose.  At
> http://userweb.kernel.org/~junio/broken.tar, I have a tarball of
> git.git repository.

Thanks.  I downloaded that tar but I can't debug it right now.
I'm feeling under the weather and already had a long day; I'm too
fried to seriously look at this pack code.  I'll do it tomorrow
evening.

-- 
Shawn.
