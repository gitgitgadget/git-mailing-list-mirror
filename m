From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 6/7] part6: l10n: de.po: use imperative form for command options
Date: Fri, 19 Sep 2014 19:12:49 +0200
Message-ID: <1411146770-8508-7-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 19:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1kX-000423-2T
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbaISRNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2014 13:13:24 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:57015 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517AbaISRNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:13:09 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so99079wes.13
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=77E2pax8ida0na1po0WPwyXIzl9ysQH9s4/Z3R8WOME=;
        b=EuhbJrZUsvbHjVcxXExDLxknm2kQnTA33S3CkpXi6T+/XczutkUNl0GqsWXcH87dRD
         AIC3CUXSuHRVFsfYarsAlvNOFeAm9ME7kcRWStup+WK9lUZpOEZobSNH5Dr61apXBcF+
         GZUQY7+qYr5R2qf7ESwgDPLKkQerxGQz6oOLCTKUpC4c8RrRd1irfIBWxQ0ECuPNTjSC
         kFqnA452o6yPJWF/CXNPOOSrjs2zvEl0wNLKcGAqtDw3gA1U7hqn4RlAeDqh3N1a7UJ9
         RyYhfvALVi7Or87m0e84DL9qHo3Tu7NMybVBKwlavlQVuZHtaq7OOOiEhaMKep8MDzTA
         sw5w==
X-Received: by 10.194.179.197 with SMTP id di5mr2309754wjc.125.1411146788548;
        Fri, 19 Sep 2014 10:13:08 -0700 (PDT)
Received: from localhost (dslb-178-000-162-213.178.000.pools.vodafone-ip.de. [178.0.162.213])
        by mx.google.com with ESMTPSA id fa20sm2760356wic.1.2014.09.19.10.13.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Sep 2014 10:13:08 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.368.g9f4fb5d
In-Reply-To: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257298>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 156 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/po/de.po b/po/de.po
index e776d6f..9ccd63b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7942,11 +7942,11 @@ msgstr "nicht l=C3=B6schen, nur anzeigen"
=20
 #: builtin/prune.c:143
 msgid "report pruned objects"
-msgstr "meldet gel=C3=B6schte Objekte"
+msgstr "gel=C3=B6schte Objekte melden"
=20
 #: builtin/prune.c:146
 msgid "expire objects older than <time>"
-msgstr "l=C3=A4sst Objekte =C3=A4lter als <Zeit> verfallen"
+msgstr "Objekte =C3=A4lter als <Zeit> verfallen lassen"
=20
 #: builtin/push.c:14
 msgid "git push [<options>] [<repository> [<refspec>...]]"
@@ -8225,23 +8225,23 @@ msgstr "Repository"
=20
 #: builtin/push.c:483
 msgid "push all refs"
-msgstr "versendet alle Referenzen"
+msgstr "alle Referenzen versenden"
=20
 #: builtin/push.c:484
 msgid "mirror all refs"
-msgstr "spiegelt alle Referenzen"
+msgstr "alle Referenzen spiegeln"
=20
 #: builtin/push.c:486
 msgid "delete refs"
-msgstr "l=C3=B6scht Referenzen"
+msgstr "Referenzen l=C3=B6schen"
=20
 #: builtin/push.c:487
 msgid "push tags (can't be used with --all or --mirror)"
-msgstr "versendet Tags (kann nicht mit --all oder --mirror verwendet w=
erden)"
+msgstr "Tags versenden (kann nicht mit --all oder --mirror verwendet w=
erden)"
=20
 #: builtin/push.c:490
 msgid "force updates"
-msgstr "erzwingt Aktualisierung"
+msgstr "Aktualisierung erzwingen"
=20
 #: builtin/push.c:492
 msgid "refname>:<expect"
@@ -8257,11 +8257,11 @@ msgstr ""
=20
 #: builtin/push.c:496
 msgid "control recursive pushing of submodules"
-msgstr "steuert rekursiven \"push\" von Submodulen"
+msgstr "rekursiven \"push\" von Submodulen steuern"
=20
 #: builtin/push.c:498
 msgid "use thin pack"
-msgstr "verwendet kleinere Pakete"
+msgstr "kleinere Pakete verwenden"
=20
 #: builtin/push.c:499 builtin/push.c:500
 msgid "receive pack program"
@@ -8269,19 +8269,19 @@ msgstr "'receive pack' Programm"
=20
 #: builtin/push.c:501
 msgid "set upstream for git pull/status"
