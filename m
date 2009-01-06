From: jidanni@jidanni.org
Subject: [PATCH] Documentation/gittutorial.txt: minimum 4 chars to match SHA1s
Date: Tue,  6 Jan 2009 10:49:00 +0800
Message-ID: <1231210140-13116-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 03:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK21Q-0004LG-W5
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 03:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbZAFCtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 21:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZAFCtG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 21:49:06 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:50421
	"EHLO homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750738AbZAFCtF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 21:49:05 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 64491D271B;
	Mon,  5 Jan 2009 18:49:02 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104624>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/gittutorial.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 4581a5a..42c2c91 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -481,7 +481,8 @@ $ git show c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
 -------------------------------------
 
 But there are other ways to refer to commits.  You can use any initial
-part of the name that is long enough to uniquely identify the commit:
+part of the name that is long enough to uniquely identify the commit
+(minimum is four characters):
 
 -------------------------------------
 $ git show c82a22c39c	# the first few characters of the name are
-- 
1.6.0.6
