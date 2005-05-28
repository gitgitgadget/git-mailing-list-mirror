From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 19:26:35 -0700
Message-ID: <7vwtpkytk4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
	<20050527195552.GA6541@cip.informatik.uni-erlangen.de>
	<7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
	<20050527203227.GA11139@cip.informatik.uni-erlangen.de>
	<7vk6lkwgfl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505271457480.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 04:25:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbr0F-0002C5-2B
	for gcvg-git@gmane.org; Sat, 28 May 2005 04:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVE1C0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 22:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVE1C0q
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 22:26:46 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33493 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262158AbVE1C0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 22:26:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528022636.UBVI19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 22:26:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271457480.17402@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 27 May 2005 15:00:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> There's no limit in the data structures, although there clearly is a 
LT> "sanity" limit (and I personally suspect it comes before you hit 16 ;)

I know that my head would start hurting way before I hit 16.

I probably shouldn't have coined the word Octopus in the first
place, giving people a false impression that somehow 8 is a
magic number.  To begin with, what I inflicted on you was not
even an Octopus but a Pentapus, merge of 5 IIRC.

Also we are counting heads, not legs.  Should have said Hydra,
but I do not offhand know how many heads it has --- I've never
met one.  I know King Ghidorah has 3 heads ;-).

