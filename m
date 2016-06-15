From: Shawn Pearce <spearce@spearce.org>
Subject: Re: An early draft of v1.5.0 release notes (2nd ed)
Date: Wed, 27 Dec 2006 21:28:55 -0500
Message-ID: <20061228022855.GF16612@spearce.org>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net> <7vvejw3iaq.fsf@assigned-by-dhcp.cox.net> <20061228020305.GD16612@spearce.org> <7vmz583goc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 03:29:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzl0y-0006s2-EJ
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 03:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWL1C3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 21:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWL1C3A
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 21:29:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38689 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964888AbWL1C27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 21:28:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzl0o-0001dX-7m; Wed, 27 Dec 2006 21:28:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED7CD20FB65; Wed, 27 Dec 2006 21:28:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz583goc.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35512>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> 
> >> -- >8 --
> >> 
> >> Major changes that are not news
> >> -------------------------------
> >
> > If these major changes aren't news, what are they?
> 
> Exactly as described in the part you did not quote:
> 
>         There were a handful big changes that happened before this major
>         release.
> 
>         This section is for people who are upgrading from ancient
>         versions.
> 
> In other words, they are only to help people who were not paying
> enough attention to earlier releases.

OK, yet again I don't quite quote enough.  Or read enough.  ;-)
 
But maybe you can title the section

	Major changes since 1.2.x

?  Or whatever version preceeded when we started to add that stuff?

The section is really for those who are upgrading from ancient
versions, but the title of the section implies (at least to me)
that these changes aren't something important.

Just my (nearly worthless against the Euro) two US pennies...

-- 
Shawn.
