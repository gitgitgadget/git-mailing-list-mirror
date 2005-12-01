From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-tree: add "-t" option to always show the tree entries
Date: Thu, 01 Dec 2005 14:04:39 -0800
Message-ID: <7vfypceao8.fsf@assigned-by-dhcp.cox.net>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
	<20051201085433.GA7866@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0512011022520.3099@g5.osdl.org>
	<7vlkz4friv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512011354500.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 23:05:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwXz-0000P4-2c
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 23:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVLAWEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 17:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVLAWEm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 17:04:42 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12777 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932515AbVLAWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 17:04:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201220317.HJJQ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 17:03:17 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512011354500.3099@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 1 Dec 2005 13:57:29 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13081>

Linus Torvalds <torvalds@osdl.org> writes:

> Maybe nobody else uses that "--name-only" thing.

I often use --name-status for diff, so that makes me nobody.
