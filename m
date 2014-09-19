From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 7/7] part7: l10n: de.po: use imperative form for command options
Date: Fri, 19 Sep 2014 19:12:50 +0200
Message-ID: <1411146770-8508-8-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 19:13:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1kN-0003sn-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbaISRNS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2014 13:13:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59107 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518AbaISRNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:13:11 -0400
Received: by mail-we0-f174.google.com with SMTP id w61so103408wes.33
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i1AKdQiQk/VJsBbOpzS0LXl7QyMSmhi8SwQRhwLljMk=;
        b=M305E7/tR1WHgMGFziK60gK4XL0RCEoIQKSAgrfKbAeNIugxTT8yYcWcFkY2kdoskA
         ArarzZK6dQfKvNqfcCvfDVvcvmk+tNf1rM60QHW+peIZJIaqBMggAEllWRE2v0Jmd6A1
         10RNlbGX2+Qn+NWPwK2Ld9kbix87xpV9rCieGxwYOiTP2o3mIyT63OqZ3xfc3mSybrWZ
         HPO/KA6UjThPVbu+aBqrAQuCAGw91GXIvX9mc8oC7YJhXjEEGjAFMhGKollqjqy1Aufh
         83ziUsxCNha74cxfjdwTKnUHrt86X3CCX4Z+a/fMPWIuknAEaJP7yloCi/QW8AyL0IVa
         UtUQ==
X-Received: by 10.180.80.38 with SMTP id o6mr7527910wix.19.1411146790114;
        Fri, 19 Sep 2014 10:13:10 -0700 (PDT)
Received: from localhost (dslb-178-000-162-213.178.000.pools.vodafone-ip.de. [178.0.162.213])
        by mx.google.com with ESMTPSA id ga9sm2866052wjb.45.2014.09.19.10.13.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Sep 2014 10:13:09 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.368.g9f4fb5d
In-Reply-To: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257295>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 162 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/po/de.po b/po/de.po
index 9ccd63b..dbac6f1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -9479,35 +9479,35 @@ msgstr "Synonym f=C3=BCr more=3D-1"
=20
 #: builtin/show-branch.c:658
 msgid "suppress naming strings"
-msgstr "unterdr=C3=BCckt Namen"
+msgstr "Namen unterdr=C3=BCcken"
=20
 #: builtin/show-branch.c:660
 msgid "include the current branch"
-msgstr "bezieht den aktuellen Branch ein"
+msgstr "den aktuellen Branch einbeziehen"
=20
 #: builtin/show-branch.c:662
 msgid "name commits with their object names"
-msgstr "benennt Commits nach ihren Objektnamen"
+msgstr "Commits nach ihren Objektnamen benennen"
=20
 #: builtin/show-branch.c:664
 msgid "show possible merge bases"
-msgstr "zeigt m=C3=B6gliche Merge-Basen an"
+msgstr "m=C3=B6gliche Merge-Basen anzeigen"
=20
 #: builtin/show-branch.c:666
 msgid "show refs unreachable from any other ref"
-msgstr "zeigt Referenzen die unerreichbar von allen anderen Referenzen=
 sind"
+msgstr "Referenzen, die unerreichbar von allen anderen Referenzen sind=
, anzeigen"
=20
 #: builtin/show-branch.c:668
 msgid "show commits in topological order"
-msgstr "zeigt Commits in topologischer Ordnung"
+msgstr "Commits in topologischer Ordnung anzeigen"
=20
 #: builtin/show-branch.c:671
 msgid "show only commits not on the first branch"
-msgstr "zeigt nur Commits, die sich nicht im ersten Branch befinden"
+msgstr "nur Commits anzeigen, die sich nicht im ersten Branch befinden=
"
=20
 #: builtin/show-branch.c:673
 msgid "show merges reachable from only one tip"
