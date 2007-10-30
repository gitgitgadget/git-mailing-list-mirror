From: "Michael W. Olson" <mwolson@gnu.org>
Subject: [PATCH] Documentation/git-cvsexportcommit.txt: s/mgs/msg/ in example
Date: Tue, 30 Oct 2007 09:53:47 -0400
Message-ID: <1193752427-21280-1-git-send-email-mwolson@gnu.org>
Cc: "Michael W. Olson" <mwolson@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 14:54:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImrY1-0004pG-1Y
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 14:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbXJ3NyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbXJ3NyK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 09:54:10 -0400
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:42192 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753246AbXJ3NyI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 09:54:08 -0400
Received: from ip6-localhost (host-212-116.inlacol.clients.pavlovmedia.com [66.253.212.116])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.13.7/8.13.7/auth-smtp.purdue.edu) with ESMTP id l9UDrnVo019325
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Tue, 30 Oct 2007 09:54:06 -0400
Received: from mwolson by ip6-localhost with local (Exim 4.67)
	(envelope-from <mwolson@hariken.mwolson.org>)
	id 1ImrXP-0005XY-Rs; Tue, 30 Oct 2007 09:53:47 -0400
X-Mailer: git-send-email 1.5.3.4
X-PMX-Version: 5.2.1.279297
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-cvsexportcommit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 4c8d1e6..c3922f9 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -73,7 +73,7 @@ Merge one patch into CVS::
 $ export GIT_DIR=~/project/.git
 $ cd ~/project_cvs_checkout
 $ git-cvsexportcommit -v <commit-sha1>
-$ cvs commit -F .mgs <files>
+$ cvs commit -F .msg <files>
 ------------
 
 Merge pending patches into CVS automatically -- only if you really know what you are doing::
-- 
1.5.3.4
