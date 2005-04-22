From: Petr Baudis <pasky@ucw.cz>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Sat, 23 Apr 2005 00:33:41 +0200
Message-ID: <20050422223341.GC21204@pasky.ji.cz>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org> <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org> <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org> <7vbr867ecy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504221503270.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:29:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6e8-0000mQ-Dz
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDVWdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDVWdp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:33:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46753 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261248AbVDVWdm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:33:42 -0400
Received: (qmail 23988 invoked by uid 2001); 22 Apr 2005 22:33:41 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504221503270.2344@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 12:14:16AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> (And I personally think that "show-diff" is really part of the "wrapper
> scripts" around git. I wrote it originally just because I needed something
> to verify the index file handling, not because it's "core" like the other
> programs. I do _not_ consider "show-diff" to be part of the core git code,
> really. Same goes for "git-export", btw - for the same reasons. It's not
> "fundamental").

Note that Cogito almost actually does not use show-diff anymore.
I'm doing diff-cache now, since that is what matters to me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
