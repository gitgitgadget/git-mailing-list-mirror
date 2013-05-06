From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 44 new messages
Date: Mon,  6 May 2013 18:50:32 +0200
Message-ID: <1367859032-3639-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon May 06 18:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOce-00007P-7H
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3EFQuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 May 2013 12:50:40 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:57453 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab3EFQui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:50:38 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1662989bkc.16
        for <git@vger.kernel.org>; Mon, 06 May 2013 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bN0MvaJP4IOqnVhMNJu5UG8uz7+kUcyj9FO+qF04wOA=;
        b=QX/n05j8TW87ZRjySRwCTLCLncALdZsto+bOFgHK45PvuZ/iii2L9upaX2ilrT5B3Y
         y18roVcVE5dhs4fJrGVHSN8n37mCNS5gTj5+SDvmQii/5YuvoZBBVljP7U6vPkyiX3B3
         DFWtbwtBiLFLmfNEw2XfLryUmiGRky8Pi7aR4WpVOsXoGLmskRs5t4IJGxZZGVrW4Vb/
         gFDa2J7ixmRM/7+R53Pds2PPpoTJFLAX6b3Mrb5ciP3gyJoK4j9rdW+rej/wr+KhyRkg
         BlGKVh6RWsnkFg3tW0oghT3OnMPc6/xnHiBSDDyugRcLjX07PpAQyP+XieQF9ujn0KwP
         RIJQ==
X-Received: by 10.204.98.77 with SMTP id p13mr8879044bkn.86.1367859037343;
        Mon, 06 May 2013 09:50:37 -0700 (PDT)
Received: from localhost (dslb-178-005-125-192.pools.arcor-ip.net. [178.5.125.192])
        by mx.google.com with ESMTPSA id da16sm5620113bkb.2.2013.05.06.09.50.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 09:50:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.361.g39d8700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223472>

