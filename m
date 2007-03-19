From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual.txt: fix a tiny typo.
Date: Sun, 18 Mar 2007 23:17:57 -0400
Message-ID: <39141.0089251169$1174274341@news.gmane.org>
References: <117427428145-git-send-email-> <1174274281887-git-send-email->
Cc: git@vger.kernel.org, Jim Meyering <jim@meyering.net>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8Ob-0000J6-EL
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933796AbXCSDSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbXCSDSJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45761 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933797AbXCSDSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:04 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003JX-K7; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
In-Reply-To: <1174274281887-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42572>

From: Jim Meyering <jim@meyering.net>

"file patch" was doubtless intended to be "file path",
but "directory name" is clearer.

Signed-off-by: Jim Meyering <jim@meyering.net>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0919574..773f65e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1698,7 +1698,7 @@ If you and maintainer both have accounts on the same machine, then
 then you can just pull changes from each other's repositories
 directly; note that all of the commands (gitlink:git-clone[1],
 git-fetch[1], git-pull[1], etc.) that accept a URL as an argument
-will also accept a local file patch; so, for example, you can
+will also accept a local directory name; so, for example, you can
 use
 
 -------------------------------------------------
-- 
1.5.0.3.31.ge47c
