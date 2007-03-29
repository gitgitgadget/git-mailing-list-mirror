From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Fix minor formatting issue in man page for git-mergetool
Date: Thu, 29 Mar 2007 11:44:15 -0400
Message-ID: <11751830653871-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwni-0003tu-Et
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbXC2Poa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbXC2Po3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:29 -0400
Received: from thunk.org ([69.25.196.29]:36580 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbXC2Po3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:29 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtd-0007Iy-MH; Thu, 29 Mar 2007 11:50:41 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xK-D3; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830653554-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43442>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/git-mergetool.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 5baaaca..34288fe 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,11 +26,11 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, and vimdiff.
-
-	If a merge resolution program is not specified, 'git mergetool'
-	will use the configuration variable merge.tool.  If the
-	configuration variable merge.tool is not set, 'git mergetool'
-	will pick a suitable default.
++
+If a merge resolution program is not specified, 'git mergetool'
+will use the configuration variable merge.tool.  If the
+configuration variable merge.tool is not set, 'git mergetool'
+will pick a suitable default.
 
 Author
 ------
-- 
1.5.1.rc2.1.g8afe-dirty
