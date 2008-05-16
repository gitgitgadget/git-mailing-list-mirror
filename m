From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-read-tree: document -v option.
Date: Fri, 16 May 2008 02:08:35 +0200
Message-ID: <1210896515-5202-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 02:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwnVl-0007JC-5U
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 02:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbYEPAIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756922AbYEPAIf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 20:08:35 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:51152 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYEPAIe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 20:08:34 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id DD82A1DDC5B;
	Fri, 16 May 2008 02:08:32 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 88ACF185E19; Fri, 16 May 2008 02:08:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82246>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-read-tree.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 8421d1f..179f4e1 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -50,6 +50,9 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.
 
+-v::
+        Be verbose.
+
 --trivial::
 	Restrict three-way merge by `git-read-tree` to happen
 	only if there is no file-level merging required, instead
-- 
1.5.5.1.211.g65ea3.dirty
