From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 6/8] Doc add: link gitignore
Date: Sun, 16 Sep 2012 11:58:01 +0100
Message-ID: <1347793083-4136-7-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:34:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDE3M-0005du-J9
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab2IPMeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:34:17 -0400
Received: from smtp2go.com ([207.58.142.213]:35647 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2IPMeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:34:05 -0400
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205614>

Include the gitignore link with the paired gitrepository-
layout link.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

without the gitignore link users are unlikely to realise the
significance of the repository layout link, nor what to look for
within it

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c1d395..311be9a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -155,7 +155,8 @@ Configuration
 The optional configuration variable `core.excludesfile` indicates a path to a
 file containing patterns of file names to exclude from git-add, similar to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See linkgit:gitrepository-layout[5].
+those in info/exclude.  See linkgit:gitrepository-layout[5] and
+linkgit:gitignore[5].
 
 
 EXAMPLES
-- 
1.7.8.msysgit.0
