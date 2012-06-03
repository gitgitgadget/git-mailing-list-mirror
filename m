From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/3] Improve credential API documentation
Date: Sun,  3 Jun 2012 18:10:01 +0200
Message-ID: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 03 18:11:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbDOQ-0003uH-TC
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 18:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab2FCQKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 12:10:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37470 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2FCQKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 12:10:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q53G1eef009657
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 18:01:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNa-0000C6-BL; Sun, 03 Jun 2012 18:10:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNa-0008Nd-6i; Sun, 03 Jun 2012 18:10:10 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jun 2012 18:01:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53G1eef009657
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339344101.33483@R3AWHeZ/APjY691g2oUoLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199087>

Follow-up to the discussion here:
http://thread.gmane.org/gmane.comp.version-control.git/198409

Matthieu Moy (3):
  api-credential.txt: show the big picture first
  api-credentials.txt: mention credential.helper explicitly
  api-credentials.txt: add "see also" section

 Documentation/technical/api-credentials.txt | 60 +++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

-- 
1.7.11.rc0.57.g84a04c7
