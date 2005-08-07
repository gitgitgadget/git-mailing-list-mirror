From: Junio C Hamano <junkio@cox.net>
Subject: Re: use of temporary refs in resolve
Date: Sun, 07 Aug 2005 13:12:17 -0700
Message-ID: <7vd5opv74u.fsf@assigned-by-dhcp.cox.net>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508071256140.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 22:12:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1rVe-0007fz-E7
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 22:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbVHGUMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbVHGUMT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 16:12:19 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6073 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1752676AbVHGUMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 16:12:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807201218.XNMC12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 16:12:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508071256140.3258@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 7 Aug 2005 13:02:23 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In fact, ORIG_HEAD is _the_ most common head I use explicitly.

Ahhhh.  You are right.

How about LAST_MERGE?
