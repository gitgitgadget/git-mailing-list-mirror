From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 45 new messages
Date: Sat, 19 Apr 2014 20:18:28 +0200
Message-ID: <1397931508-9752-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 20:18:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbZqZ-0001rD-Sr
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 20:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbaDSSSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Apr 2014 14:18:36 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:37348 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbaDSSSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 14:18:33 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so2517309eek.37
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=zmZC+pqEQV9xHS87ZR0ByqxcJePfKmQlKsSb/Gbbhz4=;
        b=L9uSnhKTb3arfbzFzkiMDhdnNjtPSYFlvPPu8ppN6hCyh5Zg1SBptBl67nfkie3vAT
         UF6v0ZFzLW+qPdi1GLzT/e+jIWNVs2OoVHVIhDyGM83VvIECTkxluwWrR/vT2gbXzVGQ
         AVbmGxG2Eb89CZsYM6sK8Q+hBLTruVyf2yUChH0IJ6qzeF3Xqcdo3ckmwpB/vFkV2Isx
         jkU5eouGlGwwcKcZWXoKFFf36MD8rX5TqUUZgdKmLxC0db1Nrcoq4N6lwi9+LIeevKNy
         i6sAmORd+WOMAr1tPWTojAb5WpDSt1iZNJU5mEPNbkEeBRKniH8JJ9Xfl9IDpkLxQ24K
         nTAw==
X-Received: by 10.14.204.199 with SMTP id h47mr32163954eeo.48.1397931511955;
        Sat, 19 Apr 2014 11:18:31 -0700 (PDT)
Received: from localhost (dslb-188-103-228-182.pools.arcor-ip.net. [188.103.228.182])
        by mx.google.com with ESMTPSA id x45sm87634083eef.15.2014.04.19.11.18.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 11:18:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0-rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246521>

