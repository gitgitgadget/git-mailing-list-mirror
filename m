From: Petr Baudis <pasky@ucw.cz>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 02:59:55 +0200
Message-ID: <20050418005955.GG1461@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <1113780698.11910.8.camel@localhost.localdomain> <20050417233936.GV1461@pasky.ji.cz> <1113782805.11910.36.camel@localhost.localdomain> <20050418003526.GD1461@pasky.ji.cz> <1113785123.11910.43.camel@localhost.localdomain> <20050418005032.GE1461@pasky.ji.cz> <1113785521.11910.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:56:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKYX-0003Bb-0w
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDRA75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVDRA75
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:59:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23707 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261384AbVDRA74 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 20:59:56 -0400
Received: (qmail 4143 invoked by uid 2001); 18 Apr 2005 00:59:55 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113785521.11910.45.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 02:51:59AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Mon, 2005-04-18 at 02:50 +0200, Petr Baudis wrote:
> > I think I will make git-pasky's default behaviour (when we get
> > http-pull, that is) to keep the complete commit history but only trees
> > you need/want; togglable to both sides.
> 
> I think the default behaviour should probably be to fetch everything.

I think fetching gigs of data just won't work for many people,
especially if they could do with a fraction of that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
