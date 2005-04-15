From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Sat, 16 Apr 2005 00:36:48 +0200
Message-ID: <20050415223648.GP7417@pasky.ji.cz>
References: <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <20050415185624.GB7417@pasky.ji.cz> <Pine.LNX.4.58.0504151212160.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 00:33:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMZNI-0001oT-SJ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 00:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVDOWgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 18:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVDOWgw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 18:36:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65250 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261991AbVDOWgu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 18:36:50 -0400
Received: (qmail 907 invoked by uid 2001); 15 Apr 2005 22:36:48 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504151212160.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 10:13:21PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Fri, 15 Apr 2005, Petr Baudis wrote:
> > 
> > So, I assume that you don't want to merge my "SCM layer" (which is
> > perfectly fine by me). However, I also apply plenty of patches
> > concerning the "core git" - be it portability, leak fixes, argument
> > parsing fixes and so on.
> 
> I'm actually perfectly happy to merge your SCM layer too eventually, but 
> I'm nervous at this point.  Especially while people are discussing some 
> SCM options that I'm personally very leery of, and think that may make 
> sense for others, but that I personally distrust.

You mean the renames tracking and similar yet mostly theoretical
discussions? Or do you dislike something already implemented? I'd be
happy to hear about it in that case. (To argue about it and likely get
persuaded... ;-)

But otherwise it is great news to me. Actually, in that case, is it
worth renaming it to Cogito and using cg to invoke it? Wouldn't be that
actually more confusing after it gets merged? IOW, should I stick to
"git" or feel free to rename it to "cg"?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