-msgstr "zeigt Merges, die nur von einem Branch aus erreichbar sind"
+msgstr "Merges anzeigen, die nur von einem Branch aus erreichbar sind"
=20
 #: builtin/show-branch.c:675
 msgid "topologically sort, maintaining date order where possible"
@@ -9519,7 +9519,7 @@ msgstr "<n>[,<Basis>]"
=20
 #: builtin/show-branch.c:679
 msgid "show <n> most recent ref-log entries starting at base"
-msgstr "zeigt die <n> j=C3=BCngsten Eintr=C3=A4ge im Reflog beginnend =
an der Basis"
+msgstr "die <n> j=C3=BCngsten Eintr=C3=A4ge im Reflog, beginnend an de=
r Basis, anzeigen"
=20
 #: builtin/show-ref.c:10
 msgid ""
@@ -9535,11 +9535,11 @@ msgstr "git show-ref --exclude-existing[=3DMust=
er] < ref-list"
=20
 #: builtin/show-ref.c:168
 msgid "only show tags (can be combined with heads)"
-msgstr "zeigt nur Tags (kann mit \"heads\" kombiniert werden)"
+msgstr "nur Tags anzeigen (kann mit \"heads\" kombiniert werden)"
=20
 #: builtin/show-ref.c:169
 msgid "only show heads (can be combined with tags)"
-msgstr "zeigt nur Branches (kann mit \"tags\" kombiniert werden)"
+msgstr "nur Branches anzeigen (kann mit \"tags\" kombiniert werden)"
=20
 #: builtin/show-ref.c:170
 msgid "stricter reference checking, requires exact ref path"
@@ -9547,15 +9547,15 @@ msgstr "strengere Referenzpr=C3=BCfung, erforde=
rt exakten Referenzpfad"
=20
 #: builtin/show-ref.c:173 builtin/show-ref.c:175
 msgid "show the HEAD reference, even if it would be filtered out"
-msgstr "zeigt die HEAD-Referenz, selbst wenn diese ausgefiltert werden=
 w=C3=BCrde"
+msgstr "die HEAD-Referenz anzeigen, selbst wenn diese ausgefiltert wer=
den w=C3=BCrde"
=20
 #: builtin/show-ref.c:177
 msgid "dereference tags into object IDs"
-msgstr "dereferenziert Tags in Objekt-Identifikationen"
+msgstr "Tags in Objekt-Identifikationen dereferenzieren"
=20
 #: builtin/show-ref.c:179
 msgid "only show SHA1 hash using <n> digits"
-msgstr "zeigt nur SHA1 Hash mit <n> Ziffern"
+msgstr "nur SHA1 Hash mit <n> Ziffern anzeigen"
=20
 #: builtin/show-ref.c:183
 msgid "do not print results to stdout (useful with --verify)"
@@ -9565,8 +9565,8 @@ msgstr ""
 #: builtin/show-ref.c:185
 msgid "show refs from stdin that aren't in local repository"
 msgstr ""
-"zeigt Referenzen von der Standard-Eingabe, die sich nicht im lokalen =
"
-"Repository befinden, an"
+"Referenzen von der Standard-Eingabe anzeigen, die sich nicht im lokal=
en "
+"Repository befinden"
=20
 #: builtin/symbolic-ref.c:7
 msgid "git symbolic-ref [options] name [ref]"
@@ -9579,11 +9579,11 @@ msgstr "git symbolic-ref -d [-q] name"
 #: builtin/symbolic-ref.c:40
 msgid "suppress error message for non-symbolic (detached) refs"
 msgstr ""
-"unterdr=C3=BCckt Fehlermeldungen f=C3=BCr nicht-symbolische (losgel=C3=
=B6ste) Referenzen"
+"Fehlermeldungen f=C3=BCr nicht-symbolische (losgel=C3=B6ste) Referenz=
en unterdr=C3=BCcken"
=20
 #: builtin/symbolic-ref.c:41
 msgid "delete symbolic ref"
