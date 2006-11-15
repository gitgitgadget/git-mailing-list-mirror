X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 01:26:28 -0500
Message-ID: <20061115062628.GB6294@spearce.org>
References: <20061115062101.22280.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 06:26:52 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061115062101.22280.qmail@science.horizon.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31421>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkEEJ-0003Bi-EQ for gcvg-git@gmane.org; Wed, 15 Nov
 2006 07:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966535AbWKOG0g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 01:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966536AbWKOG0g
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 01:26:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52439 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S966535AbWKOG0f
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 01:26:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkEEA-00042L-91; Wed, 15 Nov 2006 01:26:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7160B20FB0B; Wed, 15 Nov 2006 01:26:28 -0500 (EST)
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:
> >> 1) make "git init" an alias for "git init-db".
> 
> > Or even better, have "gh init".
> 
> If you're going to be inspired by hg, pick a cleverer name. :-)
> 
> If you want to add a thin attractive layer, silver-plate the thing and
> call it "ag".  Since it contains the letter g as well, I'm sure that
> someone can come up with a good backronym for it.

Is "more Attractive Git" not good enough?

-- 
