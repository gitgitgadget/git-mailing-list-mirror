From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] GIT commit statistics.
Date: Sun, 13 Nov 2005 12:11:30 +0100
Message-ID: <20051113111130.GN30496@pasky.or.cz>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net> <43758D21.3060107@michonline.com> <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net> <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 12:12:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbFln-0003mG-Gt
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 12:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVKMLLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 06:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKMLLc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 06:11:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57760 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932400AbVKMLLc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 06:11:32 -0500
Received: (qmail 1737 invoked by uid 2001); 13 Nov 2005 12:11:30 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11734>

Dear diary, on Sat, Nov 12, 2005 at 01:19:45PM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> Similarly, when dealing with an upstream, my tree gets slowly out of
> sync and slightly messy.

I've been replying only to this, but missed the team shared repo case,
where StGIT obviously does not make much sense.

> Related to this, I've been wondering whether it'd be possible to teach
> git to rebase local patches, even if that means rewriting local
> history. When you are dealing with team shared repo, the sequences of
> pull/push end up being quite messy, full of little meaningless merges.

Well, only pulls make up for merges. But what's wrong with that? This is
just what you get when using distributed VCS, and what's the point in
skewing the history to look different than how did it happen? I'd just
get used to it. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
