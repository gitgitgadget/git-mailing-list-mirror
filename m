X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Allow short pack names to git-pack-objects --unpacked=.
Date: Sun, 29 Oct 2006 04:44:04 -0500
Message-ID: <20061029094404.GF3847@spearce.org>
References: <20061029093711.GC3847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 09:44:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061029093711.GC3847@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30423>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge7DC-0000am-Gj for gcvg-git@gmane.org; Sun, 29 Oct
 2006 10:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932138AbWJ2JoM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 04:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJ2JoM
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 04:44:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:23435 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932138AbWJ2JoL
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 04:44:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge7DN-0003RS-VF; Sun, 29 Oct 2006 04:44:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3006320E45B; Sun, 29 Oct 2006 04:44:06 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Ok, I'm a freaking idiot:

> Subject: [PATCH 1/3] Allow short pack names to git-pack-objects --unpacked=.
> 
> Allow short pack names to git-pack-objects --unpacked=.

I meant to delete the first two lines of the body of the message
before sending so that git-am didn't stutter the first line of the
commit message when applied, yet I managed to not do that.  *sigh*

-- 
