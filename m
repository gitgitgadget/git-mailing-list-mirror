From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 13:38:16 -0700
Message-ID: <7vll4r1sxz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
	<Pine.LNX.4.58.0506301242470.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5jw-0004NT-Fo
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVF3UlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbVF3UkF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:40:05 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59356 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263141AbVF3UiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 16:38:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630203817.LNTR17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 16:38:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301242470.14331@ppc970.osdl.org> (Linus Torvalds's message of "Thu, 30 Jun 2005 12:44:53 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> In fact, the most recent push was gone with a

LT> 	git-send-pack master.kernel.org:/pub/scm/linux/kernel/git/torvalds/git.git

Congrats for a job well done.

Now is there anything for us poor mortals who would want to have
a "pull" support?  Logging in via ssh and run send-pack on the
other end is workable but not so pretty ;-).
