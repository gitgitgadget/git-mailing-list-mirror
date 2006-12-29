From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Add info about new test families (8 and 9) to t/README
Date: Fri, 29 Dec 2006 14:39:09 +0100
Message-ID: <11673995494031-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 29 14:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0HuK-0001IK-4S
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 14:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbWL2NgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 08:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbWL2NgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 08:36:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:35998 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbWL2NgP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 08:36:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4387928uga
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 05:36:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=BHNs5aILGn2zPI6HJNy6pOovOkXoqhBnWl2JZ8e/WfeFaSi4RHxwP/d4NqMHxHHMu+Vp9kMm2u9kh5t//MZD0cKpI99n30bLYFBdk7ZL7XxkyJOxnppKvYFvmRfuXZ5GGpac0eq+S+yFzAsQ7mxi6wWgt4bLVlaidmj95lYoW7w=
Received: by 10.67.97.7 with SMTP id z7mr9478440ugl.1167399374199;
        Fri, 29 Dec 2006 05:36:14 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.56])
        by mx.google.com with ESMTP id s1sm21859958uge.2006.12.29.05.36.13;
        Fri, 29 Dec 2006 05:36:13 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id kBTDdA0t003482;
	Fri, 29 Dec 2006 14:39:11 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id kBTDd9mO003481;
	Fri, 29 Dec 2006 14:39:09 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35592>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/README |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index c5db580..7abab1d 100644
--- a/t/README
+++ b/t/README
@@ -74,6 +74,8 @@ First digit tells the family:
 	5 - the pull and exporting commands
 	6 - the revision tree commands (even e.g. merge-base)
 	7 - the porcelainish commands concerning the working tree
+	8 - the porcelainish commands concerning forensics
+	9 - the git tools
 
 Second digit tells the particular command we are testing.
 
-- 
1.4.4.3
