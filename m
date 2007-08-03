From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Thu, 2 Aug 2007 23:01:01 -0400
Message-ID: <20070803030101.GI20052@spearce.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 05:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGnPn-0000gs-NV
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 05:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbXHCDBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 23:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbXHCDBH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 23:01:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56548 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbXHCDBG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 23:01:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGnPH-0005Hm-Lq; Thu, 02 Aug 2007 23:00:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 07FBA20FBAE; Thu,  2 Aug 2007 23:01:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <107BD473-E055-47D0-9720-9D878BDAB954@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54662>

Steffen Prohaska <prohaska@zib.de> wrote:
> Maybe, this would be sufficient. I mentioned the pop-up explicitly
> because it wasn't obvious to me right away. The reason might be that
> my brain adjusted too much to the Mac I'm using. Right-clicking and
> pop-ups are rarely used on Macs as the only access point to essential
> features, such as selectively staging diff hunks. Typically an icon
> or menu entry guides you explicitly to every feature. Pop-ups are only
> used for 'optimized' access but never as the only access point.

Steffen, you seem to be more in-tune with the Mac UI standards
than I am.  Any suggestions on what I can do in git-gui to make
this feature more obvious to users?

I myself use a Mac OS X based PowerBook as my primary development
system, but I have to admit, I'm not the best GUI developer that has
ever walked on this planet.  Far far far from it.  I get by, if that.
The fact that git-gui is even usable by mortals is a minor miracle.

So I'd really love to do better.  But frankly I'm at a loss here
and just don't know what sort of change to make.


Side note: Someone recently asked me how to move individual files
to the left side of the UI (to stage them).  Apparently this person
had been using git-gui for months by just clicking "Add Existing"
(recently renamed to "Stage Changed").  It never occurred to the
user to try clicking the file's individual icons.  Or to select
the files they were interested in and look for a menu option that
might work on that selection.

-- 
Shawn.
