From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 22:43:57 +0200
Message-ID: <20050426204357.GN13224@pasky.ji.cz>
References: <20050426032422.GQ13467@pasky.ji.cz> <426DE78A.3050508@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:40:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWq5-0003wW-Hi
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVDZUoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVDZUoT
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:44:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19344 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261595AbVDZUn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:43:58 -0400
Received: (qmail 9617 invoked by uid 2001); 26 Apr 2005 20:43:57 -0000
To: Philip Pokorny <ppokorny@mindspring.com>
Content-Disposition: inline
In-Reply-To: <426DE78A.3050508@mindspring.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 09:02:34AM CEST, I got a letter
where Philip Pokorny <ppokorny@mindspring.com> told me that...
> Petr Baudis wrote:
> 
> >the history changed again (hopefully the
> >last time?) because of fixing dates of some old commits.
> >
> 
> Looks like the git-pasky-0.7 tags (and friends) are now dead links. For 
> example:
> 
> [philip@xray cogito]$ cg-mkpatch git-pasky-0.7:HEAD
> .git/objects/c8/3b95297c2a6336c2007548f909769e0862b509: No such file or 
> directory
> fatal: cat-file c83b95297c2a6336c2007548f909769e0862b509: bad file
> Invalid id: c83b95297c2a6336c2007548f909769e0862b509

Oops. Good catch, fixed. I actually just iterated cg-log. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
