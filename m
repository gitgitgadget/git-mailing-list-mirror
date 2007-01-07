From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Moving initialization of log_all_ref_updates
Date: Sun, 7 Jan 2007 05:05:59 -0500
Message-ID: <20070107100559.GC10351@spearce.org>
References: <7vbqlb2nqe.fsf@assigned-by-dhcp.cox.net> <20070107093725.GB10351@spearce.org> <7v4pr32mcn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 11:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Uup-0000qV-Lj
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 11:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbXAGKGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbXAGKGG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 05:06:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53289 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbXAGKGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 05:06:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3Uuz-0003gN-HB; Sun, 07 Jan 2007 05:06:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 05BD820FB65; Sun,  7 Jan 2007 05:05:59 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pr32mcn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36147>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Do we want to consider having init-db/clone set core.bare based on
> > what they are being asked to do?
> 
> Here is what I have as a follow-up patch to the one you are
> responding to.

I like.  :-)

Worthy of 1.5.0 me thinks.

-- 
Shawn.
