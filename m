From: Tony Finch <dot@dotat.at>
Subject: [PATCH] git-push: fix link in man page
Date: Thu, 31 Jul 2014 16:06:28 +0100
Message-ID: <alpine.LSU.2.00.1407311606270.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:06:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCrwC-0000o9-2w
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbaGaPGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:06:30 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:42133 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaGaPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:06:30 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:46194)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCrw4-0002MN-Fu (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 16:06:28 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCrw4-0002Vd-Qj (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 16:06:28 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254577>

Signed-off-by: Tony Finch <dot@dotat.at>
---
 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21cd455..c0d7403 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -33,7 +33,7 @@ When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
 the default `<refspec>` by consulting `remote.*.push` configuration,
 and if it is not found, honors `push.default` configuration to decide
-what to push (See gitlink:git-config[1] for the meaning of `push.default`).
+what to push (See linkgit:git-config[1] for the meaning of `push.default`).


 OPTIONS[[OPTIONS]]
-- 
2.1.0.rc0.229.gaee38de
