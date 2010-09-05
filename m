From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v3 1/3] Minor indentation fix.
Date: Sun,  5 Sep 2010 19:48:58 +0200
Message-ID: <1283708940-2172-2-git-send-email-pascal@obry.net>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 19:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJKt-0005MD-FT
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab0IERsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:48:38 -0400
Received: from smtp19.orange.fr ([80.12.242.19]:28092 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab0IERsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:48:37 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 426F5200020F;
	Sun,  5 Sep 2010 19:48:36 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 34ED920003F2;
	Sun,  5 Sep 2010 19:48:36 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 036BD200020F;
	Sun,  5 Sep 2010 19:48:35 +0200 (CEST)
X-ME-UUID: 20100905174836140.036BD200020F@mwinf1928.orange.fr
X-Mailer: git-send-email 1.7.2.3.316.ga4c47
In-Reply-To: <1283708940-2172-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155469>

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
1.7.2.3.316.ga4c47
