From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk "parent information" in commit window
Date: Sun, 07 Aug 2005 14:17:21 -0700
Message-ID: <7v4qa1v44e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 23:18:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1sWM-0005Ul-Mo
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 23:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbVHGVRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbVHGVRY
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 17:17:24 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45208 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1752768AbVHGVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 17:17:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807211723.SPIE8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 17:17:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 7 Aug 2005 13:58:56 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> [ Btw, the patch was generated against a tree that had Paul's hovering 
>   patches merged. Junio, I don't think you've merged that yet, so this may 
>   apply better to Paul's tree than to standard git. But I _think_ it will 
>   apply cleanly to either one ]

Thanks.  Since Paul seems to be quite responsive, I'd prefer to
keep pulling from his tree.  I just pulled the hovering patches
from his tree and was about to push things out.
