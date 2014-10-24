From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] part1: l10n: de.po: use imperative form for command options
Date: Fri, 24 Oct 2014 20:02:04 +0200
Message-ID: <1414173724-10104-1-git-send-email-ralf.thielow@gmail.com>
References: <CAN0XMO+BR4Tp1EOCPe-ajNyuHpkN1B36T3rzRdw1Z_tzsZH6Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 24 20:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhjBo-0002Cv-44
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 20:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbaJXSCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Oct 2014 14:02:11 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:46738 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbaJXSCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 14:02:09 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so1632200wgg.30
        for <git@vger.kernel.org>; Fri, 24 Oct 2014 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vAt4uPvAXgEdG/oLuXUSb4xH0GVDgQ2uBhThoETjY40=;
        b=oP/VEatg99/MUhUEnypjAhglG5xA+v9ruSg/WwMDIIsfBPEOuawDvmL/1h6+zJSAl+
         /bnZgYE01w2iSp9OM48H+OhYSikcWMylWRYYPsMukB7zLINP2Ejq2obSfdMi/GOcmPO/
         0EcOGI0l8AyoPY1a3VTq/ccfJfB+yrkHz9dKY/Dvmj1MO/81DDbBkor+cSSTYZ6YNRLD
         HYYKjJk4xQBIrP1M/5Wc/eew27kmGdVwr27PLVDoL9tGt7YpEiLhayZtKUlmsfPqkZO0
         OfoQ446Vy4rNiRGzLUVte38uuwDCRzXCRYBZE2sa3/1T61ajRrnc4YdXgR8Se6p8wGgh
         oq+g==
X-Received: by 10.194.192.161 with SMTP id hh1mr6677172wjc.72.1414173727343;
        Fri, 24 Oct 2014 11:02:07 -0700 (PDT)
Received: from localhost (dslb-178-000-162-213.178.000.pools.vodafone-ip.de. [178.0.162.213])
        by mx.google.com with ESMTPSA id dw9sm2789649wib.0.2014.10.24.11.02.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Oct 2014 11:02:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.747.g2027afd
In-Reply-To: <CAN0XMO+BR4Tp1EOCPe-ajNyuHpkN1B36T3rzRdw1Z_tzsZH6Dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 166 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/po/de.po b/po/de.po
index e5d2b25..1285d57 100644
--- a/po/de.po
+++ b/po/de.po
@@ -70,7 +70,7 @@ msgstr "Pr=C3=A4fix"
=20
 #: archive.c:330
 msgid "prepend prefix to each pathname in the archive"
-msgstr "stellt einen Pr=C3=A4fix vor jeden Pfadnamen in dem Archiv"
+msgstr "einen Pr=C3=A4fix vor jeden Pfadnamen in dem Archiv stellen"
=20
 #: archive.c:331 builtin/archive.c:88 builtin/blame.c:2517
 #: builtin/blame.c:2518 builtin/config.c:57 builtin/fast-export.c:709
@@ -82,15 +82,15 @@ msgstr "Datei"
=20
 #: archive.c:332 builtin/archive.c:89
 msgid "write the archive to this file"
-msgstr "schreibt das Archiv in diese Datei"
+msgstr "das Archiv in diese Datei schreiben"
=20
 #: archive.c:334
 msgid "read .gitattributes in working directory"
-msgstr "liest .gitattributes aus dem Arbeitsverzeichnis"
+msgstr ".gitattributes aus dem Arbeitsverzeichnis lesen"
=20
 #: archive.c:335
 msgid "report archived files on stderr"
-msgstr "gibt archivierte Dateien in der Standard-Fehlerausgabe aus"
+msgstr "archivierte Dateien in der Standard-Fehlerausgabe ausgeben"
=20
 #: archive.c:336
 msgid "store only"
@@ -106,7 +106,7 @@ msgstr "besser komprimieren"
=20
 #: archive.c:348
 msgid "list supported archive formats"
-msgstr "listet unterst=C3=BCtzte Archivformate auf"
+msgstr "unterst=C3=BCtzte Archivformate auflisten"
=20
 #: archive.c:350 builtin/archive.c:90 builtin/clone.c:84
 msgid "repo"
