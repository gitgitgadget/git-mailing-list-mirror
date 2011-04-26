From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCHv2 2/2] git-svn.txt: small typeface improvements
Date: Tue, 26 Apr 2011 13:34:19 +0200
Message-ID: <1303817659-26541-3-git-send-email-valentin.haenel@gmx.de>
References: <20110425210623.GB13953@dcvr.yhbt.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 13:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEgoT-0004fp-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 13:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab1DZLwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 07:52:13 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:39293 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1DZLwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 07:52:12 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3QBYb5T026630;
	Tue, 26 Apr 2011 13:34:37 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3QBYbLV026629;
	Tue, 26 Apr 2011 13:34:37 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110425210623.GB13953@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172088>

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ba8a95e..713e523 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -564,14 +564,14 @@ For 'branch' and 'tag', display the urls that will be used for copying when
 creating the branch or tag.
 
 --use-log-author::
-	When retrieving svn commits into git (as part of fetch, rebase, or
-	dcommit operations), look for the first From: or Signed-off-by: line
+	When retrieving svn commits into git (as part of 'fetch', 'rebase', or
+	'dcommit' operations), look for the first `From:` or `Signed-off-by:` line
 	in the log message and use that as the author string.
 --add-author-from::
 	When committing to svn from git (as part of 'commit-diff', 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
-	From: or Signed-off-by: line, append a From: line based on the
-	git commit's author string.  If you use this, then --use-log-author
+	`From:` or `Signed-off-by:` line, append a `From:` line based on the
+	git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 
 
-- 
1.7.1
