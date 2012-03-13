From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/2] Release notes for 1.7.10: Typo in compatibility notes
Date: Tue, 13 Mar 2012 09:28:36 -0300
Message-ID: <1331641717-6430-2-git-send-email-vonbrand@inf.utfsm.cl>
References: <1331641717-6430-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 13:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QzC-0000Xk-PM
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab2CMMgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 08:36:50 -0400
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:50207 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab2CMMgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:36:49 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2012 08:36:49 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id D771F182016;
	Tue, 13 Mar 2012 09:28:41 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([127.0.0.1])
	by localhost (zimbra.inf.utfsm.cl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36b1JBxp7zzb; Tue, 13 Mar 2012 09:28:41 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id C3C7F181ABC;
	Tue, 13 Mar 2012 09:28:41 -0300 (CLST)
Received: from laptop15.inf.utfsm.cl (ip127.4.priv.inf.utfsm.cl [10.10.4.127])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q2DCSfCB001252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Mar 2012 09:28:41 -0300
Received: from laptop15.inf.utfsm.cl (laptop15.inf.utfsm.cl [127.0.0.1])
	by laptop15.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q2DCSfDJ006507;
	Tue, 13 Mar 2012 09:28:41 -0300
Received: (from vonbrand@localhost)
	by laptop15.inf.utfsm.cl (8.14.5/8.14.5/Submit) id q2DCSfXl006506;
	Tue, 13 Mar 2012 09:28:41 -0300
X-Mailer: git-send-email 1.7.10.rc0.41.gfa678f
In-Reply-To: <1331641717-6430-1-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193016>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes/1.7.10.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index 65df74b..0e7def1 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -26,7 +26,7 @@ Compatibility Notes
    Git v1.7.8 or newer.
 
  * The "--binary/-b" options to "git am" have been a no-op for quite a
-   while and was deprecated in mid 2008 (v1.6.0).  When you give these
+   while and were deprecated in mid 2008 (v1.6.0).  When you give these
    options to "git am", it will now fail with an error.
 
 
-- 
1.7.10.rc0.41.gfa678f
