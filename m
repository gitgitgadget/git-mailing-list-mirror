From: Petr Baudis <pasky@ucw.cz>
Subject: Re: change of git-diff-tree and symlinks
Date: Sun, 29 May 2005 23:32:06 +0200
Message-ID: <20050529213206.GR1036@pasky.ji.cz>
References: <20050525111711.GA27492@vrfy.org> <4299CED5.5070508@roemling.net> <20050529150656.GA27127@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jochen Roemling <jochen@roemling.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 23:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcVM6-0005ox-My
	for gcvg-git@gmane.org; Sun, 29 May 2005 23:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVE2VcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVE2VcN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 17:32:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46211 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261441AbVE2VcI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 17:32:08 -0400
Received: (qmail 30237 invoked by uid 2001); 29 May 2005 21:32:06 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050529150656.GA27127@vrfy.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 05:06:56PM CEST, I got a letter
where Kay Sievers <kay.sievers@vrfy.org> told me that...
> On Sun, May 29, 2005 at 04:16:53PM +0200, Jochen Roemling wrote:
> > I'm planning to use cogito/git for tracking development of my (PHP 
> > based) website. Although this is the first time in my life I'm using 
> > something that smells like a SCM, it seems to work great. The only thing 
> > lacking is a working gitweb installation.
> > I downloaded the gitweb.cgi script from 
> > kernel.org/pub/software/scm/gitweb, but it dates already May 23rd.
> > 
> > In your mail below from May 25 you state that there have been quite some 
> > changes to git-diff-tree:
> > 
> > Kay Sievers wrote:
> > >
> > >The new one shows simply nothing.
> > >Shouldn't it print the mode changes like the old one?
> > >
> > and that might be the reason why I'm getting "nothing" when I'm clicking 
> > on a "commitdiff" link.
> 
> The kernel.org servers use Cogito which needs a new release. So the
> version on kernel.org is always a working version with the current
> release of Cogito as long as we don't get a git-core to provide the
> binaries.

Tomorrow evening. I'd even do it now but I feel the changes need a bit
of testing yet.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
