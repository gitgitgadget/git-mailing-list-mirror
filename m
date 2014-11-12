From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 62 new messages
Date: Wed, 12 Nov 2014 18:17:38 +0100
Message-ID: <1415812658-3799-1-git-send-email-ralf.thielow@gmail.com>
References: <1415394326-28696-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: phillip.szelat@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 18:17:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XobYD-0007eH-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 18:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbaKLRRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2014 12:17:45 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32983 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaKLRRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 12:17:43 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so14711024wgg.30
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TCiTsJioFZJ5njNagqaPNe/aQNWXYxm6jrZlIPcBFtQ=;
        b=RwqtggAmYTSBKMWxClwBwJPjUxTGkhShPnFpg5j/4XHTqg4jBLHYBWhsAeV3ySP6ie
         X8cnyI3pORau/rX5BzutKEZ2GUNB93WE9fX9XkImaAujn9DNFZ16KJooPNFWLQde0dOi
         82VJCaLRa9BZX0j+wLcJLDQeSw/5jJk/DRPIwy0QaE9ONU5X5S5UUsHZev/L7ZjZGwfg
         pWwq/+tGAMZl19HfcsN5lVYESMBWunnAGFX8i5UK6+fjmuQHRCmnOqeYlemzewlRO+Pv
         HZ4wIzsmhhrPGT9NeeuO238AexNQINWLml09EhcrZMCfhapUXppFPzk1vn5E4ia4M5cj
         SMuQ==
X-Received: by 10.180.90.197 with SMTP id by5mr52640214wib.50.1415812661842;
        Wed, 12 Nov 2014 09:17:41 -0800 (PST)
Received: from localhost (dslb-088-073-206-248.088.073.pools.vodafone-ip.de. [88.73.206.248])
        by mx.google.com with ESMTPSA id dc8sm22398155wib.7.2014.11.12.09.17.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 09:17:41 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc0.232.g8ec773f
