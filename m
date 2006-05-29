From: bfields@fieldses.org
Subject: [PATCH 1/5] documentation: mention gitk font adjustment in tutorial
Date: Mon, 29 May 2006 19:31:32 -0400
Message-ID: <11489454961705-git-send-email-bfields@fieldses.org>
Reply-To: bfields@fieldses.org
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 01:33:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkrEr-0001pI-B7
	for gcvg-git@gmane.org; Tue, 30 May 2006 01:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWE2Xdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 19:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWE2Xdb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 19:33:31 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:11216 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1750764AbWE2Xda (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 19:33:30 -0400
Received: from puzzle.fieldses.org (c-68-40-201-198.hsd1.mi.comcast.net [68.40.201.198])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id k4TNXI84014056
	for <git@vger.kernel.org>; Mon, 29 May 2006 23:33:30 GMT
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FkrCy-0005Ku-JW; Mon, 29 May 2006 19:31:36 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3.g2506
X-Virus-Scanned: ClamAV 0.88.2/1499/Mon May 29 20:35:17 2006 on zeus2.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20998>

From: J. Bruce Fields <bfields@citi.umich.edu>

Kind of silly, but the font I get by default in gitk makes it mostly
unusable for me, so this is the first thing I'd want to know about.
(But maybe there's a better suggestion than just Ctrl-='ing until
satisfied.)

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

ded59a62d1d7b114cdc4d5352e89006880e94f08
 Documentation/tutorial.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

ded59a62d1d7b114cdc4d5352e89006880e94f08
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 79781ad..5fdeab9 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -429,7 +429,9 @@ visualizing their history.  For example,
 -------------------------------------
 
 allows you to browse any commits from the last 2 weeks of commits
-that modified files under the "drivers" directory.
+that modified files under the "drivers" directory.  (Note: you can
+adjust gitk's fonts by holding down the control key while pressing
+"-" or "+".)
 
 Finally, most commands that take filenames will optionally allow you
 to precede any filename by a commit, to specify a particular version
-- 
1.3.3.gff62
