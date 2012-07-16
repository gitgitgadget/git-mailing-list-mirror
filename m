From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] Documentation/git-daemon: add missing word
Date: Mon, 16 Jul 2012 13:50:31 +0200
Message-ID: <1342439431-18359-1-git-send-email-mschub@elegosoft.com>
Cc: gitster@pobox.com, Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 14:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqk0n-0007xP-8P
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2GPMCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:02:45 -0400
Received: from schu.io ([178.77.73.177]:48347 "EHLO
	lvps178-77-73-177.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab2GPMCo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 08:02:44 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 08:02:44 EDT
Received: from myhost.elego.de (i59F7870A.versanet.de [89.247.135.10])
	by lvps178-77-73-177.dedicated.hosteurope.de (Postfix) with ESMTPSA id 192B214954001;
	Mon, 16 Jul 2012 13:53:03 +0200 (CEST)
X-Mailer: git-send-email 1.7.11.2.196.ga22866b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201512>

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 Documentation/git-daemon.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 31b28fc..e8f7577 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -204,7 +204,7 @@ receive-pack::
 	can push anything into the repository, including removal
 	of refs).  This is solely meant for a closed LAN setting
 	where everybody is friendly.  This service can be
-	enabled by `daemon.receivepack` configuration item to
+	enabled by setting `daemon.receivepack` configuration item to
 	`true`.
 
 EXAMPLES
-- 
1.7.11.2.338.g602de8e
