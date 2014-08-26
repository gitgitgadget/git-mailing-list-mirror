From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 38 new messages
Date: Tue, 26 Aug 2014 19:31:33 +0200
Message-ID: <1409074293-8514-1-git-send-email-ralf.thielow@gmail.com>
References: <1407261111-24839-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 19:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKat-0006tf-FP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbaHZRbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2014 13:31:39 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:46596 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbaHZRbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:31:37 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so14882368wgh.14
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gt0K5uAnvRSpJ48fE6f+ASgeS7izbVQdhDg96E5cZAs=;
        b=G5mv4798saTB8tMITrhh01aoKNrPRRmbyrmfzWYUBQfs3clXA4da22YTBba0zR4mAD
         5KdvYFe8M8H82NiFT4Ak8EL24DK5fGJW0fisIgtP6h+sVopzfFu9B37JxDRmCYzeQ92d
         gDMGOCHaBfSsnYnYx7y/JheLXcotYitEHafJC5BaNqUJsPdbsZKLXT5vx304Qj84XQ60
         nLLbCmo2WWiN6T2UzclnpPw/2AvrSWs1mLiAxXCVNoiwAQAgD7vri5NX1oo2O1SPUqfJ
         HnvU5ksZ6oC1VSN+0prNJr53TWwulPq7oRMdj/DBc1XceRXNTW05wH31dl0PLrNcbgxJ
         8yZg==
X-Received: by 10.194.63.241 with SMTP id j17mr3612005wjs.115.1409074296092;
        Tue, 26 Aug 2014 10:31:36 -0700 (PDT)
Received: from localhost (dslb-088-073-189-170.088.073.pools.vodafone-ip.de. [88.73.189.170])
        by mx.google.com with ESMTPSA id cz3sm9890502wjb.23.2014.08.26.10.31.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 10:31:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.g9cce596
In-Reply-To: <1407261111-24839-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255924>

