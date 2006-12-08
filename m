X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Fri, 8 Dec 2006 01:08:50 -0500
Message-ID: <20061208060850.GE5939@fieldses.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net> <20061207214053.GC31035@fieldses.org> <20061207215914.GC12502@spearce.org> <20061208044516.GC5939@fieldses.org> <20061208055938.GB13999@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 06:09:03 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061208055938.GB13999@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33660>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsYum-0000jb-7U for gcvg-git@gmane.org; Fri, 08 Dec
 2006 07:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424733AbWLHGIx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 01:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424734AbWLHGIx
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 01:08:53 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36417 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424733AbWLHGIx (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 01:08:53 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsYug-0003qi-T5; Fri, 08 Dec 2006
 01:08:50 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Fri, Dec 08, 2006 at 12:59:38AM -0500, Shawn Pearce wrote:
> Its in the prompt for all of these users; I forced it in as part of
> the system's /etc/profile.d.  They just forget that they should think
> about where they should start their branch from before they make it.

Maybe they don't really want to use topic branches at all?  Could they
get away with just committing everything to master?  Seems like kind of
a shame, though.  Hm.

