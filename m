From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitk: bind <F5> key to Update (reread commits)
Date: Fri, 23 Feb 2007 15:41:13 -0500
Message-ID: <20070223204113.GA27261@spearce.org>
References: <11722629943386-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 21:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKhEI-00028s-0M
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 21:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbXBWUlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 15:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933202AbXBWUlS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 15:41:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32891 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbXBWUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 15:41:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HKhE6-0007gg-50; Fri, 23 Feb 2007 15:41:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C4FB720FBAE; Fri, 23 Feb 2007 15:41:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <11722629943386-git-send-email-normalperson@yhbt.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40468>

Eric Wong <normalperson@yhbt.net> wrote:
> I chose <F5> because it's also the key to reload the current
> page in web browsers such as Konqueror and Firefox, so users
> are more likely to be familiar with it.

It is also the key for rescan in git-gui.  :-)

Though I have to admit, I chose F5 there for the exact reason you
mention above.

-- 
Shawn.