@@ -114,7 +114,7 @@ msgstr "Repository"
=20
 #: archive.c:351 builtin/archive.c:91
 msgid "retrieve the archive from remote repository <repo>"
-msgstr "ruft das Archiv von Remote-Repository <Repository> ab"
+msgstr "Archiv vom Remote-Repository <Repository> abrufen"
=20
 #: archive.c:352 builtin/archive.c:92 builtin/notes.c:491
 msgid "command"
@@ -2014,38 +2014,38 @@ msgstr "aktuelle Unterschiede editieren und anw=
enden"
=20
 #: builtin/add.c:254
 msgid "allow adding otherwise ignored files"
-msgstr "erlaubt das Hinzuf=C3=BCgen andernfalls ignorierter Dateien"
+msgstr "das Hinzuf=C3=BCgen andernfalls ignorierter Dateien erlauben"
=20
 #: builtin/add.c:255
 msgid "update tracked files"
-msgstr "aktualisiert beobachtete Dateien"
+msgstr "beobachtete Dateien aktualisieren"
=20
 #: builtin/add.c:256
 msgid "record only the fact that the path will be added later"
-msgstr "speichert nur, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werd=
en soll"
+msgstr "nur speichern, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werd=
en soll"
=20
 #: builtin/add.c:257
 msgid "add changes from all tracked and untracked files"
 msgstr ""
-"f=C3=BCgt =C3=84nderungen von allen beobachteten und unbeobachteten D=
ateien hinzu"
+"=C3=84nderungen von allen beobachteten und unbeobachteten Dateien hin=
zuf=C3=BCgen"
=20
 #: builtin/add.c:260
 msgid "ignore paths removed in the working tree (same as --no-all)"
-msgstr "ignoriert gel=C3=B6schte Pfade im Arbeitsverzeichnis (genau wi=
e --no-all)"
+msgstr "gel=C3=B6schte Pfade im Arbeitsverzeichnis ignorieren (genau w=
ie --no-all)"
=20
 #: builtin/add.c:262
 msgid "don't add, only refresh the index"
-msgstr "f=C3=BCgt nichts hinzu, aktualisiert nur die Staging-Area"
+msgstr "nichts hinzuf=C3=BCgen, nur die Staging-Area aktualisieren"
=20
 #: builtin/add.c:263
 msgid "just skip files which cannot be added because of errors"
 msgstr ""
-"=C3=BCberspringt Dateien, die aufgrund von Fehlern nicht hinzugef=C3=BC=
gt werden "
+"Dateien =C3=BCberspringen, die aufgrund von Fehlern nicht hinzugef=C3=
=BCgt werden "
 "konnten"
=20
 #: builtin/add.c:264
 msgid "check if - even missing - files are ignored in dry run"
-msgstr "pr=C3=BCft ob - auch fehlende - Dateien im Probelauf ignoriert=
 werden"
+msgstr "pr=C3=BCfen ob - auch fehlende - Dateien im Probelauf ignorier=
t werden"
=20
 #: builtin/add.c:286
 #, c-format
@@ -2427,11 +2427,11 @@ msgstr "Pfad"
=20
 #: builtin/apply.c:4359
 msgid "don't apply changes matching the given path"
-msgstr "wendet keine =C3=84nderungen im angegebenen Pfad an"
+msgstr "keine =C3=84nderungen im angegebenen Pfad anwenden"
=20
 #: builtin/apply.c:4362
 msgid "apply changes matching the given path"
-msgstr "wendet =C3=84nderungen nur im angegebenen Pfad an"
+msgstr "=C3=84nderungen nur im angegebenen Pfad anwenden"
=20
 #: builtin/apply.c:4364
 msgid "num"
@@ -2440,29 +2440,29 @@ msgstr "Anzahl"
 #: builtin/apply.c:4365
 msgid "remove <num> leading slashes from traditional diff paths"
 msgstr ""
-"entfernt <Anzahl> vorangestellte Schr=C3=A4gstriche von herk=C3=B6mml=
ichen "
-"Differenzpfaden"
+"<Anzahl> vorangestellte Schr=C3=A4gstriche von herk=C3=B6mmlichen "
+"Differenzpfaden entfernen"
=20
 #: builtin/apply.c:4368
 msgid "ignore additions made by the patch"
