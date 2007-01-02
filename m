From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: A note from the maintainer
Date: Mon, 1 Jan 2007 22:47:46 -0500
Message-ID: <20070102034746.GB27690@spearce.org>
References: <7v4pra14ve.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 04:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ad2-0003e0-DQ
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 04:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXABDrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 22:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755249AbXABDrx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 22:47:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44436 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbXABDrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 22:47:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1acl-00061n-MM; Mon, 01 Jan 2007 22:47:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C753720FB65; Mon,  1 Jan 2007 22:47:46 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pra14ve.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35769>

Junio C Hamano <junkio@cox.net> wrote:
> I usually read all patches posted to the list, and follow almost
> all the discussions on the list, unless the topic is about an
> obscure corner that I do not personally use.  But I am obviously
> not perfect.  If you sent a patch that you did not hear from
> anybody for three days, that is a very good indication that it
> was dropped on the floor --- please do not hesitate to remind
> me.

Though a contributor should probably check the `maint`, `master`,
`next` or `pu` branches of git.git before sending a reminder.

Often we find that you have accepted a patch without comment (as
the patch is obviously correct and nobody else had a reason to
comment on it).  In this case the patch will just appear in one of
the git.git branches, with no email indicating that.

-- 
Shawn.
