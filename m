From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] Cogito-0.13
Date: Sat, 6 Aug 2005 20:30:22 +0200
Message-ID: <20050806183021.GA19050@pasky.ji.cz>
References: <42F2F51D.5040905@de.bosch.com> <42F3A6B1.1060605@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 20:33:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1TT5-0003pn-2Y
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 20:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbVHFSbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 14:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbVHFSbd
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 14:31:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47112 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263394AbVHFSaY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 14:30:24 -0400
Received: (qmail 19479 invoked by uid 2001); 6 Aug 2005 18:30:22 -0000
To: Dirk Behme <dirk.behme@de.bosch.com>
Content-Disposition: inline
In-Reply-To: <42F3A6B1.1060605@de.bosch.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 05, 2005 at 07:49:37PM CEST, I got a letter
where Dirk Behme <dirk.behme@de.bosch.com> told me that...
> Hi Petr,
> 
> Petr Baudis wrote:
> >  I'm happy to announce release 0.13 of the Cogito SCMish layer over the
> >GIT Tree History Storage tool. As usual, get it at:
> >
> >    http://www.kernel.org/pub/software/scm/cogito
> 
> Any plans to switch cogito (cg-pull) to curl only as well? As I
> understand it, git has already moved from wget to curl only.
> 
> http://marc.theaimsgroup.com/?l=git&m=112292041713192&w=2
> 
> For using cogito & git behind a firewall and http proxy which needs
> special authentication I think this is the only option. Unfortunately,
> wget and curl have different understandig how to get proxy user &
> password and therefore this doesn't work at the moment.

Cogito needs recursive download in order to pull patches. If you can
make curl do that, it would be cool.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
