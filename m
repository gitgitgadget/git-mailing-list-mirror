From: Jon Jensen <jon@endpoint.com>
Subject: [PATCH] Fix reference to Everyday Git, which is an HTML document and not a man page.
Date: Sat,  2 Aug 2008 15:41:48 -0600
Message-ID: <1217713308-11573-1-git-send-email-jon@endpoint.com>
Cc: Jon Jensen <jon@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 00:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPPAC-0005Yq-Up
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 00:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbYHBWAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYHBWAY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 18:00:24 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:60896 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYHBWAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 18:00:23 -0400
X-Greylist: delayed 1113 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Aug 2008 18:00:23 EDT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id 52ED537B1DA;
	Sat,  2 Aug 2008 21:41:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91192>

Signed-off-by: Jon Jensen <jon@endpoint.com>
---
 Documentation/git.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 44ea35e..3da5bf0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -602,7 +602,7 @@ contributors on the git-list <git@vger.kernel.org>.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:everyday[7], linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
 linkgit:gitcli[7], link:user-manual.html[The Git User's Manual]
 
-- 
1.6.0.rc1.48.g2b6032
