From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 5/6] user-manual: fix incorrect header level
Date: Sun, 26 Aug 2007 12:17:01 -0400
Message-ID: <43080.5303542458$1188145040@news.gmane.org>
References: <11881450221019-git-send-email->
 <11881450231606-git-send-email->
 <11881450231010-git-send-email->
 <11881450233251-git-send-email->
 <11881450231946-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKna-00030a-SD
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbXHZQRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbXHZQRK
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:10 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57988 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKnP-0007U2-Aw; Sun, 26 Aug 2007 12:17:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11881450231946-git-send-email->
Message-Id: <d5821de2e29a3a207a2c5188f73b7d1f6d52fc34.1188139206.git.bfields@citi.umich.edu>
In-Reply-To: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
References: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56696>

From: J. Bruce Fields <bfields@citi.umich.edu>

This section is a subsection of the "Examples" section.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 77e73bf..1c3f0e6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -914,7 +914,7 @@ they look OK.
 
 [[Finding-comments-with-given-content]]
 Finding commits referencing a file with given content
------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Somebody hands you a copy of a file, and asks which commits modified a
 file such that it contained the given content either before or after the
-- 
1.5.3.rc5.19.g0734d
