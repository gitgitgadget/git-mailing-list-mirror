From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 02:40:27 -0500
Message-ID: <20070128074027.GB9781@spearce.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 08:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB4eT-00086a-Mx
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 08:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbXA1Hkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 02:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXA1Hkf
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 02:40:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54328 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbXA1Hke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 02:40:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HB4eK-00056H-7C; Sun, 28 Jan 2007 02:40:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F2F2A20FBAE; Sun, 28 Jan 2007 02:40:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38021>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Here's a patch. Use "git blame --incremental filename" to get the blame 
> output in a nicely parseable format that you can now write a simple 
> graphical viewer for. 

Heh.  Nice timing.  I was starting to think about adding blame output
to git-gui.  Having an incremental backend would certainly be nice.

-- 
Shawn.
