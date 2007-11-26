From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Fix typo in 1.5.4 release notes
Date: Mon, 26 Nov 2007 09:34:48 +0100
Message-ID: <1196066088-9558-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 09:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZR0-0003mO-Vr
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbXKZIe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 03:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbXKZIe7
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 03:34:59 -0500
Received: from wincent.com ([72.3.236.74]:37967 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbXKZIe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 03:34:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQ8Yo1R032522;
	Mon, 26 Nov 2007 02:34:51 -0600
X-Mailer: git-send-email 1.5.3.6.950.g92b7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66053>

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/RelNotes-1.5.4.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index ff4d3d8..c9c5376 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -26,7 +26,7 @@ Updates since v1.5.3
  * In git-rebase, when you decide not to replay a particular change
    after the command stopped with a conflict, you can say "git-rebase
    --skip" without first running "git reset --hard", as the command now
-   run it for you.
+   runs it for you.
 
  * git-remote knows --mirror mode.
 
-- 
1.5.3.6.950.g92b7b
