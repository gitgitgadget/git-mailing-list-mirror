From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 4 May 2008 18:15:10 -0400
Message-ID: <20080504221510.GJ29038@spearce.org>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <20080504220425.GI29038@spearce.org> <86fxsxd8qy.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon May 05 00:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmV0-0006Fr-9W
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 00:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbYEDWPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 18:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbYEDWPO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 18:15:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49365 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbYEDWPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 18:15:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JsmU2-0005Pm-JQ; Sun, 04 May 2008 18:15:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4013C20FBAE; Sun,  4 May 2008 18:15:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <86fxsxd8qy.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81208>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Shawn" == Shawn O Pearce <spearce@spearce.org> writes:
> 
> Shawn> Because Apple is Apple and things must be done The Apple Way(tm),
> Shawn> or no black turtleneck for you?
> 
> So apparently the problem is known.
> Is it also understood?
> Is the solution understood, and just waiting for implementor tuits?

Yes, I think the issue has been beat to death here on the mailing
list by many parties.  Its more just an issue of someone writing
the code and finding the little implementation details that weren't
discussed yet.

-- 
Shawn.
