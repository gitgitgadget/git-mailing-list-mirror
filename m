From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-daemon server
Date: Sat, 4 Jun 2005 00:39:50 +0200
Message-ID: <20050603223950.GA13093@pasky.ji.cz>
References: <Pine.LNX.4.21.0506031727400.30848-100000@iabervon.org> <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:37:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeKmy-0003Sj-MR
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 00:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFCWkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 18:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVFCWkH
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 18:40:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4076 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261155AbVFCWj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 18:39:58 -0400
Received: (qmail 32284 invoked by uid 2001); 3 Jun 2005 22:39:50 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jun 03, 2005 at 11:59:38PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Anyway, I have to admit that at least as far as I'm concerned, the 
> rpull/rpush thing has the same issues as Jason's code - I've not seen the 
> usage documented anywhere, and that's the only real reason I don't use it 
> myself.

FWIW, Cogito's cg-pull can use rpull/rpush (if your branch URLs use the
git+ssh scheme), and I've seen people actually using it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
