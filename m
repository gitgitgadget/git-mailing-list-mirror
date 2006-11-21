X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 15:15:05 -0500
Message-ID: <20061121201505.GC22461@spearce.org>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com> <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com> <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com> <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com> <20061121063934.GA3332@spearce.org> <20061121200341.GH7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 20:16:20 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121200341.GH7201@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32034>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmc1X-0000iv-3B for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031376AbWKUUPO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934402AbWKUUPO
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:15:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:16620 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S934171AbWKUUPM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:15:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gmc1D-0008D6-5D; Tue, 21 Nov 2006 15:14:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7D33020FB09; Tue, 21 Nov 2006 15:15:05 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Nov 21, 2006 at 07:39:35AM CET, Shawn Pearce wrote:
> > I think there's a number of issues that are keeping people from
> > switching to Git and are instead causing them to choose SVN, hg
> > or Monotone:
> > 
> >   - No GUI.
> 
> It has been my impression that Git's situation is far better than in
> case of the other systems (except SVN: TortoiseSVN and RapidSVN). Is
> that not so?

Hmm.

hg has a browser (hgk).  Its a direct port of gitk.  I don't see
a GUI otherwise, such as qgit or git-gui.  They do however have a
Windows installer.

Monotone has mtsh and guitone.  Neither appear to be as far along
as say qgit or even git-gui, which isn't that far along at all.

So I guess you are right.  Git's situation is better than that
of hg or Monotone.  Now if only I can finish everything I want
to put into git-gui, and get it included as part of the core Git
distribution.  :)

-- 
