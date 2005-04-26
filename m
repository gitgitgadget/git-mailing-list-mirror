From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cg-export to tarball
Date: Tue, 26 Apr 2005 22:20:14 +0200
Message-ID: <20050426202014.GJ13224@pasky.ji.cz>
References: <200504260312.46320.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:17:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWUD-0000Gx-4S
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVDZUVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVDZUVA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:21:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51855 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261575AbVDZUUU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:20:20 -0400
Received: (qmail 31124 invoked by uid 2001); 26 Apr 2005 20:20:14 -0000
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
Content-Disposition: inline
In-Reply-To: <200504260312.46320.jcorbin@wunjo.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 09:12:46AM CEST, I got a letter
where "Joshua T. Corbin" <jcorbin@wunjo.org> told me that...
> The following patch to cg-export will simlpy create a tarball if the argument 
> ends in .tar.gz, .tar.bz2, or .tar.
> 
> Signed-off-by; Joshua T. Corbin <jcorbin@wunjo.org>

What about cooperating with Rene Scharfe and using his tar-tree?
I didn't actually try it yet (not even look at the code so far),
it'd be cool if someone would give it some review and testing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
