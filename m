From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-diff-cache: handle pathspec beginning with a dash
Date: Wed, 8 Jun 2005 22:06:12 +0200
Message-ID: <20050608200612.GM982@pasky.ji.cz>
References: <20050606212700.GA3498@diku.dk> <20050608184709.GE982@pasky.ji.cz> <Pine.LNX.4.58.0506081259580.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 22:05:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg6lW-0005io-55
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFHUGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 16:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVFHUGf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 16:06:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1761 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261584AbVFHUGS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:06:18 -0400
Received: (qmail 31878 invoked by uid 2001); 8 Jun 2005 20:06:12 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506081259580.2286@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jun 08, 2005 at 10:00:48PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Wed, 8 Jun 2005, Petr Baudis wrote:
> >
> > Dear diary, on Mon, Jun 06, 2005 at 11:27:00PM CEST, I got a letter
> > where Jonas Fonseca <fonseca@diku.dk> told me that...
> > > Parse everything after '--' as tree name or pathspec.
> > > 
> > > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > 
> > Thanks, applied to git-pb. Linus, any particular reason for holding this
> > off?
> 
> It seems to have gone only to the mailing list. I only glance through the 
> lists, and assume that if somebody wants me to apply a patch, they'll cc 
> me personally too..

I see. Jonas mentioned on IRC that he forgot to Cc' you. I'm usually
going through everything on the mailing list, so if some patch stays out
for few days I'll start nagging. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
