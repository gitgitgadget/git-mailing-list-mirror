From: mhagger@alum.mit.edu
Subject: [PATCH] Fix typo in 1.7.9 release notes
Date: Mon, 23 Jan 2012 13:09:58 +0100
Message-ID: <1327320598-28683-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 13:10:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpIiy-0006rj-RY
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 13:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab2AWMKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 07:10:06 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:47575 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2AWMKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 07:10:05 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RpIYS-0007ZS-Dc; Mon, 23 Jan 2012 12:59:20 +0100
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188988>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/RelNotes/1.7.9.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes/1.7.9.txt b/Documentation/RelNotes/1.7.9.txt
index 9b0a6eb..f1294b4 100644
--- a/Documentation/RelNotes/1.7.9.txt
+++ b/Documentation/RelNotes/1.7.9.txt
@@ -63,7 +63,7 @@ Updates since v1.7.8
    knows MATLAB.
 
  * "git log --format='<format>'" learned new %g[nNeE] specifiers to
-   show information from the reflog entries when warlking the reflog
+   show information from the reflog entries when walking the reflog
    (i.e. with "-g").
 
  * "git pull" can be used to fetch and merge an annotated/signed tag,
-- 
1.7.8.3
