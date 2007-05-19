From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Documentation (mainly user-manual) patches
Date: Sat, 19 May 2007 00:02:12 -0400
Message-ID: <20070519040212.GC3141@spearce.org>
References: <20070518033746.GB30144@fieldses.org> <20070518045634.GU4489@pasky.or.cz> <20070518134316.GA21925@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat May 19 06:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpG9B-0005rj-8f
	for gcvg-git@gmane.org; Sat, 19 May 2007 06:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbXESECT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 00:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXESECT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 00:02:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57166 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbXESECS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 00:02:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HpG90-0002E8-J8; Sat, 19 May 2007 00:02:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD66B20FBAE; Sat, 19 May 2007 00:02:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070518134316.GA21925@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47709>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Fri, May 18, 2007 at 06:56:35AM +0200, Petr Baudis wrote:
> >   BTW, there is this nice git-request-pull tool which will prepare this
> > mail for you and additionally include the list of commits included in
> > that repository, which is somewhat more friendly to the readers (I
> > myself wondered). ;-)
> 
> OK!  I'll start including the shortlog.  Appended, if anyone's still
> curious about this one.--b.

request-pull also does nice things like include the fetch URL, and
the branch name, and in a nice format that makes it very easy to
copy and paste into a "git pull" (or "git fetch") command line[*1*],
so its slightly more than just the shortlog.  ;-)


[*1*] By popular demand from Git's creator.

-- 
Shawn.