-msgstr "setzt Upstream f=C3=BCr \"git pull/status\""
+msgstr "Upstream f=C3=BCr \"git pull/status\" setzen"
=20
 #: builtin/push.c:504
 msgid "prune locally removed refs"
-msgstr "entfernt lokal gel=C3=B6schte Referenzen"
+msgstr "lokal gel=C3=B6schte Referenzen entfernen"
=20
 #: builtin/push.c:506
 msgid "bypass pre-push hook"
-msgstr "umgeht \"pre-push hook\""
+msgstr "\"pre-push hook\" umgehen"
=20
 #: builtin/push.c:507
 msgid "push missing but relevant tags"
-msgstr "versendet fehlende, aber relevante Tags"
+msgstr "fehlende, aber relevante Tags versenden"
=20
 #: builtin/push.c:517
 msgid "--delete is incompatible with --all, --mirror and --tags"
@@ -8304,11 +8304,11 @@ msgstr ""
=20
 #: builtin/read-tree.c:109
 msgid "write resulting index to <file>"
-msgstr "schreibt resultierende Staging-Area nach <Datei>"
+msgstr "resultierende Staging-Area nach <Datei> schreiben"
=20
 #: builtin/read-tree.c:112
 msgid "only empty the index"
-msgstr "leert die Staging-Area"
+msgstr "die Staging-Area leeren"
=20
 #: builtin/read-tree.c:114
 msgid "Merging"
@@ -8316,7 +8316,7 @@ msgstr "Merge"
=20
 #: builtin/read-tree.c:116
 msgid "perform a merge in addition to a read"
-msgstr "f=C3=BChrt einen Merge zus=C3=A4tzlich zum Lesen aus"
+msgstr "einen Merge, zus=C3=A4tzlich zum Lesen, ausf=C3=BChren"
=20
 #: builtin/read-tree.c:118
 msgid "3-way merge if no file level merging required"
@@ -8328,7 +8328,7 @@ msgstr "3-Wege-Merge bei Vorhandensein von hinzug=
ef=C3=BCgten/entfernten Zeilen"
=20
 #: builtin/read-tree.c:122
 msgid "same as -m, but discard unmerged entries"
-msgstr "genau wie -m, verwirft aber nicht zusammengef=C3=BChrte Eintr=C3=
=A4ge"
+msgstr "genau wie -m, aber nicht zusammengef=C3=BChrte Eintr=C3=A4ge v=
erwerfen"
=20
 #: builtin/read-tree.c:123
 msgid "<subdirectory>/"
@@ -8336,11 +8336,11 @@ msgstr "<Unterverzeichnis>/"
=20
 #: builtin/read-tree.c:124
 msgid "read the tree into the index under <subdirectory>/"
-msgstr "liest das Verzeichnis in die Staging-Area unter <Unterverzeich=
nis>/"
+msgstr "das Verzeichnis in die Staging-Area unter <Unterverzeichnis>/ =
lesen"
=20
 #: builtin/read-tree.c:127
 msgid "update working tree with merge result"
-msgstr "aktualisiert Arbeitsverzeichnis mit dem Ergebnis des Merges"
+msgstr "Arbeitsverzeichnis mit dem Ergebnis des Merges aktualisieren"
=20
 #: builtin/read-tree.c:129
 msgid "gitignore"
@@ -8348,23 +8348,23 @@ msgstr "gitignore"
=20
 #: builtin/read-tree.c:130
 msgid "allow explicitly ignored files to be overwritten"
-msgstr "erlaubt explizit ignorierte Dateien zu =C3=BCberschreiben"
+msgstr "explizit ignorierte Dateien zu =C3=BCberschreiben erlauben"
=20
 #: builtin/read-tree.c:133
 msgid "don't check the working tree after merging"
-msgstr "pr=C3=BCft nicht das Arbeitsverzeichnis nach dem Merge"
+msgstr "das Arbeitsverzeichnis nach dem Merge nicht pr=C3=BCfen"
=20
 #: builtin/read-tree.c:134
 msgid "don't update the index or the work tree"
-msgstr "aktualisiert weder die Staging-Area, noch das Arbeitsverzeichn=
is"
+msgstr "weder die Staging-Area, noch das Arbeitsverzeichnis aktualisie=
ren"
=20
 #: builtin/read-tree.c:136
 msgid "skip applying sparse checkout filter"
