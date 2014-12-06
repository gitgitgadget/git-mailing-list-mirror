From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate "track" as "versionieren"
Date: Sat, 06 Dec 2014 20:34:41 +0100
Message-ID: <3B030774-3176-44C0-861E-1DB1B668AE76@gmail.com>
References: <1417894129-5535-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 20:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxL9n-0003qM-PE
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 20:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbaLFTeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 14:34:46 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:51458 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaLFTep (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 14:34:45 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so3352521wgh.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 11:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=bG/eMcZBSDSIm7DjkuaSIUTORwDjC+bBjHpEje+lfbE=;
        b=Xfrcgx6qfGTwqX5grR5GVkpxJwaJS7itaRXwcH3ht+PuxYkK4+uPPZRdeThNPhE4yO
         REuYUefcc4h72yk2h+WKSXzL/Jks1sSTEbfHWygvDBacEN6+SyvNMlMIuhYpY/gWwX9/
         72o6M6k6fPoQWC7DCQV5ZvCCBpZ0vWEUgBI75WAeHrvNv8Kt1Uu+KXUbGYSDpuzt0DmB
         FMWy6ZK4+GaXR0pugIGmiR0H1Io2+zSXD/UmO7X/bcvMwTBKq3/RbWafvA+nedQQ03Yh
         jTInVUJfdRaovKUW2cCGzUkDz4geo7msYaokDBL24AfMrnkqjA/XjVJnMOhukkr3bKL4
         7z+A==
X-Received: by 10.180.76.211 with SMTP id m19mr13226081wiw.73.1417894483910;
        Sat, 06 Dec 2014 11:34:43 -0800 (PST)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F454EB.versanet.de. [89.244.84.235])
        by mx.google.com with ESMTPSA id vm8sm49738012wjc.6.2014.12.06.11.34.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Dec 2014 11:34:43 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <1417894129-5535-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260961>



Hi,

for my feeling Beobachten is better then Versionieren. Its more natural=
 and easier to understand, but okey ;)

Phillip

