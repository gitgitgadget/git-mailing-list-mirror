From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 2 messages
Date: Thu, 20 Nov 2014 07:28:23 +0100
Message-ID: <1416464903-5525-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 07:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrLEG-00035X-IN
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 07:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaKTG22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014 01:28:28 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41775 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaKTG22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 01:28:28 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so2800418wgh.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 22:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=GfZx6GBc2W0o1XbBHtfYJ4AJiPbPxm3eVZmKsSeKzys=;
        b=n+f21NHYTFV43VyUOTF6XknTCCt/6km6HapstNwgR61sV7OmTsJVCPet5D7sv3WlSe
         n/m43RThyW0SCmthC3PFOFnSc/BcqP5E5oZX93Gm63ZzUuxmk56ejoj01xplRmxejKfd
         4X0uF/yuWtTi3b09G/3Vu+A6WKqAfgTfnaMJ2IjYPWUNLw11muJQwhxjM8ClM6ukjHPp
         GHeyNCUR3/qY/QQGK8hjuv62fbQ6izxdEQm97wwRXCCEsG5ZoQcC6sZ0te6YOjUSXeiK
         rWlbYJc+hLvN8WK4pRBJHSxJJpUk1vKXrXQKnMc7frFqcf0SqzzuW0oHXmZVQXPWrsAx
         NObA==
X-Received: by 10.194.87.34 with SMTP id u2mr60510827wjz.42.1416464906666;
        Wed, 19 Nov 2014 22:28:26 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id fl1sm5143751wib.15.2014.11.19.22.28.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 22:28:26 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.284.g750ddc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
I already sent a pull request with this change due to
lack of time because the messages were fairly easy to
translate. If there's something wrong with these translations,
we need to fix it in a separate patch.

 po/de.po | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index eede88a..56263b4 100644
--- a/po/de.po
+++ b/po/de.po
@@ -6921,7 +6921,6 @@ msgid "show files on the filesystem that need to =
be removed"
 msgstr "Dateien im Dateisystem, die gel=C3=B6scht werden m=C3=BCssen, =
anzeigen"
=20
 #: builtin/ls-files.c:477
-#, fuzzy
 msgid "show 'other' directories' names only"
 msgstr "nur Namen von 'sonstigen' Verzeichnissen anzeigen"
=20
@@ -8082,10 +8081,9 @@ msgstr ""
 "Objekte einschlie=C3=9Fen, die von Eintr=C3=A4gen des Reflogs referen=
ziert werden"
=20
 #: builtin/pack-objects.c:2667
-#, fuzzy
 msgid "include objects referred to by the index"
 msgstr ""
-"Objekte einschlie=C3=9Fen, die von Eintr=C3=A4gen des Reflogs referen=
ziert werden"
+"Objekte einschlie=C3=9Fen, die von der Staging-Area referenziert werd=
en"
=20
 #: builtin/pack-objects.c:2670
 msgid "output pack to stdout"
--=20
2.2.0.rc2.284.g750ddc6
