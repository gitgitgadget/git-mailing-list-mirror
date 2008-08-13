From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Update .gitignore to ignore git-help
Date: Wed, 13 Aug 2008 23:32:43 +0200
Message-ID: <1218663163-9206-1-git-send-email-hendeby@isy.liu.se>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 13 23:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNyf-0007lY-0a
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYHMVcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbYHMVcq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:32:46 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:35047 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbYHMVcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:32:46 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 47E0F25A5C;
	Wed, 13 Aug 2008 23:32:44 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 02696-03; Sun, 31 Dec 1967 01:00:02 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 7C2D325A53;
	Wed, 13 Aug 2008 23:32:43 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 4CF7E2ED77; Wed, 13 Aug 2008 23:32:43 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92277>

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

---

Applies to next, this is not a problem in maint or master.

/Gustaf

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index a213e8e..bbaf9de 100644
--- a/.gitignore
+++ b/.gitignore
@@ -51,6 +51,7 @@ git-gc
 git-get-tar-commit-id
 git-grep
 git-hash-object
+git-help
 git-http-fetch
 git-http-push
 git-imap-send
-- 
1.6.0.rc3
