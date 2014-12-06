From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate "track" as "versionieren"
Date: Sat,  6 Dec 2014 20:28:49 +0100
Message-ID: <1417894129-5535-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 20:29:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxL2R-0000BB-BZ
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 20:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaLFT26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 14:28:58 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:53310 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaLFT25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 14:28:57 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so1547665wiv.8
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=MM2Nkm9w51sUdC3OcI72KnN9DvTFFHWQzjxx8BLePyo=;
        b=ino0n9i5JFw52s3EN3rONMfaA+xrc7DnG6T60AGr3w3YcqCCr8oGWwagRhgofzwPhT
         wE7mpViMnTxlPq2ztDSXd+vd0GbI6DdhaS9N8diukshDgocWEmEtmdSI5Qf24asRT4C3
         hAabYgJS8TahAfO2VTbR3Xql7XWMpkUMWPHSD89bMpdOkHD3S/Ow4+2+gM+V4fQxRbYO
         Xif8L9bqxsVn0S8MZ3kveoGiPF7WMeyVBCF/tWLdj6SszMX/1n5YKfCyiEkkZqjuhVez
         oWClx30cE0EV3oUqqa7JzqbIQ72mZTI/C4N/WSZoB0p9Fvmalm7dSFtUGkU0lI1rT59q
         IBig==
X-Received: by 10.194.119.99 with SMTP id kt3mr34557686wjb.14.1417894135631;
        Sat, 06 Dec 2014 11:28:55 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id o2sm13239099wja.45.2014.12.06.11.28.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Dec 2014 11:28:55 -0800 (PST)
X-Mailer: git-send-email 2.2.0.326.g2287303
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260958>

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5a93ea8..bf11225 100644
--- a/po/de.po
+++ b/po/de.po
@@ -690,7 +690,7 @@ msgstr ": vielleicht ein Verzeichnis/Datei-Konflikt=
?"
 #: merge-recursive.c:727
 #, c-format
 msgid "refusing to lose untracked file at '%s'"
-msgstr "verweigere, da unbeobachtete Dateien in '%s' verloren gehen w=C3=
=BCrden"
+msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen w=
=C3=BCrden"
=20
 #: merge-recursive.c:767
 #, c-format
@@ -1631,7 +1631,7 @@ msgstr ""
 #: wt-status.c:225
 msgid "  (commit or discard the untracked or modified content in submo=
dules)"
 msgstr ""
-"  (committen oder verwerfen Sie den unbeobachteten oder ge=C3=A4ndert=
en Inhalt in "
+"  (committen oder verwerfen Sie den unversionierten oder ge=C3=A4nder=
ten Inhalt in "
 "den Submodulen)"
=20
 #: wt-status.c:237
@@ -1716,7 +1716,7 @@ msgstr "ge=C3=A4nderter Inhalt, "
=20
 #: wt-status.c:374
 msgid "untracked content, "
-msgstr "unbeobachteter Inhalt, "
+msgstr "unversionierter Inhalt, "
=20
 #: wt-status.c:391
 #, c-format
@@ -1932,7 +1932,7 @@ msgstr "Initialer Commit"
=20
 #: wt-status.c:1356
 msgid "Untracked files"
-msgstr "Unbeobachtete Dateien"
+msgstr "Unversionierte Dateien"
=20
 #: wt-status.c:1358
 msgid "Ignored files"
@@ -1945,18 +1945,18 @@ msgid ""
 "may speed it up, but you have to be careful not to forget to add\n"
 "new files yourself (see 'git help status')."
 msgstr ""
-"Es dauerte %.2f Sekunden die unbeobachteten Dateien zu bestimmen.\n"
+"Es dauerte %.2f Sekunden die unversionierten Dateien zu bestimmen.\n"
 "'status -uno' k=C3=B6nnte das beschleunigen, aber Sie m=C3=BCssen dar=
auf achten,\n"
 "neue Dateien selbstst=C3=A4ndig hinzuzuf=C3=BCgen (siehe 'git help st=
atus')."
=20
 #: wt-status.c:1368
 #, c-format
 msgid "Untracked files not listed%s"
-msgstr "Unbeobachtete Dateien nicht aufgelistet%s"
+msgstr "Unversionierte Dateien nicht aufgelistet%s"
=20
 #: wt-status.c:1370
 msgid " (use -u option to show untracked files)"
-msgstr " (benutzen Sie die Option -u, um unbeobachtete Dateien anzuzei=
gen)"
+msgstr " (benutzen Sie die Option -u, um unversionierte Dateien anzuze=
igen)"
=20
 #: wt-status.c:1376
 msgid "No changes"
@@ -1980,20 +1980,20 @@ msgid ""
 "nothing added to commit but untracked files present (use \"git add\" =
to "
 "track)\n"
 msgstr ""