Translate 44 new messages came from git.pot update in
c6bc7d4 (l10n: git.pot: v1.8.3 round 2 (44 new, 12 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 139 +++++++++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 77 insertions(+), 62 deletions(-)

diff --git a/po/de.po b/po/de.po
index c823661..4073b42 100644
--- a/po/de.po
+++ b/po/de.po
@@ -134,74 +134,76 @@ msgstr ""
 "Benutzen Sie '\\!' f=C3=BCr f=C3=BChrende Ausrufezeichen."
=20
 #: branch.c:60
-#, fuzzy, c-format
+#, c-format
 msgid "Not setting branch %s as its own upstream."
-msgstr "externer Zweig %s nicht im anderen Projektarchiv %s gefunden"
+msgstr "Zweig %s kann nicht sein eigener =C3=9Cbernahmezweig sein."
=20
 #: branch.c:82
 #, c-format
 msgid "Branch %s set up to track remote branch %s from %s by rebasing.=
"
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von externem Zweig %s von %s =
durch "
+"Neuaufbau."
=20
 #: branch.c:83
 #, c-format
 msgid "Branch %s set up to track remote branch %s from %s."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von externem Zweig %s von %s.=
"
=20
 #: branch.c:87
 #, c-format
 msgid "Branch %s set up to track local branch %s by rebasing."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von lokalem Zweig %s durch Ne=
uaufbau."
=20
 #: branch.c:88
 #, c-format
 msgid "Branch %s set up to track local branch %s."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von lokalem Zweig %s."
=20
 #: branch.c:92
 #, c-format
 msgid "Branch %s set up to track remote ref %s by rebasing."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von externer Referenz %s durc=
h "
+"Neuaufbau."
=20
 #: branch.c:93
 #, c-format
 msgid "Branch %s set up to track remote ref %s."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von externer Referenz %s."
=20
 #: branch.c:97
 #, c-format
 msgid "Branch %s set up to track local ref %s by rebasing."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von lokaler Referenz %s durch=
 "
+"Neuaufbau."
=20
 #: branch.c:98
 #, c-format
 msgid "Branch %s set up to track local ref %s."
-msgstr ""
+msgstr "Zweig %s konfiguriert zum Folgen von lokaler Referenz %s."
=20
 #: branch.c:118
-#, fuzzy, c-format
+#, c-format
 msgid "Tracking not set up: name too long: %s"
-msgstr "Markierungsname zu lang: %.*s..."
+msgstr "Konfiguration zum Folgen von Zweig nicht eingerichtet. Name zu=
 lang: %s"
=20
 #: branch.c:137
-#, fuzzy, c-format
+#, c-format
 msgid "Not tracking: ambiguous information for ref %s"
-msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
+msgstr "Konfiguration zum Folgen von Zweig nicht eingerichtet. Referen=
z %s ist mehrdeutig."
=20
 #: branch.c:182
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a valid branch name."
-msgstr "'%s' ist kein g=C3=BCltiger Markierungsname."
+msgstr "'%s' ist kein g=C3=BCltiger Zweigname."
=20
 #: branch.c:187
-#, fuzzy, c-format
+#, c-format
 msgid "A branch named '%s' already exists."
-msgstr "Arbeitsbaum '%s' existiert bereits."
+msgstr "Zweig '%s' existiert bereits."
=20
 #: branch.c:195
-#, fuzzy
 msgid "Cannot force update the current branch."
-msgstr "bezieht den aktuellen Zweig ein"
+msgstr "Kann Aktualisierung des aktuellen Zweiges nicht erzwingen."
=20
 #: branch.c:201
 #, c-format
@@ -237,29 +239,27 @@ msgstr ""
 "beim Versand zu konfigurieren."
=20
 #: branch.c:250
-#, fuzzy, c-format
+#, c-format
 msgid "Not a valid object name: '%s'."
-msgstr "%s ist kein g=C3=BCltiger Objekt-Name"
+msgstr "Ung=C3=BCltiger Objekt-Name: '%s'"
=20
 #: branch.c:270
-#, fuzzy, c-format
+#, c-format
 msgid "Ambiguous object name: '%s'."
-msgstr "fehlerhafter Objekt-Name '%s'"
+msgstr "mehrdeutiger Objekt-Name: '%s'"
=20
 #: branch.c:275
-#, fuzzy, c-format
+#, c-format
 msgid "Not a valid branch point: '%s'."
-msgstr "Ung=C3=BCltiger Zweig-Name: '%s'"
+msgstr "Ung=C3=BCltige Zweig-Version: '%s'"
=20
 #: branch.c:281
-#, fuzzy
 msgid "Failed to lock ref for update"
-msgstr "Fehler beim Erstellen der Ausgabedateien."
+msgstr "Fehler beim Sperren der Referenz zur Aktualisierung."
=20
 #: branch.c:299
-#, fuzzy
 msgid "Failed to write ref"
-msgstr "konnte %s nicht schreiben"
+msgstr "Fehler beim Schreiben der Referenz."
=20
 #: bundle.c:36
 #, c-format
@@ -1161,14 +1161,14 @@ msgid "Could not format %s."
 msgstr "Konnte %s nicht formatieren."
=20
 #: sequencer.c:1083
-#, fuzzy, c-format
+#, c-format
 msgid "%s: can't cherry-pick a %s"
-msgstr "Kann \"cherry-pick\" nicht in einem leeren Zweig ausf=C3=BChre=
n."
+msgstr "%s: %s kann nicht in \"cherry-pick\" benutzt werden"
=20
 #: sequencer.c:1085
 #, c-format
 msgid "%s: bad revision"
-msgstr ""
+msgstr "%s: ung=C3=BCltige Revision"
=20
 #: sequencer.c:1119
 msgid "Can't revert as initial commit"
@@ -1561,6 +1561,9 @@ msgid ""
 "may speed it up, but you have to be careful not to forget to add\n"
 "new files yourself (see 'git help status')."
 msgstr ""
+"Es dauerte %.2f Sekunden die unbeobachteten Dateien zu bestimmen.\n"
+"'status -uno' k=C3=B6nnte das beschleunigen, aber Sie m=C3=BCssen dar=
auf achten,\n"
+"neue Dateien selbstst=C3=A4ndig hinzuzuf=C3=BCgen (siehe 'git help st=
atus')."
=20
 #: wt-status.c:1232
 #, c-format
@@ -1665,7 +1668,7 @@ msgstr "git add [Optionen] [--] [<Pfadspezifikati=
on>...]"
 #. * eventually we can drop the warning.
 #.
 #: builtin/add.c:58
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The behavior of 'git add %s (or %s)' with no path argument from a\n"
 "subdirectory of the tree will change in Git 2.0 and should not be use=
d "
@@ -1697,7 +1700,7 @@ msgstr ""
 "  (oder git add %s .)\n"
 "\n"
 "Mit der aktuellen Version von Git ist das Kommando auf das aktuelle\n=
"
-"Verzeichnis beschr=C3=A4nkt."
+"Verzeichnis beschr=C3=A4nkt.\n"
=20
 #: builtin/add.c:100
 #, c-format
@@ -1714,6 +1717,19 @@ msgid ""
#: builtin/add.c:100
#, c-format
msgid ""
"You ran 'git add' with neither '-A (--all)' or '--ignore-removal',\n"
"whose behaviour will change in Git 2.0 with respect to paths you remov=
ed.\n"
"Paths like '%s' that are\n"
"removed from your working tree are ignored with this version of Git.\n=
"
"\n"
"* 'git add --ignore-removal <pathspec>', which is the current default,=
\n"
"  ignores paths you removed from your working tree.\n"
"\n"
"* 'git add --all <pathspec>' will let you also record the removals.\n"
"\n"
 "Run 'git status' to check the paths you removed from your working tre=
e.\n"
 msgstr ""
+"Sie haben 'git add' weder mit '-A (--all)' noch mit '--ignore-removal=
'\n"
+"ausgef=C3=BChrt. Das Verhalten des Kommandos =C3=A4ndert sich in Git =
2.0 durch\n"
+"Ber=C3=BCcksichtigung der gel=C3=B6schten Pfade.\n"
+"Pfade wie '%s', die im Arbeitsverzeichnis gel=C3=B6scht wurden, werde=
n in\n"
+"dieser Version von Git ignoriert.\n"
+"\n"
+"* 'git add --ignore-removal <Pfadspezifikation>', was der aktuelle\n"
+"  Standardwert ist, ignoriert gel=C3=B6schte Pfade im Arbeitsverzeich=
nis."
+"\n"
+"* 'git add --all <Pfadspezifikation>' ber=C3=BCcksichtigt ebenfalls g=
el=C3=B6schte\n"
+"  Pfade."
+"\n"
+"F=C3=BChren Sie 'git status' aus, um die gel=C3=B6schten Pfade zu =C3=
=BCberpr=C3=BCfen.\n"
=20
 #: builtin/add.c:144
 #, c-format
@@ -1816,7 +1832,8 @@ msgstr ""
 #. takes no arguments
 #: builtin/add.c:405
 msgid "ignore paths removed in the working tree (same as --no-all)"
-msgstr ""
+msgstr "ignoriert gel=C3=B6schte Pfade im Arbeitsverzeichnis (genau wi=
e "
+"--no-all)"
=20
 #: builtin/add.c:407
 msgid "don't add, only refresh the index"
@@ -3338,7 +3355,8 @@ msgstr "Konfliktstil (merge oder diff3)"
=20
 #: builtin/checkout.c:1065
 msgid "do not limit pathspecs to sparse entries only"
-msgstr ""
+msgstr "keine Beschr=C3=A4nkung von Pfadspezifikationen zu eingeschr=C3=
=A4nkten "
+"Eintr=C3=A4gen"
=20
 #: builtin/checkout.c:1067
 msgid "second guess 'git checkout no-such-branch'"
@@ -3555,9 +3573,9 @@ msgid "set config inside the new repository"
 msgstr "setzt Konfiguration innerhalb des neuen Projektarchivs"
=20
 #: builtin/clone.c:254
-#, fuzzy, c-format
+#, c-format
 msgid "reference repository '%s' is not a local repository."
-msgstr "Referenziertes Projektarchiv '%s' ist kein lokales Verzeichnis=
=2E"
+msgstr "Referenziertes Projektarchiv '%s' ist kein lokales Projektarch=
iv."
=20
 #: builtin/clone.c:317
 #, c-format
@@ -4424,13 +4442,12 @@ msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
=20
 #: builtin/count-objects.c:82
-#, fuzzy
 msgid "git count-objects [-v] [-H | --human-readable]"
-msgstr "git count-objects [-v]"
+msgstr "git count-objects [-v] [-H | --human-readable]"
=20
 #: builtin/count-objects.c:97
 msgid "print sizes in human readable format"
-msgstr ""
+msgstr "gibt Gr=C3=B6=C3=9Fenangaben in menschenlesbaren Format aus"
=20
 #: builtin/describe.c:15
 msgid "git describe [options] <committish>*"
@@ -5337,7 +5354,7 @@ msgstr "Anzeige aller vorhandenen Kommandos"
=20
 #: builtin/help.c:44
 msgid "print list of useful guides"
-msgstr ""
+msgstr "zeigt Liste von allgemein verwendeten Anleitungen"
=20
 #: builtin/help.c:45
 msgid "show man page"
@@ -5352,9 +5369,8 @@ msgid "show info page"
 msgstr "zeigt Info-Seite"
=20
 #: builtin/help.c:54
-#, fuzzy
 msgid "git help [--all] [--guides] [--man|--web|--info] [command]"
-msgstr "git help [--all] [--man|--web|--info] [Kommando]"
+msgstr "git help [--all] [--guides] [--man|--web|--info] [Kommando]"
=20
 #: builtin/help.c:66
 #, c-format
@@ -5412,36 +5428,35 @@ msgstr "kein Informations-Betrachter konnte mit=
 dieser Anfrage umgehen"
=20
 #: builtin/help.c:422
 msgid "Defining attributes per path"
-msgstr ""
+msgstr "Definition von Attributen pro Pfad"
=20
 #: builtin/help.c:423
 msgid "A Git glossary"
-msgstr ""
+msgstr "Ein Git-Glossar"
=20
 #: builtin/help.c:424
 msgid "Specifies intentionally untracked files to ignore"
-msgstr ""
+msgstr "Spezifikation von bewusst ignorierten, unbeobachteten Dateien"
=20
 #: builtin/help.c:425
 msgid "Defining submodule properties"
-msgstr ""
+msgstr "Definition von Unterprojekt-Eigenschaften"
=20
 #: builtin/help.c:426
 msgid "Specifying revisions and ranges for Git"
-msgstr ""
+msgstr "Spezifikation von Revisionen und Bereichen f=C3=BCr Git"
=20
 #: builtin/help.c:427
 msgid "A tutorial introduction to Git (for version 1.5.1 or newer)"
-msgstr ""
+msgstr "Eine einf=C3=BChrende Anleitung zu Git (f=C3=BCr Version 1.5.1=
 oder neuer)"
