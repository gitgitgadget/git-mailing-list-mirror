From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Add gitweb.cgi to .gitignore
Date: Sun,  6 Aug 2006 12:47:33 +0200
Message-ID: <11548612533788-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Sun Aug 06 12:47:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9gAj-0006oa-1M
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 12:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWHFKru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 06:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWHFKrt
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 06:47:49 -0400
Received: from mail15.bluewin.ch ([195.186.18.63]:56309 "EHLO
	mail15.bluewin.ch") by vger.kernel.org with ESMTP id S932540AbWHFKrt
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 06:47:49 -0400
Received: from spinlock.ch (83.76.49.236) by mail15.bluewin.ch (Bluewin 7.3.110.2)
        id 4492529600BBDE41; Sun, 6 Aug 2006 10:47:45 +0000
Received: (nullmailer pid 18606 invoked by uid 1000);
	Sun, 06 Aug 2006 10:47:33 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc3.g59e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24972>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2299e36..b2feba5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@ git-verify-tag
 git-whatchanged
 git-write-tree
 git-core-*/?*
+gitweb/gitweb.cgi
 test-date
 test-delta
 test-dump-cache-tree
-- 
1.4.2.rc3.g59e1
