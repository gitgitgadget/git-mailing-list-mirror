From: Petr Baudis <pasky@suse.cz>
Subject: Re: git/cogito workshop/bof at linuxconf au?
Date: Sun, 14 Aug 2005 11:54:22 +0200
Message-ID: <20050814095422.GQ5608@pasky.ji.cz>
References: <46a038f90508130034858ad34@mail.gmail.com> <Pine.LNX.4.58.0508131111270.19049@g5.osdl.org> <46a038f905081316056e83ebec@mail.gmail.com> <Pine.LNX.4.58.0508131625010.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>, vojtech@suse.cz
X-From: git-owner@vger.kernel.org Sun Aug 14 11:55:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4FCU-0000lN-95
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 11:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVHNJy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVHNJy1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 05:54:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32262 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932125AbVHNJy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 05:54:27 -0400
Received: (qmail 26170 invoked by uid 2001); 14 Aug 2005 09:54:22 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508131625010.3553@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Aug 14, 2005 at 01:33:53AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sun, 14 Aug 2005, Martin Langhoff wrote:
> > 
> > And how are things lining up for the upcoming one (January 2006, Dunedin, NZ)?  
> 
> Dunno yet. I have a policy of trying to travel with the whole family,
> which means I'll have to decide whether I'm willing to put that much money
> into it, or whether some poor unsuspecting company can help sponsor me ;)
> We'll see.

BTW, I've asked my unsuspecting company. I'll see too. ;-)

> > There's a lot of interest, but the barriers of entry are somewhat
> > high, with the codebase moving fast, and some of the concepts
> > requiring re-learning of what to expect from an SCM. Perhaps no so
> > much among kernel hackers, but the general populace is largely still
> > laden with cvs/svn and their mindset.
> 
> Yeah. We do not have a nice paper explaining the concepts and usage. The 
> tutorial isn't really in-depth enough (it doesn't even mention a lot of 
> the helper scripts or even some of the core stuff). The old README started 
> out explaining some of the concepts, but it's _way_ of out date in all 
> usage respects.
> 
> Pasky has the Overview thing, which gets pointed to by kernel.org, and 
> which could be expanded upon a lot. 

I wanted to offer a Git/Cogito tutorial session (Is that what is meant
by "workshop"? I'm no skilled conference traveller and the website
mentions no workshops.), but on a second thought paper might be better -
Cogito is supposed to be so simple to use that a tutorial wouldn't give
you much (except tutorial.txt since I would have a strong incentive to
write it), and Git concepts aren't tutorial material. So I might try to
apply with a paper giving some overview of the new wave of "modern"
version control systems, with a special focus on GIT design and core
interface. (I will probably skip the core GIT plumbing since I'm
naturally a bit sceptical about it. ;-)

I also imagined a BOF session for more interested people (if there would
be any), for discussing advanced topics, possible further development
directions (see also the Cogito TODO for also some Git-related stuff I
have on my mind but is not yet ready for mailing list bashing) etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
