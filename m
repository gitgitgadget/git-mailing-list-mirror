From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: teach ls-tree how to handle names with embedded LF
Date: Thu, 14 Apr 2005 02:20:37 +0200
Message-ID: <20050414002037.GS25711@pasky.ji.cz>
References: <7vd5sytf94.fsf@assigned-by-dhcp.cox.net> <20050413235018.GQ25711@pasky.ji.cz> <7v7jj6tdq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 02:20:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLs5r-0004tr-2M
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 02:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDNAXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDNAXb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 20:23:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11450 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261248AbVDNAUl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 20:20:41 -0400
Received: (qmail 2080 invoked by uid 2001); 14 Apr 2005 00:20:37 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jj6tdq9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 02:15:58AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> Actually, what about just making it consistent with diff-tree and making
> PB> it always terminate the records with '\0'?
> 
> Sounds good to me.  I need '-z' for a script I am working on to
> generate data for incremental updates of object database.

I actually use ls-tree only in various one-shot hacks, so it's not an
issue for me neither.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