Translate 38 new messages came from git.pot update in fe05e19
(l10n: git.pot: v2.1.0 round 1 (38 new, 9 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
This is a resend of an earlier patch [1] with an extended
recipient list.

[1]
http://article.gmane.org/gmane.comp.version-control.git/254815

 po/de.po | 131 ++++++++++++++++++++++++++++++-------------------------=
--------
 1 file changed, 62 insertions(+), 69 deletions(-)

diff --git a/po/de.po b/po/de.po
index b8fb23f..ffc556c 100644
--- a/po/de.po
+++ b/po/de.po
@@ -23,16 +23,14 @@ msgid "hint: %.*s\n"
 msgstr "Hinweis: %.*s\n"
=20
 #: advice.c:88
-#, fuzzy
 msgid ""
 "Fix them up in the work tree, and then use 'git add/rm <file>'\n"
 "as appropriate to mark resolution and make a commit, or use\n"
 "'git commit -a'."
 msgstr ""
-"Korrigieren Sie dies im Arbeitsverzeichnis,\n"
-"und benutzen Sie dann 'git add/rm <Datei>'\n"
-"um die Aufl=C3=B6sung entsprechend zu markieren und zu committen,\n"
-"oder benutzen Sie 'git commit -a'."
+"Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie\n"
+"dann 'git add/rm <Datei>' um die Aufl=C3=B6sung entsprechend zu marki=
eren\n"
+"und zu committen, oder benutzen Sie 'git commit -a'."
=20
 #: archive.c:10
 msgid "git archive [options] <tree-ish> [<path>...]"
@@ -469,11 +467,11 @@ msgstr ""
 #: diff.c:2934
 #, c-format
 msgid "external diff died, stopping at %s"
-msgstr ""
+msgstr "externes Diff-Programm unerwartet beendet, angehalten bei %s"
=20
 #: diff.c:3329
 msgid "--follow requires exactly one pathspec"
-msgstr ""
+msgstr "--follow erfordert genau eine Pfadspezifikation"
=20
 #: diff.c:3492
 #, c-format
@@ -1141,9 +1139,8 @@ msgstr ""
 "Tragen Sie Ihre =C3=84nderungen ein oder benutzen Sie \"stash\" um fo=
rtzufahren."
=20
 #: sequencer.c:250
-#, fuzzy
 msgid "Failed to lock HEAD during fast_forward_to"
-msgstr "Fehler beim Sperren der Referenz zur Aktualisierung."
+msgstr "Fehler beim Sperren von HEAD w=C3=A4hrend fast_forward_to"
=20
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: sequencer.c:293
@@ -2739,9 +2736,8 @@ msgstr "Verarbeitet nur Zeilen im Bereich n,m, ge=
z=C3=A4hlt von 1"
 #. relative timestamps, but your language may need more or
 #. fewer display columns.
 #: builtin/blame.c:2599
-#, fuzzy
 msgid "4 years, 11 months ago"
-msgstr "%s, und %lu Monat"
+msgstr "vor 4 Jahren, und 11 Monaten"
=20
 #: builtin/branch.c:24
 msgid "git branch [options] [-r | -a] [--merged | --no-merged]"
@@ -4249,9 +4245,9 @@ msgid "malformed --author parameter"
 msgstr "Fehlerhafter --author Parameter"
=20
 #: builtin/commit.c:592
-#, fuzzy, c-format
+#, c-format
 msgid "invalid date format: %s"
-msgstr "Ung=C3=BCltiger Commit: %s"
+msgstr "Ung=C3=BCltiges Datumsformat: %s"
=20
 #: builtin/commit.c:609
 #, c-format
@@ -4263,6 +4259,8 @@ msgid ""
 "unable to select a comment character that is not used\n"
 "in the current commit message"
 msgstr ""
+"Konnte kein Kommentar-Zeichen ausw=C3=A4hlen, das nicht in\n"
+"der aktuellen Commit-Beschreibung verwendet wird."
=20
 #: builtin/commit.c:679 builtin/commit.c:712 builtin/commit.c:1086
 #, c-format
@@ -4354,19 +4352,19 @@ msgstr ""
 "Eine leere Beschreibung bricht den Commit ab.\n"
=20
 #: builtin/commit.c:855
-#, fuzzy, c-format
+#, c-format
 msgid "%sAuthor:    %.*s <%.*s>"
-msgstr "%sAutor:    %s"
+msgstr  "%sAutor:           %.*s <%.*s>"
=20
 #: builtin/commit.c:863
-#, fuzzy, c-format
+#, c-format
 msgid "%sDate:      %s"
-msgstr "%sAutor:    %s"
+msgstr "%sDatum:            %s"
=20
 #: builtin/commit.c:870
-#, fuzzy, c-format
+#, c-format
 msgid "%sCommitter: %.*s <%.*s>"
-msgstr "%sCommit-Ersteller: %s"
+msgstr "%sCommit-Ersteller: %.*s <%.*s>"
=20
 #: builtin/commit.c:888
 msgid "Cannot read index"
@@ -5081,11 +5079,11 @@ msgstr "=C3=9Cberspringt Ausgabe von Blob-Daten=
"
=20
 #: builtin/fast-export.c:720
 msgid "refspec"
-msgstr ""
+msgstr "Refspec"
=20
 #: builtin/fast-export.c:721
 msgid "Apply refspec to exported refs"
-msgstr ""
+msgstr "Wendet Refspec auf exportierte Referenzen an"
=20
 #: builtin/fetch.c:20
 msgid "git fetch [<options>] [<repository> [<refspec>...]]"
@@ -5180,11 +5178,11 @@ msgstr "akzeptiert Referenzen die .git/shallow =
aktualisieren"
=20
 #: builtin/fetch.c:125
 msgid "refmap"
-msgstr ""
+msgstr "Refmap"
=20
 #: builtin/fetch.c:126
 msgid "specify fetch refmap"
-msgstr ""
+msgstr "Angabe der Refmap f=C3=BCr 'fetch'"
=20
 #: builtin/fetch.c:376
 msgid "Couldn't find remote ref HEAD"
@@ -5952,9 +5950,9 @@ msgid "`git %s' is aliased to `%s'"
 msgstr "f=C3=BCr `git %s' wurde der Alias `%s' angelegt"
=20
 #: builtin/index-pack.c:145
-#, fuzzy, c-format
+#, c-format
 msgid "unable to open %s"
-msgstr "kann %s nicht lesen"
+msgstr "kann %s nicht =C3=B6ffnen"
=20
 #: builtin/index-pack.c:191
 #, c-format
@@ -5962,14 +5960,14 @@ msgid "object type mismatch at %s"
 msgstr "Objekt-Typen passen bei %s nicht zusammen"
=20
 #: builtin/index-pack.c:211
-#, fuzzy, c-format
+#, c-format
 msgid "did not receive expected object %s"
-msgstr "Kann Objekt %s nicht lesen."
+msgstr "erwartetes Objekt %s nicht empfangen"
=20
 #: builtin/index-pack.c:214
-#, fuzzy, c-format
+#, c-format
 msgid "object %s: expected type %s, found %s"
-msgstr "Objekt hat unerwarteten Typ"
+msgstr "Objekt %s: erwarteter Typ %s, %s gefunden"
=20
 #: builtin/index-pack.c:256
 #, c-format
@@ -6602,9 +6600,8 @@ msgid "add a signature"
 msgstr "f=C3=BCgt eine Signatur hinzu"
=20
 #: builtin/log.c:1242
-#, fuzzy
 msgid "add a signature from a file"
-msgstr "f=C3=BCgt eine Signatur hinzu"
+msgstr "f=C3=BCgt eine Signatur aus einer Datei hinzu"
=20
 #: builtin/log.c:1243
 msgid "don't print the patch filenames"
@@ -6645,9 +6642,9 @@ msgid "Could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
 #: builtin/log.c:1468
-#, fuzzy, c-format
+#, c-format
 msgid "unable to read signature file '%s'"
-msgstr "Konnte Staging-Area-Datei nicht lesen"
+msgstr "Konnte Signatur-Datei '%s' nicht lesen"
=20
 #: builtin/log.c:1531
 msgid "Failed to create output files"
@@ -8971,14 +8968,12 @@ msgid "git replace [-f] <object> <replacement>"
 msgstr "git replace [-f] <Objekt> <Ersetzung>"
=20
 #: builtin/replace.c:20
-#, fuzzy
 msgid "git replace [-f] --edit <object>"
-msgstr "git replace -d <Objekt>..."
+msgstr "git replace [-f] --edit <Objekt>"
=20
 #: builtin/replace.c:21
-#, fuzzy
 msgid "git replace [-f] --graft <commit> [<parent>...]"
-msgstr "git replace [-f] <Objekt> <Ersetzung>"
+msgstr "git replace [-f] --graft <Commit> [<Eltern-Commit>...]"
=20
 #: builtin/replace.c:22
 msgid "git replace -d <object>..."
@@ -8989,19 +8984,19 @@ msgid "git replace [--format=3D<format>] [-l [<=
pattern>]]"
 msgstr "git replace [--format=3D<Format>] [-l [<Muster>]]"
