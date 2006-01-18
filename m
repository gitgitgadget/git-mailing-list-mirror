From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito wishlist: ability to set merge strategy
Date: Wed, 18 Jan 2006 20:32:01 +0100
Message-ID: <20060118193201.GV28365@pasky.or.cz>
References: <43CE5666.90502@itaapy.com> <43CE75F0.4060009@op5.se> <7vlkxdwhs6.fsf@assigned-by-dhcp.cox.net> <46a038f90601181006u40a1f8e1n47c27651a4cab3d@mail.gmail.com> <43CC64AD.30606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 18 20:31:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzJ1B-0003lD-92
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 20:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWARTav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWARTav
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 14:30:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56200 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964916AbWARTau (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 14:30:50 -0500
Received: (qmail 28546 invoked by uid 2001); 18 Jan 2006 20:32:01 +0100
To: "H. Peter Anvin" <hpa@zytor.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90601181006u40a1f8e1n47c27651a4cab3d@mail.gmail.com> <43CC64AD.30606@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14862>

Dear diary, on Tue, Jan 17, 2006 at 04:29:49AM CET, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> It would be nice if Cogito would let one override the default merge 
> strategy, i.e. to use the recursive merge strategy.  I've had some 
> moderate luck with using recursive merge for the klibc trees recently.

Dear diary, on Wed, Jan 18, 2006 at 07:06:07PM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> One of these days I'll convince Pasky to use git-merge for
> cg-merge's internals.

For the record, I acknowledge that the merge strategies are useful and I
plan to make cg-merge use them, but I'm unable to tell when that will
happen. I would still like to keep the current Cogito merging the
default merge strategy at least for a while until the dust settles down,
though. From the Git merge strategies, I guess only recursive is
useful for Cogito...

Patches welcome.  ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
