From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] gitcvs-migration: Link to git-cvsimport documentation
Date: Sat, 18 Apr 2009 16:38:42 +0200
Message-ID: <1240065522-23647-1-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 18 16:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvBiK-00038I-7x
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 16:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbZDROim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 10:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZDROim
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 10:38:42 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:50451 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294AbZDROim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 10:38:42 -0400
Received: from mail.lenk.info ([78.47.143.197] ident=Debian-exim)
	by mx.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvBgm-0004XP-Sx; Sat, 18 Apr 2009 16:38:40 +0200
Received: from p57b2734b.dip.t-dialin.net ([87.178.115.75] helo=penrose.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvBgi-00012l-2P; Sat, 18 Apr 2009 16:38:36 +0200
Received: from flichtenheld by penrose.djpig.de with local (Exim 4.69)
	(envelope-from <flichtenheld@astaro.com>)
	id 1LvBgo-00069q-Oo; Sat, 18 Apr 2009 16:38:42 +0200
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116827>

From: Frank Lichtenheld <flichtenheld@astaro.com>

Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
---
 Documentation/gitcvs-migration.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index aaa7ef7..0e49c1c 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -118,7 +118,7 @@ Importing a CVS archive
 First, install version 2.1 or higher of cvsps from
 link:http://www.cobite.com/cvsps/[http://www.cobite.com/cvsps/] and make
 sure it is in your path.  Then cd to a checked out CVS working directory
-of the project you are interested in and run 'git-cvsimport':
+of the project you are interested in and run linkgit:git-cvsimport[1]:
 
 -------------------------------------------
 $ git cvsimport -C <destination> <module>
-- 
1.6.2.1
