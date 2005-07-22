From: Petr Baudis <pasky@suse.cz>
Subject: Re: Should cg-mkpatch output be usable with cg-patch?
Date: Fri, 22 Jul 2005 23:02:25 +0200
Message-ID: <20050722210225.GF11916@pasky.ji.cz>
References: <20050720234904.B3ED735267C@atlas.denx.de> <7vackgerpe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:09:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4fP-0005Py-HK
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVGVVC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVGVVC2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:02:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3591 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262172AbVGVVC1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:02:27 -0400
Received: (qmail 24611 invoked by uid 2001); 22 Jul 2005 21:02:25 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vackgerpe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 21, 2005 at 05:57:49AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I only briefly looked at cg-patch, but I suspect that it can
> lose 90% lines of its code by just using "git-apply --index".

Can git-apply already deal with fuzzy patches?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
