From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typo
Date: Thu, 12 Jun 2014 18:12:31 +0200
Message-ID: <1402589551-3754-1-git-send-email-ralf.thielow@gmail.com>
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 18:12:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv7cK-00037k-C9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 18:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbaFLQMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 12:12:40 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:63319 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaFLQMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 12:12:40 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so1521584wes.40
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NPrZMc8rD5AGMtrpzUHakPn5t95JV3mmUEHa9VFV7U0=;
        b=r1vsPTmI66xoKYasPFTyJ5CuWAtmk5fJMPu3bBg2WGl4cQ7jUkjdygJ/sr3GR+4pyI
         suclboQH8xR8iflLoesILVJM3t+k1NcRE6bFEaJDNwIZp1lILG9TDKfBwHOjkyz7VGXm
         S1dF5u3xEDciEPmyjzTEFgy31eAFEbQCuFFb8weE2APH2B2wiBcAMy92JA16FknF9u1P
         1/7qP7Z4SHzIr1cNEUml9PCnfzmKM0OSUj4JQc0i0/WXz12/KBjavVkaisCr4jnvugCI
         iatILz+wbtr2CMozxOYLQE6vvJxu4ISimVh7i3Yw06RK6g/rF3dITL4kBdUc427ItkJP
         ziDg==
X-Received: by 10.180.99.40 with SMTP id en8mr7988041wib.24.1402589555279;
        Thu, 12 Jun 2014 09:12:35 -0700 (PDT)
Received: from localhost (dslb-088-072-176-011.pools.arcor-ip.net. [88.72.176.11])
        by mx.google.com with ESMTPSA id f6sm603340wja.25.2014.06.12.09.12.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 09:12:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251413>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index b777ef4..d7bc424 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3503,7 +3503,7 @@ msgstr "Gewechselt zu umgesetzten Branch '%s'\n"
 #: builtin/checkout.c:648 builtin/checkout.c:1033
 #, c-format
 msgid "Switched to a new branch '%s'\n"
-msgstr "Gewechselt zu einem neuem Branch '%s'\n"
+msgstr "Gewechselt zu einem neuen Branch '%s'\n"
 
 #: builtin/checkout.c:650
 #, c-format
-- 
2.0.0.415.g8cd8cf8
