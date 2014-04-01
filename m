From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH] rev-parse: fix typo in example on manpage
Date: Tue,  1 Apr 2014 21:27:23 +0200
Message-ID: <1396380443-61239-1-git-send-email-l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 21:27:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4LP-0007l4-HO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaDAT13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:27:29 -0400
Received: from mout.web.de ([212.227.17.12]:60072 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbaDAT11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:27:27 -0400
Received: from debian.fritz.box ([79.253.130.66]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Laky4-1WtRsE0x7A-00kLen; Tue, 01 Apr 2014 21:27:26
 +0200
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K0:UPo/By8a+J0kfrNs/vsnNCg7R5j9c+mLmalKyRBg/ExvvKcUeSE
 BKH9pZHOGQK8fFGlZvGi2wXvEuHuDAB84pEPqOzyjPqFH3tX3RBVRim0KJhhR3RCJv6+RAm
 AfiEITFwifQrS7/oAhvR3wLdSXu4UB6SgKD/nyU3l2B+D6dYrageAgQnZnvMNb+nrPajCc2
 DGsbz/obs3Dqai616KFgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245637>

---
 Documentation/git-rev-parse.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index e05e6b3..377d9d7 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -363,7 +363,7 @@ usage: some-command [options] <args>...
     -h, --help            show the help
     --foo                 some nifty option --foo
     --bar ...             some cool option --bar with an argument
-    --bar <arg>           another cool option --baz with a named argument
+    --baz <arg>           another cool option --baz with a named argument
     --qux[=<path>]        qux may take a path argument but has meaning by itself
 
 An option group Header
-- 
1.9.1
