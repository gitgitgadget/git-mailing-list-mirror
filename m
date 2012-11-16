From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 3/4] RelNotes 1.8.1: Grammar thinko
Date: Fri, 16 Nov 2012 10:05:52 -0300
Message-ID: <1353071153-1453-3-git-send-email-vonbrand@inf.utfsm.cl>
References: <1353071153-1453-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 16 14:15:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZLlC-0001cv-4m
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 14:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab2KPNOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 08:14:52 -0500
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:57527 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2KPNOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 08:14:50 -0500
Received: from localhost (localhost [IPv6:::1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 02D95181B12;
	Fri, 16 Nov 2012 10:05:57 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([IPv6:::1])
	by localhost (zimbra.inf.utfsm.cl [IPv6:::1]) (amavisd-new, port 10026)
	with ESMTP id 0QD9TKm6ZruQ; Fri, 16 Nov 2012 10:05:56 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (unknown [IPv6:2800:270:c:0:201:29ff:fefc:bb25])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id DB42E1813B5;
	Fri, 16 Nov 2012 10:05:56 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (localhost [127.0.0.1])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAGD5uSI001492;
	Fri, 16 Nov 2012 10:05:56 -0300
Received: (from vonbrand@localhost)
	by quelen.inf.utfsm.cl (8.14.5/8.14.5/Submit) id qAGD5u3X001491;
	Fri, 16 Nov 2012 10:05:56 -0300
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1353071153-1453-1-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209873>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes/1.8.1.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.txt
index 69baa35..668f1a3 100644
--- a/Documentation/RelNotes/1.8.1.txt
+++ b/Documentation/RelNotes/1.8.1.txt
@@ -132,7 +132,7 @@ details).
    (merge 11fbe18 po/maint-refs-replace-docs later to maint).
 
  * Various rfc2047 quoting issues around a non-ASCII name on the
-   From: line in the output from format-patch has been corrected.
+   From: line in the output from format-patch have been corrected.
    (merge 25dc8da js/format-2047 later to maint).
 
  * Sometimes curl_multi_timeout() function suggested a wrong timeout
-- 
1.8.0.197.g5a90748