-msgstr "ignoriert hinzugef=C3=BCgte Zeilen des Patches"
+msgstr "hinzugef=C3=BCgte Zeilen des Patches ignorieren"
=20
 #: builtin/apply.c:4370
 msgid "instead of applying the patch, output diffstat for the input"
 msgstr ""
-"anstatt der Anwendung des Patches, wird der \"diffstat\" f=C3=BCr die=
 Eingabe "
+"anstatt der Anwendung des Patches, den \"diffstat\" f=C3=BCr die Eing=
abe "
 "ausgegeben"
=20
 #: builtin/apply.c:4374
 msgid "show number of added and deleted lines in decimal notation"
 msgstr ""
-"zeigt die Anzahl von hinzugef=C3=BCgten/entfernten Zeilen in Dezimaln=
otation"
+"die Anzahl von hinzugef=C3=BCgten/entfernten Zeilen in Dezimalnotatio=
n anzeigen"
=20
 #: builtin/apply.c:4376
 msgid "instead of applying the patch, output a summary for the input"
 msgstr ""
-"anstatt der Anwendung des Patches, wird eine Zusammenfassung f=C3=BCr=
 die Eingabe "
-"ausgegeben"
+"anstatt der Anwendung des Patches, eine Zusammenfassung f=C3=BCr die =
Eingabe "
+"ausgeben"
=20
 #: builtin/apply.c:4378
 msgid "instead of applying the patch, see if the patch is applicable"
@@ -2472,27 +2472,27 @@ msgstr ""
 #: builtin/apply.c:4380
 msgid "make sure the patch is applicable to the current index"
 msgstr ""
-"stellt sicher, dass der Patch in der aktuellen Staging-Area angewende=
t "
+"sicherstellen, dass der Patch in der aktuellen Staging-Area angewende=
t "
 "werden kann"
=20
 #: builtin/apply.c:4382
 msgid "apply a patch without touching the working tree"
 msgstr ""
-"wendet einen Patch an, ohne =C3=84nderungen im Arbeitsverzeichnis vor=
zunehmen"
+"Patch anwenden, ohne =C3=84nderungen im Arbeitsverzeichnis vorzunehme=
n"
=20
 #: builtin/apply.c:4384
 msgid "also apply the patch (use with --stat/--summary/--check)"
-msgstr "wendet den Patch an (Benutzung mit --stat/--summary/--check)"
+msgstr "Patch anwenden (Benutzung mit --stat/--summary/--check)"
=20
 #: builtin/apply.c:4386
 msgid "attempt three-way merge if a patch does not apply"
-msgstr "versucht 3-Wege-Merge, wenn der Patch nicht angewendet werden =
konnte"
+msgstr "versuche 3-Wege-Merge, wenn der Patch nicht angewendet werden =
konnte"
=20
 #: builtin/apply.c:4388
 msgid "build a temporary index based on embedded index information"
 msgstr ""
-"erstellt eine tempor=C3=A4re Staging-Area basierend auf den integrier=
ten Staging-"
-"Area-Informationen"
+"eine tempor=C3=A4re Staging-Area, basierend auf den integrierten Stag=
ing-"
+"Area-Informationen, erstellen"
=20
 #: builtin/apply.c:4390 builtin/checkout-index.c:198 builtin/ls-files.=
c:455
 msgid "paths are separated with NUL character"
@@ -2500,7 +2500,7 @@ msgstr "Pfade sind getrennt durch NUL Zeichen"
=20
 #: builtin/apply.c:4393
 msgid "ensure at least <n> lines of context match"
-msgstr "stellt sicher, dass mindestens <n> Zeilen des Kontextes =C3=BC=
bereinstimmen"
+msgstr "sicher stellen, dass mindestens <n> Zeilen des Kontextes =C3=BC=
bereinstimmen"
=20
 #: builtin/apply.c:4394
 msgid "action"
@@ -2508,36 +2508,36 @@ msgstr "Aktion"
=20
 #: builtin/apply.c:4395
 msgid "detect new or modified lines that have whitespace errors"
