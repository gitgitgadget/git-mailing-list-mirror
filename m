From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: [PATCH] Fix indentation of the -p, --patch option in git-add(1)
Date: Mon, 10 Dec 2007 14:40:20 +0100
Message-ID: <1197294020-1373-1-git-send-email-eyvind-git@orakel.ntnu.no>
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 10 14:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1j84-0004zx-1e
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 14:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbXLJN4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 08:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbXLJN4k
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 08:56:40 -0500
Received: from oslex.fast.no ([62.113.137.32]:47724 "EHLO OSLEX.fast.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbXLJN4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 08:56:39 -0500
X-Greylist: delayed 977 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2007 08:56:39 EST
Received: from localhost.localdomain ([192.168.2.159]) by OSLEX.fast.no with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 10 Dec 2007 14:40:20 +0100
X-Mailer: git-send-email 1.5.3.7.995.gdf9262
X-OriginalArrivalTime: 10 Dec 2007 13:40:20.0739 (UTC) FILETIME=[3538FD30:01C83B32]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67714>

Signed-off-by: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
---
 Documentation/git-add.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index bf94cd4..721ca99 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -65,7 +65,7 @@ OPTIONS
 	operation to a subset of the working tree. See ``Interactive
 	mode'' for details.
 
--p, \--patch:
+-p, \--patch::
 	Similar to Interactive mode but the initial command loop is
 	bypassed and the 'patch' subcommand is invoked using each of
 	the specified filepatterns before exiting.
-- 
1.5.3.7.995.gdf9262