=20
 #: builtin/help.c:428
 msgid "An overview of recommended workflows with Git"
-msgstr ""
+msgstr "Eine =C3=9Cbersicht =C3=BCber empfohlene Arbeitsabl=C3=A4ufe m=
it Git"
=20
 #: builtin/help.c:440
-#, fuzzy
 msgid "The common Git guides are:\n"
-msgstr "Die allgemein verwendeten Git-Kommandos sind:"
+msgstr "Die allgemein verwendeten Git-Anleitungen sind:\n"
=20
 #: builtin/help.c:462 builtin/help.c:478
 #, c-format
@@ -5897,9 +5912,8 @@ msgid "Cannot access work tree '%s'"
 msgstr "Kann nicht auf Arbeitsbaum '%s' zugreifen."
=20
 #: builtin/log.c:40
-#, fuzzy
 msgid "git log [<options>] [<revision range>] [[--] <path>...]\n"
-msgstr "git log [<Optionen>] [<seit>..<bis>] [[--] <Pfad>...]\n"
+msgstr "git log [<Optionen>] [Revisionsbereich>] [[--] <Pfad>...]\n"
=20
 #: builtin/log.c:41
 msgid "   or: git show [options] <object>..."
@@ -8510,18 +8524,16 @@ msgstr ""
 "erster Verwendung aus."
