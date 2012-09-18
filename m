From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 7/8] Doc clean: add See Also link
Date: Wed, 19 Sep 2012 00:25:33 +0100
Message-ID: <1348010734-664-8-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7A5-0005Bj-6I
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab2IRXYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:24:54 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27847 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab2IRXYs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsIFAOL+WFBZ8rU+/2dsb2JhbABFg02BU7cigQmCfTuBAiQTiASZCaFPkgsDpgSCZw
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="399027136"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:46 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205889>

'git clean' is controlled by gitignore. Provide See Also link for it.

Use of core.excludesfile is implied.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 79fb984..9f42c0d 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -63,6 +63,10 @@ OPTIONS
 	Remove only files ignored by git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+SEE ALSO
+--------
+linkgit:gitignore[5]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.8.msysgit.0
