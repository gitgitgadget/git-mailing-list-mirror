From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 1/2] Documentation/diff-options: fix typo in --submodule text
Date: Tue, 13 Mar 2012 15:00:50 -0400
Message-ID: <1331665251-11147-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 20:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Wy3-0008Nx-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 20:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709Ab2CMTBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 15:01:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35147 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275Ab2CMTBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 15:01:00 -0400
Received: by ghrr11 with SMTP id r11so908571ghr.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=J9S0eoKJxOzlkWKiAV3V0Ut14bDa29U9OJ+TSvKrIrU=;
        b=Do1n6drvvyufSPVklM7LSqJUSYKACwKU0QucoUhq10np4UtPPgE7kMpaW00SdnmQZ+
         hfRW16lVr6qqAcXADCQ9MV+2Y6gAJJT8yJRXoR3BUjgNKdQ4y2ZKXf1oTLLw4CTOz9J7
         2GZS8iCA3i6xuGBq8WBNwaDylLzYiTVsGzMo5Sp+VnjwZC19xe/PjONoWQNrJpFxgHWN
         l8Hesz9Xr1aNFlHt6KNYAd+DgB3+uVmdnDohiTVcoalYDUHKqw4ToMtzAtrB88Us0wWE
         r8N1gpxG4vNS+r8fPyrQoPsmhXX/VhPmVsQdbsDcgFWPSpUSdP7NFksd2F8CFAA7cb95
         NnUA==
Received: by 10.224.177.132 with SMTP id bi4mr5451631qab.35.1331665259537;
        Tue, 13 Mar 2012 12:00:59 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id fq1sm4753693qab.10.2012.03.13.12.00.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 12:00:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193057>

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Resent due to typo in developer list email address.

 Documentation/diff-options.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7d4566f..f44f3fc 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -165,7 +165,7 @@ any of those replacements occurred.
 	of the `--diff-filter` option on what the status letters mean.
 
 --submodule[=<format>]::
-	Chose the output format for submodule differences. <format> can be one of
+	Choose the output format for submodule differences. <format> can be one of
 	'short' and 'log'. 'short' just shows pairs of commit names, this format
 	is used when this option is not given. 'log' is the default value for this
 	option and lists the commits in that commit range like the 'summary'
-- 
1.7.10.rc0
