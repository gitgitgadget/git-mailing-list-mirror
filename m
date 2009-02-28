From: dt@korn.shell.la
Subject: [PATCH] added missing backtick in git-apply.txt
Date: Sat, 28 Feb 2009 21:03:54 +0100
Message-ID: <1235851434-16950-1-git-send-email-dt@korn.shell.la>
Cc: Danijel Tasov <dt@korn.shell.la>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 28 21:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdVqt-0004o5-4A
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 21:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbZB1UaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 15:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbZB1UaH
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 15:30:07 -0500
Received: from bounty.rbfh.de ([85.25.54.223]:53281 "EHLO bounty.rbfh.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbZB1UaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 15:30:05 -0500
X-Greylist: delayed 1563 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Feb 2009 15:30:05 EST
Received: from lion (lion [172.16.22.5])
	by bounty.rbfh.de (Postfix) with ESMTP id B387F5388002;
	Sat, 28 Feb 2009 21:03:54 +0100 (CET)
Received: by lion (Postfix, from userid 1000)
	id 6CB0467CD2D; Sat, 28 Feb 2009 21:03:54 +0100 (CET)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111789>

From: Danijel Tasov <dt@korn.shell.la>

Signed-off-by: Danijel Tasov <dt@korn.shell.la>
---
 Documentation/git-apply.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9400f6a..0566376 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -159,7 +159,7 @@ on the command line, and ignored if there is any include pattern.
 	considered whitespace errors.
 +
 By default, the command outputs warning messages but applies the patch.
-When `git-apply is used for statistics and not applying a
+When `git-apply` is used for statistics and not applying a
 patch, it defaults to `nowarn`.
 +
 You can use different `<action>` to control this
-- 
1.6.1.3
