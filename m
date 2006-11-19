X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] do_for_each_ref: perform the same sanity check for leftovers.
Date: Sun, 19 Nov 2006 01:19:05 -0500
Message-ID: <20061119061905.GB26670@spearce.org>
References: <7vr6w07ylu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 06:19:31 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6w07ylu.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31826>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glg1P-0007zu-U4 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 07:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756474AbWKSGTR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 01:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756475AbWKSGTQ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 01:19:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40104 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1756473AbWKSGTQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 01:19:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Glg1G-0004Jg-Tr; Sun, 19 Nov 2006 01:19:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5532A20E469; Sun, 19 Nov 2006 01:19:05 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
>  * "pickaxe -L'/^static int do_for_each_ref/,+40' refs.c" turns

What's this pickaxe you speak of?  Last I read you deleted it when
you renamed git-pickaxe to git-blame.

Have you reinvented git-pickaxe so soon?  Maybe we could try using
git-longblade next time a new comamnd is being developed?  :-)

-- 
