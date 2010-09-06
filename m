From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v5 1/3] Minor indentation fix.
Date: Mon,  6 Sep 2010 20:12:09 +0200
Message-ID: <1283796731-4540-2-git-send-email-pascal@obry.net>
References: <1283796731-4540-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 20:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsgB8-0005es-Br
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab0IFSMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 14:12:22 -0400
Received: from smtp19.orange.fr ([80.12.242.18]:27052 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab0IFSMT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 14:12:19 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1921.orange.fr (SMTP Server) with ESMTP id C934C200079E;
	Mon,  6 Sep 2010 20:12:16 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1921.orange.fr (SMTP Server) with ESMTP id B8556200092C;
	Mon,  6 Sep 2010 20:12:16 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf1921.orange.fr (SMTP Server) with ESMTP id 84274200079E;
	Mon,  6 Sep 2010 20:12:16 +0200 (CEST)
X-ME-UUID: 20100906181216541.84274200079E@mwinf1921.orange.fr
X-Mailer: git-send-email 1.7.3.rc0.3.g0de60
In-Reply-To: <1283796731-4540-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155591>


Signed-off-by: Pascal Obry <pascal@obry.net>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..0063606 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -212,7 +212,7 @@ my %config_settings = (
     "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
-	"smtpdomain" => \$smtp_domain,
+    "smtpdomain" => \$smtp_domain,
     "to" => \@to,
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
-- 
1.7.3.rc0
