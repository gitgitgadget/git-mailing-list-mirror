From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-name-rev off-by-one bug
Date: Thu, 1 Dec 2005 22:50:39 +0100
Message-ID: <20051201215039.GX22159@pasky.or.cz>
References: <20051128234256.1508.qmail@science.horizon.com> <7vd5khjf9g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 22:54:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwK2-0002lH-5U
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVLAVub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLAVub
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:50:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:41943 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932496AbVLAVua (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 16:50:30 -0500
Received: (qmail 18601 invoked by uid 2001); 1 Dec 2005 22:50:39 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5khjf9g.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13077>

Dear diary, on Thu, Dec 01, 2005 at 11:14:19AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Speaking of shell gotchas, I do not know what the resolution was
> on the problem Merlyn was having the other day in "lost again on
> syntax change - local repository?" thread, which seemed that the
> failure described in <868xv86dam.fsf@blue.stonehenge.com> was
> his bash mishandling an if..then..elif..else..fi chain, which
> was sort of unexpected for me.  I was curious but do not
> remember seeing the conclusion.  Pasky, what happened to that
> thread?

I'm still perplexed and curious about what _did_ git-send-pack actually
receive as URL, since it apparnetly decided it's ssh as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