-msgstr "l=C3=B6scht symbolische Referenzen"
+msgstr "symbolische Referenzen l=C3=B6schen"
=20
 #: builtin/symbolic-ref.c:42
 msgid "shorten ref output"
@@ -9719,19 +9719,19 @@ msgstr "fehlerhafter Objekt-Name '%s'"
=20
 #: builtin/tag.c:588
 msgid "list tag names"
-msgstr "listet Tagnamen auf"
+msgstr "Tagnamen auflisten"
=20
 #: builtin/tag.c:590
 msgid "print <n> lines of each tag message"
-msgstr "zeigt <n> Zeilen jeder Tag-Beschreibung"
+msgstr "<n> Zeilen jeder Tag-Beschreibung anzeigen"
=20
 #: builtin/tag.c:592
 msgid "delete tags"
-msgstr "l=C3=B6scht Tags"
+msgstr "Tags l=C3=B6schen"
=20
 #: builtin/tag.c:593
 msgid "verify tags"
-msgstr "=C3=BCberpr=C3=BCft Tags"
+msgstr "Tags =C3=BCberpr=C3=BCfen"
=20
 #: builtin/tag.c:595
 msgid "Tag creation options"
@@ -9751,19 +9751,19 @@ msgstr "annotiertes und GPG-signiertes Tag"
=20
 #: builtin/tag.c:605
 msgid "use another key to sign the tag"
-msgstr "verwendet einen anderen Schl=C3=BCssel um das Tag zu signieren=
"
+msgstr "einen anderen Schl=C3=BCssel verwenden um das Tag zu signieren=
"
=20
 #: builtin/tag.c:606
 msgid "replace the tag if exists"
-msgstr "ersetzt das Tag, wenn es existiert"
+msgstr "das Tag ersetzen, wenn es existiert"
=20
 #: builtin/tag.c:607
 msgid "show tag list in columns"
-msgstr "zeigt Liste der Tags in Spalten"
+msgstr "Liste der Tags in Spalten anzeigen"
=20
 #: builtin/tag.c:609
 msgid "sort tags"
-msgstr "sortiert Tags"
+msgstr "Tags sortieren"
=20
 #: builtin/tag.c:613
 msgid "Tag listing options"
@@ -9771,11 +9771,11 @@ msgstr "Optionen f=C3=BCr Auflistung der Tags"
=20
 #: builtin/tag.c:616 builtin/tag.c:622
 msgid "print only tags that contain the commit"
-msgstr "gibt nur Tags aus, die diesen Commit beinhalten"
+msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
=20
 #: builtin/tag.c:628
 msgid "print only tags of the object"
-msgstr "gibt nur Tags von dem Objekt aus"
+msgstr "nur Tags von dem Objekt ausgeben"
=20
 #: builtin/tag.c:654
 msgid "--column and -n are incompatible"
@@ -9850,25 +9850,25 @@ msgstr "Aktualisierung: ignoriert Submodule"
=20
 #: builtin/update-index.c:761
 msgid "do not ignore new files"
-msgstr "ignoriert keine neuen Dateien"
+msgstr "keine neuen Dateien ignorieren"
=20
 #: builtin/update-index.c:763
 msgid "let files replace directories and vice-versa"
-msgstr "l=C3=A4sst Dateien Verzeichnisse ersetzen, und umgedreht"
+msgstr "Dateien Verzeichnisse ersetzen lassen, und umgedreht"
=20
 #: builtin/update-index.c:765
 msgid "notice files missing from worktree"
-msgstr "beachtet fehlende Dateien im Arbeitsverzeichnis"
+msgstr "fehlende Dateien im Arbeitsverzeichnis beachten"
=20
 #: builtin/update-index.c:767
 msgid "refresh even if index contains unmerged entries"
 msgstr ""
-"aktualisiert, auch wenn die Staging-Area nicht zusammengef=C3=BChrte =
Eintr=C3=A4ge "
+"aktualisieren, auch wenn die Staging-Area nicht zusammengef=C3=BChrte=
 Eintr=C3=A4ge "
 "beinhaltet"
