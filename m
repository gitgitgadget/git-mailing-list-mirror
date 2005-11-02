From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cogito: install cg-admin-setuprepo
Date: Wed, 02 Nov 2005 17:41:37 -0500
Message-ID: <1130971297.23026.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 23:44:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXRIz-0002tF-2I
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 23:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbVKBWl4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 17:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbVKBWlz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 17:41:55 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:50337 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965320AbVKBWlz
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 17:41:55 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EXRIj-0001ZN-FC
	for git@vger.kernel.org; Wed, 02 Nov 2005 17:41:52 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EXRIY-0008N1-2s; Wed, 02 Nov 2005 17:41:38 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11054>

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/Makefile b/Makefile
index 1b61953..c02cfcf 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,8 @@ SCRIPT=	cg-object-id cg-add cg-admin-lso
 	cg-branch-add cg-branch-ls cg-reset cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch \
 	cg-fetch cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
-	cg cg-admin-ls cg-push cg-branch-chg cg-admin-cat cg-clean
+	cg cg-admin-ls cg-push cg-branch-chg cg-admin-cat cg-clean \
+	cg-admin-setuprepo
 
 LIB_SCRIPT=cg-Xlib cg-Xmergefile cg-Xfetchprogress
 


-- 
Regards,
Pavel Roskin
