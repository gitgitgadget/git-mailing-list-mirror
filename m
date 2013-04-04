From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: new wiki URL in documentation
Date: Thu,  4 Apr 2013 09:56:03 +0200
Message-ID: <1365062163-15740-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 04 09:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNf2H-0004F7-V5
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 09:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746Ab3DDH4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 03:56:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33861 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763744Ab3DDH4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 03:56:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r347u4up029149
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Apr 2013 09:56:04 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UNf1h-0001J1-DP; Thu, 04 Apr 2013 09:56:05 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UNf1h-00046a-8y; Thu, 04 Apr 2013 09:56:05 +0200
X-Mailer: git-send-email 1.8.2.359.g6e2e2c6.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Apr 2013 09:56:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r347u4up029149
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1365666967.81971@qCzVFFWI4xDeVvka4p3AfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219992>

The Bibzball wiki is not maintained anymore.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.txt b/contrib/mw-to-git/git-remote-mediawiki.txt
index 4d211f5..23b7ef9 100644
--- a/contrib/mw-to-git/git-remote-mediawiki.txt
+++ b/contrib/mw-to-git/git-remote-mediawiki.txt
@@ -4,4 +4,4 @@ objects from mediawiki just as one would do with a classic git
 repository thanks to remote-helpers.
 
 For more information, visit the wiki at
-https://github.com/Bibzball/Git-Mediawiki/wiki
+https://github.com/moy/Git-Mediawiki/wiki
-- 
1.8.2.359.g6e2e2c6.dirty
