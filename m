From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sun, 15 May 2005 11:07:22 -0700
Message-ID: <7v8y2guzvp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
	<7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
	<7voebe63zs.fsf@assigned-by-dhcp.cox.net>
	<20050514150356.GK3905@pasky.ji.cz>
	<7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net>
	<20050514233538.GY3905@pasky.ji.cz>
	<7vr7g9uhsl.fsf@assigned-by-dhcp.cox.net>
	<20050515093040.GC13024@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 20:08:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXNWW-0000wa-65
	for gcvg-git@gmane.org; Sun, 15 May 2005 20:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVEOSH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 14:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEOSH1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 14:07:27 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57514 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261180AbVEOSHY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 14:07:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515180721.IETC20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 14:07:21 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050515093040.GC13024@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 15 May 2005 11:30:40 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> ... But what I dislike
PB> more is that the diff output is now visually inconsistent - some diffs
PB> are separated by a newline and some aren't.

That is already fixed in the second patch.

