From: Tony Finch <dot@dotat.at>
Subject: [PATCH 1/5] gitweb: fix typo in man page
Date: Thu, 19 Mar 2015 15:39:53 +0000
Message-ID: <alpine.LSU.2.00.1503191539410.23307@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:50:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYchx-0001E6-Ns
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 16:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbbCSPtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 11:49:53 -0400
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:50313 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbbCSPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 11:49:51 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:44267)
	by ppsw-40.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YYcY5-0007sL-m3 (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:39:53 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YYcY5-0007vf-Rc (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:39:53 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265807>

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
2.2.1.68.g56d9796
