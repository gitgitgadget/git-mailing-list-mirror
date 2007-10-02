From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix typo in config.txt
Date: Tue, 2 Oct 2007 21:14:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710022114070.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 22:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ico9q-0003GU-VO
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbXJBUPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbXJBUPr
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:15:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:47818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752324AbXJBUPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:15:46 -0400
Received: (qmail invoked by alias); 02 Oct 2007 20:15:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 02 Oct 2007 22:15:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+s+eAJj2+sURZ0bBn/terLPtoTO/SZTsyrK7m1Wb
	0Xte1vpHJ74uQV
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59724>


There was an 'l' (ell) instead of a '1' (one) in one of the gitlinks.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 328487b..6b2fc82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -599,7 +599,7 @@ merge.summary::
 
 merge.tool::
 	Controls which merge resolution program is used by
-	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
+	gitlink:git-mergetool[1].  Valid values are: "kdiff3", "tkdiff",
 	"meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and "opendiff".
 
 merge.verbosity::
-- 
1.5.3.3.1147.g47f44
