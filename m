From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 20:04:03 -0400
Message-ID: <20060911000403.GB28927@spearce.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <20060908184215.31789.qmail@science.horizon.com> <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com> <17668.2019.732961.855446@cargo.ozlabs.ibm.com> <9e4733910609100756r1ece1e22m38054536a2909dd4@mail.gmail.com> <7v1wqjsgfx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 02:04:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMZHZ-0007lS-C1
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 02:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWIKAEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 20:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWIKAEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 20:04:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:29878 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964838AbWIKAEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 20:04:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GMZHH-0004bJ-Od; Sun, 10 Sep 2006 20:03:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F27A120FB33; Sun, 10 Sep 2006 20:04:03 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wqjsgfx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26823>

Junio C Hamano <junkio@cox.net> wrote:
> We could benefit from the suggested organization of one base
> archive pack plus a current active pack.  The core side code to
> help doing so was posted here which followed a discussion on how
> to have repack make use of it last week.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/26218/focus=26326
> 
> Any takers?

I thought this was settled and you had it implemented?  Is this
still an open topic?

-- 
Shawn.