-msgstr "ermittelt neue oder ge=C3=A4nderte Zeilen die Whitespace-Fehle=
r haben"
+msgstr "neue oder ge=C3=A4nderte Zeilen, die Whitespace-Fehler haben, =
ermitteln"
=20
 #: builtin/apply.c:4398 builtin/apply.c:4401
 msgid "ignore changes in whitespace when finding context"
-msgstr "ignoriert =C3=84nderungen im Whitespace bei der Suche des Kont=
extes"
+msgstr "=C3=84nderungen im Whitespace bei der Suche des Kontextes igno=
rieren"
=20
 #: builtin/apply.c:4404
 msgid "apply the patch in reverse"
-msgstr "wendet den Patch in umgekehrter Reihenfolge an"
+msgstr "den Patch in umgekehrter Reihenfolge anwenden"
=20
 #: builtin/apply.c:4406
 msgid "don't expect at least one line of context"
-msgstr "erwartet keinen Kontext"
+msgstr "keinen Kontext erwarten"
=20
 #: builtin/apply.c:4408
 msgid "leave the rejected hunks in corresponding *.rej files"
 msgstr ""
-"hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bl=C3=B6cke in entspreche=
nden *.rej Dateien"
+"zur=C3=BCckgewiesene Patch-Bl=C3=B6cke in entsprechenden *.rej Dateie=
n hinterlassen"
=20
 #: builtin/apply.c:4410
 msgid "allow overlapping hunks"
-msgstr "erlaubt sich =C3=BCberlappende Patch-Bl=C3=B6cke"
+msgstr "sich =C3=BCberlappende Patch-Bl=C3=B6cke erlauben"
=20
 #: builtin/apply.c:4413
 msgid "tolerate incorrectly detected missing new-line at the end of fi=
le"
-msgstr "toleriert fehlerhaft erkannten fehlenden Zeilenumbruch am Date=
iende"
+msgstr "fehlerhaft erkannten fehlenden Zeilenumbruch am Dateiende tole=
rieren"
=20
 #: builtin/apply.c:4416
 msgid "do not trust the line counts in the hunk headers"
-msgstr "vertraut nicht den Zeilennummern im Kopf des Patch-Blocks"
+msgstr "den Zeilennummern im Kopf des Patch-Blocks nicht vertrauen"
=20
 #: builtin/apply.c:4418
 msgid "root"
@@ -2545,7 +2545,7 @@ msgstr "Wurzelverzeichnis"
=20
 #: builtin/apply.c:4419
 msgid "prepend <root> to all filenames"
-msgstr "stellt <Wurzelverzeichnis> vor alle Dateinamen"
+msgstr "<Wurzelverzeichnis> vor alle Dateinamen stellen"
=20
 #: builtin/apply.c:4441
 msgid "--3way outside a repository"
@@ -2622,11 +2622,11 @@ msgstr "git bisect--helper --next-all [--no-che=
ckout]"
=20
 #: builtin/bisect--helper.c:17
 msgid "perform 'git bisect next'"
-msgstr "f=C3=BChrt 'git bisect next' aus"
+msgstr "'git bisect next' ausf=C3=BChren"
=20
 #: builtin/bisect--helper.c:19
 msgid "update BISECT_HEAD instead of checking out the current commit"
-msgstr "aktualisiert BISECT_HEAD, anstatt den aktuellen Commit auszuch=
ecken"
+msgstr "BISECT_HEAD aktualisieren, anstatt den aktuellen Commit auszuc=
hecken"
=20
 #: builtin/blame.c:30
 msgid "git blame [options] [rev-opts] [rev] [--] file"
@@ -2638,31 +2638,31 @@ msgstr "[rev-opts] sind dokumentiert in git-rev=
-list(1)"
=20
 #: builtin/blame.c:2501
 msgid "Show blame entries as we find them, incrementally"
-msgstr "Zeigt \"blame\"-Eintr=C3=A4ge schrittweise, w=C3=A4hrend wir s=
ie generieren"
+msgstr "\"blame\"-Eintr=C3=A4ge schrittweise anzeigen, w=C3=A4hrend wi=
r sie generieren"
=20
 #: builtin/blame.c:2502
 msgid "Show blank SHA-1 for boundary commits (Default: off)"
