From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: Fix a typo
Date: Thu,  6 Jun 2013 06:08:01 +0200
Message-ID: <1370491681-3303-1-git-send-email-ralf.thielow@gmail.com>
Cc: themineo@gmail.com, git@vger.kernel.org
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Thu Jun 06 06:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkRUo-0003ON-3j
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 06:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800Ab3FFEIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 00:08:13 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:49426 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab3FFEIM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 00:08:12 -0400
Received: by mail-bk0-f53.google.com with SMTP id e11so722543bkh.12
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 21:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yQ6sA8OwVtqWalBgag6dCeaiiMWiFpuLne1FdwgnoBo=;
        b=yPCIuT2krHGqF9yjCfd8DynciiKitmUcWXUszGerXeQdydEFBXsLGnJ/DhBRFrTDpq
         NdEFM8iamXenXKj6Yvou581MhW2pbJ0Rm3KOrrsRUCMrp89Me6J4ivnEL/m3h3KO90F9
         /z+wMRl0/ZXIskwLOZbbMbWsaDet+sLNO4kZ3/Ii8CSxXTX4rsWGgM0Jep8W6/Qml0qn
         LIWWa8DuKZsQ6eDTEaScftVMpJdkGQcumCp4zjnj2mRksZL6Z7XyRK+fbQFqNdeBvgLr
         i+IaZ0j7U2l7xtZV13dCVPlse9HxBJgQMncIGM4IGcxSK6iXmH3p1Cv9wAAau6JzJJ+x
         oI5Q==
X-Received: by 10.204.187.9 with SMTP id cu9mr10643033bkb.104.1370491691169;
        Wed, 05 Jun 2013 21:08:11 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPSA id uh4sm26840354bkb.14.2013.06.05.21.08.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 21:08:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.999.gd2ad0c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226477>

From: Wieland Hoffmann <themineo@gmail.com>

Signed-off-by: Wieland Hoffmann <themineo@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 4901488..cd6919f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -885,7 +885,7 @@ msgstr[1] "Ihr Zweig ist vor '%s' um %d Versionen.\n"
 
 #: remote.c:1787
 msgid "  (use \"git push\" to publish your local commits)\n"
-msgstr "  (benutzen Sie \"git push\" um lokalen Versionen herauszubringen)\n"
+msgstr "  (benutzen Sie \"git push\" um lokale Versionen herauszubringen)\n"
 
 #: remote.c:1790
 #, c-format
-- 
1.8.2.999.gd2ad0c7