In-Reply-To: <1415394326-28696-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 62 new messages came from git.pot update in 16742b0
(l10n: git.pot: proposed updates for v2.2.0 (+62)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 180 +++++++++++++++++++++++++++++--------------------------=
--------
 1 file changed, 83 insertions(+), 97 deletions(-)

diff --git a/po/de.po b/po/de.po
index 96d381e..28ed847 100644
--- a/po/de.po
+++ b/po/de.po
@@ -23,14 +23,13 @@ msgid "hint: %.*s\n"
 msgstr "Hinweis: %.*s\n"
=20
 #: advice.c:88
-#, fuzzy
 msgid ""
 "Fix them up in the work tree, and then use 'git add/rm <file>'\n"
 "as appropriate to mark resolution and make a commit."
 msgstr ""
 "Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie\n"
 "dann 'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu mark=
ieren\n"
-"und zu committen, oder benutzen Sie 'git commit -a'."
+"und zu committen."
=20
 #: archive.c:11
 msgid "git archive [options] <tree-ish> [<path>...]"
@@ -328,9 +327,9 @@ msgid "index-pack died"
 msgstr "Erstellung der Paketindexdatei abgebrochen"
=20
 #: color.c:157
-#, fuzzy, c-format
+#, c-format
 msgid "invalid color value: %.*s"
-msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s: %s"
+msgstr "Ung=C3=BCltiger Farbwert: %.*s"
=20
 #: commit.c:40
 #, c-format
@@ -349,56 +348,56 @@ msgstr "Speicher verbraucht"
 #: config.c:469 config.c:471
 #, c-format
 msgid "bad config file line %d in %s"
-msgstr ""
+msgstr "Zeile %d in Konfigurationsdatei %s ist ung=C3=BCltig."
=20
 #: config.c:587
 #, c-format
 msgid "bad numeric config value '%s' for '%s' in %s: %s"
-msgstr ""
+msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s' in %s: %s"
=20
 #: config.c:589
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s': %s"
-msgstr "Konnte Sektion '%s' in Konfiguration nicht nach '%s' umbenenne=
n"
+msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s': %s"
=20
 #: config.c:674
-#, fuzzy, c-format
+#, c-format
 msgid "failed to expand user dir in: '%s'"
-msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
+msgstr "Fehler beim Erweitern des Nutzerverzeichnisses in: '%s'"
=20
 #: config.c:752 config.c:763
-#, fuzzy, c-format
+#, c-format
 msgid "bad zlib compression level %d"
-msgstr "Komprimierungsgrad f=C3=BCr Paketierung"
+msgstr "ung=C3=BCltiger zlib Komprimierungsgrad %d"
=20
 #: config.c:885
-#, fuzzy, c-format
+#, c-format
 msgid "invalid mode for object creation: %s"
-msgstr "Ung=C3=BCltiges Datumsformat: %s"
+msgstr "Ung=C3=BCltiger Modus f=C3=BCr Objekterstellung: %s"
=20
 #: config.c:1201
-#, fuzzy
 msgid "unable to parse command-line config"
-msgstr "Konnte Staging-Area-Datei nicht lesen"
+msgstr "Konnte die =C3=BCber die Kommandozeile angegebene Konfiguratio=
n nicht parsen."
=20
 #: config.c:1262
 msgid "unknown error occured while reading the configuration files"
-msgstr ""
+msgstr "Es trat ein unbekannter Fehler beim Lesen der Konfigurationsda=
teien auf."
=20
 #: config.c:1586
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse '%s' from command-line config"
-msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht parsen"
+msgstr "Konnte Wert '%s' aus der =C3=BCber die Kommandozeile angegeben=
en\n"
+"Konfiguration nicht parsen."
=20
 #: config.c:1588
 #, c-format
 msgid "bad config variable '%s' in file '%s' at line %d"
-msgstr ""
+msgstr "ung=C3=BCltige Konfigurationsvariable '%s' in Datei '%s' bei Z=
eile %d"
=20
 #: config.c:1647
 #, c-format
 msgid "%s has multiple values"
-msgstr ""
+msgstr "%s hat mehrere Werte"
=20
 #: connected.c:69
 msgid "Could not run 'git rev-list'"
@@ -642,11 +641,11 @@ msgstr "%s: %s - %s"
=20
 #: lockfile.c:275
 msgid "BUG: reopen a lockfile that is still open"
-msgstr ""
+msgstr "FEHLER: Wiederer=C3=B6ffnen einer bereits ge=C3=B6ffneten Lock=
-Datei"
=20
 #: lockfile.c:277
 msgid "BUG: reopen a lockfile that has been committed"
-msgstr ""
+msgstr "FEHLER: Wiederer=C3=B6ffnen einer bereits committeten Lock-Dat=
ei"
=20
 #: merge.c:41
 msgid "failed to read the cache"
@@ -1034,9 +1033,8 @@ msgstr ""
 "Vielleicht haben Sie vergessen entweder ':/' oder '.' hinzuzuf=C3=BCg=
en?"
=20
 #: pretty.c:968
-#, fuzzy
 msgid "unable to parse --pretty format"
-msgstr "Konnte Objekt '%s' nicht parsen."
+msgstr "Konnte --pretty Format nicht parsen."
=20
 #: progress.c:225
 msgid "done"
@@ -1150,13 +1148,12 @@ msgid "dup2(%d,%d) failed"
 msgstr "dup2(%d,%d) fehlgeschlagen"
=20
 #: send-pack.c:265
-#, fuzzy
 msgid "failed to sign the push certificate"
-msgstr "gpg beim Signieren der Daten fehlgeschlagen"
+msgstr "Fehler beim Signieren des \"push\"-Zertifikates"
=20
 #: send-pack.c:322
 msgid "the receiving end does not support --signed push"
-msgstr ""
+msgstr "die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"-=
-signed push\")"
=20
 #: sequencer.c:172 builtin/merge.c:781 builtin/merge.c:892
 #: builtin/merge.c:1002 builtin/merge.c:1012
@@ -1488,9 +1485,9 @@ msgstr "Konnte core.worktree in '%s' nicht setzen=
=2E"
=20
 #: trailer.c:500 trailer.c:504 trailer.c:508 trailer.c:562 trailer.c:5=
66
 #: trailer.c:570
-#, fuzzy, c-format
+#, c-format
 msgid "unknown value '%s' for key '%s'"
-msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht parsen"
+msgstr "unbekannter Wert '%s' f=C3=BCr Schl=C3=BCssel %s"
=20
 #: trailer.c:552 trailer.c:557 builtin/remote.c:288
 #, c-format
@@ -1500,17 +1497,16 @@ msgstr "mehr als ein %s"
 #: trailer.c:587
 #, c-format
 msgid "empty trailer token in trailer '%s'"
-msgstr ""
+msgstr "leerer Anhang-Token in Anhang '%s'"
=20
 #: trailer.c:706
-#, fuzzy, c-format
+#, c-format
 msgid "could not read input file '%s'"
-msgstr "Konnte Log-Datei '%s' nicht lesen"
+msgstr "Konnte Eingabe-Datei '%s' nicht lesen"
=20
 #: trailer.c:709
-#, fuzzy
 msgid "could not read from stdin"
-msgstr "konnte nicht von '%s' lesen"
+msgstr "konnte nicht von der Standard-Eingabe lesen"
=20
 #: unpack-trees.c:202
 msgid "Checking out files"
@@ -1565,9 +1561,8 @@ msgid "no such user"
 msgstr "kein solcher Benutzer"
=20
 #: wrapper.c:550
-#, fuzzy
 msgid "unable to get current working directory"
-msgstr "Kann nicht auf aktuelles Arbeitsverzeichnis zugreifen."
+msgstr "Konnte aktuelles Arbeitsverzeichnis nicht bekommen."
=20
 #: wt-status.c:150
 msgid "Unmerged paths:"
@@ -4234,7 +4229,6 @@ msgid "git status [options] [--] <pathspec>..."
 msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
=20
 #: builtin/commit.c:47
-#, fuzzy
 msgid ""
 "Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n=
"
@@ -4251,12 +4245,12 @@ msgstr ""
 "Ihr Name und E-Mail Adresse wurden automatisch auf Basis\n"
 "Ihres Benutzer- und Rechnernamens konfiguriert. Bitte pr=C3=BCfen Sie=
, dass\n"
 "diese zutreffend sind. Sie k=C3=B6nnen diese Meldung unterdr=C3=BCcke=
n, indem Sie\n"
-"diese explizit setzen:\n"
+"diese explizit setzen. F=C3=BChren Sie dazu das folgende Kommando aus=
 und folgen\n"
+"Sie den Anweisungen in Ihrem Editor, um die Konfigurationsdatei zu be=
arbeiten:\n"
 "\n"
-"    git config --global user.name \"Ihr Name\"\n"
-"    git config --global user.email ihre@emailadresse.de\n"
+"    git config --global --edit\n"
 "\n"
-"Nachdem Sie das getan hast, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=BC=
r diesen Commit "
+"Nachdem Sie das getan haben, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=
=BCr diesen Commit\n"
 "=C3=A4ndern mit:\n"
 "\n"
 "    git commit --amend --reset-author\n"
@@ -4345,19 +4339,16 @@ msgid "interactive add failed"
 msgstr "interaktives Hinzuf=C3=BCgen fehlgeschlagen"
=20
 #: builtin/commit.c:359
-#, fuzzy
 msgid "unable to write index file"
-msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
+msgstr "Konnte Staging-Area-Datei nicht schreiben."
=20
 #: builtin/commit.c:361
-#, fuzzy
 msgid "unable to update temporary index"
-msgstr "Konnte tempor=C3=A4re Staging-Area nicht erstellen."
+msgstr "Konnte tempor=C3=A4re Staging-Area nicht aktualisieren."
=20
 #: builtin/commit.c:363
-#, fuzzy
 msgid "Failed to update main cache tree"
-msgstr "Konnte Cache-Verzeichnis nicht aktualisieren\n"
+msgstr "Konnte Haupt-Cache-Verzeichnis nicht aktualisieren"
=20
 #: builtin/commit.c:387 builtin/commit.c:412 builtin/commit.c:461
 msgid "unable to write new_index file"
@@ -4383,12 +4374,12 @@ msgstr "Konnte tempor=C3=A4re Staging-Area-Date=
i nicht schreiben."
 #: builtin/commit.c:592
 #, c-format
 msgid "commit '%s' lacks author header"
-msgstr ""
+msgstr "Commit '%s' fehlt Autor-Kopfbereich"
=20
 #: builtin/commit.c:594
 #, c-format
 msgid "commit '%s' has malformed author line"
-msgstr ""
+msgstr "Commit '%s' hat fehlerhafte Autor-Zeile"
=20
 #: builtin/commit.c:613
 msgid "malformed --author parameter"
@@ -4774,7 +4765,7 @@ msgstr "GPG-Schl=C3=BCsselkennung"
=20
 #: builtin/commit.c:1633 builtin/merge.c:225 builtin/revert.c:93
 msgid "GPG sign commit"
-msgstr "signiert Commit mit GPG"
+msgstr "Commit mit GPG signieren"
=20
 #: builtin/commit.c:1636
 msgid "Commit contents options"
@@ -4862,7 +4853,6 @@ msgid "failed to write commit object"
 msgstr "Fehler beim Schreiben des Commit-Objektes."
=20
 #: builtin/commit.c:1827
-#, fuzzy
 msgid ""
 "Repository has been updated, but unable to write\n"
 "new_index file. Check that disk is not full and quota is\n"
@@ -5002,9 +4992,8 @@ msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
=20
 #: builtin/config.c:315
-#, fuzzy
 msgid "unable to parse default color value"
-msgstr "kann lokale Referenz nicht aktualisieren"
+msgstr "konnte Standard-Farbwert nicht parsen"
=20
 #: builtin/config.c:455
 #, c-format
@@ -5015,11 +5004,16 @@ msgid ""
 "#\tuser =3D %s\n"
 "#\temail =3D %s\n"
 msgstr ""
+"# Das ist Git's benutzerspezifische Konfiguraionsdatei.\n"
+"[core]\n"
+"# Bitte passen Sie die folgenden Zeilen an und kommentieren Sie diese=
 aus:\n"
+"#\tuser =3D %s\n"
+"#\temail =3D %s\n"
=20
 #: builtin/config.c:590
-#, fuzzy, c-format
+#, c-format
 msgid "cannot create configuration file %s"
-msgstr "Konnte Archiv-Datei '%s' nicht erstellen."
+msgstr "Konnte Konfigurationsdatei '%s' nicht erstellen."
=20
 #: builtin/count-objects.c:82
 msgid "git count-objects [-v] [-H | --human-readable]"
@@ -5250,7 +5244,7 @@ msgstr "Wendet Refspec auf exportierte Referenzen=
 an"
=20
 #: builtin/fast-export.c:999
 msgid "anonymize output"
-msgstr ""
+msgstr "Ausgabe anonymisieren"
=20
 #: builtin/fetch.c:20
 msgid "git fetch [<options>] [<repository> [<refspec>...]]"
@@ -5563,9 +5557,8 @@ msgid "file to read from"
 msgstr "Datei zum Einlesen"
=20
 #: builtin/for-each-ref.c:676
-#, fuzzy
 msgid "unable to parse format"
-msgstr "Konnte Kontakt '%s' nicht parsen."
+msgstr "Konnte Format nicht parsen."
=20
 #: builtin/for-each-ref.c:1057
 msgid "git for-each-ref [options] [<pattern>]"
@@ -5668,9 +5661,9 @@ msgid "git gc [options]"
 msgstr "git gc [Optionen]"
=20
 #: builtin/gc.c:79
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid gc.pruneexpire: '%s'"
-msgstr "Ung=C3=BCltige Referenz: %s"
+msgstr "Ung=C3=BCltiges Wert f=C3=BCr \"gc.pruneexpire\": '%s'"
=20
 #: builtin/gc.c:107
 #, c-format
@@ -6001,6 +5994,8 @@ msgstr "speichert Datei wie sie ist, ohne Filter"
 msgid ""
 "just hash any random garbage to create corrupt objects for debugging =
Git"
 msgstr ""
+"Hash =C3=BCber zuf=C3=A4llige Daten, zur Erzeugung von besch=C3=A4dig=
ten Objekten zur\n"
+Fehlersuche in Git, erzeugen"
=20
 #: builtin/hash-object.c:101
 msgid "process file as it were from this path"
@@ -6090,7 +6085,7 @@ msgstr "Definition von Attributen pro Pfad"
=20
 #: builtin/help.c:424
 msgid "Everyday Git With 20 Commands Or So"
-msgstr ""
+msgstr "T=C3=A4gliche Benutzung von Git mit ungef=C3=A4hr 20 Kommandos=
"
=20
 #: builtin/help.c:425
 msgid "A Git glossary"
@@ -6573,18 +6568,20 @@ msgid ""
 "git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<val=
ue>])...] "
 "[<file>...]"
 msgstr ""
