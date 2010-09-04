From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v2 1/3] Minor indentation fix.
Date: Sat,  4 Sep 2010 21:55:26 +0200
Message-ID: <1283630128-3472-2-git-send-email-pascal@obry.net>
References: <1283630128-3472-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 21:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oryq5-0005oe-J0
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 21:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab0IDTzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 15:55:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38160 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab0IDTza (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 15:55:30 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so1379184wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 12:55:29 -0700 (PDT)
Received: by 10.216.28.80 with SMTP id f58mr2399431wea.94.1283630128986;
        Sat, 04 Sep 2010 12:55:28 -0700 (PDT)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id u11sm2195174weq.7.2010.09.04.12.55.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 12:55:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.277.gb49c4
In-Reply-To: <1283630128-3472-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155350>

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
