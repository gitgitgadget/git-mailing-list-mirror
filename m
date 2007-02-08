From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] fast-import: Fix compile warnings
Date: Thu, 8 Feb 2007 02:16:03 -0500
Message-ID: <20070208071603.GB3746@spearce.org>
References: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070208070342.GA3746@spearce.org> <7vejp12kh5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF3W7-0007CP-ED
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030647AbXBHHQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 02:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030660AbXBHHQM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:16:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58762 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030647AbXBHHQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 02:16:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HF3Vm-0006Vg-3O; Thu, 08 Feb 2007 02:16:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 98A9520FBAE; Thu,  8 Feb 2007 02:16:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vejp12kh5.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39035>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > was the only part that did not apply cleanly, but that was easily
> > fixed by tossing an extra tab at the start of each line, as this
> > hunk was shifted in one level by a recent commit that Junio has
> > not pushed out to master.
> 
> Actually it has been pushed out quite a while ago, but as usual
> kernel.org is taking its sweet time to mirror it out.

Nice.  OK.  So don't pull in my repo.or.cz branch right now. :-)

-- 
Shawn.
