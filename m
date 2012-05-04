From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Fix synopsis for git-tag
Date: Fri,  4 May 2012 09:04:36 -0400
Message-ID: <1336136676-16510-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: gitster@pobox.com, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 15:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQIJI-0002E6-0P
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 15:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644Ab2EDNMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 09:12:31 -0400
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:47988 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131Ab2EDNMb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 09:12:31 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 09:12:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 2FC9418119F;
	Fri,  4 May 2012 09:04:58 -0400 (CLT)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([127.0.0.1])
	by localhost (zimbra.inf.utfsm.cl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFsEU0JjKzSE; Fri,  4 May 2012 09:04:58 -0400 (CLT)
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id 1B6DE181182;
	Fri,  4 May 2012 09:04:58 -0400 (CLT)
Received: from laptop15.inf.utfsm.cl (pc-33-95-241-201.cm.vtr.net [201.241.95.33])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q44D4vPr000331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 May 2012 09:04:57 -0400
Received: from laptop15.inf.utfsm.cl (laptop15.inf.utfsm.cl [127.0.0.1])
	by laptop15.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id q44D4uAl016546;
	Fri, 4 May 2012 09:04:56 -0400
Received: (from vonbrand@localhost)
	by laptop15.inf.utfsm.cl (8.14.5/8.14.5/Submit) id q44D4uhx016545;
	Fri, 4 May 2012 09:04:56 -0400
X-Mailer: git-send-email 1.7.10.1.456.g16798d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197018>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-tag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e36a7c3..ff7fa28 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [<pattern>...]
+	[--column[=<options> | --no-column] [<pattern>...]
 	[<pattern>...]
 'git tag' -v <tagname>...
 
-- 
1.7.10.1.456.g16798d0
