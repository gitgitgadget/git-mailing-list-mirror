From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Fri, 12 Aug 2005 03:26:10 +0200
Message-ID: <20050812012610.GN25280@pasky.ji.cz>
References: <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org> <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org> <20050712074801.GD6363@pasky.ji.cz> <Pine.LNX.4.58.0507120938240.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 03:27:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3OJZ-000635-Bh
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 03:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVHLB0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 21:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVHLB0Y
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 21:26:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57868 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932429AbVHLB0X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 21:26:23 -0400
Received: (qmail 4967 invoked by uid 2001); 12 Aug 2005 01:26:10 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507120938240.17536@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 12, 2005 at 06:48:50PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Then "cg-seek" and "cg-unseek" would continue to work, but the core git 
> layer would never be confused because they're really using normal 
> branches?

That makes sense, I just did exactly that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
