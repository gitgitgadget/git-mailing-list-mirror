From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: [PATCH] Documentation/git-request-pull: Fixed a typo ("send" -> "end")
Date: Wed,  9 Apr 2008 22:20:10 +0200
Message-ID: <12077724101577-git-send-email-newsletter@dirk.my1.cc>
Cc: Junio C Hamano <gitster@pobox.com>,
	Dirk Suesserott <newsletter@dirk.my1.cc>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 22:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjgmz-0004NA-0P
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbYDIUUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbYDIUUQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:20:16 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:37354 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbYDIUUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:20:15 -0400
Received: from [84.176.63.240] (helo=wurst.suesserott.de)
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JjgmC-0000Lj-Ot; Wed, 09 Apr 2008 22:20:13 +0200
X-Mailer: git-send-email 1.5.3.mingw.1.142.g63611
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79130>

From: Dirk Suesserott <newsletter@dirk.my1.cc>

Signed-off-by: Dirk Suesserott <newsletter@dirk.my1.cc>
---
 Documentation/git-request-pull.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 270df9b..9a14c04 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -24,7 +24,7 @@ OPTIONS
 	URL to include in the summary.
 
 <end>::
-	Commit to send at; defaults to HEAD.
+	Commit to end at; defaults to HEAD.
 
 Author
 ------
-- 
1.5.4.2.1161.g1a6f0
