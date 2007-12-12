From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Documentation: minor grammar fix for "git apply"
Date: Wed, 12 Dec 2007 09:14:20 +0100
Message-ID: <1197447260-93614-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 09:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Mk0-0004cb-P7
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXLLIOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbXLLIOb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:14:31 -0500
Received: from wincent.com ([72.3.236.74]:43625 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754700AbXLLIOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:14:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBC8ELKu015119;
	Wed, 12 Dec 2007 02:14:22 -0600
X-Mailer: git-send-email 1.5.3.7.1116.gf11de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68011>

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-apply.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index bae3e7b..9ec38f9 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -119,7 +119,7 @@ discouraged.
 
 --no-add::
 	When applying a patch, ignore additions made by the
-	patch.  This can be used to extract common part between
+	patch.  This can be used to extract the common part between
 	two files by first running `diff` on them and applying
 	the result with this option, which would apply the
 	deletion part but not addition part.
-- 
1.5.3.7.1116.gf11de
