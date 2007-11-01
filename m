From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git-filter-branch.txt: fix a typo.
Date: Thu, 01 Nov 2007 16:24:11 +0300
Message-ID: <87r6ja2j5w.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 14:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ina2C-0003ui-CS
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbXKANYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXKANYT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:24:19 -0400
Received: from javad.com ([216.122.176.236]:3614 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbXKANYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:24:18 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA1DOHm46706
	for <git@vger.kernel.org>; Thu, 1 Nov 2007 13:24:17 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Ina1r-0001iZ-EK
	for git@vger.kernel.org; Thu, 01 Nov 2007 16:24:11 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62957>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ba9b4fb..385ecc9 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -219,7 +219,7 @@ git filter-branch --commit-filter '
 	fi' HEAD
 ------------------------------------------------------------------------------
 
-The function 'skip_commits' is defined as follows:
+The function 'skip_commit' is defined as follows:
 
 --------------------------
 skip_commit()
-- 
1.5.3.4
