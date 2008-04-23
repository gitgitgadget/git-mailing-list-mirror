From: Matt Graham <mdg149@gmail.com>
Subject: [PATCH] Linked glossary from cvs-migration page
Date: Wed, 23 Apr 2008 09:13:51 -0400
Message-ID: <1208956431-1955-1-git-send-email-mdg149@gmail.com>
Cc: git@vger.kernel.org, Matt Graham <mdg149@gmail.com>
To: gitster@pobox.com, bfields@citi.umich.edu
X-From: git-owner@vger.kernel.org Wed Apr 23 15:22:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoevH-0008E8-GE
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 15:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYDWNVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 09:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbYDWNVQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 09:21:16 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:49568 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbYDWNVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 09:21:15 -0400
Received: from localhost.localdomain ([70.107.49.200])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JZS00B3B4YDJ7I0@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 23 Apr 2008 08:18:14 -0500 (CDT)
X-Mailer: git-send-email 1.5.5.49.gf43e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80215>

Coming from CVS, I found the git glossary vital to learning git and learning
how terms in git correlate to the cvs terminology with which I am familiar.

This patch links the glossary from the cvs-migration page so cvs users will
be able to fine the glossary as soon as they start looking at git documents.

Signed-off-by: Matt Graham <mdg149@gmail.com>
---
 Documentation/cvs-migration.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index ea98900..00f2e36 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -8,7 +8,8 @@ designating a single shared repository which people can synchronize with;
 this document explains how to do that.
 
 Some basic familiarity with git is required.  This
-link:tutorial.html[tutorial introduction to git] should be sufficient.
+link:tutorial.html[tutorial introduction to git] and the
+link:glossary.html[git glossary] should be sufficient.
 
 Developing against a shared repository
 --------------------------------------
-- 
1.5.5.49.gf43e2
