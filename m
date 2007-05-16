From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Fixed link in user-manual
Date: Wed, 16 May 2007 07:48:47 +0200
Message-ID: <1179294527336-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 07:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoCOU-0003TL-4a
	for gcvg-git@gmane.org; Wed, 16 May 2007 07:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761314AbXEPFtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 01:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761374AbXEPFtp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 01:49:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:40151 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314AbXEPFto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 01:49:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4G5mmA6026016
	for <git@vger.kernel.org>; Wed, 16 May 2007 07:49:43 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4G5mlZp019264;
	Wed, 16 May 2007 07:48:48 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47412>

link to git-mergetool was broken.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 13db969..dd1578d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1357,7 +1357,7 @@ $ gitk --merge
 These will display all commits which exist only on HEAD or on
 MERGE_HEAD, and which touch an unmerged file.
 
-You may also use gitlink:git-mergetool, which lets you merge the
+You may also use gitlink:git-mergetool[1], which lets you merge the
 unmerged files using external tools such as emacs or kdiff3.
 
 Each time you resolve the conflicts in a file and update the index:
-- 
1.5.1.2
