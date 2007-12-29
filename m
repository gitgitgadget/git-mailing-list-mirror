From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] user-manual: fix typo
Date: Sat, 29 Dec 2007 10:52:25 +0100
Message-ID: <1198921945-25616-1-git-send-email-hendeby@isy.liu.se>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 29 10:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8YNd-0003bD-1C
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 10:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbXL2Jw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 04:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbXL2Jw3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 04:52:29 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:52666 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbXL2Jw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 04:52:28 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 84A2025A5C;
	Sat, 29 Dec 2007 10:52:26 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 23277-03; Sat, 29 Dec 2007 10:52:25 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id BE2DE25A37;
	Sat, 29 Dec 2007 10:52:25 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id A86CA1779C; Sat, 29 Dec 2007 10:52:25 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc2.1.g4bcdb
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69311>

---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f2b4206..3f552e9 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -74,7 +74,7 @@ version is called a <<def_commit,commit>>.
 
 Those snapshots aren't necessarily all arranged in a single line from
 oldest to newest; instead, work may simultaneously proceed along
-parallel lines of development, called <def_branch,branches>>, which may
+parallel lines of development, called <<def_branch,branches>>, which may
 merge and diverge.
 
 A single git repository can track development on multiple branches.  It
-- 
1.5.4.rc2.1.g4bcdb