=20
 #: builtin/update-index.c:770
 msgid "refresh stat information"
-msgstr "aktualisiert Dateiinformationen"
+msgstr "Dateiinformationen aktualisieren"
=20
 #: builtin/update-index.c:774
 msgid "like --refresh, but ignore assume-unchanged setting"
@@ -9880,7 +9880,7 @@ msgstr "<Modus>,<Objekt>,<Pfad>"
=20
 #: builtin/update-index.c:779
 msgid "add the specified entry to the index"
-msgstr "merkt den angegebenen Eintrag zum Commit vor"
+msgstr "den angegebenen Eintrag zum Commit vormerken"
=20
 #: builtin/update-index.c:783
 msgid "(+/-)x"
@@ -9888,34 +9888,34 @@ msgstr "(+/-)x"
=20
 #: builtin/update-index.c:784
 msgid "override the executable bit of the listed files"
-msgstr "=C3=BCberschreibt das \"ausf=C3=BChrbar\"-Bit der aufgelistete=
n Dateien"
+msgstr "das \"ausf=C3=BChrbar\"-Bit der aufgelisteten Dateien =C3=BCbe=
rschreiben"
=20
 #: builtin/update-index.c:788
 msgid "mark files as \"not changing\""
-msgstr "betrachte diese Datei immer als unver=C3=A4ndert"
+msgstr "diese Datei immer als unver=C3=A4ndert betrachten"
=20
 #: builtin/update-index.c:791
 msgid "clear assumed-unchanged bit"
-msgstr "l=C3=B6scht \"assumed-unchanged\"-Bit"
+msgstr "\"assumed-unchanged\"-Bit l=C3=B6schen"
=20
 #: builtin/update-index.c:794
 msgid "mark files as \"index-only\""
-msgstr "markiert Dateien als \"index-only\""
+msgstr "Dateien als \"index-only\" markieren"
=20
 #: builtin/update-index.c:797
 msgid "clear skip-worktree bit"
-msgstr "l=C3=B6scht \"skip-worktree\"-Bit"
+msgstr "\"skip-worktree\"-Bit l=C3=B6schen"
=20
 #: builtin/update-index.c:800
 msgid "add to index only; do not add content to object database"
 msgstr ""
-"merkt die =C3=84nderungen nur zum Commit vor; Inhalt wird nicht der O=
bjekt-"
+"die =C3=84nderungen nur zum Commit vormerken; Inhalt wird nicht der O=
bjekt-"
 "Datenbank hinzugef=C3=BCgt"
=20
 #: builtin/update-index.c:802
 msgid "remove named paths even if present in worktree"
 msgstr ""
-"l=C3=B6scht benannte Pfade, auch wenn sie sich im Arbeitsverzeichnis =
befinden"
+"benannte Pfade l=C3=B6schen, auch wenn sie sich im Arbeitsverzeichnis=
 befinden"
=20
 #: builtin/update-index.c:804
 msgid "with --stdin: input lines are terminated by null bytes"
@@ -9923,11 +9923,11 @@ msgstr "mit --stdin: eingegebene Zeilen sind du=
rch NUL-Bytes abgeschlossen"
=20
 #: builtin/update-index.c:806
 msgid "read list of paths to be updated from standard input"
-msgstr "liest Liste der zu aktualisierenden Pfade von der Standard-Ein=
gabe"
+msgstr "Liste der zu aktualisierenden Pfade von der Standard-Eingabe l=
esen"
=20
 #: builtin/update-index.c:810
 msgid "add entries from standard input to the index"
-msgstr "merkt Eintr=C3=A4ge von der Standard-Eingabe zum Commit vor"
+msgstr "Eintr=C3=A4ge von der Standard-Eingabe zum Commit vormerken"
=20
 #: builtin/update-index.c:814
 msgid "repopulate stages #2 and #3 for the listed paths"
