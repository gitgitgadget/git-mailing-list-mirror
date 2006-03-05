From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] gitignore: Ignore some more boring things.
Date: Sun, 05 Mar 2006 12:25:43 +0000
Message-ID: <20060305122542.6724.87703.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 13:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFsJ3-00076Q-AJ
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 13:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbWCEMZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 07:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbWCEMZp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 07:25:45 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:42651 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1752272AbWCEMZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 07:25:44 -0500
Received: (qmail 6750 invoked from network); 5 Mar 2006 12:25:43 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 5 Mar 2006 12:25:43 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17227>

From: Mark Wooding <mdw@distorted.org.uk>

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 .gitignore   |    1 +
 t/.gitignore |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5be239a..abbc509 100644
--- a/.gitignore
+++ b/.gitignore
@@ -130,3 +130,4 @@ libgit.a
 *.o
 *.py[co]
 config.mak
+git-blame
diff --git a/t/.gitignore b/t/.gitignore
new file mode 100644
index 0000000..fad67c0
--- /dev/null
+++ b/t/.gitignore
@@ -0,0 +1 @@
+trash
