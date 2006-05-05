From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn 1.0.0
Date: Fri, 05 May 2006 12:35:40 -0700
Message-ID: <11468577403171-git-send-email-normalperson@yhbt.net>
References: <11468577403821-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 05 22:51:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc7Gz-0001mV-Pu
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWEEUve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWEEUvd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:51:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:11462 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751774AbWEEUvb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 16:51:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 53FF92DC035;
	Fri,  5 May 2006 13:51:31 -0700 (PDT)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11468577403821-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19643>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3680a525691232e2f45f2bcf63458e547ff109ba
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index e003501..de13a96 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -8,7 +8,7 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '0.11.0';
+$VERSION = '1.0.0';
 
 use Cwd qw/abs_path/;
 $GIT_DIR = abs_path($ENV{GIT_DIR} || '.git');
-- 
1.3.2.ge3d7
