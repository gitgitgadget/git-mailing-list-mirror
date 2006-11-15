X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:49:14 -0500
Message-ID: <20061115184914.GA24122@spearce.org>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <Pine.LNX.4.64.0611151315291.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 18:49:47 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611151315291.2591@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31466>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPpH-0001ye-RG for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030865AbWKOSt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030861AbWKOSt3
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:49:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:7662 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1030865AbWKOSt1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:49:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkPor-0000fb-77; Wed, 15 Nov 2006 13:49:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5604220FB0B; Wed, 15 Nov 2006 13:49:14 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> As for the fraction of people complaining being a small fraction of 
> current GIT users: that is easily explainable by the fact that most 
> people who would have grown the complainers group are simply not GIT 
> users anymore since they were turned away by GIT's current user 
> interface issues.  The only complainers remaining are those who see 
> value in the GIT technology but who would like to bring more 
> intuitiveness to the GIT interface instead of going for the alternative 
> technology.  And those kind of people are always few.

Or they are by proxy.

*I* don't see that much of a problem with git pull; I can use it
without trouble at this point.  But I find it difficult to teach
to others.

My complaints about git pull/fetch/push are by proxy for about 10
other users who aren't on the mailing list but whom I interact with
through Git.  They don't like pull/fetch/push very much.

So count my complaints 10 times.  :)

Ok, that's still a drop in the bucket of current Git users.
But still, I'm sure there are others.  I think Carl was recently
talking about complaints from some Fedora folks...

-- 