-msgstr "=C3=BCberspringt Anwendung des Filters f=C3=BCr sp=C3=A4rliche=
s Auschecken"
+msgstr "Anwendung des Filters f=C3=BCr sp=C3=A4rliches Auschecken =C3=BC=
berspringen"
=20
 #: builtin/read-tree.c:138
 msgid "debug unpack-trees"
-msgstr "protokolliert Entpacken der B=C3=A4ume"
+msgstr "Entpacken der B=C3=A4ume protokollieren"
=20
 #: builtin/reflog.c:499
 #, c-format
@@ -8478,11 +8478,11 @@ msgstr "unbekanntes Argument f=C3=BCr Option --=
mirror: %s"
=20
 #: builtin/remote.c:153
 msgid "fetch the remote branches"
-msgstr "fordert die Remote-Branches an"
+msgstr "die Remote-Branches anfordern"
=20
 #: builtin/remote.c:155
 msgid "import all tags and associated objects when fetching"
-msgstr "importiert alle Tags und verbundene Objekte beim Anfordern"
+msgstr "alle Tags und verbundene Objekte beim Anfordern importieren"
=20
 #: builtin/remote.c:158
 msgid "or do not fetch any tag at all (--no-tags)"
@@ -8837,7 +8837,7 @@ msgstr "* [veralteten Branch entfernt] %s"
=20
 #: builtin/remote.c:1397
 msgid "prune remotes after fetching"
-msgstr "entfernt veraltete Branches im Remote-Repository nach \"fetch\=
""
+msgstr "entferne veraltete Branches im Remote-Repository nach \"fetch\=
""
=20
 #: builtin/remote.c:1463 builtin/remote.c:1537
 #, c-format
@@ -8846,7 +8846,7 @@ msgstr "Kein solches Remote-Repository '%s'"
=20
 #: builtin/remote.c:1483
 msgid "add branch"
-msgstr "f=C3=BCgt Branch hinzu"
+msgstr "Branch hinzuf=C3=BCgen"
=20
 #: builtin/remote.c:1490
 msgid "no remote specified"
@@ -8854,15 +8854,15 @@ msgstr "kein Remote-Repository angegeben"
=20
 #: builtin/remote.c:1512
 msgid "manipulate push URLs"
-msgstr "manipuliert URLs f=C3=BCr \"push\""
+msgstr "URLs f=C3=BCr \"push\" manipulieren"
=20
 #: builtin/remote.c:1514
 msgid "add URL"
-msgstr "f=C3=BCgt URL hinzu"
+msgstr "URL hinzuf=C3=BCgen"
=20
 #: builtin/remote.c:1516
 msgid "delete URLs"
-msgstr "l=C3=B6scht URLs"
+msgstr "URLs l=C3=B6schen"
=20
 #: builtin/remote.c:1523
 msgid "--add --delete doesn't make sense"
@@ -8893,7 +8893,7 @@ msgstr "git repack [Optionen]"
=20
 #: builtin/repack.c:160
 msgid "pack everything in a single pack"
-msgstr "packt alles in eine einzige Pack-Datei"
+msgstr "alles in eine einzige Pack-Datei packen"
=20
 #: builtin/repack.c:162
 msgid "same as -a, and turn unreachable objects loose"
@@ -8901,15 +8901,15 @@ msgstr "genau wie -a, unerreichbare Objekte wer=
den aber nicht gel=C3=B6scht"
=20
 #: builtin/repack.c:165
 msgid "remove redundant packs, and run git-prune-packed"
-msgstr "entfernt redundante Pakete und f=C3=BChrt \"git-prune-packed\"=
 aus"
+msgstr "redundante Pakete entfernen und \"git-prune-packed\" ausf=C3=BC=
hren"
=20
 #: builtin/repack.c:167
 msgid "pass --no-reuse-delta to git-pack-objects"
-msgstr "=C3=BCbergibt --no-reuse-delta an git-pack-objects"
+msgstr "--no-reuse-delta an git-pack-objects =C3=BCbergeben"
=20
 #: builtin/repack.c:169
 msgid "pass --no-reuse-object to git-pack-objects"
-msgstr "=C3=BCbergibt --no-reuse-object an git-pack-objects"
+msgstr "--no-reuse-object an git-pack-objects =C3=BCbergeben"
=20
 #: builtin/repack.c:171
 msgid "do not run git-update-server-info"
