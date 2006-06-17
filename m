From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Update gitweb README: gitweb is now included with git
Date: Sat, 17 Jun 2006 08:53:45 +0200
Organization: At home
Message-ID: <e708tr$ea8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 17 08:54:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrUh7-0007BA-Fq
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 08:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWFQGyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 02:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWFQGyG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 02:54:06 -0400
Received: from main.gmane.org ([80.91.229.2]:24197 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932360AbWFQGyE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 02:54:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrUgr-00078N-AQ
	for git@vger.kernel.org; Sat, 17 Jun 2006 08:53:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 08:53:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 08:53:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22005>

---
ftp://ftp.kernel.org/pub/software/scm/gitweb/  and
http://www.kernel.org/pub/software/scm/gitweb/ are empty.

http://www.kernel.org/git/?p=git/gitweb.git;a=summary
does not exist.


 gitweb/README |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

52fffe22be5fc02045ee630c755dab5713afb4fb
diff --git a/gitweb/README b/gitweb/README
index 3014d73..8d67276 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -3,14 +3,7 @@ GIT web Interface
 The one working on:
   http://www.kernel.org/git/
 
-Get the gitweb.cgi by ftp:
-  ftp://ftp.kernel.org/pub/software/scm/gitweb/
-
-It reqires the git-core binaries installed on the system:
-  http://www.kernel.org/git/?p=git/git.git;a=summary
-
-The gitweb repository is here:
-  http://www.kernel.org/git/?p=git/gitweb.git;a=summary
+From the git version 1.4.0 gitweb is bundled with git.
 
 Any comment/question/concern to:
   Kay Sievers <kay.sievers@vrfy.org>
-- 
1.3.0
