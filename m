X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Fri, 15 Dec 2006 10:01:30 -0500
Message-ID: <20061215150130.GB17860@spearce.org>
References: <20061215020629.GK26202@spearce.org> <87tzzx4zm7.wl%cworth@cworth.org> <20061215032530.GM26202@spearce.org> <87slfh4xkm.wl%cworth@cworth.org> <eluasq$v7q$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 15:01:40 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <eluasq$v7q$3@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34509>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEZ7-0005h7-QA for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752698AbWLOPBf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbWLOPBe
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:01:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48660 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752698AbWLOPBe (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:01:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvEYx-0005HN-06; Fri, 15 Dec 2006 10:01:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6190A20FB65; Fri, 15 Dec 2006 10:01:30 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Carl Worth wrote:
> 
> > On Thu, 14 Dec 2006 22:25:30 -0500, Shawn Pearce wrote:
> 
> >>  * gitweb made it appear as though a whole lot of Carl's recent
> >>    work was somehow undone in the merge.
> > 
> > That looks like a simple gitweb bug. None of the other tools, (gitk,
> > git log -p), consider a trivial merge commit like this as having
> > anything interesting in it worth displaying.
> 
> It's not a bug, it is rather lack of feature (or misfeature).

Its a bug.

I'm not a gitweb user (meaning I almost never look at something
in gitweb).  But I'm clearly also not a Git newbie.  ;-)

I could not fathom why that merge commit was being displayed that
way in gitweb.  I had to clone the cairo project just so I could
actually look at the commit with log/show/whatchanged/diff-tree,
because I couldn't believe what I was seeing from gitweb.
 
-- 
