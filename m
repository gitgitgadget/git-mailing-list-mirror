From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] Remove extra '-' from git-am(1)
Date: Thu,  4 Mar 2010 13:08:28 +0100
Message-ID: <1267704508-2868-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Michal Sojka <sojkam1@fel.cvut.cz>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 13:08:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn9rF-0004gX-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 13:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab0CDMIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 07:08:43 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:43153 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911Ab0CDMIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 07:08:43 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 1DED819F3615;
	Thu,  4 Mar 2010 13:08:42 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id ovNXLP8HwQ5x; Thu,  4 Mar 2010 13:08:41 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id C60E419F3607;
	Thu,  4 Mar 2010 13:08:40 +0100 (CET)
Received: from steelpick.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 87075FA003;
	Thu,  4 Mar 2010 13:08:40 +0100 (CET)
Received: from wsh by steelpick.localdomain with local (Exim 4.71)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Nn9r6-0000ko-4P; Thu, 04 Mar 2010 13:08:40 +0100
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141522>


Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Documentation/git-am.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index c66c565..23864df 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -44,7 +44,7 @@ OPTIONS
 	Remove everything in body before a scissors line (see
 	linkgit:git-mailinfo[1]).
 
----no-scissors::
+--no-scissors::
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
 
 -q::
-- 
1.7.0