Translate 45 new messages came from git.pot update in 5e078fc
(l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 123 +++++++++++++++++++++++++------------------------------=
--------
 1 file changed, 49 insertions(+), 74 deletions(-)

diff --git a/po/de.po b/po/de.po
index 59acf20..e3088db 100644
--- a/po/de.po
+++ b/po/de.po
@@ -436,13 +436,13 @@ msgstr[1] "vor %lu Jahren"
 #, c-format
 msgid "failed to read orderfile '%s'"
 msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
=20
 #: diffcore-rename.c:517
 msgid "Performing inexact rename detection"
-msgstr ""
+msgstr "F=C3=BChre Erkennung f=C3=BCr ungenaue Umbenennung aus"
=20
 #: diff.c:113
 #, c-format
 msgid "  Failed to parse dirstat cut-off percentage '%s'\n"
 msgstr ""
 "  Fehler beim Parsen des abgeschnittenen \"dirstat\" Prozentsatzes '%=
s'\n"
@@ -964,29 +964,32 @@ msgid ""
 "Perhaps you forgot to add either ':/' or '.' ?"
 msgstr ""
 ":(exclude) Muster, aber keine anderen Pfadspezifikationen angegeben.\=
n"
 "Vielleicht haben Sie vergessen entweder ':/' oder '.' hinzuzuf=C3=BCg=
en?"
=20
 #: progress.c:224
-#, fuzzy
 msgid "done"
-msgstr "Fertig\n"
+msgstr "Fertig"
=20
 #: read-cache.c:1238
 #, c-format
 msgid ""
 "index.version set, but the value is invalid.\n"
 "Using version %i"
 msgstr ""
+"index.version gesetzt, aber Wert ung=C3=BCltig.\n"
+"Verwende Version %i"
=20
 #: read-cache.c:1248
 #, c-format
 msgid ""
 "GIT_INDEX_VERSION set, but the value is invalid.\n"
 "Using version %i"
 msgstr ""
+"GIT_INDEX_VERSION gesetzt, aber Wert ung=C3=BCltig.\n"
+"Verwende Version %i"
=20
 #: remote.c:758
 #, c-format
 msgid "Cannot fetch both %s and %s to %s"
 msgstr "Kann 'fetch' nicht f=C3=BCr sowohl %s als auch %s nach %s ausf=
=C3=BChren."
=20
@@ -1400,15 +1403,14 @@ msgstr "Konnte git-Verweis %s nicht erstellen"
 #: submodule.c:1132
 #, c-format
 msgid "Could not set core.worktree in %s"
 msgstr "Konnte core.worktree in '%s' nicht setzen."
=20
 #: unpack-trees.c:206
-#, fuzzy
 msgid "Checking out files"
-msgstr "Pr=C3=BCfe Patch %s..."
+msgstr "Checke Dateien aus"
=20
 #: urlmatch.c:120
 msgid "invalid URL scheme name or missing '://' suffix"
 msgstr "Ung=C3=BCltiges URL-Schema oder Suffix '://' fehlt"
=20
 #: urlmatch.c:144 urlmatch.c:297 urlmatch.c:356
@@ -1554,55 +1556,47 @@ msgstr "von beiden hinzugef=C3=BCgt:"
=20
 #: wt-status.c:264
 msgid "both modified:"
 msgstr "von beiden ge=C3=A4ndert:"
=20
 #: wt-status.c:266
-#, fuzzy, c-format
+#, c-format
 msgid "bug: unhandled unmerged status %x"
-msgstr "Fehler: unbehandelter Differenz-Status %c"
+msgstr "Fehler: unbehandelter Unmerged-Status %x"
=20
 #: wt-status.c:274
-#, fuzzy
 msgid "new file:"
-msgstr "neue Datei"
+msgstr "neue Datei:"
=20
 #: wt-status.c:276
-#, fuzzy
 msgid "copied:"
-msgstr "kopiert"
+msgstr "kopiert:"
=20
 #: wt-status.c:278
-#, fuzzy
 msgid "deleted:"
-msgstr "gel=C3=B6scht"
+msgstr "gel=C3=B6scht:"
=20
 #: wt-status.c:280
-#, fuzzy
 msgid "modified:"
-msgstr "ge=C3=A4ndert"
+msgstr "ge=C3=A4ndert:"
=20
 #: wt-status.c:282
-#, fuzzy
 msgid "renamed:"
-msgstr "umbenannt"
+msgstr "umbenannt:"
=20
 #: wt-status.c:284
-#, fuzzy
 msgid "typechange:"
-msgstr "Typ=C3=A4nderung"
+msgstr "Typ=C3=A4nderung:"
=20
 #: wt-status.c:286
-#, fuzzy
 msgid "unknown:"
-msgstr "unbekannt"
+msgstr "unbekannt:"
=20
 #: wt-status.c:288
-#, fuzzy
 msgid "unmerged:"
-msgstr "nicht zusammengef=C3=BChrt"
+msgstr "nicht gemerged:"
=20
 #: wt-status.c:370
 msgid "new commits, "
 msgstr "neue Commits, "
=20
 #: wt-status.c:372
@@ -3543,13 +3537,12 @@ msgstr "setzt HEAD zu benanntem Commit"
=20
 #: builtin/checkout.c:1096
 msgid "set upstream info for new branch"
 msgstr "setzt Informationen zum Upstream-Branch f=C3=BCr den neuen Bra=
nch"
=20
 #: builtin/checkout.c:1098
-#, fuzzy
 msgid "new-branch"
 msgstr "neuer Branch"
=20
 #: builtin/checkout.c:1098
 msgid "new unparented branch"
 msgstr "neuer Branch ohne Eltern-Commit"
@@ -3791,22 +3784,20 @@ msgstr "l=C3=B6scht nur ignorierte Dateien"
=20
 #: builtin/clean.c:903
 msgid "-x and -X cannot be used together"
 msgstr "Die Optionen -x und -X k=C3=B6nnen nicht gemeinsam verwendet w=
erden."
=20
 #: builtin/clean.c:907
-#, fuzzy
 msgid ""
 "clean.requireForce set to true and neither -i, -n, nor -f given; refu=
sing to "
 "clean"
 msgstr ""
 "clean.requireForce auf \"true\" gesetzt und weder -i, -n noch -f gege=
ben; "
 "\"clean\" verweigert"
=20
 #: builtin/clean.c:910
-#, fuzzy
 msgid ""
 "clean.requireForce defaults to true and neither -i, -n, nor -f given;=
 "
 "refusing to clean"
 msgstr ""
 "clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetzt und w=
eder -i, -n noch -"
 "f gegeben; \"clean\" verweigert"
@@ -4419,13 +4410,12 @@ msgstr ""
 #: builtin/commit.c:1129
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
 "Klug... den letzten Commit mit einer ge=C3=A4nderten Staging-Area nac=
hbessern."
=20
 #: builtin/commit.c:1131
-#, fuzzy
 msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
 msgstr ""
 "Explizite Pfade ohne -i oder -o angegeben; unter der Annahme von --on=
ly "
 "Pfaden..."
=20
 #: builtin/commit.c:1143 builtin/tag.c:639
@@ -4594,13 +4584,13 @@ msgstr ""
 msgid "include status in commit message template"
 msgstr "f=C3=BCgt Status in die Commit-Beschreibungsvorlage ein"
=20
 #: builtin/commit.c:1504 builtin/merge.c:223 builtin/revert.c:92
 #: builtin/tag.c:516
 msgid "key-id"
-msgstr ""
+msgstr "GPG-Schl=C3=BCsselkennung"
=20
 #: builtin/commit.c:1505 builtin/merge.c:224 builtin/revert.c:93
 msgid "GPG sign commit"
 msgstr "signiert Commit mit GPG"
=20
 #: builtin/commit.c:1508
@@ -5394,20 +5384,18 @@ msgstr "Sch=C3=BCssel"
=20
 #: builtin/for-each-ref.c:1090
 msgid "field name to sort on"
 msgstr "sortiere nach diesem Feld"
=20
 #: builtin/fsck.c:147 builtin/prune.c:172
-#, fuzzy
 msgid "Checking connectivity"
-msgstr "Pr=C3=BCfe Konnektivit=C3=A4t... "
+msgstr "Pr=C3=BCfe Konnektivit=C3=A4t"
=20
 #: builtin/fsck.c:544
-#, fuzzy
 msgid "Checking object directories"
-msgstr "zu langes Objekt-Verzeichnis %.*s"
+msgstr "Pr=C3=BCfe Objekt-Verzeichnisse"
=20
 #: builtin/fsck.c:607
 msgid "git fsck [options] [<object>...]"
 msgstr "git fsck [Optionen] [<Objekt>...]"
=20
 #: builtin/fsck.c:613
@@ -5448,15 +5436,14 @@ msgstr "schreibt unreferenzierte Objekte nach .=
git/lost-found"
=20
 #: builtin/fsck.c:623 builtin/prune.c:144
 msgid "show progress"
 msgstr "zeigt Fortschrittsanzeige"
=20
 #: builtin/fsck.c:673
-#, fuzzy
 msgid "Checking objects"
-msgstr "Empfange Objekte"
+msgstr "Pr=C3=BCfe Objekte"
=20
 #: builtin/gc.c:24
 msgid "git gc [options]"
 msgstr "git gc [Optionen]"
=20
 #: builtin/gc.c:90
@@ -5485,29 +5472,29 @@ msgstr "aktiviert \"auto-gc\" Modus"
 msgid "force running gc even if there may be another gc running"
 msgstr ""
 "erzwingt Ausf=C3=BChrung von \"git gc\" selbst wenn ein anderes\n"
 "\"git gc\" bereits ausgef=C3=BChrt wird"
=20
 #: builtin/gc.c:318
-#, fuzzy, c-format
+#, c-format
 msgid "Auto packing the repository in background for optimum performan=
ce.\n"
 msgstr ""
-"Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce "
-"komprimiert.\n"
+"Die Datenbank des Repositories wird f=C3=BCr eine optimale Performanc=
e automatisch\n"
+"im Hintergrund komprimiert.\n"
=20
 #: builtin/gc.c:320
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
 msgstr ""
 "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce "
 "komprimiert.\n"
=20
 #: builtin/gc.c:321
 #, c-format
 msgid "See \"git help gc\" for manual housekeeping.\n"
-msgstr ""
+msgstr "Siehe \"git help gc\" f=C3=BCr manuelle Einstellungen.\n"
=20
 #: builtin/gc.c:336
 #, c-format
 msgid ""
 "gc is already running on machine '%s' pid %<PRIuMAX> (use --force if =
not)"
 msgstr ""
