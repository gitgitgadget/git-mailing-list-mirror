From: Petr Baudis <pasky@ucw.cz>
Subject: Re: SSH pull problems
Date: Sun, 5 Jun 2005 19:50:41 +0200
Message-ID: <20050605175041.GG17462@pasky.ji.cz>
References: <42A1A716.9030304@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:47:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezDW-0004Vh-2F
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVFERus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVFERus
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:50:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47006 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261598AbVFERuo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 13:50:44 -0400
Received: (qmail 15385 invoked by uid 2001); 5 Jun 2005 17:50:41 -0000
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <42A1A716.9030304@gorzow.mm.pl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 04, 2005 at 03:05:26PM CEST, I got a letter
where Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> told me that...
> I had some problems today with git+ssh protocol.
> First, when using cg-clone, it couldn't execute cg-rpush, although it's
> there in /usr/local.
> Maybe that has something to do with that being added to the path in
> /etc/profile.
> 
> Second, I don't know how to specify the port number,
> the typical notation of git+ssh://xyz:port/repo didn't work.
> 
> Anybody knows what to do with these?
> SSH would be very useful for me if it worked right.

If you are staying at the Cogito's tip, there was an incompatible
protocol change introduced recently, so make sure you have the same
Cogito version on both sides.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
