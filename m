From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Fix trivial typo in git-log man page.
Date: Fri, 28 Apr 2006 09:15:03 -0400
Message-ID: <BAYC1-PASMTP0933E0E4DDF253A9478776AEB20@CEZ.ICE>
Reply-To: Sean Estabrooks <seanlkml@sympatico.ca>
Cc: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Apr 28 15:19:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZSso-0004Y7-Lj
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 15:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWD1NTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWD1NTh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 09:19:37 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:27645 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1030392AbWD1NTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 09:19:36 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from guru.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 06:21:08 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by guru.attic.local (Postfix) with ESMTP id 7D07B7001EA;
	Fri, 28 Apr 2006 09:15:06 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <11462301062278-git-send-email-seanlkml@sympatico.ca>
X-Mailer: git-send-email 1.3.1.gc672
X-OriginalArrivalTime: 28 Apr 2006 13:21:08.0687 (UTC) FILETIME=[9C698DF0:01C66AC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/git-log.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

0afa7822c6a0d6ffa82f9d9b64c78df8587e190d
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 76cb894..af378ff 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -14,13 +14,12 @@ DESCRIPTION
 -----------
 Shows the commit logs.
 
-The command takes options applicable to the gitlink::git-rev-list[1]
+The command takes options applicable to the gitlink:git-rev-list[1]
 command to control what is shown and how, and options applicable to
-the gitlink::git-diff-tree[1] commands to control how the change
+the gitlink:git-diff-tree[1] commands to control how the change
 each commit introduces are shown.
 
-This manual page describes only the most frequently used
-options.
+This manual page describes only the most frequently used options.
 
 
 OPTIONS
-- 
1.3.1.gc672
