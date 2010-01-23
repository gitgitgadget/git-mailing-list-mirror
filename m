From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: rev-list: fix synopsys for --tags and and
	--remotes
Date: Sat, 23 Jan 2010 08:26:26 +0100
Message-ID: <20100123072627.6509.86297.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 08:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYaLw-0001xK-Gg
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 08:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab0AWHYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 02:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703Ab0AWHYL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 02:24:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45847 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab0AWHYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 02:24:10 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 84146818019;
	Sat, 23 Jan 2010 08:24:00 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6DA2D8180E6;
	Sat, 23 Jan 2010 08:23:58 +0100 (CET)
X-git-sha1: bbd7ffdcadabe7f5b4614e058f7a2e825f486a45 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137813>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-list.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ae17c8a..173f3fc 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -22,8 +22,8 @@ SYNOPSIS
 	     [ \--not ]
 	     [ \--all ]
 	     [ \--branches[=pattern] ]
-	     [ \--tags=[pattern] ]
-	     [ \--remotes=[pattern] ]
+	     [ \--tags[=pattern] ]
+	     [ \--remotes[=pattern] ]
 	     [ \--glob=glob-pattern ]
 	     [ \--stdin ]
 	     [ \--quiet ]
-- 
1.6.6.1.557.g77031
