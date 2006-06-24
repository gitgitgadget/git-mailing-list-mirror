From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] GIT user survey
Date: Sun, 25 Jun 2006 00:09:04 +0200
Message-ID: <20060624220904.GW21864@pasky.or.cz>
References: <4d8e3fd30606240918m6b452314m6514b5e5fc86f147@mail.gmail.com> <86ac82bi1u.fsf@blue.stonehenge.com> <4d8e3fd30606241008w6cf9e6c0hf230ff1091194a7c@mail.gmail.com> <863bduba81.fsf@blue.stonehenge.com> <20060624200401.GV21864@pasky.or.cz> <Pine.LNX.4.64.0606241344450.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 00:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuGJb-0002xz-UG
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWFXWJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 18:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFXWJH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 18:09:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39304 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751115AbWFXWJG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 18:09:06 -0400
Received: (qmail 20912 invoked by uid 2001); 25 Jun 2006 00:09:04 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606241344450.6483@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22550>

Dear diary, on Sat, Jun 24, 2006 at 10:52:04PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> Pasky, the homepage seems a bit pointless. Each individual page is so 
> small that splitting it up into six different pages is just 
> counter-productive.

Wow, finally some more feedback on the homepage!

> I'd almost suggest making it _one_ page, perhaps with some shortcuts 
> within it (ie a "http://git.or.cz/index.html#tools" shortcut within the 
> page instead of having a separate "http://git.or.cz/tools.html" page)

Good point. When designing the multi-page layout I expected much more
stuff to end up on the homepage but it sort of didn't happen and now the
Wiki seems to work pretty well, so I have folded it all back to a single
page. I ain't no webdesign-ka but it could've turned out worse; as
usual, I'm taking patches.

The menubar should be now actually useful for quick navigation between
various Git-related resources (going to Git's gitweb using this path
should be much faster than over kernel.org, especially when gitweb.cgi
has its bad days over there).

> I don't know about everybody else, but I get irritated at webpages that 
> force me to just switch to another page to get any information. It's like 
> how some web journalists split up a story over 20 pages, and each page is 
> just a few paragraphs and some graphic (and the commercials, of course).

We could put up some commercials as well and use them for funding pizza
distributed in a round-robin fashion between the developers.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
