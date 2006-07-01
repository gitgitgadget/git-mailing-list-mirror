From: Petr Baudis <pasky@suse.cz>
Subject: [POOL] Who likes running Git without make install?
Date: Sun, 2 Jul 2006 01:59:06 +0200
Message-ID: <20060701235906.GE29115@pasky.or.cz>
References: <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org> <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net> <20060625010202.GX21864@pasky.or.cz> <20060625014009.GA21864@pasky.or.cz> <7vac82q6mb.fsf@assigned-by-dhcp.cox.net> <20060625152157.GG21864@pasky.or.cz> <7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 01:59:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwpMn-0002OT-9F
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWGAX7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGAX7J
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:59:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2276 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964866AbWGAX7I (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:59:08 -0400
Received: (qmail 4371 invoked by uid 2001); 2 Jul 2006 01:59:06 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23084>

Dear diary, on Mon, Jun 26, 2006 at 08:48:31AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I remember myself getting utterly discusted when I saw the
> inclusion of the build-time blib directory in the search path in
> some other Perl code outside git.

Well, yes, it is ugly, but it was really cool that we could have used
Git without installing it anywhere.

But perhaps that's just me refusing to break his old ways of doing
things. Does anyone else care about it? (And why?)

> Worse yet, I suspect the order you do the two directories is
> wrong to prefer the freshly built one over the one you installed
> the last time, but I was trying not to stare at too much for
> health reasons so ... ;-).

Oh man, of course you are right. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
