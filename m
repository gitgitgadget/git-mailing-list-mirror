From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Sun, 29 May 2005 17:57:09 -0700
Message-ID: <7voeatbkey.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
	<20050527195552.GA6541@cip.informatik.uni-erlangen.de>
	<7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
	<20050527203227.GA11139@cip.informatik.uni-erlangen.de>
	<20050529230240.GB12290@cip.informatik.uni-erlangen.de>
	<20050529231053.GD12290@cip.informatik.uni-erlangen.de>
	<20050529231621.GE12290@cip.informatik.uni-erlangen.de>
	<20050529234606.GF12290@cip.informatik.uni-erlangen.de>
	<20050529235630.GG12290@cip.informatik.uni-erlangen.de>
	<7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 02:55:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcYYL-0006nG-Dn
	for gcvg-git@gmane.org; Mon, 30 May 2005 02:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVE3A5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVE3A5N
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 20:57:13 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:26758 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261490AbVE3A5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 20:57:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530005709.UKCE23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 20:57:09 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <7vsm05bkps.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 17:50:39 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH>    - If MB is either BASE or H1, then you have a fast forward.
JCH>      Take either BASE or H1 that is not MB and update variable
JCH>      BASE with it, and update variable T with the tree
JCH>      associated with it.  Continue with the loop (i.e. Perl
JCH>      "next").

Chuck this part please.  I was not thinking.

