From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v4 1/3] Minor indentation fix.
Date: Mon,  6 Sep 2010 19:38:01 +0200
Message-ID: <1283794683-2796-2-git-send-email-pascal@obry.net>
References: <1283794683-2796-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 19:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osfdb-0003aE-Uu
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 19:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0IFRhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 13:37:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36298 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab0IFRho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 13:37:44 -0400
Received: by wyf22 with SMTP id 22so3214915wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 10:37:42 -0700 (PDT)
Received: by 10.227.146.76 with SMTP id g12mr607232wbv.82.1283794662797;
        Mon, 06 Sep 2010 10:37:42 -0700 (PDT)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id i14sm4837497wbe.6.2010.09.06.10.37.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 10:37:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0
In-Reply-To: <1283794683-2796-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155586>

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
