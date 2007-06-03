From: merlyn@blue.stonehenge.com (Randal L. Schwartz)
Subject: (unknown)
Date: Sun,  3 Jun 2007 08:30:20 -0700 (PDT)
Message-ID: <20070603153020.BE3341DE4CC@blue.stonehenge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 17:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HusRg-0002Mf-2o
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 17:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbXFCP4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 11:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbXFCP4h
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 11:56:37 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:18107 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbXFCP4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 11:56:37 -0400
X-Greylist: delayed 1576 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2007 11:56:37 EDT
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id BE3341DE4CC; Sun,  3 Jun 2007 08:30:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49010>

>From 8948e5c81bf39ca7a8118746e4ca60b3b1566efa Mon Sep 17 00:00:00 2001
From: Randal L. Schwartz <merlyn@stonehenge.com>
Date: Sun, 3 Jun 2007 08:27:52 -0700
Subject: [PATCH] Add test-sha1 to .gitignore.

---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 15aed70..8e75c99 100644
--- a/.gitignore
+++ b/.gitignore
@@ -151,6 +151,7 @@ test-delta
 test-dump-cache-tree
 test-genrandom
 test-match-trees
+test-sha1
 common-cmds.h
 *.tar.gz
 *.dsc
-- 
1.5.2.1.111.gc94b
