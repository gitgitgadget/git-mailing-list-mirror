From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] fixup for patch 1: typo
Date: Wed, 16 Jul 2014 18:09:12 +0200
Message-ID: <1405526952-25019-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqha2h9tjw.fsf@anie.imag.fr>
 <1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: artagnon@gmail.com, tanayabh@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 18:40:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7SFf-0005QN-5f
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965627AbaGPQkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:40:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49210 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965611AbaGPQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:40:10 -0400
X-Greylist: delayed 1787 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2014 12:40:09 EDT
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG9qJt012504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 18:09:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG9slZ027192;
	Wed, 16 Jul 2014 18:09:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1X7RmE-0006hM-Cy; Wed, 16 Jul 2014 18:09:54 +0200
X-Mailer: git-send-email 2.0.0.262.gdafc651
In-Reply-To: <1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Jul 2014 18:09:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GG9qJt012504
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406131796.65751@PFkDbASVmz3zL6hCzoF2Ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253674>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/technical/api-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index fc0e379..8a86e45 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -242,7 +242,7 @@ Configset API provides functions for the above mentioned work flow, including:
 
 	Parses the file and adds the variable-value pairs to the `config_set`,
 	dies if there is an error in parsing the file. Returns 0 on success, or
-	-1 if the file doesnot exist or is inaccessible. The user has to decide
+	-1 if the file does not exist or is inaccessible. The user has to decide
 	if he wants to free the incomplete configset or continue using it when
 	the function returns -1.
 
-- 
2.0.0.262.gdafc651