-msgstr "Zeigt leere SHA-1 f=C3=BCr Grenz-Commits (Standard: aus)"
+msgstr "leere SHA-1 f=C3=BCr Grenz-Commits anzeigen (Standard: aus)"
=20
 #: builtin/blame.c:2503
 msgid "Do not treat root commits as boundaries (Default: off)"
-msgstr "Behandelt Ursprungs-Commit nicht als Grenzen (Standard: aus)"
+msgstr "Ursprungs-Commit nicht als Grenzen behandeln (Standard: aus)"
=20
 #: builtin/blame.c:2504
 msgid "Show work cost statistics"
-msgstr "Zeigt Statistiken zum Arbeitsaufwand"
+msgstr "Statistiken zum Arbeitsaufwand anzeigen"
=20
 #: builtin/blame.c:2505
 msgid "Show output score for blame entries"
-msgstr "Zeigt Ausgabebewertung f=C3=BCr \"blame\"-Eintr=C3=A4ge"
+msgstr "Ausgabebewertung f=C3=BCr \"blame\"-Eintr=C3=A4ge anzeigen"
=20
 #: builtin/blame.c:2506
 msgid "Show original filename (Default: auto)"
-msgstr "Zeigt urspr=C3=BCnglichen Dateinamen (Standard: auto)"
+msgstr "urspr=C3=BCnglichen Dateinamen anzeigen (Standard: auto)"
=20
 #: builtin/blame.c:2507
 msgid "Show original linenumber (Default: off)"
-msgstr "Zeigt urspr=C3=BCngliche Zeilennummer (Standard: aus)"
+msgstr "urspr=C3=BCngliche Zeilennummer anzeigen (Standard: aus)"
=20
 #: builtin/blame.c:2508
 msgid "Show in a format designed for machine consumption"
@@ -2675,39 +2675,39 @@ msgstr ""
=20
 #: builtin/blame.c:2510
 msgid "Use the same output mode as git-annotate (Default: off)"
-msgstr "Benutzt den gleichen Ausgabemodus wie \"git-annotate\" (Standa=
rd: aus)"
+msgstr "Den gleichen Ausgabemodus benutzen wie \"git-annotate\" (Stand=
ard: aus)"
=20
 #: builtin/blame.c:2511
 msgid "Show raw timestamp (Default: off)"
-msgstr "Zeigt unbearbeiteten Zeitstempel (Standard: aus)"
+msgstr "Unbearbeiteten Zeitstempel anzeigen (Standard: aus)"
=20
 #: builtin/blame.c:2512
 msgid "Show long commit SHA1 (Default: off)"
-msgstr "Zeigt langen Commit-SHA1 (Standard: aus)"
+msgstr "Langen Commit-SHA1 anzeigen (Standard: aus)"
=20
 #: builtin/blame.c:2513
 msgid "Suppress author name and timestamp (Default: off)"
-msgstr "Unterdr=C3=BCckt den Namen des Autors und den Zeitstempel (Sta=
ndard: aus)"
+msgstr "Den Namen des Autors und den Zeitstempel unterdr=C3=BCcken (St=
andard: aus)"
=20
 #: builtin/blame.c:2514
 msgid "Show author email instead of name (Default: off)"
-msgstr "Zeigt anstatt des Namens die Email-Adresse des Autors (Standar=
d: aus)"
+msgstr "Anstatt des Namens die Email-Adresse des Autors anzeigen (Stan=
dard: aus)"
=20
 #: builtin/blame.c:2515
 msgid "Ignore whitespace differences"
-msgstr "Ignoriert Unterschiede im Whitespace"
+msgstr "Unterschiede im Whitespace ignorieren"
=20
 #: builtin/blame.c:2516
 msgid "Spend extra cycles to find better match"
-msgstr "arbeite l=C3=A4nger, um bessere =C3=9Cbereinstimmungen zu find=
en"
+msgstr "L=C3=A4nger arbeiten, um bessere =C3=9Cbereinstimmungen zu fin=
den"
=20
 #: builtin/blame.c:2517
 msgid "Use revisions from <file> instead of calling git-rev-list"
-msgstr "Benutzt Commits von <Datei> anstatt \"git-rev-list\" aufzurufe=
n"
+msgstr "Commits von <Datei> benutzen, anstatt \"git-rev-list\" aufzuru=
fen"
=20
 #: builtin/blame.c:2518
 msgid "Use <file>'s contents as the final image"
