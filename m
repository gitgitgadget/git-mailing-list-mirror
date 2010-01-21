From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/1] git-rebase.txt: Fix spelling
Date: Thu, 21 Jan 2010 17:34:25 -0300
Message-ID: <1264106065-24682-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: gitster@pobox.com, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 22:34:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY4fh-0001kG-9N
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 22:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab0AUVeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 16:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657Ab0AUVeZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 16:34:25 -0500
Received: from inti.inf.utfsm.cl ([200.1.19.1]:39102 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090Ab0AUVeY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 16:34:24 -0500
X-Greylist: delayed 3108 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2010 16:34:24 EST
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by inti.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id o0LKYQov002235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 17:34:26 -0300
Received: from laptop14.inf.utfsm.cl (cautin.dcsc.utfsm.cl [200.1.21.41])
	by quelen.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id j0702dUF026998;
	Thu, 6 Jan 2005 21:02:39 -0300
Received: from laptop14.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id o0LKYchU024718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 17:34:38 -0300
Received: (from vonbrand@localhost)
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3/Submit) id o0LKYbsp024716;
	Thu, 21 Jan 2010 17:34:37 -0300
X-Mailer: git-send-email 1.6.6.1.383.g5a9f
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (inti.inf.utfsm.cl [0.0.0.0]); Thu, 21 Jan 2010 17:34:26 -0300 (CLST)
X-Spam-Status: No, score=-99.9 required=5.0 tests=AWL,UNPARSEABLE_RELAY,
	USER_IN_WHITELIST autolearn=failed version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137692>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-rebase.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 89a957e..823f2a4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -312,7 +312,7 @@ which makes little sense.
 	When the commit log message begins with "squash! ..." (or
 	"fixup! ..."), and there is a commit whose title begins with
 	the same ..., automatically modify the todo list of rebase -i
-	so that the commit marked for quashing come right after the
+	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
 	commit from `pick` to `squash` (or `fixup`).
 +
-- 
1.6.6.1.383.g5a9f
