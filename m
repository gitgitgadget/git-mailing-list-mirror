X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 01:18:33 -0500
Message-ID: <20061115061833.GA6294@spearce.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home> <7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 06:19:05 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31419>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkE6n-0001zk-DX for gcvg-git@gmane.org; Wed, 15 Nov
 2006 07:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966530AbWKOGSp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 01:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966531AbWKOGSp
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 01:18:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53206 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S966530AbWKOGSo
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 01:18:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkE6W-0003aP-IG; Wed, 15 Nov 2006 01:18:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CCBF420FB0B; Wed, 15 Nov 2006 01:18:33 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Or even better, have "gh init".

Why gh?  Is Git just Mercurial backwards?  :)

I'm all in favor of this discussion, and in particular of just
breaking the entire UI in 2.0 by using a new frontend command.
I'm just not sure that "Mercurial backwards" describes Git well.

-- 
