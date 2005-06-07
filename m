From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add missing Documentation/*
Date: Tue, 07 Jun 2005 11:50:06 -0700
Message-ID: <7vvf4qhuht.fsf@assigned-by-dhcp.cox.net>
References: <20050607141736.GA2157@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 20:48:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfj5t-0004B6-8x
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 20:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVFGSuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 14:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVFGSuP
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 14:50:15 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17881 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261880AbVFGSuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 14:50:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050607185007.HAKC7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Jun 2005 14:50:07 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <20050607141736.GA2157@jmcmullan.timesys> (Jason McMullan's
 message of "Tue, 7 Jun 2005 10:17:36 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.

I would suggest dropping "and the git-list" and the rest from
all the new files.  The doc is by you, at least until somebody
else mucks on it.

+++ b/Documentation/git-get-tar-commit-id.txt
@@ -0,0 +1,29 @@
+DESCRIPTION
+-----------
+This shows the commit ID embedded in a git-tar-tree generated file.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>

This is by Rene Scharfe.  There is no single line from Linus in
the source file get-tar-commit-id.c, according to my "surviving
line counter".

