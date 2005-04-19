From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 11:28:12 +0200
Message-ID: <20050419092812.GE2393@pasky.ji.cz>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwheeler@dwheeler.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 11:25:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNoyV-0007oP-DT
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDSJ2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSJ2g
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:28:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47290 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261416AbVDSJ2S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:28:18 -0400
Received: (qmail 9099 invoked by uid 2001); 19 Apr 2005 09:28:12 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4264CCFF.30400@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 11:18:55AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> What's the most common thing to do? pull or update?

update for normal users.

> which is easier to type?
> what are people used to?

I think 'git up' is easier to type than 'git pull'. It's the CVS/SVN
tradition, though, probably not the BK tradition.

> I'm not sure but I suggest that pull and get would be better choices.
> 
> git pull
> git get

I don't like git get; it is something completely new - not in CVS/SVN
and means something completely different in BK, apparently.

> is it rare enough to justify:
> git --download-only pull

Dunno. I do it personally all the time, with git at least.

What do others think? :-)

I start to like the pull/update distinction, and I think I'll go for it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