@@ -9936,15 +9936,15 @@ msgstr ""
=20
 #: builtin/update-index.c:818
 msgid "only update entries that differ from HEAD"
-msgstr "aktualisiert nur Eintr=C3=A4ge, die unterschiedlich zu HEAD si=
nd"
+msgstr "nur Eintr=C3=A4ge aktualisieren, die unterschiedlich zu HEAD s=
ind"
=20
 #: builtin/update-index.c:822
 msgid "ignore files missing from worktree"
-msgstr "ignoriert fehlende Dateien im Arbeitsverzeichnis"
+msgstr "fehlende Dateien im Arbeitsverzeichnis ignorieren"
=20
 #: builtin/update-index.c:825
 msgid "report actions to standard output"
-msgstr "gibt die Aktionen in der Standard-Ausgabe aus"
+msgstr "die Aktionen in der Standard-Ausgabe ausgeben"
=20
 #: builtin/update-index.c:827
 msgid "(for porcelains) forget saved unresolved conflicts"
@@ -9952,7 +9952,7 @@ msgstr "(f=C3=BCr Fremdprogramme) keine gespeiche=
rten, nicht aufgel=C3=B6ste Konflikte"
=20
 #: builtin/update-index.c:831
 msgid "write index in this format"
-msgstr "schreibt Staging-Area-Datei in diesem Format"
+msgstr "Staging-Area-Datei in diesem Format schreiben"
=20
 #: builtin/update-index.c:833
 msgid "enable or disable split index"
@@ -9972,11 +9972,11 @@ msgstr "git update-ref [Optionen] --stdin [-z]"
=20
 #: builtin/update-ref.c:350
 msgid "delete the reference"
-msgstr "l=C3=B6scht diese Referenz"
+msgstr "diese Referenz l=C3=B6schen"
=20
 #: builtin/update-ref.c:352
 msgid "update <refname> not the one it points to"
-msgstr "aktualisiert <Referenzname>, nicht den Verweis"
+msgstr "<Referenzname> aktualisieren, nicht den Verweis"
=20
 #: builtin/update-ref.c:353
 msgid "stdin has NUL-terminated arguments"
@@ -9984,7 +9984,7 @@ msgstr "Standard-Eingabe hat durch NUL-Zeichen ab=
geschlossene Argumente"
=20
 #: builtin/update-ref.c:354
 msgid "read updates from stdin"
-msgstr "liest Aktualisierungen von der Standard-Eingabe"
+msgstr "Aktualisierungen von der Standard-Eingabe lesen"
=20
 #: builtin/update-server-info.c:6
 msgid "git update-server-info [--force]"
@@ -9992,7 +9992,7 @@ msgstr "git update-server-info [--force]"
=20
 #: builtin/update-server-info.c:14
 msgid "update the info files from scratch"
-msgstr "aktualisiert die Informationsdateien von Grund auf"
+msgstr "die Informationsdateien von Grund auf aktualisieren"
=20
 #: builtin/verify-commit.c:17
 msgid "git verify-commit [-v|--verbose] <commit>..."
@@ -10000,7 +10000,7 @@ msgstr "git verify-commit [-v|--verbose] <Commi=
t>..."
=20
 #: builtin/verify-commit.c:75
 msgid "print commit contents"
-msgstr "gibt Commit-Inhalte aus"
+msgstr "Commit-Inhalte ausgeben"
=20
 #: builtin/verify-pack.c:55
 msgid "git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."
@@ -10012,7 +10012,7 @@ msgstr "erweiterte Ausgaben"
=20
 #: builtin/verify-pack.c:67
 msgid "show statistics only"
-msgstr "zeigt nur Statistiken"
+msgstr "nur Statistiken anzeigen"
=20
 #: builtin/verify-tag.c:17
 msgid "git verify-tag [-v|--verbose] <tag>..."
