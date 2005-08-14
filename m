From: Petr Baudis <pasky@suse.cz>
Subject: Re: sending changesets from the middle of a git tree
Date: Sun, 14 Aug 2005 11:27:57 +0200
Message-ID: <20050814092757.GP5608@pasky.ji.cz>
References: <42FEBC16.9050309@austin.rr.com> <Pine.LNX.4.58.0508132155100.3553@g5.osdl.org> <7vhddtdk86.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Aug 14 11:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Emw-0007zm-4f
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 11:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVHNJ2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 05:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVHNJ2D
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 05:28:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12294 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932427AbVHNJ2B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 05:28:01 -0400
Received: (qmail 24508 invoked by uid 2001); 14 Aug 2005 09:27:58 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhddtdk86.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Aug 14, 2005 at 09:57:13AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Linus Torvalds <torvalds@osdl.org> writes:
> > Alternatively, use "git cherry", which helps re-order the commits in your
> > tree. They'll be _new_ commits, but they'll have the contents moved over. 
> 
> > Junio, maybe you want to talk about how you move patches from your "pu" 
> > branch to the real branches.
> 
> As I have mentioned elsewhere, I have been trying not to use
> JIT, my own Porcelain, to make sure that the core-git barebone
> Porcelain is usable.
> 
> Unfortunately, this is one area in my workflow that I still
> heavily rely on JIT, because it is so handy.  I've kept saying I
> do not do Porcelain, but I'll make an exception this time, by
> invitation ;-).

Actually, wouldn't this be also precisely for what StGIT is intended to?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
