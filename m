From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] prune: --expire=time
Date: Mon, 22 Jan 2007 01:57:45 -0500
Message-ID: <20070122065745.GA4669@spearce.org>
References: <7vejpo39zg.fsf@assigned-by-dhcp.cox.net> <20070121220114.GA24729@coredump.intra.peff.net> <45B415B1.30407@midwinter.com> <20070122015252.GA26934@coredump.intra.peff.net> <7vwt3fx1am.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701211813410.14248@woody.osdl.org> <7virezwzpz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701211851310.14248@woody.osdl.org> <7v3b63wsh3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701212137370.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 07:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8t81-00065X-SM
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 07:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXAVG5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 01:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXAVG5x
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 01:57:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39685 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbXAVG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 01:57:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H8t7j-0006NW-9f; Mon, 22 Jan 2007 01:57:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 16D5620FBAE; Mon, 22 Jan 2007 01:57:45 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701212137370.14248@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37399>

Linus Torvalds <torvalds@osdl.org> wrote:
> Add my sign-off on the patch as appropriate. I do think it's mergeable, 
> but I'd _really_ like somebody else to double-check me here.

Your patch looks right to me.  And I like the idea of reducing the
output to only the really important stuff.  Nice work.

-- 
Shawn.
