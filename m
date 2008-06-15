From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: RelNotes-1.5.6: talk about renamed HTML
 files
Date: Sun, 15 Jun 2008 15:39:20 +0200
Message-ID: <20080615153920.f60178b3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7sOu-0000jz-BK
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757437AbYFONfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 09:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757442AbYFONfO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:35:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47922 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbYFONfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 09:35:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E17861AB311;
	Sun, 15 Jun 2008 15:35:10 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B9A271AB2F7;
	Sun, 15 Jun 2008 15:35:09 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85090>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/RelNotes-1.5.6.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.5.6.txt b/Documentation/RelNotes-1.5.6.txt
index 0d2608c..b22bfa8 100644
--- a/Documentation/RelNotes-1.5.6.txt
+++ b/Documentation/RelNotes-1.5.6.txt
@@ -21,8 +21,10 @@ Updates since v1.5.5
 (documentation)
 
 * Many freestanding documentation pages have been converted and made
-  available to "git help" (aka "man git-<command>") as section 7 of the
-  manual pages.
+  available to "git help" (aka "man git<something>") as section 7 of
+  the manual pages. This means bookmarks to some HTML documentation
+  files may need to be updated (eg "tutorial.html" became
+  "gittutorial.html").
 
 (performance)
 
-- 
1.5.6.rc3
