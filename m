From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 4/6] user-manual: fix missing colon in git-show example
Date: Sat, 10 Mar 2007 23:35:29 -0500
Message-ID: <11735877343565-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu> <11735877321525-git-send-email-bfields@citi.umich.edu> <11735877332438-git-send-email-bfields@citi.umich.edu> <11735877331883-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:35:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFmX-0000iw-Pl
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbXCKEfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933064AbXCKEfi
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:38 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50345
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933055AbXCKEfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:38 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZYhS022233;
	Sat, 10 Mar 2007 23:35:34 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4ZYs9022232;
	Sat, 10 Mar 2007 23:35:34 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11735877331883-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41903>

From: J. Bruce Fields <bfields@citi.umich.edu>

There should be a colon in this git-show example.

Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f4ea967..1e151b4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1431,7 +1431,7 @@ modifying the working directory, you can do that with
 gitlink:git-show[1]:
 
 -------------------------------------------------
-$ git show HEAD^ path/to/file
+$ git show HEAD^:path/to/file
 -------------------------------------------------
 
 which will display the given version of the file.
-- 
1.5.0.gb75812-dirty
