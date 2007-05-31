From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Fix minor grammatical typos in the git-gc man page
Date: Thu, 31 May 2007 19:00:48 -0400
Message-ID: <11806524483959-git-send-email-tytso@mit.edu>
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 01:00:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Httdb-0002Ih-8k
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 01:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbXEaXAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbXEaXAv
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 19:00:51 -0400
Received: from THUNK.ORG ([69.25.196.29]:48089 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbXEaXAu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 19:00:50 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Httkh-0003yH-0s; Thu, 31 May 2007 19:08:19 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HttdQ-0004Od-32; Thu, 31 May 2007 19:00:48 -0400
X-Mailer: git-send-email 1.5.2.136.g322bc
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48829>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/git-gc.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 4ac839f..c7742ca 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -37,10 +37,10 @@ OPTIONS
 
 --aggressive::
 	Usually 'git-gc' runs very quickly while providing good disk
-	space utilization and performance.   This option will cause
-	git-gc to more aggressive optimize the repository at the expense
+	space utilization and performance.  This option will cause
+	git-gc to more aggressively optimize the repository at the expense
 	of taking much more time.  The effects of this optimization are
-	persistent, so this option only needs to be sporadically; every
+	persistent, so this option only needs to be used occasionally; every
 	few hundred changesets or so.
 
 Configuration
-- 
1.5.2.136.g322bc
