From: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] l10n: de.po: change Email to E-Mail
Date: Sat, 20 Sep 2014 17:51:53 +0200
Message-ID: <1411228313-1941-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phillip Sz <phillip.szelat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 17:52:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVMx9-0003q6-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 17:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbaITPv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2014 11:51:58 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59175 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbaITPv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 11:51:57 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so1013441wgg.18
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=JhvfSl70uUkxvgcGoY9Wg19S+ERj+ANmo0pQJUqIqZw=;
        b=Odj6AwJAik/GXm+RVcJd0fnekPWGAMY93mnVbp6IcrXKWjP3aKTgG1O8RX0N1hPonf
         8+bdjLw5P7GTaEsLilPr/QFk1HyAR2ZssnlSHU9mXqS8gBSwHshykmVpc5WXl7dAVANQ
         Ph71hbgBHPlF0vWsGwdyxcy+1nFoZ0hhQXo926jKAciQd9EMgf2ZeB1vw0SSDDeDsY/L
         QvZv+JAr3gg8Fe0wbhOFVdUWflN5PmupB+0/81tDV24qWQkpGjmMGjCqx7R4UEDlBi9e
         w5lvt/FGg2nST+nqquZkLcq9WIeaSBwhtgJo8g0hwjPjoiOaABFP+fJEG4coHU6WMnpx
         8yVA==
X-Received: by 10.180.14.101 with SMTP id o5mr4057191wic.25.1411228316256;
        Sat, 20 Sep 2014 08:51:56 -0700 (PDT)
Received: from phillip.fritz.box (i577AAC24.versanet.de. [87.122.172.36])
        by mx.google.com with ESMTPSA id v9sm5963443wjy.14.2014.09.20.08.51.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Sep 2014 08:51:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257326>

Changes all Email to E-Mail, as this is the correct form in german.

Phillip

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
---
 po/de.po | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/po/de.po b/po/de.po
index e5d2b25..c6aa69f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2691,7 +2691,7 @@ msgstr "Unterdr=C3=BCckt den Namen des Autors und=
 den Zeitstempel (Standard: aus)"
=20
 #: builtin/blame.c:2514
 msgid "Show author email instead of name (Default: off)"
-msgstr "Zeigt anstatt des Namens die Email-Adresse des Autors (Standar=
d: aus)"
+msgstr "Zeigt anstatt des Namens die E-Mail-Adresse des Autors (Standa=
rd: aus)"
=20
 #: builtin/blame.c:2515
 msgid "Ignore whitespace differences"
@@ -6535,7 +6535,7 @@ msgstr "zeigt Patchformat anstatt des Standards (=
Patch + Zusammenfassung)"
=20
 #: builtin/log.c:1217
 msgid "Messaging"
-msgstr "Email-Einstellungen"
+msgstr "E-Mail-Einstellungen"
=20
 #: builtin/log.c:1218
 msgid "header"
@@ -6543,11 +6543,11 @@ msgstr "Header"
=20
 #: builtin/log.c:1219
 msgid "add email header"
-msgstr "f=C3=BCgt Email-Header hinzu"
+msgstr "f=C3=BCgt E-Mail-Header hinzu"
=20
 #: builtin/log.c:1220 builtin/log.c:1222
 msgid "email"
-msgstr "Email"
+msgstr "E-Mail"
=20
 #: builtin/log.c:1220
 msgid "add To: header"
@@ -6573,7 +6573,7 @@ msgstr "message-id"
=20
 #: builtin/log.c:1228
 msgid "make first mail a reply to <message-id>"
-msgstr "macht aus erster Email eine Antwort zu <message-id>"
+msgstr "macht aus erster E-Mail eine Antwort zu <message-id>"
=20
 #: builtin/log.c:1229 builtin/log.c:1232
 msgid "boundary"
@@ -9431,7 +9431,7 @@ msgstr "Unterdr=C3=BCckt Commit-Beschreibungen, l=
iefert nur Anzahl der Commits"
=20
 #: builtin/shortlog.c:234
 msgid "Show the email address of each author"
-msgstr "Zeigt die Email-Adresse von jedem Autor"
+msgstr "Zeigt die E-Mail-Adresse von jedem Autor"
=20
 #: builtin/shortlog.c:235
 msgid "w[,i1[,i2]]"
@@ -10284,7 +10284,7 @@ msgstr ""
=20
 #: git-am.sh:732
 msgid "Patch does not have a valid e-mail address."
-msgstr "Patch enth=C3=A4lt keine g=C3=BCltige Email-Adresse."
+msgstr "Patch enth=C3=A4lt keine g=C3=BCltige E-Mail-Adresse."
=20
 #: git-am.sh:779
 msgid "cannot be interactive without stdin connected to a terminal."
--=20
2.1.0