@@ -10020,7 +10020,7 @@ msgstr "git verify-tag [-v|--verbose] <Tag>..."
=20
 #: builtin/verify-tag.c:73
 msgid "print tag contents"
-msgstr "gibt Tag-Inhalte aus"
+msgstr "Tag-Inhalte ausgeben"
=20
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
@@ -10032,7 +10032,7 @@ msgstr "<Pr=C3=A4fix>/"
=20
 #: builtin/write-tree.c:27
 msgid "write tree object for a subdirectory <prefix>"
-msgstr "schreibt das \"Tree\"-Objekt f=C3=BCr ein Unterverzeichnis <Pr=
=C3=A4fix>"
+msgstr "das \"Tree\"-Objekt f=C3=BCr ein Unterverzeichnis <Pr=C3=A4fix=
> schreiben"
=20
 #: builtin/write-tree.c:30
 msgid "only useful for debugging"
@@ -10067,100 +10067,100 @@ msgstr "weniger Ausgaben"
=20
 #: parse-options.h:240
 msgid "use <n> digits to display SHA-1s"
-msgstr "benutze <n> Ziffern zur Anzeige von SHA-1s"
+msgstr "<n> Ziffern zur Anzeige von SHA-1s benutzen"
=20
 #: common-cmds.h:8
 msgid "Add file contents to the index"
-msgstr "merkt Dateiinhalte zum Commit vor"
+msgstr "Dateiinhalte zum Commit vormerken"
=20
 #: common-cmds.h:9
 msgid "Find by binary search the change that introduced a bug"
 msgstr ""
-"Findet =C3=BCber eine Bin=C3=A4rsuche die =C3=84nderungen, die einen =
=46ehler verursacht haben"
+"=C3=BCber eine Bin=C3=A4rsuche die =C3=84nderungen finden, die einen =
=46ehler verursacht haben"
=20
 #: common-cmds.h:10
 msgid "List, create, or delete branches"
-msgstr "Zeigt an, erstellt oder entfernt Branches"
+msgstr "Branches anzeigen, erstellen oder entfernen"
=20
 #: common-cmds.h:11
 msgid "Checkout a branch or paths to the working tree"
-msgstr "Checkt Branches oder Pfade im Arbeitsverzeichnis aus"
+msgstr "Branches oder Pfade im Arbeitsverzeichnis auschecken"
=20
 #: common-cmds.h:12
 msgid "Clone a repository into a new directory"
-msgstr "Klont ein Repository in einem neuen Verzeichnis"
+msgstr "ein Repository in einem neuen Verzeichnis klonen"
=20
 #: common-cmds.h:13
 msgid "Record changes to the repository"
-msgstr "Tr=C3=A4gt =C3=84nderungen in das Repository ein"
+msgstr "=C3=84nderungen in das Repository eintragen"
=20
 #: common-cmds.h:14
 msgid "Show changes between commits, commit and working tree, etc"
 msgstr ""
-"Zeigt =C3=84nderungen zwischen Commits, Commit und Arbeitsverzeichnis=
, etc. an"
+"=C3=84nderungen zwischen Commits, Commit und Arbeitsverzeichnis, etc.=
 anzeigen"
=20
 #: common-cmds.h:15
 msgid "Download objects and refs from another repository"
-msgstr "L=C3=A4dt Objekte und Referenzen von einem anderen Repository =
herunter"
+msgstr "Objekte und Referenzen von einem anderen Repository herunterla=
den"
=20
 #: common-cmds.h:16
 msgid "Print lines matching a pattern"
-msgstr "Stellt Zeilen dar, die einem Muster entsprechen"
+msgstr "Zeilen darstellen, die einem Muster entsprechen"
=20
 #: common-cmds.h:17
 msgid "Create an empty Git repository or reinitialize an existing one"
 msgstr ""
-"Erstellt ein leeres Git-Repository oder initialisiert ein bestehendes=
 neu"
