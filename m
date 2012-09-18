From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 6/8] Doc add: link gitignore
Date: Wed, 19 Sep 2012 00:25:32 +0100
Message-ID: <1348010734-664-7-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7A4-0005Bj-LK
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab2IRXYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:24:52 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:52563 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752335Ab2IRXYs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAMPsWFBZ8rU+/2dsb2JhbABFhSC3IoEJgn07gQIkE4gEmH+hUpILA6YEgmc
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="393942829"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:46 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205890>

Use a gitignore link rather than the gitrepository-
layout link.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c1d395..fd9e36b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -155,7 +155,7 @@ Configuration
 The optional configuration variable `core.excludesfile` indicates a path to a
 file containing patterns of file names to exclude from git-add, similar to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See linkgit:gitrepository-layout[5].
+those in info/exclude.  See linkgit:gitignore[5].
 
 
 EXAMPLES
-- 
1.7.8.msysgit.0
