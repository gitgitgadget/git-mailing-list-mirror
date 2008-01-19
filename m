From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] doc typo: s/prior committing/prior to committing/
Date: Sat, 19 Jan 2008 16:23:32 +0100
Message-ID: <87k5m5et57.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 16:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFYG-0007ga-Ed
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760093AbYASPXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760089AbYASPXf
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:23:35 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:46196 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758822AbYASPXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:23:34 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 981A717B56B
	for <git@vger.kernel.org>; Sat, 19 Jan 2008 16:23:33 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 81DF117B561
	for <git@vger.kernel.org>; Sat, 19 Jan 2008 16:23:33 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id D6E9F34934
	for <git@vger.kernel.org>; Sat, 19 Jan 2008 16:23:32 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71116>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 3bcc12c..877ab66 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -24,7 +24,7 @@ OPTIONS

 -e|--edit::
 	With this option, `git-cherry-pick` will let you edit the commit
-	message prior committing.
+	message prior to committing.

 -x::
 	When recording the commit, append to the original commit
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 494fc7f..93e20f7 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -24,7 +24,7 @@ OPTIONS

 -e|--edit::
 	With this option, `git-revert` will let you edit the commit
-	message prior committing the revert. This is the default if
+	message prior to committing the revert. This is the default if
 	you run the command from a terminal.

 -m parent-number|--mainline parent-number::
--
1.5.4.rc3.38.g3c92