+"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<Wer=
t>])...] "
+"[<Datei>...]"
=20
 #: builtin/interpret-trailers.c:25
 msgid "trim empty trailers"
-msgstr ""
+msgstr "k=C3=BCrzt leere Anh=C3=A4nge"
=20
 #: builtin/interpret-trailers.c:26
 msgid "trailer"
-msgstr ""
+msgstr "Anhang"
=20
 #: builtin/interpret-trailers.c:27
 msgid "trailer(s) to add"
-msgstr ""
+msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
=20
 #: builtin/log.c:41
 msgid "git log [<options>] [<revision range>] [[--] <path>...]\n"
@@ -6595,9 +6592,9 @@ msgid "   or: git show [options] <object>..."
 msgstr "   oder: git show [Optionen] <Objekt>..."
=20
 #: builtin/log.c:81
-#, fuzzy, c-format
+#, c-format
 msgid "invalid --decorate option: %s"
-msgstr "Ung=C3=BCltige Option: %s"
+msgstr "Ung=C3=BCltige Option f=C3=BCr --decorate: %s"
=20
 #: builtin/log.c:127
 msgid "suppress diff output"
@@ -6616,9 +6613,8 @@ msgid "decorate options"
 msgstr "decorate-Optionen"
=20
 #: builtin/log.c:133
