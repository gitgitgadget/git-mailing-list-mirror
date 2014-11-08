From: Thomas Quinot <thomas@quinot.org>
Subject: [PATCH] Documentation/config.txt: fix minor typo
Date: Sat, 8 Nov 2014 11:45:39 +0100
Message-ID: <20141108104539.GA89745@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 11:54:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3f5-0000ln-6B
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 11:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbaKHKy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 05:54:27 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:29773 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbaKHKy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 05:54:26 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id CB32A33556; Sat,  8 Nov 2014 11:45:39 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing capital at the beginning of a sentence, and rephrase
slightly.

Signed-off-by: Thomas Quinot <thomas@quinot.org>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e8dd76d..588d024 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -683,7 +683,7 @@ alias.*::
 	confusion and troubles with script usage, aliases that
 	hide existing Git commands are ignored. Arguments are split by
 	spaces, the usual shell quoting and escaping is supported.
-	quote pair and a backslash can be used to quote them.
+	A quote pair or a backslash can be used to quote them.
 +
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
-- 
1.9.2
