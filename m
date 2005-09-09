From: jdl@freescale.com
Subject: PATCH fix tutorial typo
Date: Fri, 09 Sep 2005 10:41:15 -0500
Message-ID: <E1EDl07-00053e-4j@jdl.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:41:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDl0F-0001Fs-Pg
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 17:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVIIPlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 11:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVIIPlV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 11:41:21 -0400
Received: from colo.jdl.com ([66.118.10.122]:18652 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964953AbVIIPlU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 11:41:20 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EDl07-00053e-4j
	for git@vger.kernel.org; Fri, 09 Sep 2005 10:41:16 -0500
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8241>

Fix a minor typo in the tutorial.txt.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -742,7 +742,7 @@ git commit -m 'Some work.' hello
 ------------------------------------------------
 
 Here, we just added another line to `hello`, and we used a shorthand for
-both going a `git-update-index hello` and `git commit` by just giving the
+doing both `git-update-index hello` and `git commit` by just giving the
 filename directly to `git commit`. The `-m` flag is to give the
 commit log message from the command line.
 