-msgstr "Benutzt Inhalte der <Datei>en als entg=C3=BCltiges Abbild"
+msgstr "Inhalte der <Datei>en als entg=C3=BCltiges Abbild benutzen"
=20
 #: builtin/blame.c:2519 builtin/blame.c:2520
 msgid "score"
@@ -2715,11 +2715,11 @@ msgstr "Bewertung"
=20
 #: builtin/blame.c:2519
 msgid "Find line copies within and across files"
-msgstr "Findet kopierte Zeilen innerhalb oder zwischen Dateien"
+msgstr "kopierte Zeilen innerhalb oder zwischen Dateien finden"
=20
 #: builtin/blame.c:2520
 msgid "Find line movements within and across files"
-msgstr "Findet verschobene Zeilen innerhalb oder zwischen Dateien"
+msgstr "verschobene Zeilen innerhalb oder zwischen Dateien finden"
=20
 #: builtin/blame.c:2521
 msgid "n,m"
@@ -2727,7 +2727,7 @@ msgstr "n,m"
=20
 #: builtin/blame.c:2521
 msgid "Process only line range n,m, counting from 1"
-msgstr "Verarbeitet nur Zeilen im Bereich n,m, gez=C3=A4hlt von 1"
+msgstr "nur Zeilen im Bereich n,m verarbeiten, gez=C3=A4hlt von 1"
=20
 #. TRANSLATORS: This string is used to tell us the maximum
 #. display width for a relative timestamp in "git blame"
@@ -2959,27 +2959,27 @@ msgstr "Allgemeine Optionen"
=20
 #: builtin/branch.c:805
 msgid "show hash and subject, give twice for upstream branch"
-msgstr "Zeigt Hash und Betreff; -vv: zus=C3=A4tzlich Upstream-Branch"
+msgstr "Hash und Betreff anzeigen; -vv: zus=C3=A4tzlich Upstream-Branc=
h"
=20
 #: builtin/branch.c:806
 msgid "suppress informational messages"
-msgstr "unterdr=C3=BCckt Informationsmeldungen"
+msgstr "Informationsmeldungen unterdr=C3=BCcken"
=20
 #: builtin/branch.c:807
 msgid "set up tracking mode (see git-pull(1))"
-msgstr "stellt den =C3=9Cbernahmemodus ein (siehe git-pull(1))"
+msgstr "den =C3=9Cbernahmemodus einstellen (siehe git-pull(1))"
=20
 #: builtin/branch.c:809
 msgid "change upstream info"
-msgstr "=C3=A4ndert Informationen zum Upstream-Branch"
+msgstr "Informationen zum Upstream-Branch =C3=A4ndern"
=20
 #: builtin/branch.c:813
 msgid "use colored output"
-msgstr "verwendet farbliche Ausgaben"
+msgstr "farbliche Ausgaben verwenden"
=20
 #: builtin/branch.c:814
 msgid "act on remote-tracking branches"
-msgstr "wirkt auf Remote-Tracking-Branches"
+msgstr "auf Remote-Tracking-Branches wirken"
=20
 #: builtin/branch.c:817 builtin/branch.c:823 builtin/branch.c:844
 #: builtin/branch.c:850 builtin/commit.c:1573 builtin/commit.c:1574
@@ -2990,7 +2990,7 @@ msgstr "Commit"
=20
 #: builtin/branch.c:818 builtin/branch.c:824
 msgid "print only branches that contain the commit"
-msgstr "gibt nur Branches aus, welche diesen Commit beinhalten"
+msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
=20
 #: builtin/branch.c:830
 msgid "Specific git-branch actions:"
@@ -2998,52 +2998,52 @@ msgstr "spezifische Aktionen f=C3=BCr \"git-bra=
nch\":"
=20
 #: builtin/branch.c:831
 msgid "list both remote-tracking and local branches"
-msgstr "listet Remote-Tracking und lokale Branches auf"
+msgstr "Remote-Tracking und lokale Branches auflisten"
=20
 #: builtin/branch.c:833
 msgid "delete fully merged branch"
