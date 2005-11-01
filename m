From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-am.txt is no stub anymore
Date: Tue, 01 Nov 2005 21:47:10 +0100
Message-ID: <20051101204710.19362.89407.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX32i-0003ZJ-Qa
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 21:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVKAUrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 15:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVKAUrO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 15:47:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3263 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751138AbVKAUrM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 15:47:12 -0500
Received: (qmail 19374 invoked from network); 1 Nov 2005 21:47:10 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 1 Nov 2005 21:47:10 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10954>

That notice was added by me for the emergency documentation, but Junio
already expanded it to a full-fledged manual page. This patch removes
the notice.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-am.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 704dc51..e4df4a4 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -82,8 +82,6 @@ Documentation
 --------------
 Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
-This manual page is a stub. You can help the git documentation by expanding it.
-
 GIT
 ---
 Part of the gitlink:git[7] suite
