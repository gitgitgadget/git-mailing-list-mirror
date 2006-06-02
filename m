From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 22:56:44 -0400
Message-ID: <20060602025644.GA5181@spearce.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <1149204044.27695.38.camel@neko.keithp.com> <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com> <1149214075.5521.31.camel@neko.keithp.com> <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 04:56:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlzqG-0000nV-8g
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 04:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWFBC4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 22:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWFBC4t
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 22:56:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:9678 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751164AbWFBC4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 22:56:48 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Flzpy-0002ac-O6; Thu, 01 Jun 2006 22:56:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3E3420E445; Thu,  1 Jun 2006 22:56:44 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21137>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Did I see that you can use CVS client tools to manipulate a git
> repository? Mozilla has a lot of users on other OSes besides Linux. It
> would be nice to change the core server over to git and leave these
> other users running their existing tools.

Yes.  Look at git-cvsserver (ships standard as part of GIT).
It should also be faster than the original CVS server.  :-)

-- 
Shawn.
