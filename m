From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC (take 2) Git User's Survey 2007
Date: Mon, 30 Jul 2007 21:09:21 -0400
Message-ID: <20070731010921.GY20052@spearce.org>
References: <200707250358.58637.jnareb@gmail.com> <200707302256.38251.jnareb@gmail.com> <20070731003251.GW20052@spearce.org> <200707310245.56077.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFgEr-0001Je-4r
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 03:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938963AbXGaBJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 21:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937828AbXGaBJZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 21:09:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38267 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762250AbXGaBJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 21:09:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFgEa-0008Gi-2g; Mon, 30 Jul 2007 21:09:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA07B20FBAE; Mon, 30 Jul 2007 21:09:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707310245.56077.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54300>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > But I *seriously* object to calling egit a porcelain.  egit is a
> > complete reimplementation of git in Java.
> 
> O.K. I was not sure where to put egit (if put it at all). 
> Implementations? Currently we have core-git in C, egit in Java (what is 
> the progress report on this front?), and there was GSoC project of 
> Git.NET (but it didn't start I think).

Right, that's an accurate state of affairs.  Today egit can make
commits on the current branch.  Yay, progress.  :)
 
> Do you want question about egit in the survey?

Might be nice to know how many people are interested in the
Eclipse plugin.  But aside from that, I don't think its worth
including much about it.  Maybe just have a checkbox under
some heading like:

  What features is Git currently missing for your needs?
  [ ] Eclipse plugin
  [ ] wizhbang foo thing
  [ ] Other:  ________________________

?

-- 
Shawn.