@@ -8917,11 +8917,11 @@ msgstr "git-update-server-info nicht ausf=C3=BC=
hren"
=20
 #: builtin/repack.c:174
 msgid "pass --local to git-pack-objects"
-msgstr "=C3=BCbergibt --local an git-pack-objects"
+msgstr "--local an git-pack-objects =C3=BCbergeben"
=20
 #: builtin/repack.c:176
 msgid "write bitmap index"
-msgstr "schreibt Bitmap-Index"
+msgstr "Bitmap-Index schreiben"
=20
 #: builtin/repack.c:177
 msgid "approxidate"
@@ -8929,7 +8929,7 @@ msgstr "Datumsangabe"
=20
 #: builtin/repack.c:178
 msgid "with -A, do not loosen objects older than this"
-msgstr "mit -A, l=C3=B6scht keine Objekte =C3=A4lter als dieses Datum"
+msgstr "mit -A, keine Objekte =C3=A4lter als dieses Datum l=C3=B6schen=
"
=20
 #: builtin/repack.c:180
 msgid "size of the window used for delta compression"
@@ -8942,12 +8942,12 @@ msgstr "Bytes"
 #: builtin/repack.c:182
 msgid "same as the above, but limit memory size instead of entries cou=
nt"
 msgstr ""
-"gleiches wie oben, limitiert aber die Speichergr=C3=B6=C3=9Fe anstatt=
 der\n"
-"Anzahl der Eintr=C3=A4ge"
+"gleiches wie oben, aber die Speichergr=C3=B6=C3=9Fe anstatt der\n"
+"Anzahl der Eintr=C3=A4ge limitieren"
=20
 #: builtin/repack.c:184
 msgid "limits the maximum delta depth"
-msgstr "limitiert die maximale Delta-Tiefe"
+msgstr "die maximale Delta-Tiefe limitieren"
=20
 #: builtin/repack.c:186
 msgid "maximum size of each packfile"
@@ -8956,7 +8956,7 @@ msgstr "maximale Gr=C3=B6=C3=9Fe f=C3=BCr jede Pa=
ketdatei"
 #: builtin/repack.c:188
 msgid "repack objects in packs marked with .keep"
 msgstr ""
-"packt Objekte um, die sich in mit .keep markierten Pack-Dateien befin=
den"
+"Objekte umpacken, die sich in mit .keep markierten Pack-Dateien befin=
den"
=20
 #: builtin/repack.c:374
 #, c-format
@@ -9023,23 +9023,23 @@ msgstr "Konnte Ersetzungs-Commit f=C3=BCr '%s' =
nicht schreiben"
=20
 #: builtin/replace.c:429
 msgid "list replace refs"
-msgstr "listet ersetzende Referenzen auf"
+msgstr "ersetzende Referenzen auflisten"
=20
 #: builtin/replace.c:430
 msgid "delete replace refs"
-msgstr "l=C3=B6scht ersetzende Referenzen"
+msgstr "ersetzende Referenzen l=C3=B6schen"
=20
 #: builtin/replace.c:431
 msgid "edit existing object"
-msgstr "bearbeitet existierendes Objekt"
+msgstr "existierendes Objekt bearbeiten"
=20
 #: builtin/replace.c:432
 msgid "change a commit's parents"
-msgstr "=C3=A4ndert Eltern-Commits eines Commits"
+msgstr "Eltern-Commits eines Commits =C3=A4ndern"
=20
 #: builtin/replace.c:433
 msgid "replace the ref if it exists"
-msgstr "ersetzt die Referenz, wenn sie existiert"
+msgstr "die Referenz ersetzen, wenn sie existiert"
=20
 #: builtin/replace.c:434
 msgid "do not pretty-print contents for --edit"
@@ -9047,7 +9047,7 @@ msgstr "keine ansprechende Anzeige des Objektinha=
ltes f=C3=BCr --edit"
=20
 #: builtin/replace.c:435
 msgid "use this format"
-msgstr "benutzt das angegebene Format"
+msgstr "das angegebene Format benutzen"
=20
 #: builtin/rerere.c:12
 msgid "git rerere [clear | forget path... | status | remaining | diff =
| gc]"
@@ -9055,7 +9055,7 @@ msgstr "git rerere [clean | forget path... | stat=
us | remaining | diff | gc]"
=20
 #: builtin/rerere.c:57
 msgid "register clean resolutions in index"
-msgstr "registriert saubere Aufl=C3=B6sungen in der Staging-Area"
+msgstr "saubere Aufl=C3=B6sungen in der Staging-Area registrieren"
=20
 #: builtin/reset.c:25
 msgid ""
