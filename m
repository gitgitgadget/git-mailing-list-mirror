From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: correct translation of "completed" after resolving deltas
Date: Sat, 12 Apr 2014 22:37:40 +0200
Message-ID: <1397335060-6037-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4gQ-0005v0-Fm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbaDLUhq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2014 16:37:46 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:35854 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbaDLUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:37:45 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so5229202eek.13
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=DJFHDbj8zWdXjU20JvmJEdoJqsBtLp1ltdtitnf4/9g=;
        b=BzG2SvKbaUQnOJCJ5QOqfop6HJTFtl2jFKPCxkwgi5HuNt20UOsTxSzdN3cyPJIzPe
         v9IO/Zhg267omvK7A+L3ppq4741AYIUNSRFwj+C8/7bIvtec/9l6Ek/kUDaPAQqC6SPq
         s/vxiA/fRpEh4gf3r+rTVwmu7IH2jXl0aM3+OR6DYX450u6R94myjU47agqk9HdAADOq
         NlBLsCcgz3HGzlMuPTJHIC2pBHjlWHhJM/i1Cp1Tf7kr8op4IweZ6CdMsI9R5otHaie6
         fR5ECthmIbW4gb9bNWGVr5iTlan/6xteNb/yApm1ys3f2GFZi4+j/i2W2tj+BD9aO0qe
         B2Vg==
X-Received: by 10.14.88.7 with SMTP id z7mr1154174eee.90.1397335063976;
        Sat, 12 Apr 2014 13:37:43 -0700 (PDT)
Received: from localhost (dslb-178-008-126-192.pools.arcor-ip.net. [178.8.126.192])
        by mx.google.com with ESMTPSA id o7sm27864608eew.25.2014.04.12.13.37.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 13:37:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.649.g5ae4ba5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246186>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
I'll queue this fix as part of the German l10n changes
for the next release.

 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 773ae87..3e01e72 100644
--- a/po/de.po
+++ b/po/de.po
@@ -6108,7 +6108,7 @@ msgstr "Fehler beim Aufl=C3=B6sen der Unterschied=
e"
 #: builtin/index-pack.c:1138
 #, c-format
 msgid "completed with %d local objects"
-msgstr "vervollst=C3=A4ndigt mit %d lokalen Objekten"
+msgstr "abgeschlossen mit %d lokalen Objekten"
=20
 #: builtin/index-pack.c:1148
 #, c-format
--=20
1.9.2.649.g5ae4ba5
