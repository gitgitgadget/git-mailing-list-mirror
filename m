From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typo
Date: Wed, 31 Dec 2014 20:18:43 +0100
Message-ID: <1420053523-25250-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 20:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6Otn-0000ps-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 20:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbaLaTZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Dec 2014 14:25:35 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:61687 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaLaTZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2014 14:25:34 -0500
Received: by mail-wg0-f51.google.com with SMTP id x12so22148690wgg.24
        for <git@vger.kernel.org>; Wed, 31 Dec 2014 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Z1xjvYRFDqXHY9sh55dTKmui46O4wUDGIxpTUX2H0vw=;
        b=waF039wUuxdtJsljna2rH6GAq2t9mU/BsKmCqpYCpNUGF6aQEhAkaSzy+z/yG3D9Dz
         PM04WzttgO40Q5saCpntYwuh9KeRagUKnWJzGIvGWlHGkQYq43RQmc0LHvbcpYwBk5KK
         EUMaY/JDd0IomKrvEwNxjDd5UzQ9mz0kH9lRqghM3J1tdUCmszXnZM4v6LWOugLd0FMt
         wWZKGUnjKYPUkJNj6Q+AGoZ6AMrDyCjF5ybclvdf7jjbYbOO0aCyecbUiJWKTBXmbp6b
         eXHncROSjb2Qi4s5Gwe2WgnX/kXEV0jvPXleVGQHP0mg5pcmDVpf3V1lr/LkWSvvuZdu
         LFSQ==
X-Received: by 10.180.75.199 with SMTP id e7mr119288876wiw.21.1420053527742;
        Wed, 31 Dec 2014 11:18:47 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id w3sm8107767wjf.3.2014.12.31.11.18.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Dec 2014 11:18:47 -0800 (PST)
X-Mailer: git-send-email 2.2.1.314.g08fc3c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261969>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 5a93ea8..bf7a13b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7802,7 +7802,7 @@ msgstr "zu viele Parameter"
 #: builtin/notes.c:387 builtin/notes.c:646
 #, c-format
 msgid "No note found for object %s."
-msgstr "Kein Notiz f=C3=BCr Objekt %s gefunden."
+msgstr "Keine Notiz f=C3=BCr Objekt %s gefunden."
=20
 #: builtin/notes.c:409 builtin/notes.c:566
 msgid "note contents as a string"
--=20
2.2.1.314.g08fc3c1