-#, fuzzy
 msgid "Process line range n,m in file, counting from 1"
-msgstr "Verarbeitet nur Zeilen im Bereich n,m, gez=C3=A4hlt von 1"
+msgstr "Verarbeitet nur Zeilen im Bereich n,m in der Datei, gez=C3=A4h=
lt von 1"
=20
 #: builtin/log.c:229
 #, c-format
@@ -6628,7 +6624,7 @@ msgstr "letzte Ausgabe: %d %s\n"
 #: builtin/log.c:458
 #, c-format
 msgid "git show %s: bad file"
-msgstr ""
+msgstr "git show %s: ung=C3=BCltige Datei"
=20
 #: builtin/log.c:472 builtin/log.c:564
 #, c-format
@@ -6917,7 +6913,6 @@ msgid "show files on the filesystem that need to =
be removed"
 msgstr "zeigt Dateien im Dateisystem, die gel=C3=B6scht werden m=C3=BC=
ssen, an"
=20
 #: builtin/ls-files.c:477
-#, fuzzy
 msgid "show 'other' directories' names only"
 msgstr "zeigt nur Namen von 'sonstigen' Verzeichnissen an"
=20
@@ -7245,29 +7240,27 @@ msgstr "Kein Remote-Tracking-Branch f=C3=BCr %s=
 von %s"
