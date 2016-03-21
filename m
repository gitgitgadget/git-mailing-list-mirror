From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation: fix broken linkgit to git-config
Date: Mon, 21 Mar 2016 19:38:34 +0100
Message-ID: <1458585514-11225-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 21 20:36:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5co-0003io-Bh
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbcCUTgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:36:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38744 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757208AbcCUTgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:36:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u2LIcaZF004256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 21 Mar 2016 19:38:36 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2LIcctx008854;
	Mon, 21 Mar 2016 19:38:38 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 21 Mar 2016 19:38:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2LIcaZF004256
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1459190320.27783@LARQAuKy8S1G+3d19QZ0AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289444>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/githooks.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..90a59d1 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -367,7 +367,7 @@ preceding SP is also omitted.  Currently, no commands pass any
 'extra-info'.
 
 The hook always runs after the automatic note copying (see
-"notes.rewrite.<command>" in linkgit:git-config.txt[1]) has happened, and
+"notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
 thus has access to these notes.
 
 The following command-specific comments apply:
-- 
2.7.2.334.g35ed2ae.dirty
