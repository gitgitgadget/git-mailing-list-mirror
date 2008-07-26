From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH] Documentation/git-submodule.txt: fix doubled word
Date: Sat, 26 Jul 2008 01:17:42 -0300
Message-ID: <1217045862-2506-1-git-send-email-cesarb@cesarb.net>
Cc: Cesar Eduardo Barros <cesarb@cesarb.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 26 06:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMbLR-0003sE-Oy
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 06:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbYGZEY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 00:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbYGZEYZ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 00:24:25 -0400
Received: from smtp-02.mandic.com.br ([200.225.81.133]:47368 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYGZEYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 00:24:25 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jul 2008 00:24:24 EDT
Received: (qmail 1910 invoked from network); 26 Jul 2008 04:17:42 -0000
Received: from grumari.nitnet.com.br (HELO localhost.localdomain) (zcncxNmDysja2tXBpdiToZWJlF6Wp6IuYnI=@[200.157.204.13])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-02.mandic.com.br (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 26 Jul 2008 04:17:42 -0000
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90168>

Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 Documentation/git-submodule.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 829b032..35efeef 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -63,7 +63,7 @@ COMMANDS
 add::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
-	project: the current project is termed termed the "superproject".
+	project: the current project is termed the "superproject".
 +
 This requires two arguments: <repository> and <path>.
 +
-- 
1.5.6.4
