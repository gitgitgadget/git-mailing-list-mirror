From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Documentation: fix typo in git-remote.txt
Date: Sat,  5 May 2007 14:23:12 -0400
Message-ID: <11783893924046-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat May 05 20:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkP0V-0005Yb-DQ
	for gcvg-git@gmane.org; Sat, 05 May 2007 20:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934316AbXEES3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934314AbXEES3M
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 14:29:12 -0400
Received: from ms-smtp-02.southeast.rr.com ([24.25.9.101]:42501 "EHLO
	ms-smtp-02.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934316AbXEES3L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 14:29:11 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-02.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l45IT8gf014157;
	Sat, 5 May 2007 14:29:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.rc1.740.gc9ba5
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46280>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 Documentation/git-remote.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a9fb6a9..3dde713 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -40,7 +40,7 @@ With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
 `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
 is created.  You can give more than one `-t <branch>` to track
-multiple branche without grabbing all branches.
+multiple branches without grabbing all branches.
 +
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
-- 
1.5.2.rc1.740.gc9ba5
