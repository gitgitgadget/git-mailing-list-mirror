From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [PATCH] several typos in tutorial
Date: Thu, 2 Jun 2005 16:02:07 +0400
Message-ID: <200506021602.07258.snake@penza-gsm.ru>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexey Nezhdanov <snake@penza-gsm.ru>
X-From: git-owner@vger.kernel.org Thu Jun 02 14:04:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdoPs-000182-7g
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 14:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFBMGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 08:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFBMGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 08:06:16 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:29921
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261382AbVFBMGO
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 08:06:14 -0400
Received: (qmail 20757 invoked from network); 2 Jun 2005 12:06:12 -0000
Received: from unknown (HELO nezhdanov.penza-gsm.ru) (192.168.4.99)
  by fileserver.penza-gsm.ru with SMTP; 2 Jun 2005 12:06:10 -0000
Received: (qmail 9179 invoked by uid 1000); 2 Jun 2005 12:06:10 -0000
X-KMail-Identity: 1411969544
X-KMail-Fcc: =?koi8-r?q?=2E=F2=C1=D3=D3=D9=CC=CB=C9=2Edirectory/=2Elinux-related=2Edir?=
 =?koi8-r?q?ectory/git?=
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.7.2
In-Reply-To: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
X-KMail-Link-Message: 239188
X-KMail-Link-Type: reply
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alexey Nezhdanov <snake@penza-gsm.ru>
---
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -298,7 +298,7 @@ have committed something, we can also le
 
 Unlike "git-diff-files", which showed the difference between the index
 file and the working directory, "git-diff-cache" shows the differences
-between a committed _tree_ and the index file.  In other words,
+between a committed _tree_ and the working directory.  In other words,
 git-diff-cache wants a tree to be diffed against, and before we did the
 commit, we couldn't do that, because we didn't have anything to diff
 against. 
@@ -423,8 +423,8 @@ With that, you should now be having some
 can explore on your own.
 
 
-	Copoying archives
-	-----------------
+	Copying archives
+	----------------
 
 Git arhives are normally totally self-sufficient, and it's worth noting
 that unlike CVS, for example, there is no separate notion of

