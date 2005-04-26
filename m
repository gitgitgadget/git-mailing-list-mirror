From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cogito recursive cg-add and cg-rm
Date: Tue, 26 Apr 2005 14:39:01 +0200
Message-ID: <20050426123901.GF18971@pasky.ji.cz>
References: <200504260027.03451.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 14:35:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQPGI-0007ik-TU
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 14:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVDZMjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 08:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDZMjF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 08:39:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60806 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261411AbVDZMjC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 08:39:02 -0400
Received: (qmail 30592 invoked by uid 2001); 26 Apr 2005 12:39:01 -0000
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
Content-Disposition: inline
In-Reply-To: <200504260027.03451.jcorbin@wunjo.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 06:27:02AM CEST, I got a letter
where "Joshua T. Corbin" <jcorbin@wunjo.org> told me that...
> This patch adds recursive addition and removal to cg-add and cg-rm, recursion 
> can be disabled with the -n switch.
> 
> Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

I'd actually prefer -r to explicitly turn the recursion on. That is more
consistent with the rest of the UNIX world and I really don't feel
comfortable with cg-rm recursing by default. ;-)

Also please use tabs for indentation.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