@@ -7510,15 +7497,15 @@ msgstr "Konnte '%s' nicht als g=C3=BCltige Refe=
renz aufl=C3=B6sen."
 #: builtin/notes.c:272
 #, c-format
 msgid "Failed to read object '%s'."
 msgstr "Fehler beim Lesen des Objektes '%s'."
=20
 #: builtin/notes.c:276
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot read note data from non-blob object '%s'."
-msgstr "Kann existierendes Objekt %s nicht lesen."
+msgstr "Kann Notiz-Daten von Nicht-Blob Objekt '%s' nicht lesen."
=20
 #: builtin/notes.c:316
 #, c-format
 msgid "Malformed input line: '%s'."
 msgstr "Fehlerhafte Eingabezeile: '%s'."
=20
@@ -7659,13 +7646,12 @@ msgstr "der Versuch, eine nicht existierende No=
tiz zu l=C3=B6schen, ist kein Fehler"
=20
 #: builtin/notes.c:861
 msgid "read object names from the standard input"
 msgstr "liest Objektnamen von der Standard-Eingabe"
=20
 #: builtin/notes.c:942
-#, fuzzy
 msgid "notes-ref"
 msgstr "Notiz-Referenz"
=20
 #: builtin/notes.c:943
 msgid "use notes from <notes_ref>"
 msgstr "verwendet Notizen von <Notiz-Referenz>"