=20
 #: builtin/merge.c:1129
 msgid "There is no merge to abort (MERGE_HEAD missing)."
-msgstr "Es gibt keinen Merge zum Abbrechen (vermisse MERGE_HEAD)"
+msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
=20
 #: builtin/merge.c:1145
-#, fuzzy
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren."
=20
 #: builtin/merge.c:1148 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existier=
t)."
=20
 #: builtin/merge.c:1152
-#, fuzzy
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren."
=20
 #: builtin/merge.c:1155
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
@@ -7474,12 +7467,11 @@ msgid "git mv [options] <source>... <destinatio=
n>"
 msgstr "git mv [Optionen] <Quelle>... <Ziel>"
=20
 #: builtin/mv.c:69
-#, fuzzy, c-format
+#, c-format
 msgid "Directory %s is in index and no submodule?"
-msgstr "Huh? Verzeichnis %s ist zum Commit vorgemerkt und kein Submodu=
l?"
+msgstr "Verzeichnis %s ist zum Commit vorgemerkt und kein Submodul?"
=20
 #: builtin/mv.c:71
-#, fuzzy
 msgid "Please stage your changes to .gitmodules or stash them to proce=
ed"
 msgstr ""
 "Bitte merken Sie Ihre =C3=84nderungen in .gitmodules zum Commit vor o=
der "
@@ -7487,9 +7479,9 @@ msgstr ""
 "Sie \"stash\", um fortzufahren."
=20
 #: builtin/mv.c:89
-#, fuzzy, c-format
+#, c-format
 msgid "%.*s is in index"
-msgstr "Huh? %.*s ist zum Commit vorgemerkt?"
+msgstr "%.*s ist zum Commit vorgemerkt"
=20
 #: builtin/mv.c:111
 msgid "force move/rename even if target exists"
@@ -7500,9 +7492,9 @@ msgid "skip move/rename errors"
 msgstr "=C3=BCberspringt Fehler beim Verschieben oder Umbenennen"
