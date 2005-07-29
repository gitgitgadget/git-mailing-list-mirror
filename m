From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Thu, 28 Jul 2005 19:24:30 -0700
Message-ID: <7vack6qrhd.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<1122068634.7042.35.camel@localhost.localdomain>
	<7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	<1122108098.6863.38.camel@localhost.localdomain>
	<20050723093035.GB11814@pasky.ji.cz>
	<1122114452.6863.72.camel@localhost.localdomain>
	<20050728194748.GD24948@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 04:25:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKYO-0008Se-EZ
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVG2CYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG2CYl
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:24:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32411 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262251AbVG2CYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:24:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022425.OPBX1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:24:25 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> The committer field generally identifies the committer "physically", and
> isn't usually overriden. You'll find <xpasky@machine.sinus.cz> in my
> committer field, e.g.

I do not want to get involved in policy decisions, but for the
record I always hated your commit log for that "identifies the
committer physically" approach.
