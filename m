From: jidanni@jidanni.org
Subject: [PATCH] Documentation/diff-options.txt: unify options
Date: Sun, 28 Dec 2008 04:12:50 +0800
Message-ID: <E1LGfY3-0001pM-S9@jidanni.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 22:16:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGgVz-0000n4-Gd
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 22:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYL0VOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYL0VOq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 16:14:46 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:49289 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751732AbYL0VOq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 16:14:46 -0500
Received: from jidanni.org (122-127-33-180.dynamic.hinet.net [122.127.33.180])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 4FA6EC5837
	for <git@vger.kernel.org>; Sat, 27 Dec 2008 13:14:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104017>


Signed-off-by: jidanni <jidanni@jidanni.org>

diff --git a/diff-options.txt b/diff-options.txt
index 5721548..b05503a 100644
--- a/diff-options.txt
+++ b/diff-options.txt
@@ -21,0 +22 @@ ifndef::git-format-patch[]
+-u::
@@ -26,3 +26,0 @@ endif::git-format-patch[]
--u::
-	Synonym for "-p".
-
@@ -30,2 +27,0 @@ endif::git-format-patch[]
-	Shorthand for "--unified=<n>".
-
@@ -189,0 +186 @@ endif::git-format-patch[]
+-a::
@@ -193,3 +189,0 @@ endif::git-format-patch[]
--a::
-	Shorthand for "--text".
-
@@ -198,0 +193 @@ endif::git-format-patch[]
+-b::
@@ -204,3 +199 @@ endif::git-format-patch[]
--b::
-	Shorthand for "--ignore-space-change".
-
+-w::
@@ -212,3 +204,0 @@ endif::git-format-patch[]
--w::
-	Shorthand for "--ignore-all-space".
-
-- 
1.5.6.5