=20
 #: builtin/mv.c:151
-#, fuzzy, c-format
+#, c-format
 msgid "destination '%s' is not a directory"
-msgstr "%s existiert und ist kein Verzeichnis"
+msgstr "Ziel '%s' ist kein Verzeichnis"
=20
 #: builtin/mv.c:162
 #, c-format
@@ -7751,7 +7743,7 @@ msgid "unable to write note object"
 msgstr "Konnte Notiz-Objekt nicht schreiben"
=20
 #: builtin/notes.c:213
-#, fuzzy, c-format
+#, c-format
 msgid "The note contents have been left in %s"
 msgstr "Die Notiz-Inhalte wurden in %s belassen"
=20
@@ -8499,9 +8491,8 @@ msgid "push missing but relevant tags"
 msgstr "versendet fehlende, aber relevante Tags"
=20
 #: builtin/push.c:509
-#, fuzzy
 msgid "GPG sign the push"
-msgstr "signiert Commit mit GPG"
+msgstr "signiert \"push\" mit GPG"
=20
 #: builtin/push.c:518
 msgid "--delete is incompatible with --all, --mirror and --tags"
@@ -9531,7 +9522,6 @@ msgid "git rm [options] [--] <file>..."
 msgstr "git rm [Optionen] [--] [<Datei>...]"
=20
 #: builtin/rm.c:65
-#, fuzzy
 msgid ""
 "the following submodule (or one of its nested submodules)\n"
 "uses a .git directory:"
@@ -10253,10 +10243,9 @@ msgstr "nur n=C3=BCtzlich f=C3=BCr Fehlersuche=
"
=20
 #: credential-cache--daemon.c:267
 msgid "print debugging messages to stderr"
-msgstr ""
+msgstr "Meldungen zur Fehlersuche in Standard-Fehlerausgabe ausgeben"
=20
 #: git.c:17
-#, fuzzy
 msgid ""
 "'git help -a' and 'git help -g' list available subcommands and some\n=
"
 "concept guides. See 'git help <command>' or 'git help <concept>'\n"
@@ -10382,7 +10371,7 @@ msgstr "benutze <n> Ziffern zur Anzeige von SHA=
-1s"
=20
 #: rerere.h:27
 msgid "update the index with reused conflict resolution if possible"
-msgstr ""
+msgstr "Staging-Area, wenn m=C3=B6glich, mit wiederverwendeter Konflik=
taufl=C3=B6sung aktualisieren"
=20
 #: git-am.sh:52
 msgid "You need to set your committer info first"
@@ -10648,7 +10637,6 @@ msgid "Are you sure [Y/n]? "
 msgstr "Sind Sie sicher [Y/n]? "
=20
 #: git-bisect.sh:289
-#, fuzzy
 msgid ""
 "You need to give me at least one good and one bad revision.\n"
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
@@ -10658,7 +10646,6 @@ msgstr ""
 "(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
=20
 #: git-bisect.sh:292
-#, fuzzy
 msgid ""
 "You need to start by \"git bisect start\".\n"
 "You then need to give me at least one good and one bad revision.\n"
@@ -10732,16 +10719,15 @@ msgid "bisect run success"
 msgstr "'bisect run' erfolgreich ausgef=C3=BChrt"
=20
 #: git-pull.sh:21
-#, fuzzy
 msgid ""
 "Pull is not possible because you have unmerged files.\n"
 "Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
 "as appropriate to mark resolution and make a commit."
 msgstr ""
 "\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben.\n"
-"Bitte korrigieren Sie dies im Arbeitsverzeichnis und benutzen Sie dan=
n \n"
-"'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu markieren=
, oder\n"
-"benutzen Sie 'git commit -a'."
+"Bitte korrigieren Sie dies im Arbeitsverzeichnis und benutzen Sie dan=
n\n"
+"'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu markieren=
 und zu\n"
+"committen."
=20
 #: git-pull.sh:25
 msgid "Pull is not possible because you have unmerged files."
@@ -11017,7 +11003,7 @@ msgid "Too many revisions specified: $REV"
 msgstr "Zu viele Commits angegeben: $REV"
=20
 #: git-stash.sh:397
-#, fuzzy, sh-format
+#, sh-format
 msgid "$reference is not a valid reference"
 msgstr "$reference ist keine g=C3=BCltige Referenz"
=20
--=20
2.2.0.rc0.232.g8ec773f
