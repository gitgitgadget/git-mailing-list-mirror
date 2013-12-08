From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] RelNotes: fix a typo in "Negotiate".
Date: Sun,  8 Dec 2013 20:29:19 +0000
Message-ID: <1386534559-209439-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 21:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpkz5-0006ii-QY
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 21:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3LHU33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 15:29:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34547 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755274Ab3LHU32 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Dec 2013 15:29:28 -0500
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C22B42807E
	for <git@vger.kernel.org>; Sun,  8 Dec 2013 20:29:27 +0000 (UTC)
X-Mailer: git-send-email 1.8.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239048>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/RelNotes/1.9.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.9.txt b/Documentation/RelNotes/1.9.txt
index 9debcc4..d5c99a9 100644
--- a/Documentation/RelNotes/1.9.txt
+++ b/Documentation/RelNotes/1.9.txt
@@ -68,7 +68,7 @@ Updates since v1.8.5
 
 Foreign interfaces, subsystems and ports.
 
- * The HTTP transport, when talking GSS-Negotinate, uses "100
+ * The HTTP transport, when talking GSS-Negotiate, uses "100
    Continue" response to avoid having to rewind and resend a large
    payload, which may not be always doable.
 
-- 
1.8.5.1
