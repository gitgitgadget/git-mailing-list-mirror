From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cogito cg-update fails
Date: Tue, 3 May 2005 08:46:33 +0200
Message-ID: <20050503064633.GA10244@pasky.ji.cz>
References: <1115090374.6030.50.camel@gaston> <200505022157.07800.elenstev@mesatop.com> <1115094227.6031.62.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Cole <elenstev@mesatop.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 08:40:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSr55-0001ky-OG
	for gcvg-git@gmane.org; Tue, 03 May 2005 08:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVECGqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 02:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVECGqk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 02:46:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5309 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261405AbVECGqf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 02:46:35 -0400
Received: (qmail 19099 invoked by uid 2001); 3 May 2005 06:46:33 -0000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <1115094227.6031.62.camel@gaston>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 06:23:46AM CEST, I got a letter
where Benjamin Herrenschmidt <benh@kernel.crashing.org> told me that...
> 
> > 
> > Yeah, I got exactly the same behavior a little while ago, but thanks
> > to www.kernel.org/git, I saw that the problem had been found and fixed.
> > 
> > I had an older backup copy of all the cogito scripts, so I used that to update.
> > 
> > I believe the fix is this patch:
> 
> Thanks, fixed it ! Current top of tree seem to be fine too.

Yes, sorry about this. I fixed it right away but then forgot to push it,
so it appears some people got it in the meantime. :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
