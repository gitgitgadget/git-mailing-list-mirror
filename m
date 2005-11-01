From: Petr Baudis <pasky@suse.cz>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 1 Nov 2005 10:17:11 +0100
Message-ID: <20051101091710.GC11618@pasky.or.cz>
References: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <7vbr15b4m4.fsf@assigned-by-dhcp.cox.net> <20051101004255.GQ11488@ca-server1.us.oracle.com> <46a038f90510311702wfb43281rf4464a02e8e3be2@mail.gmail.com> <20051101012915.GR11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 10:18:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWsGc-0000fJ-45
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 10:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVKAJRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 04:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVKAJRP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 04:17:15 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7651 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965008AbVKAJRN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 04:17:13 -0500
Received: (qmail 20125 invoked by uid 2001); 1 Nov 2005 10:17:11 +0100
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20051101012915.GR11488@ca-server1.us.oracle.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10928>

Dear diary, on Tue, Nov 01, 2005 at 02:29:15AM CET, I got a letter
where Joel Becker <Joel.Becker@oracle.com> told me that...
> On Tue, Nov 01, 2005 at 02:02:43PM +1300, Martin Langhoff wrote:
> > I'm really surprised that Calalin hasn't chimed in. If you are into
> > rewriting/merging/splitting your patches, StGIT is your friend. Check
> > out:  http://www.procode.org/stgit/
> 
> 	But I'm not.  I don't want patches in the first place.  I want
> cg-pull but with a flattened history.

StGIT does not work with patches but with commits. You can manage the
logical changes with StGIT and when it's time, just merge your
StGIT-tracked branch with whatever else. "Patch" here is really just a
different name for logical change / commit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
