From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH] Documentation: minor grammatical fixes.
Date: Sat, 28 Feb 2009 13:12:59 -0800
Message-ID: <20090228220724.41A9617A49@sandstone.whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 28 23:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdXMd-0008G7-82
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 23:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbZB1WH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 17:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbZB1WH1
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 17:07:27 -0500
Received: from quartz.whistlingcat.com ([67.223.228.111]:40876 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbZB1WH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 17:07:26 -0500
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id AE9F2488006;
	Sat, 28 Feb 2009 14:07:24 -0800 (PST)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 6AE6938E7346;
	Sat, 28 Feb 2009 14:07:24 -0800 (PST)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 41A9617A49; Sat, 28 Feb 2009 14:07:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111796>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-add.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 7c129cb..e4c711b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -136,7 +136,7 @@ $ git add Documentation/\\*.txt
 ------------
 +
 Note that the asterisk `\*` is quoted from the shell in this
-example; this lets the command to include the files from
+example; this lets the command include the files from
 subdirectories of `Documentation/` directory.
 
 * Considers adding content from all git-*.sh scripts:
@@ -145,7 +145,7 @@ subdirectories of `Documentation/` directory.
 $ git add git-*.sh
 ------------
 +
-Because this example lets shell expand the asterisk (i.e. you are
+Because this example lets the shell expand the asterisk (i.e. you are
 listing the files explicitly), it does not consider
 `subdir/git-foo.sh`.
 
@@ -198,8 +198,8 @@ one deletion).
 
 update::
 
-   This shows the status information and gives prompt
-   "Update>>".  When the prompt ends with double '>>', you can
+   This shows the status information and issues an "Update>>"
+   prompt.  When the prompt ends with double '>>', you can
    make more than one selection, concatenated with whitespace or
    comma.  Also you can say ranges.  E.g. "2-5 7,9" to choose
    2,3,4,5,7,9 from the list.  If the second number in a range is
@@ -238,8 +238,8 @@ add untracked::
 
 patch::
 
-  This lets you choose one path out of 'status' like selection.
-  After choosing the path, it presents diff between the index
+  This lets you choose one path out of a 'status' like selection.
+  After choosing the path, it presents the diff between the index
   and the working tree file and asks you if you want to stage
   the change of each hunk.  You can say:
 
-- 
1.6.1.3
