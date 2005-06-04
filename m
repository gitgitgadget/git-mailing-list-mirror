From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Use correct U*MAX.
Date: Sat, 4 Jun 2005 02:00:42 +0200
Message-ID: <20050604000042.GG13093@pasky.ji.cz>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net> <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net> <7vwtpc7lju.fsf_-_@assigned-by-dhcp.cox.net> <20050603230234.GC13093@pasky.ji.cz> <7v4qcfko0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 01:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeM2g-0001Da-RF
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 01:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFDAAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFDAAq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 20:00:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37357 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261180AbVFDAAo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 20:00:44 -0400
Received: (qmail 6326 invoked by uid 2001); 4 Jun 2005 00:00:42 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4qcfko0q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 04, 2005 at 01:40:21AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I'd rather see it use the correct U*MAX.

Care to elaborate? It doesn't make sense to me to use any U*MAX stuff
there whatsoever. (And how do you define the "correct" U*MAX anyway?)

P.S.: Could you please always keep at least some context in the mail?
Thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
