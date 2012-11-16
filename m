From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/4] RelNotes 1.8.1: Typo
Date: Fri, 16 Nov 2012 10:05:50 -0300
Message-ID: <1353071153-1453-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 16 14:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZLlC-0001cv-MD
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 14:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab2KPNOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 08:14:51 -0500
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:57524 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2KPNOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 08:14:50 -0500
Received: from localhost (localhost [IPv6:::1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 46D1C1813F7;
	Fri, 16 Nov 2012 10:05:56 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([IPv6:::1])
	by localhost (zimbra.inf.utfsm.cl [IPv6:::1]) (amavisd-new, port 10026)
	with ESMTP id iEhkZbPlsjFo; Fri, 16 Nov 2012 10:05:56 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (unknown [IPv6:2800:270:c:0:201:29ff:fefc:bb25])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id 29A231813B5;
	Fri, 16 Nov 2012 10:05:56 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (localhost [127.0.0.1])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAGD5tPs001484;
	Fri, 16 Nov 2012 10:05:55 -0300
Received: (from vonbrand@localhost)
	by quelen.inf.utfsm.cl (8.14.5/8.14.5/Submit) id qAGD5tCh001483;
	Fri, 16 Nov 2012 10:05:55 -0300
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209874>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes/1.8.1.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.txt
index 107e5f3..559cd05 100644
--- a/Documentation/RelNotes/1.8.1.txt
+++ b/Documentation/RelNotes/1.8.1.txt
@@ -36,7 +36,7 @@ UI, Workflows & Features
    give the default number of context lines in the patch output, to
    override the hardcoded default of 3 lines.
 
- * "git format-patch" leraned the "--notes=<ref>" option to give
+ * "git format-patch" learned the "--notes=<ref>" option to give
    notes for the commit after the three-dash lines in its output.
 
  * "git log --grep=<pcre>" learned to honor the "grep.patterntype"
-- 
1.8.0.197.g5a90748
