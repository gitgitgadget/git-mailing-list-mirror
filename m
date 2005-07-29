From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH 0/2] Bits from git-pb
Date: Fri, 29 Jul 2005 10:58:19 +0200
Message-ID: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 10:59:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQhr-0004JG-UI
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVG2I62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVG2I61
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:58:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53004 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262541AbVG2I6X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 04:58:23 -0400
Received: (qmail 9713 invoked by uid 2001); 29 Jul 2005 08:58:19 -0000
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,

  those two bits were long kept local to git-pb. You can either apply
the patches or pull:

	www.kernel.org/pub/scm/cogito/git-pb.git

The bits are mostly cosmetic but I want to get rid of them. :-)

  I'd like to know what to do with the git-pb branch in the future.
Based on what do you think, I can either:

  (i) Keep the git-pb branch polished and nice-to-merge, if you want to
pull from it.

  (ii) Keep the git-pb branch polished and nice-to-merge and rebase it
regularily if you don't want loong edges in your history graph, but
want to pull from it.

  (ii) Do wild things in the git-pb branch and send you patches.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
