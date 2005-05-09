From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Tue, 10 May 2005 01:02:11 +0200
Message-ID: <20050509230211.GD15712@pasky.ji.cz>
References: <20050509212842.GC15712@pasky.ji.cz> <Pine.LNX.4.44.0505091549210.2136-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	Git Mailing List <git@vger.kernel.org>,
	darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Tue May 10 00:55:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVH9Z-00038u-HH
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEIXCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 19:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVEIXCQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 19:02:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40844 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261311AbVEIXCN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 19:02:13 -0400
Received: (qmail 29320 invoked by uid 2001); 9 May 2005 23:02:11 -0000
To: Brad Roberts <braddr@puremagic.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0505091549210.2136-100000@bellevue.puremagic.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 10, 2005 at 12:50:33AM CEST, I got a letter
where Brad Roberts <braddr@puremagic.com> told me that...
> > >  - there's no way to have multiple simultaneous caches, short of
> > >    hacking at the values of Git's global variables by hand.
> >
> > See the Brad Robert's patches of Apr 21. I've decided not to apply them
> > since it appears a lot has changed since then and it would be some pain;
> > but they may be a worthy starting point for a more up-to-date patch.
> >
> > --
> > 				Petr "Pasky" Baudis
> 
> Since there's interest, I'll pull tip of your tree and re-do them.  I
> haven't bothered todate since no one seemed interested.  Do you want them
> piece meal like I did last time or just one big diff?

Piece meal would be excellent.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
