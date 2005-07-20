From: Petr Baudis <pasky@suse.cz>
Subject: Re: Why fetching latest kernel sources is failing?
Date: Wed, 20 Jul 2005 02:00:33 +0200
Message-ID: <20050720000033.GG2255@pasky.ji.cz>
References: <loom.20050713T182418-822@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 02:01:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv216-0007Z1-1a
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 02:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGTAAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 20:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGTAAm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 20:00:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16645 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261421AbVGTAAe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 20:00:34 -0400
Received: (qmail 8385 invoked by uid 2001); 20 Jul 2005 00:00:33 -0000
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Content-Disposition: inline
In-Reply-To: <loom.20050713T182418-822@post.gmane.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 13, 2005 at 07:22:22PM CEST, I got a letter
where "Paolo \\'Blaisorblade\\' Giarrusso" <blaisorblade@yahoo.it> told me that...
> cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Please use rsync, http is broken for the time being and not trivially
fixable (patches pending, though).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
