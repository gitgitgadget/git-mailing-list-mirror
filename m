From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 20:45:36 +0200
Message-ID: <20070630184536.GW12721@planck.djpig.de>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site> <200706300539.l5U5dHLh003989@mi1.bluebottle.com> <Pine.LNX.4.64.0706301644190.4438@racer.site> <20070630163823.GT12721@planck.djpig.de> <Pine.LNX.4.64.0706301847370.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hx9-0001j5-5y
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbXF3Spt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXF3Spt
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:45:49 -0400
Received: from planck.djpig.de ([85.10.192.180]:4426 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbXF3Spt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:45:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id BBC5088105;
	Sat, 30 Jun 2007 20:45:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmCsACieGN4M; Sat, 30 Jun 2007 20:45:37 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id D6AB7881B4; Sat, 30 Jun 2007 20:45:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706301847370.4438@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51243>

On Sat, Jun 30, 2007 at 06:48:27PM +0100, Johannes Schindelin wrote:
> On Sat, 30 Jun 2007, Frank Lichtenheld wrote:
> > On Sat, Jun 30, 2007 at 04:44:39PM +0100, Johannes Schindelin wrote:
> > > +Author
> > > +------
> > > +Written by Johannes E. Schindelin <johannes.schindelin@gmx.de>
> > 
> > AFAICT "Author" is usually used for the author of the documented program
> > and "Documentation" for the author of the documentation itself.
> 
> Oh? If that is so, please disregard this hunk.

Documentation$ grep -B2 -i "\(written\|documentation\) by" *.txt

seems to suggest that I'm right.

> Although in that case, git-bundle.txt is misattributed.

Indeed.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
