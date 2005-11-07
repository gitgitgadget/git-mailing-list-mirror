From: Petr Baudis <pasky@suse.cz>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 7 Nov 2005 23:56:52 +0100
Message-ID: <20051107225652.GW1431@pasky.or.cz>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com> <20051031213003.GN11488@ca-server1.us.oracle.com> <20051101091533.GB11618@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 23:58:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZFwI-0000nG-Tr
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 23:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbVKGW5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965590AbVKGW5T
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 17:57:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:36738 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965589AbVKGW44 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 17:56:56 -0500
Received: (qmail 3842 invoked by uid 2001); 7 Nov 2005 23:56:52 +0100
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20051101091533.GB11618@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11287>

Dear diary, on Tue, Nov 01, 2005 at 10:15:33AM CET, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> That said, with a big warning, I would be willing to do something like
> cg-merge -s and cg-update -s (s as squash), with a big warning that this
> is suitable only for topical branches. And I think it'd be still much
> better to spend the work making StGIT able to track history of changes
> to a particular patch.

FWIW, cg-merge -s and cg-update -s is supported now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
