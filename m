From: Petr Baudis <pasky@ucw.cz>
Subject: Re: RE: Date handling.
Date: Thu, 14 Apr 2005 21:46:26 +0200
Message-ID: <20050414194626.GB22699@pasky.ji.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMAHW-0002Z1-Ko
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDNTsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDNTsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:48:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10442 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261612AbVDNTq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 15:46:28 -0400
Received: (qmail 29828 invoked by uid 2001); 14 Apr 2005 19:46:26 -0000
To: "Luck, Tony" <tony.luck@intel.com>
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03457AE6@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 09:42:28PM CEST, I got a letter
where "Luck, Tony" <tony.luck@intel.com> told me that...
> >I'd prefer not to lose the information. If someone has committed a
> >change at 2am, I like to know that it was 2am for _them_. It helps me
> >decide where to look first for the cause of problems. :)
> 
> I'd think the 8:00am-before-the-first-coffee checkins would be the
> most worrying :-)
> 
> >It also helps disambiguate certain comments, especially those involving
> >words or phrases such as "yesterday" or "this afternoon".
> 
> This is a very good point ... but this still has problems with the
> "git is a filesystem, not a SCM" mantra.  Timezone comments don't
> belong in the git inode.

So, when commit is done in a given time of day, a "*YAWN*" line should
be automatically appended to the log message. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
