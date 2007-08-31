From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] filter-branch: provide the convenience functions
 also for commit filters
Date: Fri, 31 Aug 2007 22:10:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312209480.28586@racer.site>
References: <Pine.LNX.4.64.0708312005070.28586@racer.site>
 <7vzm07xvwa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDlZ-0007sV-DC
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760438AbXHaVKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760154AbXHaVKx
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:10:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:50597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759927AbXHaVKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:10:53 -0400
Received: (qmail invoked by alias); 31 Aug 2007 21:10:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 31 Aug 2007 23:10:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dRPILtjXdoJ9lF/8EIc+6bkuDIJV71yDppx3EbJ
	kvwGiUetbS67Oa
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm07xvwa.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57211>

Hi,

On Fri, 31 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Obviously, I think that these two changes are simple enough to be
> > 	included even this late in the game for 1.5.3.  But I understand
> > 	completely when people shout at me: "What exactly does deep
> > 	feature freeze mean to you *knocks on Dscho's head*?"
> 
> My response to those people who might shout is that this is merely a 
> step to complete a _new_ program that was not in _any_ released version 
> to make it feature complete.  You do not have to even pretend that 
> filter-branch did not exist before -- it actually didn't.  The new part 
> might be buggier than other parts, but that's the same way as any other 
> software development process.  If the new 'map' does not work as 
> advertised there is always 1.5.3.1.

Thank you for your encouraging words.

And yes, if there are bugs, I will be more than happy to fix them; and a 
released version always gets more eyes than an unreleased one.

Thanks,
Dscho
