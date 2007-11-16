From: Sergei Organov <osv@javad.com>
Subject: [PATCH] user-manual.txt: minor clarification.
Date: Fri, 16 Nov 2007 14:28:57 +0300
Message-ID: <87wssi1l2x.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 12:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IszSO-0006Eg-CN
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 12:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbXKPLdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 06:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838AbXKPLdj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 06:33:39 -0500
Received: from javad.com ([216.122.176.236]:4465 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411AbXKPLdi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 06:33:38 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAGBXWi09062;
	Fri, 16 Nov 2007 11:33:32 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IszRu-0000sM-KU; Fri, 16 Nov 2007 14:33:26 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65217>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/user-manual.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c7cfbbc..518b7b5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1567,9 +1567,9 @@ old history using, for example,
 $ git log master@{1}
 -------------------------------------------------
 
-This lists the commits reachable from the previous version of the head.
-This syntax can be used with any git command that accepts a commit,
-not just with git log.  Some other examples:
+This lists the commits reachable from the previous version of the
+"master" branch head.  This syntax can be used with any git command
+that accepts a commit, not just with git log.  Some other examples:
 
 -------------------------------------------------
 $ git show master@{2}		# See where the branch pointed 2,
-- 
1.5.3.4
