X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Wed, 13 Dec 2006 05:57:54 -0500
Message-ID: <20061213105754.GC9484@spearce.org>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <200612111147.44964.Josef.Weidendorfer@gmx.de> <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net> <200612130415.59038.Josef.Weidendorfer@gmx.de> <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612131137100.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 10:58:13 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612131137100.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34208>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRoI-0000n9-8j for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932447AbWLMK57 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWLMK57
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:57:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59669 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932447AbWLMK56 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 05:57:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuRo8-000803-Th; Wed, 13 Dec 2006 05:57:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 26BDC20FB6E; Wed, 13 Dec 2006 05:57:54 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 12 Dec 2006, Junio C Hamano wrote:
> > Hmm, a way to easily stash away local changes and restoring
> > would lead to a system where you can easily stash and unstash
> > multiple snapshots and switch between them, and such a model
> > sounds vaguely familiar...
> 
> Hmm, what might that be? :-)
> 
> A more simple approach than to buy into Python 

Hmmm... last I heard Git doesn't depend on Python anymore, thanks
largely to you and Alex.  But it does stash and unstash snapshots
of my working directory wicked fast using these things called
branches...  :-)

-- 
