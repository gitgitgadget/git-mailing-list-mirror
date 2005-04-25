From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH COGITO] githelp.sh is not installed
Date: Mon, 25 Apr 2005 14:44:57 -0400
Message-ID: <1114454697.9003.1.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 25 20:42:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ8V6-0001m9-Nt
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDYSpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVDYSpI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:45:08 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:63431
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261718AbVDYSpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 14:45:03 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 186E0EFF5E; Mon, 25 Apr 2005 14:44:58 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

"make install" doesn't install githelp.sh

Signed-off-by: Pavel Roskin <proski@gnu.org>

Index: Makefile
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/Makefile  (mode:100644 sha1:0bbdbee6b6925b64af476de3cebde9b02f9b03ca)
+++ uncommitted/Makefile  (mode:100644)
@@ -36,7 +36,7 @@
 	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh \
 	gitapply.sh gitcancel.sh gitXlntree.sh gitlsremote.sh \
 	gitfork.sh gitinit.sh gitseek.sh gitstatus.sh gitpatch.sh \
-	gitmerge-file.sh
+	gitmerge-file.sh githelp.sh
 
 COMMON=	read-cache.o
 


-- 
Regards,
Pavel Roskin

