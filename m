From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Sat, 23 Apr 2005 00:43:58 +0200
Message-ID: <20050422224358.GF21204@pasky.ji.cz>
References: <200504221442.29488.rhys@rhyshardwick.co.uk> <200504221554.04749.rhys@rhyshardwick.co.uk> <1114183357.29271.31.camel@nosferatu.lan> <200504221624.27769.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:39:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6o1-0001ym-WE
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDVWoC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDVWoC
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:44:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60065 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261260AbVDVWn7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:43:59 -0400
Received: (qmail 25147 invoked by uid 2001); 22 Apr 2005 22:43:58 -0000
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Content-Disposition: inline
In-Reply-To: <200504221624.27769.rhys@rhyshardwick.co.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 05:24:27PM CEST, I got a letter
where Rhys Hardwick <rhys@rhyshardwick.co.uk> told me that...
> > Seems your /bin/sh do not support 'echo -e' ... Know what provides
> > your /bin/sh (I think ash at least do support it)?
> >
> > Petr, I think you should really start to consider going full bash?
> 
> I use dash...

FYI, I've succumbed to the real world out there and switched the whole
thing to use bash.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