@@ -9120,23 +9120,23 @@ msgstr "weniger Ausgaben, meldet nur Fehler"
=20
 #: builtin/reset.c:277
 msgid "reset HEAD and index"
-msgstr "setzt HEAD und Staging-Area um"
+msgstr "HEAD und Staging-Area umsetzen"
=20
 #: builtin/reset.c:278
 msgid "reset only HEAD"
-msgstr "setzt nur HEAD um"
+msgstr "nur HEAD umsetzen"
=20
 #: builtin/reset.c:280 builtin/reset.c:282
 msgid "reset HEAD, index and working tree"
-msgstr "setzt HEAD, Staging-Area und Arbeitsverzeichnis um"
+msgstr "HEAD, Staging-Area und Arbeitsverzeichnis umsetzen"
=20
 #: builtin/reset.c:284
 msgid "reset HEAD but keep local changes"
-msgstr "setzt HEAD um, beh=C3=A4lt aber lokale =C3=84nderungen"
+msgstr "HEAD umsetzen, aber lokale =C3=84nderungen behalten"
=20
 #: builtin/reset.c:287
 msgid "record only the fact that removed paths will be added later"
-msgstr "speichert nur, dass gel=C3=B6schte Pfade sp=C3=A4ter hinzugef=C3=
=BCgt werden sollen"
+msgstr "nur speichern, dass gel=C3=B6schte Pfade sp=C3=A4ter hinzugef=C3=
=BCgt werden sollen"
=20
 #: builtin/reset.c:304
 #, c-format
@@ -9196,11 +9196,11 @@ msgstr "git rev-parse --parseopt [Optionen] -- =
[<Argumente>...]"
=20
 #: builtin/rev-parse.c:365
 msgid "keep the `--` passed as an arg"
-msgstr "l=C3=A4sst `--` als Argument"
+msgstr "`--` als Argument lassen"
=20
 #: builtin/rev-parse.c:367
 msgid "stop parsing after the first non-option argument"
-msgstr "stoppt das Parsen nach dem ersten Argument was keine Option is=
t"
+msgstr "das Parsen nach dem ersten Argument, was keine Option ist, sto=
ppen"
=20
 #: builtin/rev-parse.c:370
 msgid "output in stuck long form"
@@ -9245,23 +9245,23 @@ msgstr "%s: %s kann nicht mit %s verwendet werd=
en"
=20
 #: builtin/revert.c:80
 msgid "end revert or cherry-pick sequence"
-msgstr "beendet \"revert\" oder \"cherry-pick\" Ablauf"
+msgstr "\"revert\" oder \"cherry-pick\" Ablauf beenden"
=20
 #: builtin/revert.c:81
 msgid "resume revert or cherry-pick sequence"
-msgstr "setzt \"revert\" oder \"cherry-pick\" Ablauf fort"
+msgstr "\"revert\" oder \"cherry-pick\" Ablauf fortsetzen"
=20
 #: builtin/revert.c:82
 msgid "cancel revert or cherry-pick sequence"
-msgstr "bricht \"revert\" oder \"cherry-pick\" Ablauf ab"
+msgstr "\"revert\" oder \"cherry-pick\" Ablauf abbrechen"
=20
 #: builtin/revert.c:83
 msgid "don't automatically commit"
-msgstr "committet nicht automatisch"
+msgstr "nicht automatisch committen"
=20
 #: builtin/revert.c:84
 msgid "edit the commit message"
-msgstr "Bearbeitung der Commit-Beschreibung"
+msgstr "Commit-Beschreibung bearbeiten"
=20
 #: builtin/revert.c:87
 msgid "parent number"
@@ -9281,23 +9281,23 @@ msgstr "Option f=C3=BCr Merge-Strategie"
=20
 #: builtin/revert.c:104
 msgid "append commit name"
-msgstr "h=C3=A4ngt Commit-Namen an"
+msgstr "Commit-Namen anh=C3=A4ngen"
=20
 #: builtin/revert.c:105
 msgid "allow fast-forward"
-msgstr "erlaubt Vorspulen"
+msgstr "Vorspulen erlauben"
=20
 #: builtin/revert.c:106
 msgid "preserve initially empty commits"
-msgstr "erh=C3=A4lt urspr=C3=BCngliche, leere Commits"
+msgstr "urspr=C3=BCngliche, leere Commits erhalten"
=20
 #: builtin/revert.c:107
 msgid "allow commits with empty messages"
