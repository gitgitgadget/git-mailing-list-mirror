From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 05:29:41 +0200
Message-ID: <20050426032941.GR13467@pasky.ji.cz>
References: <20050426032422.GQ13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 05:25:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQGgy-0005Xe-Kb
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 05:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDZD3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 23:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVDZD3x
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 23:29:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28652 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261201AbVDZD3m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 23:29:42 -0400
Received: (qmail 6339 invoked by uid 2001); 26 Apr 2005 03:29:41 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 05:24:22AM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
>   here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
> history tracker. This package was formerly called git-pasky, however
> this release brings big changes. The usage is significantly different,
> as well as some basic concepts; the history changed again (hopefully the
> last time?) because of fixing dates of some old commits. The .git/
> directory layout changed too.

I forgot to mention that you should really only upgrade if you feel
brave and are willing to do some testing; it is likely there are some
new bugs introduced by the renaming, some leftovers of the original
git-pasky stuff in some not-so-frequently called scripts, etc. I will
see how many bug reports will we get and how fast will the bugcount
drop; if things won't stabilize very quickly, I might release
git-pasky-0.7.1 with few obvious bugfixes.

(And don't write announcements at 4am.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
