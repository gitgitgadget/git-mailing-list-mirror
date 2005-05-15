From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4] Rediffed against the tip of git-pb tree
Date: Sun, 15 May 2005 14:23:37 -0700
Message-ID: <7vk6m0qj3a.fsf@assigned-by-dhcp.cox.net>
References: <7vis1kvqac.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 23:24:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQaJ-0000QK-MI
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVEOVXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEOVXv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:23:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21227 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261256AbVEOVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:23:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515212338.MVJM7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 17:23:38 -0400
To: pasky@ucw.cz
In-Reply-To: <7vis1kvqac.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 15 May 2005 01:36:59 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr, I am sending rediff against the tip of git-pb tree.  One
of the patches is not just rediff---the earlier version I failed
to add a couple of newly created files.

 [1/4] Add --author and --committer match to git-rev-list and git-rev-tree.
 [2/4] Tweak diff output further to make it a bit less distracting.
 [3/4] Implement git-checkout-cache -u to update stat information in the cache.
 [4/4] Trivial test harness fixes.

