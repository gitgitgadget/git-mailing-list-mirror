From: c.shoemaker@cox.net
Subject: [PATCH] Remove -r from common diff options documentation in one more place
Date: Sat, 29 Oct 2005 00:16:01 -0400
Message-ID: <E1EVi8P-0002TX-8g@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:20:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi8u-0003wp-0u
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVJ2EQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVJ2EQE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:16:04 -0400
Received: from eastrmmtao04.cox.net ([68.230.240.35]:51851 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750857AbVJ2EQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:16:02 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041501.BMOM23022.eastrmmtao04.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:15:01 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi8P-0002TX-8g
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:16:01 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10785>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 Documentation/diff-options.txt |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

77e622ef1f6b29fa8b76d5c4f96200cd4d6d82ab
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -4,10 +4,6 @@
 -u::
 	Synonym for "-p".
 
--r::
-	Look recursively in subdirectories; only used by "git-diff-tree";
-	other diff commands always work recursively.
-
 -z::
 	\0 line termination on output
 
