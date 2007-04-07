From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/4] Fix typo in help string.
Date: Sat, 07 Apr 2007 23:36:53 +0200
Message-ID: <20070407213653.13698.31672.stgit@gandelf.nowhere.earth>
References: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 00:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIax-0002vd-Bm
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966356AbXDGVhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966357AbXDGVhK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:37:10 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51811 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966356AbXDGVhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:37:09 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 48FFD5DEE4;
	Sat,  7 Apr 2007 23:37:08 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 26DB21F096;
	Sat,  7 Apr 2007 23:36:53 +0200 (CEST)
In-Reply-To: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43988>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/init.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index df2235f..46562d0 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -28,8 +28,8 @@ help = 'initialise the current branch for use with StGIT'
 usage = """%prog [options]
 
 Initialise the current GIT branch to be used as an StGIT stack. Note
-that the you must already be in a GIT repository and .git/HEAD must
-point to a valid file in refs/heads/."""
+that you must already be in a GIT repository and .git/HEAD must point
+to a valid file in refs/heads/."""
 
 options = []
 