@@ -7688,24 +7674,23 @@ msgstr ""
 #: builtin/pack-objects.c:175 builtin/pack-objects.c:178
 #, c-format
 msgid "deflate error (%d)"
 msgstr "Fehler beim Komprimieren (%d)"
=20
 #: builtin/pack-objects.c:771
-#, fuzzy
 msgid "Writing objects"
-msgstr "verwendet existierende Objekte wieder"
+msgstr "Schreibe Objekte"
=20
 #: builtin/pack-objects.c:1012
 msgid "disabling bitmap writing, as some objects are not being packed"
-msgstr ""
+msgstr "Deaktiviere Schreiben des Bitmap-Index, da einige Objekte nich=
t in\n"
+"eine Pack-Datei geschrieben wurden"
=20
 #: builtin/pack-objects.c:2174
-#, fuzzy
 msgid "Compressing objects"
-msgstr "erlaubt fehlende Objekte"
+msgstr "Komprimiere Objekte"
=20
 #: builtin/pack-objects.c:2530
 #, c-format
 msgid "unsupported index version %s"
 msgstr "Nicht unterst=C3=BCtzte Staging-Area-Version %s"
=20
@@ -7848,22 +7833,21 @@ msgstr "Komprimierungsgrad f=C3=BCr Paketierung=
"
 #: builtin/pack-objects.c:2640
 msgid "do not hide commits by grafts"
 msgstr "verbirgt keine k=C3=BCnstlichen Vorg=C3=A4nger-Commits (\"graf=
ts\")"
=20
 #: builtin/pack-objects.c:2642
 msgid "use a bitmap index if available to speed up counting objects"
-msgstr ""
+msgstr "benutzt Bitmap-Index (falls verf=C3=BCgbar) zur Optimierung de=
r Objektz=C3=A4hlung"
=20
 #: builtin/pack-objects.c:2644
 msgid "write a bitmap index together with the pack index"