=20
 #: builtin/replace.c:322 builtin/replace.c:360 builtin/replace.c:388
-#, fuzzy, c-format
+#, c-format
 msgid "Not a valid object name: '%s'"
 msgstr "Ung=C3=BCltiger Objekt-Name: '%s'"
=20
 #: builtin/replace.c:352
-#, fuzzy, c-format
+#, c-format
 msgid "bad mergetag in commit '%s'"
-msgstr "ung=C3=BCltiges Repository '%s'"
+msgstr "ung=C3=BCltiger Merge-Tag in Commit '%s'"
=20
 #: builtin/replace.c:354
-#, fuzzy, c-format
+#, c-format
 msgid "malformed mergetag in commit '%s'"
-msgstr "fehlerhafter Objekt-Name '%s'"
+msgstr "fehlerhafter Merge-Tag in Commit '%s'"
=20
 #: builtin/replace.c:365
 #, c-format
@@ -9009,20 +9004,22 @@ msgid ""
 "original commit '%s' contains mergetag '%s' that is discarded; use --=
edit "
 "instead of --graft"
 msgstr ""
+"Der urspr=C3=BCngliche Commit '%s' enth=C3=A4lt Merge-Tag '%s', der v=
erworfen\n"
+"wird; benutzen Sie --edit anstatt --graft"
=20
 #: builtin/replace.c:398
-#, fuzzy, c-format
+#, c-format
 msgid "the original commit '%s' has a gpg signature."
-msgstr "=C3=BCberpr=C3=BCft den genannten Commit auf eine g=C3=BCltige=
 GPG-Signatur"
+msgstr "Der urspr=C3=BCngliche Commit '%s' hat eine GPG-Signatur."
=20
 #: builtin/replace.c:399
 msgid "the signature will be removed in the replacement commit!"
-msgstr ""
+msgstr "Die Signatur wird in dem Ersetzungs-Commit entfernt!"
=20
 #: builtin/replace.c:405
-#, fuzzy, c-format
+#, c-format
 msgid "could not write replacement commit for: '%s'"
-msgstr "Konnte Eltern-Commit %s nicht parsen\n"
+msgstr "Konnte Ersetzungs-Commit f=C3=BCr '%s' nicht schreiben"
=20
 #: builtin/replace.c:429
 msgid "list replace refs"
@@ -9033,23 +9030,20 @@ msgid "delete replace refs"
 msgstr "l=C3=B6scht ersetzende Referenzen"
