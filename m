From: Ivan Stankovic <pokemon@fly.srk.fer.hr>
Subject: [PATCH] Documentation: fix invalid reference to 'mybranch' in user manual
Date: Sun, 10 Aug 2008 18:22:14 +0200
Message-ID: <1218385334-15893-1-git-send-email-pokemon@fly.srk.fer.hr>
Cc: Ivan Stankovic <pokemon@fly.srk.fer.hr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 18:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSE3B-00074r-Lv
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 18:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYHJQos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 12:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbYHJQos
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 12:44:48 -0400
Received: from fly.srk.fer.hr ([161.53.74.66]:55184 "EHLO fly.srk.fer.hr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbYHJQor (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 12:44:47 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Aug 2008 12:44:47 EDT
Received: from localhost (localhost [127.0.0.1])
	by fly.srk.fer.hr (Postfix) with ESMTP id 995B61404D;
	Sun, 10 Aug 2008 18:22:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at fly.srk.fer.hr
Received: from fly.srk.fer.hr ([127.0.0.1])
	by localhost (fly.srk.fer.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5ZZEsP81v1I; Sun, 10 Aug 2008 18:22:14 +0200 (CEST)
Received: by fly.srk.fer.hr (Postfix, from userid 39115)
	id 801691404C; Sun, 10 Aug 2008 18:22:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.4.rc1.23.g3a969
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91856>

Signed-off-by: Ivan Stankovic <pokemon@fly.srk.fer.hr>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f421689..86c1e65 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2826,7 +2826,7 @@ $ git config remote.example.fetch +master:ref/remotes/example/master
 -------------------------------------------------
 
 Don't do this unless you're sure you won't mind "git-fetch" possibly
-throwing away commits on mybranch.
+throwing away commits on `example/master` branch.
 
 Also note that all of the above configuration can be performed by
 directly editing the file .git/config instead of using
-- 
1.5.4.rc1.23.g3a969
