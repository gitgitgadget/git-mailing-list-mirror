From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] ssh-protocol version, command types, response code
Date: Sat, 4 Jun 2005 00:49:29 +0200
Message-ID: <20050603224928.GB13093@pasky.ji.cz>
References: <Pine.LNX.4.21.0506031740020.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:47:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeKvu-0004A8-Gv
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 00:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFCWtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 18:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFCWtk
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 18:49:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26860 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261168AbVFCWtb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 18:49:31 -0400
Received: (qmail 6009 invoked by uid 2001); 3 Jun 2005 22:49:29 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0506031740020.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jun 03, 2005 at 11:43:52PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> This patch makes an incompatible change to the protocol used by
> rpull/rpush which will let it be extended in the future without
> incompatible changes. 
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

It looks fine by me. Linus? (I would really like to see this in.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