=20
 #: builtin/replace.c:431
-#, fuzzy
 msgid "edit existing object"
-msgstr "verwendet existierende Objekte wieder"
+msgstr "bearbeitet existierendes Objekt"
=20
 #: builtin/replace.c:432
-#, fuzzy
 msgid "change a commit's parents"
-msgstr "Keine Commits geparst."
+msgstr "=C3=A4ndert Eltern-Commits eines Commits"
=20
 #: builtin/replace.c:433
 msgid "replace the ref if it exists"
 msgstr "ersetzt die Referenz, wenn sie existiert"
=20
 #: builtin/replace.c:434
-#, fuzzy
 msgid "do not pretty-print contents for --edit"
-msgstr "ansprechende Anzeige des Objektinhaltes"
+msgstr "keine ansprechende Anzeige des Objektinhaltes f=C3=BCr --edit"
=20
 #: builtin/replace.c:435
 msgid "use this format"
@@ -9652,7 +9646,7 @@ msgid "could not verify the tag '%s'"
 msgstr "Konnte Tag '%s' nicht verifizieren"
=20
 #: builtin/tag.c:343
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "\n"
 "Write a message for tag:\n"
@@ -9660,11 +9654,12 @@ msgid ""
 "Lines starting with '%c' will be ignored.\n"
 msgstr ""
 "\n"
-"Geben Sie eine Tag-Beschreibung ein.\n"
-"Zeilen, die mit '%c' beginnen, werden ignoriert.\n"
+"Geben Sie eine Beschreibung f=C3=BCr Tag\n"
+"  %s\n"
+"ein. Zeilen, die mit '%c' beginnen, werden ignoriert.\n"
=20
 #: builtin/tag.c:347
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "\n"
 "Write a message for tag:\n"
@@ -9673,19 +9668,20 @@ msgid ""
 "want to.\n"
 msgstr ""
 "\n"
-"Geben Sie eine Tag-Beschreibung ein.\n"
-"Zeilen, die mit '%c' beginnen, werden behalten; Sie d=C3=BCrfen diese=
\n"
+"Geben Sie eine Beschreibung f=C3=BCr Tag\n"
+"  %s\n"
+"ein. Zeilen, die mit '%c' beginnen, werden behalten; Sie d=C3=BCrfen =
diese\n"
 "selbst entfernen wenn Sie m=C3=B6chten.\n"
=20
 #: builtin/tag.c:371
-#, fuzzy, c-format
+#, c-format
 msgid "unsupported sort specification '%s'"
-msgstr "Nicht unterst=C3=BCtzte Angabe f=C3=BCr \"--sort\": %s"
+msgstr "Nicht unterst=C3=BCtzte Angabe f=C3=BCr \"--sort\" '%s'"
=20
 #: builtin/tag.c:373
-#, fuzzy, c-format
+#, c-format
 msgid "unsupported sort specification '%s' in variable '%s'"
-msgstr "Nicht unterst=C3=BCtzte Angabe f=C3=BCr \"--sort\": %s"
+msgstr "Nicht unterst=C3=BCtzte Angabe f=C3=BCr \"--sort\" '%s' in Var=
iable '%s'"
=20
 #: builtin/tag.c:428
 msgid "unable to sign the tag"
@@ -9959,9 +9955,8 @@ msgid "write index in this format"
 msgstr "schreibt Staging-Area-Datei in diesem Format"
=20
 #: builtin/update-index.c:833
-#, fuzzy
 msgid "enable or disable split index"
-msgstr "Konnte Staging-Area nicht schreiben."
+msgstr "Aktivierung oder Deaktivierung des Splittings der Staging-Area=
"
=20
 #: builtin/update-ref.c:9
 msgid "git update-ref [options] -d <refname> [<oldval>]"
@@ -10000,14 +9995,12 @@ msgid "update the info files from scratch"
 msgstr "aktualisiert die Informationsdateien von Grund auf"
=20
 #: builtin/verify-commit.c:17
-#, fuzzy
 msgid "git verify-commit [-v|--verbose] <commit>..."
-msgstr "git verify-tag [-v|--verbose] <Tag>..."
+msgstr "git verify-commit [-v|--verbose] <Commit>..."
=20
 #: builtin/verify-commit.c:75
-#, fuzzy
 msgid "print commit contents"
-msgstr "gibt Tag-Inhalte aus"
+msgstr "gibt Commit-Inhalte aus"
=20
 #: builtin/verify-pack.c:55
 msgid "git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."
--=20
2.1.0.240.g9cce596
