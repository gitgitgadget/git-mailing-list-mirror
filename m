From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 14:45:55 +0100
Message-ID: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 21 14:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIfpU-0007SB-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 14:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab3CUNqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 09:46:25 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:36616 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757570Ab3CUNqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 09:46:24 -0400
Received: from test.quest-ce.net (unknown [37.160.17.34])
	by smtp1-g21.free.fr (Postfix) with ESMTP id BCF16940134;
	Thu, 21 Mar 2013 14:46:16 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2LDkBgi008322;
	Thu, 21 Mar 2013 14:46:12 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2LDkAqT008321;
	Thu, 21 Mar 2013 14:46:10 +0100
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218728>

The documentation is in AsciiDoc format: it should be written somewhere
with links to AsciiDoc documentation so that it became easy to find
how to write documentation for Git.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 Documentation/README | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/README

diff --git a/Documentation/README b/Documentation/README
new file mode 100644
index 0000000..c41734c
--- /dev/null
+++ b/Documentation/README
@@ -0,0 +1,13 @@
+Documentation
+=============
+
+Most of the Git documentation is in AsciiDoc format,
+a lightweight markup text language.
+
+AsciiDoc formatted files can be translated to man pages,
+HTML, DocBook or PDF documents.
+
+See:
+- http://asciidoc.org/
+- https://git.wiki.kernel.org/index.php/AsciiDoc
+
-- 
1.7.11.7
