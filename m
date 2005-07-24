From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Sun, 24 Jul 2005 09:24:52 -0700
Message-ID: <7v4qakdve3.fsf@assigned-by-dhcp.cox.net>
References: <20050711222046.GA21376@buici.com>
	<7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
	<20050712021004.GA27576@buici.com>
	<Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507112045420.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
	<20050712074801.GD6363@pasky.ji.cz>
	<7vy88c5r4w.fsf@assigned-by-dhcp.cox.net>
	<20050724085757.GB7601@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Singer <elf@buici.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 18:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwjHf-0007yP-SI
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 18:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVGXQY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 12:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVGXQY4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 12:24:56 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7861 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261399AbVGXQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 12:24:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724162451.GEV12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Jul 2005 12:24:51 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050724085757.GB7601@pasky.ji.cz> (Petr Baudis's message of "Sun, 24 Jul 2005 10:57:57 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> After some thought, I like Linus' approach more now, having head-name
> only when it's really necessary.

I agree 100%.  That makes much more sense.

The message from Linus reminded me that the way he tackles a
problem is (as always) simpler, consistent and more elegant than
mine.  I have been practicing thinking things through more than
three times before I open my mouth, but still...
