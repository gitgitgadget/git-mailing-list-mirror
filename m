From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Typo in Documentation/RelNotes/1.8.2.txt
Date: Fri, 30 Nov 2012 10:15:02 -0300
Message-ID: <1354281302-9605-2-git-send-email-vonbrand@inf.utfsm.cl>
References: <1354281302-9605-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 30 14:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeQRF-0006TR-79
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 14:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564Ab2K3NPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 08:15:11 -0500
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:57241 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab2K3NPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 08:15:09 -0500
Received: from localhost (localhost [IPv6:::1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 4D1A318240F;
	Fri, 30 Nov 2012 10:15:08 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([IPv6:::1])
	by localhost (zimbra.inf.utfsm.cl [IPv6:::1]) (amavisd-new, port 10026)
	with ESMTP id AlB8cyYdkvSd; Fri, 30 Nov 2012 10:15:08 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (unknown [IPv6:2800:270:c:0:201:29ff:fefc:bb25])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id 2F9831812C8;
	Fri, 30 Nov 2012 10:15:08 -0300 (CLST)
Received: from netbook1.inf.utfsm.cl (ip64.4.priv.inf.utfsm.cl [10.10.4.64])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAUDF7Zx016345;
	Fri, 30 Nov 2012 10:15:07 -0300
Received: from netbook1.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by netbook1.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAUDF70P009653;
	Fri, 30 Nov 2012 10:15:07 -0300
Received: (from vonbrand@localhost)
	by netbook1.inf.utfsm.cl (8.14.5/8.14.5/Submit) id qAUDF7Fx009652;
	Fri, 30 Nov 2012 10:15:07 -0300
X-Mailer: git-send-email 1.8.0.1.347.gf94c325
In-Reply-To: <1354281302-9605-1-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210923>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes/1.8.1.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.txt
index 8f53af3..ce5b5ec 100644
--- a/Documentation/RelNotes/1.8.1.txt
+++ b/Documentation/RelNotes/1.8.1.txt
@@ -79,7 +79,7 @@ UI, Workflows & Features
    case and removes the submodule working tree when it is safe.
 
  * "git send-email" used to prompt for the sender address, even when
-   the committer identify is well specified (e.g. via user.name and
+   the committer identity is well specified (e.g. via user.name and
    user.email configuration variables).  The command no longer gives
    this prompt when not necessary.
 
-- 
1.8.0.1.347.gf94c325
