From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] fixed link in documentation of diff-options
Date: Tue,  2 Oct 2007 08:14:37 +0200
Message-ID: <11913056772885-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 08:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icb1q-0001fI-It
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 08:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbXJBGOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 02:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbXJBGOj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 02:14:39 -0400
Received: from mailer.zib.de ([130.73.108.11]:42997 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbXJBGOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 02:14:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l926EbLZ020030
	for <git@vger.kernel.org>; Tue, 2 Oct 2007 08:14:37 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l926EbGI022687;
	Tue, 2 Oct 2007 08:14:37 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59663>


Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/diff-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 228ccaf..b1f528a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -179,8 +179,8 @@
 
 --ext-diff::
 	Allow an external diff helper to be executed. If you set an
-	external diff driver with gitlink:gitattributes(5), you need
-	to use this option with gitlink:git-log(1) and friends.
+	external diff driver with gitlink:gitattributes[5], you need
+	to use this option with gitlink:git-log[1] and friends.
 
 --no-ext-diff::
 	Disallow external diff drivers.
-- 
1.5.3.3.127.g40d17