-msgstr "entfernt vollst=C3=A4ndig zusammengef=C3=BChrten Branch"
+msgstr "vollst=C3=A4ndig zusammengef=C3=BChrten Branch entfernen"
=20
 #: builtin/branch.c:834
 msgid "delete branch (even if not merged)"
-msgstr "l=C3=B6scht Branch (auch wenn nicht zusammengef=C3=BChrt)"
+msgstr "Branch l=C3=B6schen (auch wenn nicht zusammengef=C3=BChrt)"
=20
 #: builtin/branch.c:835
 msgid "move/rename a branch and its reflog"
-msgstr "verschiebt/benennt einen Branch und dessen Reflog um"
+msgstr "einen Branch und dessen Reflog verschieben/umbenennen"
=20
 #: builtin/branch.c:836
 msgid "move/rename a branch, even if target exists"
 msgstr ""
-"verschiebt/benennt einen Branch um, auch wenn das Ziel bereits existi=
ert"
+"einen Branch verschieben/umbenennen, auch wenn das Ziel bereits exist=
iert"
=20
 #: builtin/branch.c:837
 msgid "list branch names"
-msgstr "listet Branchnamen auf"
+msgstr "Branchnamen auflisten"
=20
 #: builtin/branch.c:838
 msgid "create the branch's reflog"
-msgstr "erzeugt das Reflog des Branches"
+msgstr "das Reflog des Branches erzeugen"
=20
 #: builtin/branch.c:840
 msgid "edit the description for the branch"
-msgstr "bearbeitet die Beschreibung f=C3=BCr den Branch"
+msgstr "die Beschreibung f=C3=BCr den Branch bearbeiten"
=20
 #: builtin/branch.c:841
 msgid "force creation (when already exists)"
-msgstr "erzeuge auch, wenn der Branch bereits existiert"
+msgstr "Branch auch erzeugen, wenn dieser bereits existiert"
=20
 #: builtin/branch.c:844
 msgid "print only not merged branches"
-msgstr "gibt nur Branches aus, die nicht zusammengef=C3=BChrt sind"
+msgstr "nur Branches ausgeben, die nicht zusammengef=C3=BChrt sind"
=20
 #: builtin/branch.c:850
 msgid "print only merged branches"
-msgstr "gibt nur Branches aus, die zusammengef=C3=BChrt sind"
+msgstr "nur Branches ausgeben, die zusammengef=C3=BChrt sind"
=20
 #: builtin/branch.c:854
 msgid "list branches in columns"
-msgstr "listet Branches in Spalten auf"
+msgstr "Branches in Spalten auflisten"
=20
 #: builtin/branch.c:867
 msgid "Failed to resolve HEAD as a valid ref."
@@ -3188,15 +3188,15 @@ msgstr "<Art> kann sein: blob, tree, commit, ta=
g"
=20
 #: builtin/cat-file.c:370
 msgid "show object type"
-msgstr "zeigt Objektart"
+msgstr "Objektart anzeigen"
=20
 #: builtin/cat-file.c:371
 msgid "show object size"
-msgstr "zeigt Objektgr=C3=B6=C3=9Fe"
+msgstr "Objektgr=C3=B6=C3=9Fe anzeigen"
=20
 #: builtin/cat-file.c:373
 msgid "exit with zero when there's no error"
-msgstr "beendet mit R=C3=BCckgabewert 0, wenn kein Fehler aufgetreten =
ist"
+msgstr "mit R=C3=BCckgabewert 0 beenden, wenn kein Fehler aufgetreten =
ist"
=20
 #: builtin/cat-file.c:374
 msgid "pretty-print object's content"
@@ -3204,7 +3204,7 @@ msgstr "ansprechende Anzeige des Objektinhaltes"
=20
 #: builtin/cat-file.c:376
 msgid "for blob objects, run textconv on object's content"
-msgstr "f=C3=BChrt eine Textkonvertierung auf den Inhalt von Blob-Obje=
kten aus"
+msgstr "eine Textkonvertierung auf den Inhalt von Blob-Objekten ausf=C3=
=BChren"
=20
 #: builtin/cat-file.c:378
 msgid "show info and content of objects fed from the standard input"
--=20
2.1.2.747.g2027afd