-msgstr "erlaubt Commits mit leerer Beschreibung"
+msgstr "Commits mit leerer Beschreibung erlauben"
=20
 #: builtin/revert.c:108
 msgid "keep redundant, empty commits"
-msgstr "beh=C3=A4lt redundante, leere Commits"
+msgstr "redundante, leere Commits behalten"
=20
 #: builtin/revert.c:112
 msgid "program error"
@@ -9384,23 +9384,23 @@ msgstr[1] "die folgenden Dateien haben lokale =C3=
=84nderungen:"
=20
 #: builtin/rm.c:270
 msgid "do not list removed files"
-msgstr "listet keine gel=C3=B6schten Dateien auf"
+msgstr "keine gel=C3=B6schten Dateien auflisten"
=20
 #: builtin/rm.c:271
 msgid "only remove from the index"
-msgstr "entfernt nur aus der Staging-Area"
+msgstr "nur aus der Staging-Area entfernen"
=20
 #: builtin/rm.c:272
 msgid "override the up-to-date check"
-msgstr "=C3=BCberschreibt die \"up-to-date\" Pr=C3=BCfung"
+msgstr "die \"up-to-date\" Pr=C3=BCfung =C3=BCberschreiben"
=20
 #: builtin/rm.c:273
 msgid "allow recursive removal"
-msgstr "erlaubt rekursive Entfernung"
+msgstr "rekursive Entfernung erlauben"
=20
 #: builtin/rm.c:275
 msgid "exit with a zero status even if nothing matched"
-msgstr "beendet mit R=C3=BCckgabewert 0, wenn keine =C3=9Cbereinstimmu=
ng gefunden wurde"
+msgstr "mit R=C3=BCckgabewert 0 beenden, wenn keine =C3=9Cbereinstimmu=
ng gefunden wurde"
=20
 #: builtin/rm.c:336
 #, c-format
@@ -9423,15 +9423,15 @@ msgstr "fehlender Autor: %s"
=20
 #: builtin/shortlog.c:230
 msgid "sort output according to the number of commits per author"
-msgstr "sortiert die Ausgabe entsprechend der Anzahl von Commits pro A=
utor"
+msgstr "die Ausgabe entsprechend der Anzahl von Commits pro Autor sort=
ieren"
=20
 #: builtin/shortlog.c:232
 msgid "Suppress commit descriptions, only provides commit count"
-msgstr "Unterdr=C3=BCckt Commit-Beschreibungen, liefert nur Anzahl der=
 Commits"
+msgstr "Commit-Beschreibungen unterdr=C3=BCcken, nur Anzahl der Commit=
s liefern"
=20
 #: builtin/shortlog.c:234
 msgid "Show the email address of each author"
-msgstr "Zeigt die Email-Adresse von jedem Autor"
+msgstr "die Email-Adresse von jedem Autor anzeigen"
=20
 #: builtin/shortlog.c:235
 msgid "w[,i1[,i2]]"
@@ -9459,19 +9459,19 @@ msgstr "git show-branch (-g|--reflog)[=3D<n>[,<=
Basis>]] [--list] [<Referenz>]"
=20
 #: builtin/show-branch.c:649
 msgid "show remote-tracking and local branches"
-msgstr "zeigt Remote-Tracking und lokale Branches an"
+msgstr "Remote-Tracking und lokale Branches anzeigen"
=20
 #: builtin/show-branch.c:651
 msgid "show remote-tracking branches"
-msgstr "zeigt Remote-Tracking-Branches an"
+msgstr "Remote-Tracking-Branches anzeigen"
=20
 #: builtin/show-branch.c:653
 msgid "color '*!+-' corresponding to the branch"
-msgstr "f=C3=A4rbt '*!+-' entsprechend des Branches ein"
+msgstr "'*!+-' entsprechend des Branches einf=C3=A4rgen"
=20
 #: builtin/show-branch.c:655
 msgid "show <n> more commits after the common ancestor"
-msgstr "zeigt <n> weitere Commits nach dem gemeinsamen Vorg=C3=A4nger-=
Commit"
+msgstr "<n> weitere Commits nach dem gemeinsamen Vorg=C3=A4nger-Commit=
 anzeigen"
=20
 #: builtin/show-branch.c:657
 msgid "synonym to more=3D-1"
--=20
2.1.0.368.g9f4fb5d
