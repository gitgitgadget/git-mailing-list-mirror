From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Documentation: Point to gitcli(7) from git(1)
Date: Wed,  2 Jul 2008 10:13:35 -0400
Message-ID: <1215008015-7845-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE36U-0007dF-9b
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbYGBONl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYGBONl
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:13:41 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:58653 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbYGBONk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 10:13:40 -0400
Received: from localhost.localdomain (dfpub107.digitalfocus.com [65.120.79.7])
	by silverinsanity.com (Postfix) with ESMTP id 8896A1FFC02D;
	Wed,  2 Jul 2008 14:13:34 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.1.243.g6b82b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87140>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 Documentation/git.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f9e4416..2b20b0d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -601,7 +601,7 @@ SEE ALSO
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-link:user-manual.html[The Git User's Manual]
+linkgit:gitcli[7], link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-- 
1.5.6.1.243.g6b82b
