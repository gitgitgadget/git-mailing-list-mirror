From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Conjugate "search" correctly in the git-prune-packed man page.
Date: Fri, 21 Sep 2007 07:37:18 -0700
Message-ID: <11903854383085-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 16:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYjdJ-0004UH-NQ
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 16:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758680AbXIUOhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 10:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758323AbXIUOhX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 10:37:23 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:43405 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176AbXIUOhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 10:37:22 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1IYjtd-0002Gt-7j; Fri, 21 Sep 2007 07:54:21 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1IYjd8-0003CN-Kj; Fri, 21 Sep 2007 07:37:18 -0700
X-Mailer: git-send-email 1.5.3.1
X-Spam-Score: -4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58858>


Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Documentation/git-prune-packed.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 3800edb..9f85f38 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This program search the `$GIT_OBJECT_DIR` for all objects that currently
+This program searches the `$GIT_OBJECT_DIR` for all objects that currently
 exist in a pack file as well as the independent object directories.
 
 All such extra objects are removed.
-- 
1.5.3.1
