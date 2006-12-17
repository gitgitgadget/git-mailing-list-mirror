X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 16 Dec 2006 23:42:37 -0500
Message-ID: <20061217044237.GC19636@spearce.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 04:42:58 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34676>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvnrP-0007d8-Ml for gcvg-git@gmane.org; Sun, 17 Dec
 2006 05:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751907AbWLQEmo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 23:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWLQEmo
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 23:42:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52596 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751907AbWLQEmn (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 23:42:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gvnr0-0000YY-Uh; Sat, 16 Dec 2006 23:42:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DEF9A20FB65; Sat, 16 Dec 2006 23:42:37 -0500 (EST)
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Brian Gernhardt <benji@silverinsanity.com> wrote:
> >** jc/reflog (Thu Dec 14 15:58:56 2006 -0800) 1 commit
> > - Teach show-branch how to show ref-log data.
> 
> What about a "git reflog [<branch>]" command instead?  Would show  
> output similar to "git log" (or "git show-branch" for brevity).

It has been proposed on the list.  I even sketched out what such
a command would look like, how it should present the data, etc.
But I never wrote it.  Nobody else has taken up the task either.  :-)

-- 
