From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 4 May 2008 18:04:25 -0400
Message-ID: <20080504220425.GI29038@spearce.org>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon May 05 00:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmKb-0003AY-VX
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 00:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbYEDWE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 18:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbYEDWE3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 18:04:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44090 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYEDWE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 18:04:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JsmJe-0003ri-3W; Sun, 04 May 2008 18:04:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7E8F520FBAE; Sun,  4 May 2008 18:04:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <86skwxd97d.fsf@blue.stonehenge.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81205>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >> 
> >> # On branch master
> >> # Untracked files:
> >> #   (use "git add <file>..." to include in what will be committed)
> >> #
> >> #       "gitweb/test/Ma\314\210rchen"
> >> nothing added to commit but untracked files present (use "git add" to track)
> 
> Shawn> Isn't this just the normal HFS+ name mangling?
> 
> I don't recall having this problem on HFS+.

Everyone has this problem on HFS+.  :-|
 
> But, oh, it's because my git.git is on a UFS partition.  So UFS works
> fine.  Why shouldn't ZFS (which will be closer to UFS than HFS+)
> be the same?

Because Apple is Apple and things must be done The Apple Way(tm),
or no black turtleneck for you?

-- 
Shawn.