+"ein leeres Git-Repository erstellen oder ein bestehendes neuinitialis=
ieren"
=20
 #: common-cmds.h:18
 msgid "Show commit logs"
-msgstr "Zeigt Commit-Historie an"
+msgstr "Commit-Historie anzeigen"
=20
 #: common-cmds.h:19
 msgid "Join two or more development histories together"
-msgstr "F=C3=BChrt zwei oder mehr Entwicklungszweige zusammen"
+msgstr "zwei oder mehr Entwicklungszweige zusammenf=C3=BChren"
=20
 #: common-cmds.h:20
 msgid "Move or rename a file, a directory, or a symlink"
 msgstr ""
-"Verschiebt oder benennt eine Datei, ein Verzeichnis, oder einen symbo=
lischen "
-"Verweis um"
+"eine Datei, ein Verzeichnis, oder einen symbolischen "
+"Verweis verschieben oder umbenennen"
=20
 #: common-cmds.h:21
 msgid "Fetch from and integrate with another repository or a local bra=
nch"
 msgstr ""
-"Fordert Objekte von einem externen Repository an und f=C3=BChrt sie m=
it einem "
-"anderen Repository oder einem lokalen Branch zusammen"
+"Objekte von einem externen Repository anfordern und sie mit einem "
+"anderen Repository oder einem lokalen Branch zusammenf=C3=BChren"
=20
 #: common-cmds.h:22
 msgid "Update remote refs along with associated objects"
-msgstr "Aktualisiert Remote-Referenzen mitsamt den verbundenen Objekte=
n"
+msgstr "Remote-Referenzen mitsamt den verbundenen Objekten aktualisier=
en"
=20
 #: common-cmds.h:23
 msgid "Forward-port local commits to the updated upstream head"
-msgstr "Baut lokale Commits auf einem aktuellerem Upstream-Branch neu =
auf"
+msgstr "lokale Commits auf einem aktuellerem Upstream-Branch neu aufba=
uen"
=20
 #: common-cmds.h:24
 msgid "Reset current HEAD to the specified state"
-msgstr "Setzt aktuellen HEAD zu einem spezifizierten Zustand"
+msgstr "aktuellen HEAD zu einem spezifizierten Zustand setzen"
=20
 #: common-cmds.h:25
 msgid "Remove files from the working tree and from the index"
-msgstr "L=C3=B6scht Dateien im Arbeitsverzeichnis und von der Staging-=
Area"
+msgstr "Dateien im Arbeitsverzeichnis und von der Staging-Area l=C3=B6=
schen"
=20
 #: common-cmds.h:26
 msgid "Show various types of objects"
-msgstr "Zeigt verschiedene Arten von Objekten an"
+msgstr "verschiedene Arten von Objekten anzeigen"
=20
 #: common-cmds.h:27
 msgid "Show the working tree status"
-msgstr "Zeigt den Zustand des Arbeitsverzeichnisses an"
+msgstr "den Zustand des Arbeitsverzeichnisses anzeigen"
=20
 #: common-cmds.h:28
 msgid "Create, list, delete or verify a tag object signed with GPG"
 msgstr ""
-"Erzeugt, listet auf, l=C3=B6scht oder verifiziert ein mit GPG signier=
tes Tag-"
-"Objekt"
+"ein mit GPG signiertes Tag-Objekt erzeugen, auflisten, l=C3=B6schen o=
der "
+"verifizieren."
=20
 #: git-am.sh:52
 msgid "You need to set your committer info first"
@@ -10347,7 +10347,7 @@ msgstr ""
=20
 #: git-am.sh:902
 msgid "applying to an empty history"
-msgstr "wende zu leerer Historie an"
+msgstr "auf leere Historie anwenden"
=20
 #: git-bisect.sh:48
 msgid "You need to start by \"git bisect start\""
--=20
2.1.0.368.g9f4fb5d
