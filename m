From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 4/5] README.md: don't call git stupid in the title
Date: Thu, 25 Feb 2016 09:37:29 +0100
Message-ID: <1456389450-27118-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 09:37:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrQn-0002i2-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760112AbcBYIht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:37:49 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35271 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759493AbcBYIhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:37:47 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bcZM012979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:37:39 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bdLO010488;
	Thu, 25 Feb 2016 09:37:39 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 09:37:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8bcZM012979
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456994260.31033@TdAM75a4CWhhJGq/FUKgtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287340>

"the stupid content tracker" was true in the early days of Git, but
hardly applicable these days. "fast, scalable, distributed" describes
Git more accuralety.

Also, "stupid" can be seen as offensive by some people. Let's not use it
in the very first words of the README.

The new formulation is taken from the description of the Debian package.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 5500f8a..e3ddc3e 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,5 @@
-Git - the stupid content tracker
-================================
+Git - fast, scalable, distributed revision control system
+=========================================================
 
 "git" can mean anything, depending on your mood.
 
-- 
2.7.2.334.g35ed2ae.dirty