-"nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien (ben=
utzen "
-"Sie \"git add\" zum Beobachten)\n"
+"nichts zum Commit vorgemerkt, aber es gibt unversionierte Dateien (be=
nutzen "
+"Sie \"git add\" zum Versionieren)\n"
=20
 #: wt-status.c:1390
 #, c-format
 msgid "nothing added to commit but untracked files present\n"
-msgstr "nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Datei=
en\n"
+msgstr "nichts zum Commit vorgemerkt, aber es gibt unversionierte Date=
ien\n"
=20
 #: wt-status.c:1393
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to tra=
ck)\n"
 msgstr ""
 "nichts zu committen (Erstellen/Kopieren Sie Dateien und benutzen Sie =
\"git "
-"add\" zum Beobachten)\n"
+"add\" zum Versionieren)\n"
=20
 #: wt-status.c:1396 wt-status.c:1401
 #, c-format
@@ -2004,7 +2004,7 @@ msgstr "nichts zu committen\n"
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
 msgstr ""
-"nichts zu committen (benutzen Sie die Option -u, um unbeobachtete Dat=
eien "
+"nichts zu committen (benutzen Sie die Option -u, um unversionierte Da=
teien "
 "anzuzeigen)\n"
=20
 #: wt-status.c:1403
@@ -2119,7 +2119,7 @@ msgstr "das Hinzuf=C3=BCgen andernfalls ignoriert=
er Dateien erlauben"
=20
 #: builtin/add.c:255
 msgid "update tracked files"
-msgstr "beobachtete Dateien aktualisieren"
+msgstr "versionierte Dateien aktualisieren"
=20
 #: builtin/add.c:256
 msgid "record only the fact that the path will be added later"
@@ -2128,7 +2128,7 @@ msgstr "nur speichern, dass der Pfad sp=C3=A4ter =
hinzugef=C3=BCgt werden soll"
 #: builtin/add.c:257
 msgid "add changes from all tracked and untracked files"
 msgstr ""
-"=C3=84nderungen von allen beobachteten und unbeobachteten Dateien hin=
zuf=C3=BCgen"
+"=C3=84nderungen von allen versionierten und unversionierten Dateien h=
inzuf=C3=BCgen"
=20
 #: builtin/add.c:260
 msgid "ignore paths removed in the working tree (same as --no-all)"
@@ -4536,7 +4536,7 @@ msgstr "Kein existierender Autor mit '%s' gefunde=
n."
 #: builtin/commit.c:1110 builtin/commit.c:1350
 #, c-format
 msgid "Invalid untracked files mode '%s'"
-msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
+msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unversionierte Dateien"
=20
 #: builtin/commit.c:1147
 msgid "--long and -z are incompatible"
@@ -4636,7 +4636,7 @@ msgstr "Modus"
 #: builtin/commit.c:1377 builtin/commit.c:1656
 msgid "show untracked files, optional modes: all, normal, no. (Default=
: all)"
 msgstr ""
-"nicht beobachtete Dateien anzeigen, optionale Modi: all, normal, no. =
"
+"unversionierte Dateien anzeigen, optionale Modi: all, normal, no. "
 "(Standard: all)"
=20
 #: builtin/commit.c:1380
@@ -4657,7 +4657,7 @@ msgstr ""
=20
 #: builtin/commit.c:1384
 msgid "list untracked files in columns"
-msgstr "unbeobachtete Dateien in Spalten auflisten"
+msgstr "unversionierte Dateien in Spalten auflisten"
=20
 #: builtin/commit.c:1471
 msgid "couldn't look up newly created commit"
@@ -5768,7 +5768,7 @@ msgstr "auch in Inhalten finden, die nicht von Gi=
t verwaltet werden"
=20
 #: builtin/grep.c:642
 msgid "search in both tracked and untracked files"
-msgstr "in beobachteten und unbeobachteten Dateien suchen"
+msgstr "in versionierten und unversionierten Dateien suchen"
=20
 #: builtin/grep.c:644
 msgid "search also in ignored files"
@@ -5959,7 +5959,7 @@ msgstr ""
 #: builtin/grep.c:900
 msgid "--[no-]exclude-standard cannot be used for tracked contents."
 msgstr ""
-"Die Option --[no-]exclude-standard kann nicht mit beobachteten Inhalt=
en "
+"Die Option --[no-]exclude-standard kann nicht mit versionierten Inhal=
ten "
 "verwendet werden."
=20
 #: builtin/grep.c:908
@@ -6101,7 +6101,7 @@ msgstr "Ein Git-Glossar"
=20
 #: builtin/help.c:426
 msgid "Specifies intentionally untracked files to ignore"
-msgstr "Spezifikation von bewusst ignorierten, unbeobachteten Dateien"
+msgstr "Spezifikation von bewusst ignorierten, unversionierten Dateien=
"
=20
 #: builtin/help.c:427
 msgid "Defining submodule properties"
--=20
2.2.0.326.g2287303
