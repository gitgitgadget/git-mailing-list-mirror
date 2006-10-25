X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 18:15:31 -0400
Message-ID: <20061025221531.GB10140@spearce.org>
References: <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu> <20061025094900.GA26989@coredump.intra.peff.net> <453F6B7A.60805@op5.se> <Pine.LNX.4.63.0610251450040.1754@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:15:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610251450040.1754@qynat.qvtvafvgr.pbz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30107>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcr2B-0004b4-4z for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964828AbWJYWPf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWJYWPf
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:15:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61575 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964828AbWJYWPf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:15:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gcr1v-0007wx-PJ; Wed, 25 Oct 2006 18:15:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A5D3A21269E; Wed, 25 Oct 2006 18:15:31 -0400 (EDT)
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

David Lang <dlang@digitalinsight.com> wrote:
> a quick lesson on program nameing
> 
> On Wed, 25 Oct 2006, Andreas Ericsson wrote:
> 
> >I'm personally all for a rewrite of the necessary commands in C ("commit" 
> >comes to mind), but as many others, I have no personal interest in doing 
> >the actual work. I'm fairly certain that once we get it working natively 
> >on windows with some decent performance, windows hackers will pick up the 
> >ball and write "wingit", which will be a log viewer and GUI thing for
>              ^^^^^^
> 
> how many other people read this as 'wing it' rather then 'win git'? ;-)

Yes, that's certainly a less than optimal name...

What about gitk?  Is it "gi tk" or "git k" ?  This has actually
been the source of much local debate.  :-)

-- 
