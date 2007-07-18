From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 21:52:10 -0400
Message-ID: <20070718015210.GS32566@spearce.org>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk> <20070717212103.11950.10363.julian@quantumfyre.co.uk> <20070717214011.GU19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 03:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAyiB-00069K-E5
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 03:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbXGRBwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 21:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756479AbXGRBwQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 21:52:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48150 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbXGRBwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 21:52:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAyhs-0004T9-F5; Tue, 17 Jul 2007 21:52:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67D0420FBAE; Tue, 17 Jul 2007 21:52:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070717214011.GU19073@lavos.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52818>

Brian Downing <bdowning@lavos.net> wrote:
> Can we handle versions with '-dirty' at the end as well, or is this
> ill-advised?  For some reason when I build my hacked-up personal debian
> packages it usually winds up:
> 
> :; git --version
> git version 1.5.3.GIT-dirty
> 
> and I haven't bothered to find out why.

Already fixed.  Please get the latest version of git-gui...

-- 
Shawn.
