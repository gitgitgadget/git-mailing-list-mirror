From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 4/6] Add deprecation note to old everyday.txt
Date: Thu,  9 Jan 2014 23:13:10 +0000
Message-ID: <1389309192-5748-5-git-send-email-philipoakley@iee.org>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 00:13:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Omo-0003rV-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 00:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbaAIXNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 18:13:12 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:12064 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755940AbaAIXND (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 18:13:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApgkAJQsz1JOl3JU/2dsb2JhbABZgwuDOocmlw0BAZhggQ8XdIImAQVWMwhJOR4GE4gItEGOZRePDIQ3BKosgy08
X-IPAS-Result: ApgkAJQsz1JOl3JU/2dsb2JhbABZgwuDOocmlw0BAZhggQ8XdIImAQVWMwhJOR4GE4gItEGOZRePDIQ3BKosgy08
X-IronPort-AV: E=Sophos;i="4.95,634,1384300800"; 
   d="scan'208";a="432373454"
Received: from host-78-151-114-84.as13285.net (HELO localhost) ([78.151.114.84])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 09 Jan 2014 23:13:00 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240287>

Also include link to new man page.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/everyday.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 2a18c1f..9de6347 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -1,6 +1,10 @@
 Everyday Git With 20 Commands Or So
 ===================================
 
+Note, the Everyday Git guidance is now available via `git help everyday`
+linkgit:giteveryday[7].
+This version is deprecated and may be removed in later releases.
+
 <<Individual Developer (Standalone)>> commands are essential for
 anybody who makes a commit, even for somebody who works alone.
 
-- 
1.8.3.msysgit.0
