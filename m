From: Petr Baudis <pasky@suse.cz>
Subject: Re: branching and supporting a tagged kernel version
Date: Tue, 13 Dec 2005 01:01:41 +0100
Message-ID: <20051213000140.GZ22159@pasky.or.cz>
References: <68948ca0512121331x13bfb691t62224d02ced04a27@mail.gmail.com> <7virtueycd.fsf@assigned-by-dhcp.cox.net> <68948ca0512121558s6e300103t95fcc0e9573604a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:03:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elxc3-0006YT-AP
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 01:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVLMABp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLMABo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 19:01:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49087 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932321AbVLMABo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 19:01:44 -0500
Received: (qmail 4407 invoked by uid 2001); 13 Dec 2005 01:01:41 +0100
To: Don Zickus <dzickus@gmail.com>
Content-Disposition: inline
In-Reply-To: <68948ca0512121558s6e300103t95fcc0e9573604a7@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13548>

Dear diary, on Tue, Dec 13, 2005 at 12:58:38AM CET, I got a letter
where Don Zickus <dzickus@gmail.com> said that...
> Thanks for clearing things up.
> 
> > I'll refrain from saying that it is not the usual way to work
> > with git, since you seem to know what you are doing.  So let's
> 
> Either this or cvs. :)  Anyway my work involves releasing a platform
> to customers who don't want  to constantly upgrade their kernel.  And
> instead of waiting for bugs to be filed, I was just trying to find a
> way to be pro-active and fix certain bugs _before_ our customers hit
> them.

You might also consider managing your patches in StGIT, which could give
you more comfort for managing them. StGIT provides quilt-like
functionality on top of GIT, and it's easy to reorder, add, and remove
patches, as well as submit them to the upstream and remove them
automatically when they get merged.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
