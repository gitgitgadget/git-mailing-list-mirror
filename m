From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Documentation/user-manual.txt: fix typo
Date: Mon, 31 Dec 2007 14:31:35 +0100
Message-ID: <1199107895-25950-1-git-send-email-hendeby@isy.liu.se>
References: <1198921945-25616-1-git-send-email-hendeby@isy.liu.se>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 31 14:32:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9KkP-0008HN-H7
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 14:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbXLaNbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 08:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXLaNbk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 08:31:40 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:56184 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbXLaNbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 08:31:40 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 6797D25A5A;
	Mon, 31 Dec 2007 14:31:36 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 05786-07; Mon, 31 Dec 2007 14:31:35 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id AD45625A52;
	Mon, 31 Dec 2007 14:31:35 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id A173E1779C; Mon, 31 Dec 2007 14:31:35 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc2.8.g41c7c6
In-Reply-To: <1198921945-25616-1-git-send-email-hendeby@isy.liu.se>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69404>

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

I didn't see this one in the latest patches added to v1.5.4-rc2 so I
guess it was forgotten, or just dropped because it seems I forgot to
sign it the last time.  (Sorry about that, it should teach me not to
do anything important at 4 in the morning...)  I think the patch is
obviously correct so I'm resending.

/Gustaf

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
1.5.4.rc2.8.g41c7c6