-msgstr ""
+msgstr "schreibt Bitmap-Index zusammen mit Pack-Index"
=20
 #: builtin/pack-objects.c:2723
-#, fuzzy
 msgid "Counting objects"
-msgstr "Indiziere Objekte"
+msgstr "Z=C3=A4hle Objekte"
=20
 #: builtin/pack-refs.c:6
 msgid "git pack-refs [options]"
 msgstr "git pack-refs [Optionen]"
=20
 #: builtin/pack-refs.c:14
@@ -7876,15 +7860,14 @@ msgstr "entfernt lose Referenzen (Standard)"
=20
 #: builtin/prune-packed.c:7
 msgid "git prune-packed [-n|--dry-run] [-q|--quiet]"
 msgstr "git prune-packed [-n|--dry-run] [-q|--quiet]"
=20
 #: builtin/prune-packed.c:49
-#, fuzzy
 msgid "Removing duplicate objects"
-msgstr "Entferne Notiz f=C3=BCr Objekt %s\n"
+msgstr "L=C3=B6sche doppelte Objekte"
=20
 #: builtin/prune.c:12
 msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
 msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head>...]"
=20
 #: builtin/prune.c:142
@@ -7990,13 +7973,12 @@ msgid ""
 msgstr ""
 "Sie versenden nach '%s', welches kein Upstream-Repository Ihres aktue=
llen\n"
 "Branches '%s' ist, ohne anzugeben, was versendet werden soll, um welc=
hen\n"
 "Remote-Branch zu aktualisieren."
=20
 #: builtin/push.c:206
-#, fuzzy
 msgid ""
 "push.default is unset; its implicit value has changed in\n"
 "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
 "and maintain the traditional behavior, use:\n"
 "\n"
 "  git config --global push.default matching\n"
@@ -8015,13 +7997,13 @@ msgid ""
 "See 'git help config' and search for 'push.default' for further "
 "information.\n"
 "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode=
\n"
 "'current' instead of 'simple' if you sometimes use older versions of =
Git)"
 msgstr ""
 "'push.default' ist nicht gesetzt; der implizit gesetzte Wert\n"
-"wird in Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese =
Meldung zu\n"
+"wurde in Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese=
 Meldung zu\n"
 "unterdr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des S=
tandardwertes\n"
 "beizubehalten, benutzen Sie:\n"
 "\n"
 "  git config --global push.default matching\n"
 "\n"
 "Um diese Meldung zu unterdr=C3=BCcken und das neue Verhalten jetzt zu=
 =C3=BCbernehmen, "
@@ -8029,13 +8011,13 @@ msgstr ""
 "\n"
 "  git config --global push.default simple\n"
 "\n"
 "Wenn 'push.default' auf den Wert 'matching' gesetzt ist, werden lokal=
e\n"
 "Branches zu den Remote-Branches mit den selben Namen versendet.\n"
 "\n"
-"In Git 2.0 wird das Standardverhalten zu 'simple' ge=C3=A4ndert. Hier=
bei wird\n"
+"In Git 2.0 wurde das Standardverhalten zu 'simple' ge=C3=A4ndert. Hie=
rbei wird\n"
 "der aktuelle Branch zu dem entsprechenden Remote-Branch versendet, de=
n\n"
 "'git pull' zur Aktualisierung des aktuellen Branches verwendet.\n"
 "\n"
 "F=C3=BChren Sie 'git help config' aus und suchen Sie nach 'push.defau=
lt' f=C3=BCr\n"
 "weitere Informationen.\n"
 "(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutzen Sie=
 den "
@@ -8870,13 +8852,13 @@ msgstr "git-update-server-info nicht ausf=C3=BC=
hren"
 #: builtin/repack.c:170
 msgid "pass --local to git-pack-objects"
 msgstr "=C3=BCbergibt --local an git-pack-objects"
