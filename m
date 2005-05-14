From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sun, 15 May 2005 01:35:38 +0200
Message-ID: <20050514233538.GY3905@pasky.ji.cz>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <20050513224529.GF32232@pasky.ji.cz> <7vhdh691gs.fsf@assigned-by-dhcp.cox.net> <20050513233354.GK32232@pasky.ji.cz> <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net> <7voebe63zs.fsf@assigned-by-dhcp.cox.net> <20050514150356.GK3905@pasky.ji.cz> <7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 01:36:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DX6Ay-0005FX-CX
	for gcvg-git@gmane.org; Sun, 15 May 2005 01:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVENXf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVENXf4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 19:35:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21667 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261372AbVENXfm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 19:35:42 -0400
Received: (qmail 12447 invoked by uid 2001); 14 May 2005 23:35:38 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 06:27:27PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> Now I understand which discussion I was missing ;-).
> 
> PB> For humans I'd say "Mode change" instead of "mode" would be better, and
> PB> for machines I still think "@" would be better than "#". "#" can occur
> PB> quite naturally in some code snippets or whatever pasted to the commit
> PB> message, which is extremely unlikely for "@". What are the advantages
> PB> of "#"?
> 
> Wait a minute.  Aren't we scanning starting from the first
> '---\n'?  Why does what's in commit message matter?

Ok, that changes the whole situation. I'll take your patches as they are
now in that case. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
