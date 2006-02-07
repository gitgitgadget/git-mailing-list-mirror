From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] .gitignore git-rerere and config.mak
Date: Tue, 7 Feb 2006 17:23:12 +0000 (UTC)
Message-ID: <20060207172234.41A975BF02@nox.op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 07 18:23:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6WY3-0008Dq-86
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 18:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWBGRWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 12:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWBGRWf
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 12:22:35 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:35970 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932075AbWBGRWf
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 12:22:35 -0500
Received: from nox.op5.se (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 611B06BD28
	for <git@vger.kernel.org>; Tue,  7 Feb 2006 18:22:34 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 41A975BF02; Tue,  7 Feb 2006 18:22:34 +0100 (CET)
To: git@vger.kernel.org
In-Reply-To: 20060207182234
Date: Tue Feb 7 18:21:02 2006 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15700>

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

0a04811b6d4a6673869cd078471cd1ee6db31e5a
diff --git a/.gitignore b/.gitignore
index 513f22e..d7e8d2a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,6 +78,7 @@ git-relink
 git-repack
 git-repo-config
 git-request-pull
+git-rerere
 git-reset
 git-resolve
 git-rev-list
@@ -123,3 +124,4 @@ git-core.spec
 libgit.a
 *.o
 *.py[co]
+config.mak
-- 
1.1.6.g53f3
