From: henrik@austad.us
Subject: [PATCH 1/2] Use capitalized names where appropriate
Date: Mon,  5 Jan 2009 16:25:36 +0100
Message-ID: <1231169137-32653-2-git-send-email-henrik@austad.us>
References: <1231169137-32653-1-git-send-email-henrik@austad.us>
Cc: Henrik Austad <henrik@austad.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 17:20:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJsC3-000435-AB
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 17:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbZAEQTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 11:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZAEQTR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 11:19:17 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:50058 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbZAEQTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 11:19:16 -0500
Received: from januz.myftp.org (084202164248.customer.alfanett.no [84.202.164.248])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n05FPaON001300;
	Mon, 5 Jan 2009 16:25:37 +0100 (MET)
Received: by januz.myftp.org (Postfix, from userid 1000)
	id 73779140D8; Mon,  5 Jan 2009 16:25:37 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc2
In-Reply-To: <1231169137-32653-1-git-send-email-henrik@austad.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104584>

From: Henrik Austad <henrik@austad.us>

The Linux kernel and Emacs are both spelled capitalized

Signed-off-by: Henrik Austad <henrik@austad.us>
---
 Documentation/gittutorial.txt |    4 ++--
 Documentation/user-manual.txt |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 7892244..458fafd 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -590,7 +590,7 @@ list.  When the history has lines of development that diverged and
 then merged back together, the order in which 'git-log' presents
 those commits is meaningless.
 
-Most projects with multiple contributors (such as the linux kernel,
+Most projects with multiple contributors (such as the Linux kernel,
 or git itself) have frequent merges, and 'gitk' does a better job of
 visualizing their history.  For example,
 
@@ -642,7 +642,7 @@ digressions that may be interesting at this point are:
 
   * linkgit:git-format-patch[1], linkgit:git-am[1]: These convert
     series of git commits into emailed patches, and vice versa,
-    useful for projects such as the linux kernel which rely heavily
+    useful for projects such as the Linux kernel which rely heavily
     on emailed patches.
 
   * linkgit:git-bisect[1]: When there is a regression in your
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d4b1e90..5242a7e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -59,7 +59,7 @@ project in mind, here are some interesting examples:
 ------------------------------------------------
 	# git itself (approx. 10MB download):
 $ git clone git://git.kernel.org/pub/scm/git/git.git
-	# the linux kernel (approx. 150MB download):
+	# the Linux kernel (approx. 150MB download):
 $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 ------------------------------------------------
 
@@ -1340,7 +1340,7 @@ These will display all commits which exist only on HEAD or on
 MERGE_HEAD, and which touch an unmerged file.
 
 You may also use linkgit:git-mergetool[1], which lets you merge the
-unmerged files using external tools such as emacs or kdiff3.
+unmerged files using external tools such as Emacs or kdiff3.
 
 Each time you resolve the conflicts in a file and update the index:
 
-- 
1.6.1.36.g8430e