=20
 #: builtin/repack.c:172
 msgid "write bitmap index"
-msgstr ""
+msgstr "schreibt Bitmap-Index"
=20
 #: builtin/repack.c:173
 msgid "approxidate"
 msgstr "Datumsangabe"
=20
 #: builtin/repack.c:174
@@ -8904,13 +8886,13 @@ msgstr "limitiert die maximale Delta-Tiefe"
 #: builtin/repack.c:182
 msgid "maximum size of each packfile"
 msgstr "maximale Gr=C3=B6=C3=9Fe f=C3=BCr jede Paketdatei"
=20
 #: builtin/repack.c:184
 msgid "repack objects in packs marked with .keep"
-msgstr ""
+msgstr "packt Objekte um, die sich in mit .keep markierten Pack-Dateie=
n befinden"
=20
 #: builtin/repack.c:371
 #, c-format
 msgid "removing '%s' failed"
 msgstr "L=C3=B6schen von '%s' fehlgeschlagen"
=20
@@ -9025,15 +9007,14 @@ msgstr "setzt HEAD, Staging-Area und Arbeitsver=
zeichnis um"
=20
 #: builtin/reset.c:282
 msgid "reset HEAD but keep local changes"
 msgstr "setzt HEAD um, beh=C3=A4lt aber lokale =C3=84nderungen"
=20
 #: builtin/reset.c:285
-#, fuzzy
 msgid "record only the fact that removed paths will be added later"
-msgstr "speichert nur, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werd=
en soll"
+msgstr "speichert nur, dass gel=C3=B6schte Pfade sp=C3=A4ter hinzugef=C3=
=BCgt werden sollen"
=20
 #: builtin/reset.c:302
 #, c-format
 msgid "Failed to resolve '%s' as a valid revision."
 msgstr "Konnte '%s' nicht als g=C3=BCltigen Commit aufl=C3=B6sen."
=20
@@ -9065,15 +9046,14 @@ msgstr "Ein '%s'-Reset mit Pfaden ist nicht m=C3=
=B6glich."
 #: builtin/reset.c:340
 #, c-format
 msgid "%s reset is not allowed in a bare repository"
 msgstr "'%s'-Reset ist in einem Bare-Repository nicht erlaubt"
=20
 #: builtin/reset.c:344
-#, fuzzy
 msgid "-N can only be used with --mixed"
-msgstr "-B kann nicht mit -b benutzt werden"
+msgstr "-N kann nur mit -mixed benutzt werden"
=20
 #: builtin/reset.c:361
 msgid "Unstaged changes after reset:"
 msgstr "Nicht zum Commit vorgemerkte =C3=84nderungen nach Zur=C3=BCcks=
etzung:"
=20
 #: builtin/reset.c:367
@@ -9596,15 +9576,15 @@ msgstr "Option 'points-at' erfordert ein Objekt=
"
 #: builtin/tag.c:457
 #, c-format
 msgid "malformed object name '%s'"
 msgstr "fehlerhafter Objekt-Name '%s'"
=20
 #: builtin/tag.c:480
-#, fuzzy, c-format
+#, c-format
 msgid "unsupported sort specification %s"
-msgstr "Nicht unterst=C3=BCtzte Staging-Area-Version %s"
+msgstr "Nicht unterst=C3=BCtzte Angabe f=C3=BCr \"--sort\": %s"
=20
 #: builtin/tag.c:500
 msgid "list tag names"
 msgstr "listet Tagnamen auf"
=20
 #: builtin/tag.c:502
@@ -9645,15 +9625,14 @@ msgstr "ersetzt das Tag, wenn es existiert"
=20
 #: builtin/tag.c:519
 msgid "show tag list in columns"
 msgstr "zeigt Liste der Tags in Spalten"
=20
 #: builtin/tag.c:521
-#, fuzzy
 msgid "sort tags"
