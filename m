From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 18:33:27 -0700
Message-ID: <7vpsvibuag.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522184237.GG18500@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org>
	<7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
	<7vy8a7cavf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org>
	<7vis1adfvq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221611020.2307@ppc970.osdl.org>
	<7vu0kubwyg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221751070.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 03:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da1nj-0006gN-1R
	for gcvg-git@gmane.org; Mon, 23 May 2005 03:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVEWBdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 21:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEWBdb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 21:33:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55988 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261833AbVEWBd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 21:33:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523013327.HSGP550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 21:33:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505221751070.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 22 May 2005 18:07:48 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Delaying the message generation to just before output is part of
the fix I've been working on, yes.  But there are some other
issues.  Give me some more time as I asked.

