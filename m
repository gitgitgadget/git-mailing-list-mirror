From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 00:55:10 -0400
Message-ID: <20070720045510.GL32566@spearce.org>
References: <20070719125657.8utk85ynuow4ow48@webmail.tu-harburg.de> <Pine.LNX.4.64.0707191323510.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 20 06:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBkWt-0006M8-QU
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 06:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbXGTEzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 00:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXGTEzs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 00:55:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49330 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbXGTEzr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 00:55:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBkWP-00017O-R4; Fri, 20 Jul 2007 00:55:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 467F620FBAE; Fri, 20 Jul 2007 00:55:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707191323510.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53050>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 19 Jul 2007, Christian Stimming wrote:
> 
> > Does this implementation look okay?
> 
> This is valuable work, but unfortunately, it does not follow the 
> recommendation in Documentation/SubmittingPatches at all.
> 
> For starters, please send the patches inlined, one per mail.  And you 
> might want to Cc the maintainer of git-gui (Shawn Pearce), too...

I agree that internationalization of git-gui is worth doing.
I've thought about working on it, but haven't yet because nobody
else has seemed interested in having it done.  Apparently someone
is, so patches towards that end are most welcome.

-- 
Shawn.
