From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Fri, 13 May 2005 07:44:24 +0200
Message-ID: <20050513054424.GG16464@pasky.ji.cz>
References: <20050512205735.GE5914@waste.org> <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 07:37:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWSr1-0001KX-UJ
	for gcvg-git@gmane.org; Fri, 13 May 2005 07:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVEMFoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 01:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVEMFoh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 01:44:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22501 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262248AbVEMFo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 01:44:26 -0400
Received: (qmail 23604 invoked by uid 2001); 13 May 2005 05:44:24 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 11:24:27PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> In the present mainline, you first have to find the head commit you
> want. I have a patch which does this for you over the same
> connection. Starting from that point, it tracks reachability on the
> receiving end, and requests anything it doesn't have.

Could we get the patch, please? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
