From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename tracking
Date: Sat, 14 May 2005 09:36:22 -0700
Message-ID: <7vfywpzrw9.fsf@assigned-by-dhcp.cox.net>
References: <7vk6m260xf.fsf@assigned-by-dhcp.cox.net>
	<20050514151159.GL3905@pasky.ji.cz>
	<7v4qd523p1.fsf@assigned-by-dhcp.cox.net>
	<20050514162133.GW3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:37:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWzdU-0003GA-3C
	for gcvg-git@gmane.org; Sat, 14 May 2005 18:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVENQgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 12:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVENQgt
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 12:36:49 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14725 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262799AbVENQg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 12:36:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514163622.BVSY550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 12:36:22 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514162133.GW3905@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 18:21:33 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Well, I'd say that with those renaming patches we are feeling the need
PB> for it?

Again, not me.  What I did (and asked you to do) was to help
_others_ who are interested in rename tracking, not me.  Find
the following message in the archive if you want to know why I
am not in urgent need for rename tracking.

    To:	Linus Torvalds <torvalds@osdl.org>
    Cc:	David Greaves <david@dgreaves.com>, git@vger.kernel.org
    Subject: GIT blame (was Re: Quick command reference)
    From:	Junio C Hamano <junkio@cox.net>
    Date:	Fri, 06 May 2005 02:32:30 -0700
    X-Mailing-List:	git@vger.kernel.org

    >>>>> I == Junio C Hamano <junkio@cox.net> said:

    JCH> Linus, please pull from git-jc.git archive at:
    JCH>     http://members.cox.net/junkio/git-jc.git/

    Since that message I have added a couple more commits there.
    One of the things is a backport of -t (tag) flag to git-ls-files
    from Cogito fork.

    The reason I am writing this message is not because I am excited
    about the backport [*1*], but because I find it quite cool the
    way I found out which commit in Pasky's development line
    introduced the change.  It demonstrates your previous "renames
    does not matter when doing CVS blame" argument actually works.

    Here is what I did: ... (the rest omitted) ...