-msgstr "meldet Tags"
+msgstr "sortiert Tags"
=20
 #: builtin/tag.c:525
 msgid "Tag listing options"
 msgstr "Optionen f=C3=BCr Auflistung der Tags"
=20
 #: builtin/tag.c:528 builtin/tag.c:534
@@ -9666,15 +9645,14 @@ msgstr "gibt nur Tags von dem Objekt aus"
=20
 #: builtin/tag.c:566
 msgid "--column and -n are incompatible"
 msgstr "--column und -n sind inkompatibel"
=20
 #: builtin/tag.c:578
-#, fuzzy
 msgid "--sort and -n are incompatible"
-msgstr "--column und -n sind inkompatibel"
+msgstr "--sort und -n sind inkompatibel"
=20
 #: builtin/tag.c:585
 msgid "-n option is only allowed with -l."
 msgstr "-n Option ist nur erlaubt mit -l."
=20
 #: builtin/tag.c:587
@@ -9716,15 +9694,14 @@ msgstr "%s: kann Referenz nicht aktualisieren"
 #: builtin/tag.c:650
 #, c-format
 msgid "Updated tag '%s' (was %s)\n"
 msgstr "Tag '%s' aktualisiert (war %s)\n"
=20
 #: builtin/unpack-objects.c:483
-#, fuzzy
 msgid "Unpacking objects"
-msgstr "Indiziere Objekte"
+msgstr "Entpacke Objekte"
=20
 #: builtin/update-index.c:399
 msgid "git update-index [options] [--] [<file>...]"
 msgstr "git update-index [Optionen] [--] [<Datei>...]"
=20
 #: builtin/update-index.c:748
@@ -9761,15 +9738,14 @@ msgstr "aktualisiert Dateiinformationen"
=20
 #: builtin/update-index.c:767
 msgid "like --refresh, but ignore assume-unchanged setting"
 msgstr "wie --refresh, ignoriert aber \"assume-unchanged\" Einstellung=
"
=20
 #: builtin/update-index.c:771
-#, fuzzy
 msgid "<mode>,<object>,<path>"
-msgstr "<Modus> <Objekt> <Pfad>"
+msgstr "<Modus>,<Objekt>,<Pfad>"
=20
 #: builtin/update-index.c:772
 msgid "add the specified entry to the index"
 msgstr "merkt den angegebenen Eintrag zum Commit vor"
=20
 #: builtin/update-index.c:776
@@ -9925,13 +9901,12 @@ msgstr ""
 "'git help -a' und 'git help -g' listet verf=C3=BCgbare Unterkommandos=
 und\n"
 "einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Komm=
ando>'\n"
 "oder 'git help <Konzept>' um mehr =C3=BCber ein spezifisches Kommando=
 oder\n"
 "Konzept zu erfahren."
=20
 #: parse-options.h:143
-#, fuzzy
 msgid "expiry-date"
 msgstr "Verfallsdatum"
=20
 #: parse-options.h:158
 msgid "no-op (backward compatibility)"
 msgstr "Kein Effekt (R=C3=BCckw=C3=A4rtskompatibilit=C3=A4t)"
@@ -10811,15 +10786,15 @@ msgstr ""
 #: git-submodule.sh:475
 #, sh-format
 msgid "Reactivating local git directory for submodule '$sm_name'."
 msgstr "Reaktiviere lokales Git-Verzeichnis f=C3=BCr Submodul '$sm_nam=
e'."
=20
 #: git-submodule.sh:487
-#, fuzzy, sh-format
+#, sh-format
 msgid "Unable to checkout submodule '$sm_path'"
-msgstr "Unf=C3=A4hig Submodul '$sm_path' auszuchecken"
+msgstr "Kann Submodul '$sm_path' nicht auschecken"
=20
 #: git-submodule.sh:492
 #, sh-format
 msgid "Failed to add submodule '$sm_path'"
 msgstr "Hinzuf=C3=BCgen von Submodul '$sm_path' fehlgeschlagen"
=20
--=20
2.0.0-rc0
