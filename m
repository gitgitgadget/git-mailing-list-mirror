From: Pascal Obry <pascal@obry.net>
Subject: [PATCH 1/2] Minor indentation fix.
Date: Sat,  4 Sep 2010 18:06:11 +0200
Message-ID: <1283616372-3340-2-git-send-email-pascal@obry.net>
References: <1283616372-3340-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 18:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvG6-0003Fx-0N
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0IDQGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:06:18 -0400
Received: from smtp20.orange.fr ([80.12.242.26]:60404 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab0IDQGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:06:17 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id 5ADA720002F6;
	Sat,  4 Sep 2010 18:06:07 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id 4D46A2000393;
	Sat,  4 Sep 2010 18:06:07 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id 1B95620002F6;
	Sat,  4 Sep 2010 18:06:07 +0200 (CEST)
X-ME-UUID: 20100904160607113.1B95620002F6@mwinf2003.orange.fr
X-Mailer: git-send-email 1.7.2.2.277.gb49c4
In-Reply-To: <1283616372-3340-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155335>

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
1.7.2.2.277.gb49c4
