From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/6] user-manual: minor editing for conciseness
Date: Sun, 26 Aug 2007 12:16:58 -0400
Message-ID: <47129.6697076925$1188145040@news.gmane.org>
References: <11881450221019-git-send-email->
 <11881450231606-git-send-email->
Cc: git@vger.kernel.org,
	"J. Bruce Fields" <bfields@puzzle.fieldses.org>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKnb-00030a-Ew
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbXHZQRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXHZQRL
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:11 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57984 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKnP-0007Tw-4t; Sun, 26 Aug 2007 12:17:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11881450231606-git-send-email->
Message-Id: <a5f90f31302eb47cb1aa2f12447376ff9332abef.1188139206.git.bfields@citi.umich.edu>
In-Reply-To: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
References: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56697>

From: J. Bruce Fields <bfields@puzzle.fieldses.org>

Just cutting out a few unnecessary words.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0331bad..933177a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -42,10 +42,9 @@ How to get a git repository
 It will be useful to have a git repository to experiment with as you
 read this manual.
 
-The best way to get one is by using the gitlink:git-clone[1] command
-to download a copy of an existing repository for a project that you
-are interested in.  If you don't already have a project in mind, here
-are some interesting examples:
+The best way to get one is by using the gitlink:git-clone[1] command to
+download a copy of an existing repository.  If you don't already have a
+project in mind, here are some interesting examples:
 
 ------------------------------------------------
 	# git itself (approx. 10MB download):
@@ -63,9 +62,6 @@ directory, you will see that it contains a copy of the project files,
 together with a special top-level directory named ".git", which
 contains all the information about the history of the project.
 
-In most of the following, examples will be taken from one of the two
-repositories above.
-
 [[how-to-check-out]]
 How to check out a different version of a project
 -------------------------------------------------
-- 
1.5.3.rc5.19.g0734d
