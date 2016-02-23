From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/5] README.md: don't call git stupid in the title
Date: Tue, 23 Feb 2016 18:40:28 +0100
Message-ID: <1456249229-30454-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: emma.westby@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:41:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYGxa-000618-1M
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbcBWRlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:41:12 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46919 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713AbcBWRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:41:09 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHf1d8021022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:41:01 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHf0l8012837;
	Tue, 23 Feb 2016 18:41:04 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 18:41:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHf1d8021022
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854065.70702@jgEbgRrvtHnZ/i81dct35g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287087>

"the stupid content tracker" was true in the early days of Git, but
hardly applicable these days. "fast, scalable, distributed" describes
Git more accuralety.

Also, "stupid" can be seen as offensive by some people. Let's not use it
in the very first words of the README.

The new formulation is taken from the description of the Debian package.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 1625352..c11c3e2 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,4 @@
-# Git - the stupid content tracker
+# Git - fast, scalable, distributed revision control system
 
 "git" can mean anything, depending on your mood.
 
-- 
2.7.2.334.g35ed2ae.dirty
