From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 1/2] l10n: de.po: add space before ellipsis
Date: Tue, 24 Mar 2015 19:42:06 +0100
Message-ID: <1427222527-4086-1-git-send-email-ralf.thielow@gmail.com>
References: <CAN0XMOKVAebs6xNuLLNvzi8gkARsmSgNC1k+TuS23BxqCffOig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, phillip.szelat@gmail.com,
	tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 19:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaTmL-0003dS-9W
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 19:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbbCXSmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 14:42:13 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:35291 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbCXSmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 14:42:11 -0400
Received: by weoy45 with SMTP id y45so1375097weo.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P5wEm39tjY3SEoaAs89d+DNQUyJnlKO9386tdEKJbHs=;
        b=asJVkpOlDDzt4U/RDHUtTmC0VKEC/aWsiSbsslMV+K16WIdivBgnJJ5akgF0TL96mh
         EgpZmNfcIVOnpJAGmBJFqlWNPV2mQ24QubrLH7EgVG6e10eitvMAxoXR3dxMa4HTBnJv
         S+e7zGX2hTp1Qk8Z+Om6jvw0tRw8t6zGlhdmQUPC1UTkdi5mp3HWrZQAkn0W8P+IW6ej
         g2ekEYQbIljqWcq+/SEpTX85vE5Qj7YJfYawbvevwFH/ziBPO6cTKdI+bu6yWksre8/z
         DXDLoHpclUkpUoR8sf+dJgIwFxfypQ1pXdIreDRx44HQwfjTJ4xJj4oqmJAdg19c2jS0
         e3IA==
X-Received: by 10.180.12.84 with SMTP id w20mr31626968wib.9.1427222530561;
        Tue, 24 Mar 2015 11:42:10 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id hl8sm101869wjb.38.2015.03.24.11.42.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Mar 2015 11:42:09 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.434.g642b19b
In-Reply-To: <CAN0XMOKVAebs6xNuLLNvzi8gkARsmSgNC1k+TuS23BxqCffOig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266220>

=46rom: Phillip Sz <phillip.szelat@gmail.com>

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/po/de.po b/po/de.po
index 11fbd0f..7b30f62 100644
--- a/po/de.po
+++ b/po/de.po
@@ -616,7 +616,7 @@ msgstr ""
 #: help.c:373
 #, c-format
 msgid "in %0.1f seconds automatically..."
-msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden..."
+msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden ..."
=20
 #: help.c:380
 #, c-format
@@ -2436,7 +2436,7 @@ msgstr "%s: Patch konnte nicht angewendet werden"
 #: builtin/apply.c:3653
 #, c-format
 msgid "Checking patch %s..."
-msgstr "Pr=C3=BCfe Patch %s..."
+msgstr "Pr=C3=BCfe Patch %s ..."
=20
 #: builtin/apply.c:3746 builtin/checkout.c:231 builtin/reset.c:135
 #, c-format
@@ -4091,7 +4091,7 @@ msgstr "Konnte zu klonenden Remote-Branch %s nich=
t finden."
 #: builtin/clone.c:561
 #, c-format
 msgid "Checking connectivity... "
-msgstr "Pr=C3=BCfe Konnektivit=C3=A4t... "
+msgstr "Pr=C3=BCfe Konnektivit=C3=A4t ... "
=20
 #: builtin/clone.c:564
 msgid "remote did not send all necessary objects"
@@ -4165,12 +4165,12 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht er=
stellen."
 #: builtin/clone.c:870
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
-msgstr "Klone in Bare-Repository '%s'...\n"
+msgstr "Klone in Bare-Repository '%s' ...\n"
=20
 #: builtin/clone.c:872
 #, c-format
 msgid "Cloning into '%s'...\n"
-msgstr "Klone nach '%s'...\n"
+msgstr "Klone nach '%s' ...\n"
=20
 #: builtin/clone.c:897
 msgid "--dissociate given, but there is no --reference"
@@ -4600,7 +4600,7 @@ msgstr ""
 #: builtin/commit.c:1199
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area nac=
hbessern."
+"Klug ... den letzten Commit mit einer ge=C3=A4nderten Staging-Area na=
chbessern."
=20
 #: builtin/commit.c:1201
 msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
@@ -7335,7 +7335,7 @@ msgstr "Aktualisiere %s..%s\n"
 #: builtin/merge.c:1388
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
-msgstr "Probiere wirklich trivialen \"in-index\"-Merge...\n"
+msgstr "Probiere wirklich trivialen \"in-index\"-Merge ...\n"
=20
 #: builtin/merge.c:1395
 #, c-format
@@ -7349,12 +7349,12 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche ab=
=2E"
 #: builtin/merge.c:1450 builtin/merge.c:1529
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung...\n"
+msgstr "R=C3=BCcklauf des Verzeichnisses bis zum Ursprung ...\n"
=20
 #: builtin/merge.c:1454
 #, c-format
 msgid "Trying merge strategy %s...\n"
-msgstr "Probiere Merge-Strategie %s...\n"
+msgstr "Probiere Merge-Strategie %s ...\n"
=20
 #: builtin/merge.c:1520
 #, c-format
@@ -10450,7 +10450,7 @@ msgstr ""
=20
 #: git-am.sh:166
 msgid "Falling back to patching base and 3-way merge..."
-msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges.=
=2E."
+msgstr "Falle zur=C3=BCck zum Patchen der Basis und des 3-Wege-Merges =
=2E.."
=20
 #: git-am.sh:182
 msgid "Failed to merge in the changes."
@@ -10943,7 +10943,7 @@ msgstr "=C3=84nderungen von $mb zu $onto:"
 msgid "First, rewinding head to replay your work on top of it..."
 msgstr ""
 "Zun=C3=A4chst wird der Branch zur=C3=BCckgespult, um Ihre =C3=84nderu=
ngen\n"
-"darauf neu anzuwenden..."
+"darauf neu anzuwenden ..."
=20
 #: git-rebase.sh:620
 #, sh-format
--=20
2.3.3.434.g642b19b