=20
 #: builtin/revert.c:22
-#, fuzzy
 msgid "git revert [options] <commit-ish>..."
-msgstr "git revert [options] <Versionsangabe>"
+msgstr "git revert [Optionen] <Versionsangabe>..."
=20
 #: builtin/revert.c:23
 msgid "git revert <subcommand>"
 msgstr "git revert <Unterkommando>"
=20
 #: builtin/revert.c:28
-#, fuzzy
 msgid "git cherry-pick [options] <commit-ish>..."
-msgstr "git cherry-pick [Optionen] <Versionsangabe>"
+msgstr "git cherry-pick [Optionen] <Versionsangabe>..."
=20
 #: builtin/revert.c:29
 msgid "git cherry-pick <subcommand>"
@@ -8675,9 +8687,8 @@ msgid "git rm: unable to remove %s"
 msgstr "git rm: konnte %s nicht l=C3=B6schen"
=20
 #: builtin/shortlog.c:13
-#, fuzzy
 msgid "git shortlog [<options>] [<revision range>] [[--] [<path>...]]"
-msgstr "git log [<Optionen>] [<seit>..<bis>] [[--] <Pfad>...]\n"
+msgstr "git shortlog [<Optionen>] [Revisionsbereich] [[--] <Pfad>...]"
=20
 #: builtin/shortlog.c:131
 #, c-format
@@ -9259,6 +9270,10 @@ msgid ""
 "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 "to read about a specific subcommand or concept."
 msgstr ""
+"'git help -a' und 'git help -g' listet verf=C3=BCgbare Unterkommandos=
 und\n"
+"einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Komm=
ando>'\n"
+"oder 'git help <Konzept>' um mehr =C3=BCber ein spezifisches Kommando=
 oder\n"
+"Konzept zu erfahren."
=20
 #: parse-options.h:156
 msgid "no-op (backward compatibility)"
--=20
1.8.3.rc0.361.g39d8700
