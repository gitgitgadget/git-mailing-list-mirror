From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito 0.12.1
Date: Wed, 20 Jul 2005 01:43:51 +0200
Message-ID: <20050719234351.GD2255@pasky.ji.cz>
References: <20050712010058.GE5981@pasky.ji.cz> <20050713081257.D19871@flint.arm.linux.org.uk> <tnxzmsrc61b.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 01:44:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv1kl-00065E-7C
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 01:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVGSXnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 19:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGSXnx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 19:43:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2565 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261625AbVGSXnx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 19:43:53 -0400
Received: (qmail 7025 invoked by uid 2001); 19 Jul 2005 23:43:51 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxzmsrc61b.fsf@arm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 13, 2005 at 01:13:52PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> Russell King <rmk@arm.linux.org.uk> wrote:
> > I won't bother trying to explain, I'll just paste the errors.  We've been
> > here before in a previous cogito revision.
> >
> > rmk@dyn-67:[linux-2.6-rmk]:<1038> cg-branch-ls
> > origin  ../linux-2.6
> > smp     ../linux-2.6-smp
> 
> I noticed that Cogito doesn't work well with relative paths. Run
> cg-branch-chg and put absolute paths, it might work (it did for me).

Yes, that's it. Will be fixed in Cogito-0.12.2 (or 0.13, whichever comes
first), thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