On 6 December 2014 20:28:49 CET, Ralf Thielow <ralf.thielow@gmail.com> =
wrote:
>Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>---
> po/de.po | 40 ++++++++++++++++++++--------------------
> 1 file changed, 20 insertions(+), 20 deletions(-)
>
>diff --git a/po/de.po b/po/de.po
>index 5a93ea8..bf11225 100644
>--- a/po/de.po
>+++ b/po/de.po
>@@ -690,7 +690,7 @@ msgstr ": vielleicht ein
>Verzeichnis/Datei-Konflikt?"
> #: merge-recursive.c:727
> #, c-format
> msgid "refusing to lose untracked file at '%s'"
>-msgstr "verweigere, da unbeobachtete Dateien in '%s' verloren gehen
>w=C3=BCrden"
>+msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen
>w=C3=BCrden"
>=20
> #: merge-recursive.c:767
> #, c-format
>@@ -1631,7 +1631,7 @@ msgstr ""
> #: wt-status.c:225
>msgid "  (commit or discard the untracked or modified content in
>submodules)"
> msgstr ""
>-"  (committen oder verwerfen Sie den unbeobachteten oder ge=C3=A4nder=
ten
>Inhalt in "
>+"  (committen oder verwerfen Sie den unversionierten oder ge=C3=A4nde=
rten
>Inhalt in "
> "den Submodulen)"
>=20
> #: wt-status.c:237
>@@ -1716,7 +1716,7 @@ msgstr "ge=C3=A4nderter Inhalt, "
>=20
> #: wt-status.c:374
> msgid "untracked content, "
>-msgstr "unbeobachteter Inhalt, "
>+msgstr "unversionierter Inhalt, "
>=20
> #: wt-status.c:391
> #, c-format
>@@ -1932,7 +1932,7 @@ msgstr "Initialer Commit"
>=20
> #: wt-status.c:1356
> msgid "Untracked files"
>-msgstr "Unbeobachtete Dateien"
>+msgstr "Unversionierte Dateien"
>=20
> #: wt-status.c:1358
> msgid "Ignored files"
>@@ -1945,18 +1945,18 @@ msgid ""
> "may speed it up, but you have to be careful not to forget to add\n"
> "new files yourself (see 'git help status')."
> msgstr ""
>-"Es dauerte %.2f Sekunden die unbeobachteten Dateien zu bestimmen.\n"
>+"Es dauerte %.2f Sekunden die unversionierten Dateien zu bestimmen.\n=
"
>"'status -uno' k=C3=B6nnte das beschleunigen, aber Sie m=C3=BCssen dar=
auf
>achten,\n"
> "neue Dateien selbstst=C3=A4ndig hinzuzuf=C3=BCgen (siehe 'git help s=
tatus')."
>=20
> #: wt-status.c:1368
> #, c-format
> msgid "Untracked files not listed%s"
>-msgstr "Unbeobachtete Dateien nicht aufgelistet%s"
>+msgstr "Unversionierte Dateien nicht aufgelistet%s"
>=20
> #: wt-status.c:1370
> msgid " (use -u option to show untracked files)"
>-msgstr " (benutzen Sie die Option -u, um unbeobachtete Dateien
>anzuzeigen)"
>+msgstr " (benutzen Sie die Option -u, um unversionierte Dateien
>anzuzeigen)"
>=20
> #: wt-status.c:1376
> msgid "No changes"
>@@ -1980,20 +1980,20 @@ msgid ""
>"nothing added to commit but untracked files present (use \"git add\"
>to "
> "track)\n"
> msgstr ""
>-"nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien
>(benutzen "
>-"Sie \"git add\" zum Beobachten)\n"
>+"nichts zum Commit vorgemerkt, aber es gibt unversionierte Dateien
>(benutzen "
>+"Sie \"git add\" zum Versionieren)\n"
>=20
> #: wt-status.c:1390
> #, c-format
> msgid "nothing added to commit but untracked files present\n"
>-msgstr "nichts zum Commit vorgemerkt, aber es gibt unbeobachtete
>Dateien\n"
>+msgstr "nichts zum Commit vorgemerkt, aber es gibt unversionierte
>Dateien\n"
>=20
> #: wt-status.c:1393
> #, c-format
>msgid "nothing to commit (create/copy files and use \"git add\" to
>track)\n"
> msgstr ""
>"nichts zu committen (Erstellen/Kopieren Sie Dateien und benutzen Sie
>\"git "
>-"add\" zum Beobachten)\n"
>+"add\" zum Versionieren)\n"
>=20
> #: wt-status.c:1396 wt-status.c:1401
> #, c-format
>@@ -2004,7 +2004,7 @@ msgstr "nichts zu committen\n"
> #, c-format
> msgid "nothing to commit (use -u to show untracked files)\n"
> msgstr ""
>-"nichts zu committen (benutzen Sie die Option -u, um unbeobachtete
>Dateien "
>+"nichts zu committen (benutzen Sie die Option -u, um unversionierte
>Dateien "
> "anzuzeigen)\n"
>=20
> #: wt-status.c:1403
>@@ -2119,7 +2119,7 @@ msgstr "das Hinzuf=C3=BCgen andernfalls ignorier=
ter
>Dateien erlauben"
>=20
> #: builtin/add.c:255
> msgid "update tracked files"
>-msgstr "beobachtete Dateien aktualisieren"
>+msgstr "versionierte Dateien aktualisieren"
>=20
> #: builtin/add.c:256
> msgid "record only the fact that the path will be added later"
>@@ -2128,7 +2128,7 @@ msgstr "nur speichern, dass der Pfad sp=C3=A4ter
>hinzugef=C3=BCgt werden soll"
> #: builtin/add.c:257
> msgid "add changes from all tracked and untracked files"
> msgstr ""
>-"=C3=84nderungen von allen beobachteten und unbeobachteten Dateien
>hinzuf=C3=BCgen"
>+"=C3=84nderungen von allen versionierten und unversionierten Dateien
>hinzuf=C3=BCgen"
>=20
> #: builtin/add.c:260
> msgid "ignore paths removed in the working tree (same as --no-all)"
>@@ -4536,7 +4536,7 @@ msgstr "Kein existierender Autor mit '%s'
>gefunden."
> #: builtin/commit.c:1110 builtin/commit.c:1350
> #, c-format
> msgid "Invalid untracked files mode '%s'"
>-msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
>+msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unversionierte Dateien"
>=20
> #: builtin/commit.c:1147
> msgid "--long and -z are incompatible"
>@@ -4636,7 +4636,7 @@ msgstr "Modus"
> #: builtin/commit.c:1377 builtin/commit.c:1656
>msgid "show untracked files, optional modes: all, normal, no. (Default=
:
>all)"
> msgstr ""
>-"nicht beobachtete Dateien anzeigen, optionale Modi: all, normal, no.
>"
>+"unversionierte Dateien anzeigen, optionale Modi: all, normal, no. "
> "(Standard: all)"
>=20
> #: builtin/commit.c:1380
>@@ -4657,7 +4657,7 @@ msgstr ""
>=20
> #: builtin/commit.c:1384
> msgid "list untracked files in columns"
>-msgstr "unbeobachtete Dateien in Spalten auflisten"
>+msgstr "unversionierte Dateien in Spalten auflisten"
>=20
> #: builtin/commit.c:1471
> msgid "couldn't look up newly created commit"
>@@ -5768,7 +5768,7 @@ msgstr "auch in Inhalten finden, die nicht von
>Git verwaltet werden"
>=20
> #: builtin/grep.c:642
> msgid "search in both tracked and untracked files"
>-msgstr "in beobachteten und unbeobachteten Dateien suchen"
>+msgstr "in versionierten und unversionierten Dateien suchen"
>=20
> #: builtin/grep.c:644
> msgid "search also in ignored files"
>@@ -5959,7 +5959,7 @@ msgstr ""
> #: builtin/grep.c:900
> msgid "--[no-]exclude-standard cannot be used for tracked contents."
> msgstr ""
>-"Die Option --[no-]exclude-standard kann nicht mit beobachteten
>Inhalten "
>+"Die Option --[no-]exclude-standard kann nicht mit versionierten
>Inhalten "
> "verwendet werden."
>=20
> #: builtin/grep.c:908
>@@ -6101,7 +6101,7 @@ msgstr "Ein Git-Glossar"
>=20
> #: builtin/help.c:426
> msgid "Specifies intentionally untracked files to ignore"
>-msgstr "Spezifikation von bewusst ignorierten, unbeobachteten Dateien=
"
>+msgstr "Spezifikation von bewusst ignorierten, unversionierten
>Dateien"
>=20
> #: builtin/help.c:427
> msgid "Defining submodule properties"
