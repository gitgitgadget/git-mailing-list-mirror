From: Tony Finch <dot@dotat.at>
Subject: [PATCH 1/5] gitweb: fix typo in man page
Date: Thu, 31 Jul 2014 13:53:36 +0100
Message-ID: <alpine.LSU.2.00.1407311353350.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:53:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCprd-00071R-H2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaGaMxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:53:38 -0400
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57385 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:53:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:43448)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCprU-000596-rX (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:36 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCprU-0005j9-Hs (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:36 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254565>

Signed-off-by: Tony Finch <dot@dotat.at>
---
 Documentation/gitweb.conf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index ebe7a6c..29f1e06 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -487,7 +487,7 @@ By default it is set to (), i.e. an empty list.  This means that gitweb
 would not try to create project URL (to fetch) from project name.

 $projects_list_group_categories::
-	Whether to enables the grouping of projects by category on the project
+	Whether to enable the grouping of projects by category on the project
 	list page. The category of a project is determined by the
 	`$GIT_DIR/category` file or the `gitweb.category` variable in each
 	repository's configuration.  Disabled by default (set to 0).
-- 
2.1.0.rc0.229.gaee38de
