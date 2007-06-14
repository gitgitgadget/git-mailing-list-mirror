From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: That improved git-gui blame viewer..
Date: Thu, 14 Jun 2007 01:17:54 -0400
Message-ID: <20070614051754.GZ6073@spearce.org>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org> <Pine.LNX.4.64.0706131553390.4059@racer.site> <200706131827.08163.Josef.Weidendorfer@gmx.de> <200706131854.59605.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 07:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyhil-0004KL-5V
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 07:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbXFNFSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 01:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbXFNFSF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 01:18:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55079 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbXFNFSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 01:18:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HyhiW-0003O8-Nj; Thu, 14 Jun 2007 01:17:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7BB2820FBAE; Thu, 14 Jun 2007 01:17:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706131854.59605.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50166>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> I wished git-gui and gitk would be better integrated for
> history/blame browsing;

I'm not sure when/if git-gui and gitk will ever integrate.  It
looks like it would be a good bit of work.  ;-)

> I also missed a text search functionality
> in the blame view of git-gui.

That's on my list of things to do very-soon-now.  I'm hoping to
get it into the next release of git-gui, which should be 0.8.0,
and maybe will happen by early next week.

-- 
Shawn.
