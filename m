From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merging git-p4 into git/fastimport.git (second try)
Date: Fri, 22 Jun 2007 19:20:02 -0400
Message-ID: <20070622232002.GJ17393@spearce.org>
References: <200706190036.01950.simon@lst.de> <20070618230018.GA6143@spearce.org> <200706190842.13175.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 01:20:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1sQW-0005CI-Bo
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbXFVXUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 19:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbXFVXUK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 19:20:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48967 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbXFVXUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 19:20:09 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1sQ1-0002j4-PN; Fri, 22 Jun 2007 19:19:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A8C3F20FBAE; Fri, 22 Jun 2007 19:20:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706190842.13175.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50715>

Simon Hausmann <simon@lst.de> wrote:
> Why not just leave out the entire lot of git-p4 logs in "What's in git.git" 
> this one time? I'm not sure of how much value it is at this point anyway. I'm 
> just interested in preserving the history to ease debugging.

Yeah, maybe a good idea.  That's now up to Junio.  I just pulled
your git-p4 branch into my fastimport, and republished it.

-- 
Shawn.
