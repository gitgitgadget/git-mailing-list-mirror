From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH 2/3] builtin-remote: fix typo in option description
Date: Fri, 17 Apr 2009 19:13:29 +0100
Message-ID: <1239992010-16698-3-git-send-email-mike@abacus.co.uk>
References: <1239992010-16698-1-git-send-email-mike@abacus.co.uk>
 <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lusyi-0008E2-Jg
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760075AbZDQSiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759830AbZDQSiO
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:38:14 -0400
Received: from [82.109.193.99] ([82.109.193.99]:31743 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759511AbZDQSiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:38:13 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id 1A8A21D539A; Fri, 17 Apr 2009 19:13:30 +0100 (BST)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
In-Reply-To: <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116771>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ca7c639..2ed752c 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1216,7 +1216,7 @@ static int update(int argc, const char **argv)
 	struct option options[] = {
 		OPT_GROUP("update specific options"),
 		OPT_BOOLEAN('p', "prune", &prune,
-			    "prune remotes after fecthing"),
+			    "prune remotes after fetching"),
 		OPT_END()
 	};
 
-- 
1.6.0.2.229.g1293c.dirty
