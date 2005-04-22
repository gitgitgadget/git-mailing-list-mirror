From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-pasky: Add .gitrc directory to allow command defaults like with .cvsrc
Date: Fri, 22 Apr 2005 18:38:20 +0200
Message-ID: <20050422163820.GC7173@pasky.ji.cz>
References: <200504221828.51752.FabianFranz@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 18:34:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP16E-0005im-FV
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVDVQiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVDVQiY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:38:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7580 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262060AbVDVQiW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 12:38:22 -0400
Received: (qmail 4501 invoked by uid 2001); 22 Apr 2005 16:38:20 -0000
To: Fabian Franz <FabianFranz@gmx.de>
Content-Disposition: inline
In-Reply-To: <200504221828.51752.FabianFranz@gmx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 06:28:48PM CEST, I got a letter
where Fabian Franz <FabianFranz@gmx.de> told me that...
> Hi,

Hello,

> PS: Should the commandline parsing be cleaned up or do you want to do that 
> after first release of cogito? And if yes, do you want to use "getopts" or 
> would this be not supported on some systems?

I want to go for Perl in the longer term.

> PPS: I'm fairly new to git, how do I create a diff with the signed-by fields 
> and with what do I need to sign it?

Put

	Signed-off-by: Fabian Franz <FabianFranz@gmx.de>

in front of your patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
