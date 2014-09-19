From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 2/7] part2: l10n: de.po: use imperative form for command options
Date: Fri, 19 Sep 2014 19:12:45 +0200
Message-ID: <1411146770-8508-3-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 19:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1kC-0003sn-11
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513AbaISRNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2014 13:13:07 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:53515 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbaISRND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:13:03 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so98935wes.13
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/pNwdSRWYGnRWPsjbZ9LB763kYkRlGEIeZhR2Mp/1Ag=;
        b=QeJczGq4LugadDpxeuleYsd+79Nex4+tim1jk+i0inlxbLzgiy4QcfX2t/0uVtNSVO
         KYCMnzQ4TlKqOKLXA2cbRdFWXAuYmHqfrOg/fd0FZV4PdHcBFxNuqMjP7m4xMl0CX9px
         9pozI6fzwf1PPp0Up99jXbHRvyzkFTTXX7ocbnAD69pfaiOPLOeDOV2eZaRTkgeZxzYj
         5AEm8Rn2Ji7MJnTKOlvNJGVLm0+SwoVruLBKXA5iY+uAeWJm9gYZRuKh92dVh1p3neRu
         q7zmawbtHUh7lZTt1wz4tv+5myrc3FGOkK+P9nfyV7+Y6hCdWnJWcF4DcpFhfInMywsU
         +AEg==
X-Received: by 10.194.23.8 with SMTP id i8mr2434372wjf.104.1411146782115;
        Fri, 19 Sep 2014 10:13:02 -0700 (PDT)
Received: from localhost (dslb-178-000-162-213.178.000.pools.vodafone-ip.de. [178.0.162.213])
        by mx.google.com with ESMTPSA id u8sm2721229wia.24.2014.09.19.10.13.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Sep 2014 10:13:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.368.g9f4fb5d
In-Reply-To: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257292>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 148 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/po/de.po b/po/de.po
index 13b31bd..ca174c2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3228,31 +3228,31 @@ msgstr ""
=20
 #: builtin/check-attr.c:19
 msgid "report all attributes set on file"
-msgstr "gibt alle Attribute einer Datei aus"
+msgstr "alle Attribute einer Datei ausgeben"
=20
 #: builtin/check-attr.c:20
 msgid "use .gitattributes only from the index"
-msgstr "verwendet .gitattributes nur von der Staging-Area"
+msgstr ".gitattributes nur von der Staging-Area verwenden"
=20
 #: builtin/check-attr.c:21 builtin/check-ignore.c:22 builtin/hash-obje=
ct.c:75
 msgid "read file names from stdin"
-msgstr "liest Dateinamen von der Standard-Eingabe"
+msgstr "Dateinamen von der Standard-Eingabe lesen"
=20
 #: builtin/check-attr.c:23 builtin/check-ignore.c:24
 msgid "terminate input and output records by a NUL character"
-msgstr "schlie=C3=9Ft Eintr=C3=A4ge von Ein- und Ausgabe mit NUL-Zeich=
en ab"
+msgstr "Eintr=C3=A4ge von Ein- und Ausgabe mit NUL-Zeichen abschlie=C3=
=9Fen"
=20
 #: builtin/check-ignore.c:18 builtin/checkout.c:1083 builtin/gc.c:285
 msgid "suppress progress reporting"
-msgstr "unterdr=C3=BCckt Fortschrittsanzeige"
+msgstr "Fortschrittsanzeige unterdr=C3=BCcken"
=20
 #: builtin/check-ignore.c:26
 msgid "show non-matching input paths"
-msgstr "zeigt Eingabe-Pfade ohne =C3=9Cbereinstimmungen"
+msgstr "Eingabe-Pfade ohne =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/check-ignore.c:28
 msgid "ignore index when checking"
-msgstr "ignoriert Staging-Area bei der Pr=C3=BCfung"
+msgstr "Staging-Area bei der Pr=C3=BCfung ignorieren"
=20
 #: builtin/check-ignore.c:154
 msgid "cannot specify pathnames with --stdin"
@@ -3285,7 +3285,7 @@ msgstr "git check-mailmap [Optionen] <Kontakt>...=
"
=20
 #: builtin/check-mailmap.c:13
 msgid "also read contacts from stdin"
-msgstr "liest ebenfalls Kontakte von der Standard-Eingabe"
+msgstr "ebenfalls Kontakte von der Standard-Eingabe lesen"
=20
 #: builtin/check-mailmap.c:24
 #, c-format
@@ -3302,11 +3302,11 @@ msgstr "git checkout-index [Optionen] [--] [<Da=
tei>...]"
=20
 #: builtin/checkout-index.c:188
 msgid "check out all files in the index"
-msgstr "checkt alle Dateien in der Staging-Area aus"
+msgstr "alle Dateien in der Staging-Area auschecken"
=20
 #: builtin/checkout-index.c:189
 msgid "force overwrite of existing files"
-msgstr "erzwingt das =C3=9Cberschreiben bereits existierender Dateien"
+msgstr "das =C3=9Cberschreiben bereits existierender Dateien erzwingen=
"
=20
 #: builtin/checkout-index.c:191
 msgid "no warning for existing files and files not in index"
@@ -3316,19 +3316,19 @@ msgstr ""
=20
 #: builtin/checkout-index.c:193
 msgid "don't checkout new files"
-msgstr "checkt keine neuen Dateien aus"
+msgstr "keine neuen Dateien auschecken"
=20
 #: builtin/checkout-index.c:195
 msgid "update stat information in the index file"
-msgstr "aktualisiert Dateiinformationen in der Staging-Area-Datei"
+msgstr "Dateiinformationen in der Staging-Area-Datei aktualisieren"
=20
 #: builtin/checkout-index.c:201
 msgid "read list of paths from the standard input"
-msgstr "liest eine Liste von Pfaden von der Standard-Eingabe"
+msgstr "eine Liste von Pfaden von der Standard-Eingabe lesen"
=20
 #: builtin/checkout-index.c:203
 msgid "write the content to temporary files"
-msgstr "schreibt den Inhalt in tempor=C3=A4re Dateien"
+msgstr "den Inhalt in tempor=C3=A4re Dateien schreiben"
=20
 #: builtin/checkout-index.c:204 builtin/column.c:30
 msgid "string"
@@ -3341,7 +3341,7 @@ msgstr ""
=20
 #: builtin/checkout-index.c:208
 msgid "copy out the files from named stage"
-msgstr "kopiert Dateien von dem benannten Stand"
+msgstr "Dateien von dem benannten Stand kopieren"
=20
 #: builtin/checkout.c:25
 msgid "git checkout [options] <branch>"
@@ -3542,23 +3542,23 @@ msgstr "Branch"
=20
 #: builtin/checkout.c:1085
 msgid "create and checkout a new branch"
-msgstr "erzeugt und checkt einen neuen Branch aus"
+msgstr "einen neuen Branch erzeugen und auschecken"
=20
 #: builtin/checkout.c:1087
 msgid "create/reset and checkout a branch"
-msgstr "erzeugt/setzt um und checkt einen Branch aus"
+msgstr "einen Branch erstellen/umsetzen und auschecken"
=20
 #: builtin/checkout.c:1088
 msgid "create reflog for new branch"
-msgstr "erzeugt das Reflog f=C3=BCr den neuen Branch"
+msgstr "das Reflog f=C3=BCr den neuen Branch erzeugen"
=20
 #: builtin/checkout.c:1089
 msgid "detach the HEAD at named commit"
-msgstr "setzt HEAD zu benanntem Commit"
+msgstr "HEAD zu benanntem Commit setzen"
=20
 #: builtin/checkout.c:1090
 msgid "set upstream info for new branch"
-msgstr "setzt Informationen zum Upstream-Branch f=C3=BCr den neuen Bra=
nch"
+msgstr "Informationen zum Upstream-Branch f=C3=BCr den neuen Branch se=
tzen"
=20
 #: builtin/checkout.c:1092
 msgid "new-branch"
@@ -3570,23 +3570,23 @@ msgstr "neuer Branch ohne Eltern-Commit"
=20
 #: builtin/checkout.c:1093
 msgid "checkout our version for unmerged files"
-msgstr "checkt unsere Variante f=C3=BCr nicht zusammengef=C3=BChrte Da=
teien aus"
+msgstr "unsere Variante f=C3=BCr nicht zusammengef=C3=BChrte Dateien a=
uschecken"
=20
 #: builtin/checkout.c:1095
 msgid "checkout their version for unmerged files"
-msgstr "checkt ihre Variante f=C3=BCr nicht zusammengef=C3=BChrte Date=
ien aus"
+msgstr "ihre Variante f=C3=BCr nicht zusammengef=C3=BChrte Dateien aus=
checken"
=20
 #: builtin/checkout.c:1097
 msgid "force checkout (throw away local modifications)"
-msgstr "erzwingt Auschecken (verwirft lokale =C3=84nderungen)"
+msgstr "Auschecken erzwingen (verwirft lokale =C3=84nderungen)"
=20
 #: builtin/checkout.c:1098
 msgid "perform a 3-way merge with the new branch"
-msgstr "f=C3=BChrt einen 3-Wege-Merge mit dem neuen Branch aus"
+msgstr "einen 3-Wege-Merge mit dem neuen Branch ausf=C3=BChren"
=20
 #: builtin/checkout.c:1099 builtin/merge.c:225
 msgid "update ignored files (default)"
-msgstr "aktualisiert ignorierte Dateien (Standard)"
+msgstr "ignorierte Dateien aktualisieren (Standard)"
=20
 #: builtin/checkout.c:1100 builtin/log.c:1236 parse-options.h:245
 msgid "style"
@@ -3598,7 +3598,7 @@ msgstr "Konfliktstil (merge oder diff3)"
=20
 #: builtin/checkout.c:1104
 msgid "do not limit pathspecs to sparse entries only"
-msgstr "Pfadspezifikationen ignorieren Einstellungen zum partiellen Au=
schecken"
+msgstr "keine Einschr=C3=A4nkung bei Pfadspezifikationen zum partielle=
n Auschecken"
=20
 #: builtin/checkout.c:1106
 msgid "second guess 'git checkout no-such-branch'"
@@ -3772,11 +3772,11 @@ msgstr "Keine Dateien mehr zum L=C3=B6schen, be=
ende."
=20
 #: builtin/clean.c:874
 msgid "do not print names of files removed"
-msgstr "gibt keine Namen von gel=C3=B6schten Dateien aus"
+msgstr "keine Namen von gel=C3=B6schten Dateien ausgeben"
=20
 #: builtin/clean.c:876
 msgid "force"
-msgstr "erzwingt Aktion"
+msgstr "Aktion erzwingen"
=20
 #: builtin/clean.c:877
 msgid "interactive cleaning"
@@ -3784,7 +3784,7 @@ msgstr "interaktives Clean"
=20
 #: builtin/clean.c:879
 msgid "remove whole directories"
-msgstr "l=C3=B6scht ganze Verzeichnisse"
+msgstr "ganze Verzeichnisse l=C3=B6schen"
=20
 #: builtin/clean.c:880 builtin/describe.c:406 builtin/grep.c:714
 #: builtin/ls-files.c:486 builtin/name-rev.c:311 builtin/show-ref.c:18=
5
@@ -3793,15 +3793,15 @@ msgstr "Muster"
=20
 #: builtin/clean.c:881
 msgid "add <pattern> to ignore rules"
-msgstr "f=C3=BCgt <Muster> zu den Regeln f=C3=BCr ignorierte Pfade hin=
zu"
+msgstr "<Muster> zu den Regeln f=C3=BCr ignorierte Pfade hinzuf=C3=BCg=
en"
=20
 #: builtin/clean.c:882
 msgid "remove ignored files, too"
-msgstr "l=C3=B6scht auch ignorierte Dateien"
+msgstr "auch ignorierte Dateien l=C3=B6schen"
=20
 #: builtin/clean.c:884
 msgid "remove only ignored files"
-msgstr "l=C3=B6scht nur ignorierte Dateien"
+msgstr "nur ignorierte Dateien l=C3=B6schen"
=20
 #: builtin/clean.c:902
 msgid "-x and -X cannot be used together"
@@ -3830,7 +3830,7 @@ msgstr "git clone [Optionen] [--] <Repository> [<=
Verzeichnis>]"
 #: builtin/clone.c:64 builtin/fetch.c:112 builtin/merge.c:222
 #: builtin/push.c:503
 msgid "force progress reporting"
-msgstr "erzwingt Fortschrittsanzeige"
+msgstr "Fortschrittsanzeige erzwingen"
=20
 #: builtin/clone.c:66
 msgid "don't create a checkout"
@@ -3838,27 +3838,27 @@ msgstr "kein Auschecken"
=20
 #: builtin/clone.c:67 builtin/clone.c:69 builtin/init-db.c:486
 msgid "create a bare repository"
-msgstr "erstellt ein Bare-Repository"
+msgstr "ein Bare-Repository erstellen"
=20
 #: builtin/clone.c:71
 msgid "create a mirror repository (implies bare)"
-msgstr "erstellt ein Spiegelarchiv (impliziert --bare)"
+msgstr "ein Spiegelarchiv erstellen (impliziert --bare)"
=20
 #: builtin/clone.c:73
 msgid "to clone from a local repository"
-msgstr "um von einem lokalen Repository zu klonen"
+msgstr "von einem lokalen Repository klonen"
=20
 #: builtin/clone.c:75
 msgid "don't use local hardlinks, always copy"
-msgstr "verwendet lokal keine harten Verweise, immer Kopien"
+msgstr "lokal keine harten Verweise verwenden, immer Kopien"
=20
 #: builtin/clone.c:77
 msgid "setup as shared repository"
-msgstr "Einrichtung als verteiltes Repository"
+msgstr "als verteiltes Repository einrichten"
=20
 #: builtin/clone.c:79 builtin/clone.c:81
 msgid "initialize submodules in the clone"
-msgstr "initialisiert Submodule im Klon"
+msgstr "Submodule im Klon initialisieren"
=20
 #: builtin/clone.c:82 builtin/init-db.c:483
 msgid "template-directory"
@@ -3870,7 +3870,7 @@ msgstr "Verzeichnis, von welchem die Vorlagen ver=
wendet werden"
=20
 #: builtin/clone.c:85
 msgid "reference repository"
-msgstr "referenziert Repository"
+msgstr "Repository referenzieren"
=20
 #: builtin/clone.c:86 builtin/column.c:26 builtin/merge-file.c:44
 msgid "name"
@@ -3878,11 +3878,11 @@ msgstr "Name"
=20
 #: builtin/clone.c:87
 msgid "use <name> instead of 'origin' to track upstream"
-msgstr "verwendet <Name> statt 'origin' f=C3=BCr Upstream-Repository"
+msgstr "<Name> statt 'origin' f=C3=BCr Upstream-Repository verwenden"
=20
 #: builtin/clone.c:89
 msgid "checkout <branch> instead of the remote's HEAD"
-msgstr "checkt <Branch> aus, anstatt HEAD des Remote-Repositories"
+msgstr "<Branch> auschecken, anstatt HEAD des Remote-Repositories"
=20
 #: builtin/clone.c:91
 msgid "path to git-upload-pack on the remote"
@@ -3895,11 +3895,11 @@ msgstr "Tiefe"
 #: builtin/clone.c:93
 msgid "create a shallow clone of that depth"
 msgstr ""
-"erstellt einen Klon mit unvollst=C3=A4ndiger Historie (shallow) in di=
eser Tiefe"
+"einen Klon mit unvollst=C3=A4ndiger Historie (shallow) in dieser Tief=
e erstellen"
=20
 #: builtin/clone.c:95
 msgid "clone only one branch, HEAD or --branch"
-msgstr "klont nur einen Branch, HEAD oder --branch"
+msgstr "nur einen Branch klonen, HEAD oder --branch"
=20
 #: builtin/clone.c:96 builtin/init-db.c:492
 msgid "gitdir"
@@ -3907,7 +3907,7 @@ msgstr ".git-Verzeichnis"
=20
 #: builtin/clone.c:97 builtin/init-db.c:493
 msgid "separate git dir from working tree"
-msgstr "separiert Git-Verzeichnis vom Arbeitsverzeichnis"
+msgstr "Git-Verzeichnis vom Arbeitsverzeichnis separieren"
=20
 #: builtin/clone.c:98
 msgid "key=3Dvalue"
@@ -3915,7 +3915,7 @@ msgstr "Schl=C3=BCssel=3DWert"
=20
 #: builtin/clone.c:99
 msgid "set config inside the new repository"
-msgstr "setzt Konfiguration innerhalb des neuen Repositories"
+msgstr "Konfiguration innerhalb des neuen Repositories setzen"
=20
 #: builtin/clone.c:252
 #, c-format
@@ -4097,7 +4097,7 @@ msgstr "git column [Optionen]"
=20
 #: builtin/column.c:26
 msgid "lookup config vars"
-msgstr "schl=C3=A4gt Konfigurationsvariablen nach"
+msgstr "Konfigurationsvariablen nachschlagen"
=20
 #: builtin/column.c:27 builtin/column.c:28
 msgid "layout to use"
@@ -4462,11 +4462,11 @@ msgstr "Die Option -a kann nur mit der Angabe v=
on Pfaden verwendet werden."
=20
 #: builtin/commit.c:1330 builtin/commit.c:1595
 msgid "show status concisely"
-msgstr "zeigt Status im Kurzformat"
+msgstr "Status im Kurzformat anzeigen"
=20
 #: builtin/commit.c:1332 builtin/commit.c:1597
 msgid "show branch information"
-msgstr "zeigt Branchinformationen"
+msgstr "Branchinformationen anzeigen"
=20
 #: builtin/commit.c:1334 builtin/commit.c:1599 builtin/push.c:489
 msgid "machine-readable output"
@@ -4474,11 +4474,11 @@ msgstr "maschinenlesbare Ausgabe"
=20
 #: builtin/commit.c:1337 builtin/commit.c:1601
 msgid "show status in long format (default)"
-msgstr "zeigt Status im Langformat (Standard)"
+msgstr "Status im Langformat anzeigen (Standard)"
=20
 #: builtin/commit.c:1340 builtin/commit.c:1604
 msgid "terminate entries with NUL"
-msgstr "schlie=C3=9Ft Eintr=C3=A4ge mit NUL-Zeichen ab"
+msgstr "Eintr=C3=A4ge mit NUL-Zeichen abschlie=C3=9Fen"
=20
 #: builtin/commit.c:1342 builtin/commit.c:1607 builtin/fast-export.c:7=
03
 #: builtin/fast-export.c:706 builtin/tag.c:602
@@ -4488,12 +4488,12 @@ msgstr "Modus"
 #: builtin/commit.c:1343 builtin/commit.c:1607
 msgid "show untracked files, optional modes: all, normal, no. (Default=
: all)"
 msgstr ""
-"zeigt nicht beobachtete Dateien, optionale Modi: all, normal, no. (St=
andard: "
+"nicht beobachtete Dateien anzeigen, optionale Modi: all, normal, no. =
(Standard: "
 "all)"
=20
 #: builtin/commit.c:1346
 msgid "show ignored files"
-msgstr "zeigt ignorierte Dateien"
+msgstr "ignorierte Dateien anzeigen"
=20
 #: builtin/commit.c:1347 parse-options.h:153
 msgid "when"
@@ -4504,12 +4504,12 @@ msgid ""
 "ignore changes to submodules, optional when: all, dirty, untracked. "
 "(Default: all)"
 msgstr ""
-"ignoriert =C3=84nderungen in Submodulen, optional wenn: all, dirty, u=
ntracked. "
+"=C3=84nderungen in Submodulen ignorieren, optional wenn: all, dirty, =
untracked. "
 "(Standard: all)"
=20
 #: builtin/commit.c:1350
 msgid "list untracked files in columns"
-msgstr "listet unbeobachtete Dateien in Spalten auf"
+msgstr "unbeobachtete Dateien in Spalten auflisten"
=20
 #: builtin/commit.c:1419
 msgid "couldn't look up newly created commit"
@@ -4529,11 +4529,11 @@ msgstr " (Basis-Commit)"
=20
 #: builtin/commit.c:1565
 msgid "suppress summary after successful commit"
-msgstr "unterdr=C3=BCckt Zusammenfassung nach erfolgreichem Commit"
+msgstr "Zusammenfassung nach erfolgreichem Commit unterdr=C3=BCcken"
=20
 #: builtin/commit.c:1566
 msgid "show diff in commit message template"
-msgstr "zeigt Unterschiede in Commit-Beschreibungsvorlage an"
+msgstr "Unterschiede in Commit-Beschreibungsvorlage anzeigen"
=20
 #: builtin/commit.c:1568
 msgid "Commit message options"
@@ -4541,7 +4541,7 @@ msgstr "Optionen f=C3=BCr Commit-Beschreibung"
=20
 #: builtin/commit.c:1569 builtin/tag.c:600
 msgid "read message from file"
-msgstr "liest Beschreibung von Datei"
+msgstr "Beschreibung von Datei lesen"
=20
 #: builtin/commit.c:1570
 msgid "author"
@@ -4549,7 +4549,7 @@ msgstr "Autor"
=20
 #: builtin/commit.c:1570
 msgid "override author for commit"
-msgstr "=C3=BCberschreibt Autor eines Commits"
+msgstr "Autor eines Commits =C3=BCberschreiben"
=20
 #: builtin/commit.c:1571 builtin/gc.c:286
 msgid "date"
@@ -4557,7 +4557,7 @@ msgstr "Datum"
=20
 #: builtin/commit.c:1571
 msgid "override date for commit"
-msgstr "=C3=BCberschreibt Datum eines Commits"
+msgstr "Datum eines Commits =C3=BCberschreiben"
=20
 #: builtin/commit.c:1572 builtin/merge.c:216 builtin/notes.c:409
 #: builtin/notes.c:566 builtin/tag.c:598
@@ -4570,39 +4570,39 @@ msgstr "Commit-Beschreibung"
=20
 #: builtin/commit.c:1573
 msgid "reuse and edit message from specified commit"
-msgstr "verwendet wieder und editiert Beschreibung des angegebenen Com=
mits"
+msgstr "Beschreibung des angegebenen Commits wiederverwenden und editi=
eren"
=20
 #: builtin/commit.c:1574
 msgid "reuse message from specified commit"
-msgstr "verwendet Beschreibung des angegebenen Commits wieder"
+msgstr "Beschreibung des angegebenen Commits wiederverwenden"
=20
 #: builtin/commit.c:1575
 msgid "use autosquash formatted message to fixup specified commit"
 msgstr ""
-"verwendet eine automatisch zusammengesetzte Beschreibung zum Nachbess=
ern des "
-"angegebenen Commits"
+"eine automatisch zusammengesetzte Beschreibung zum Nachbessern des "
+"angegebenen Commits verwenden"
=20
 #: builtin/commit.c:1576
 msgid "use autosquash formatted message to squash specified commit"
 msgstr ""
-"verwendet eine automatisch zusammengesetzte Beschreibung beim \"squas=
h\" des "
-"angegebenen Commits"
+"eine automatisch zusammengesetzte Beschreibung beim \"squash\" des "
+"angegebenen Commits verwenden"
=20
 #: builtin/commit.c:1577
 msgid "the commit is authored by me now (used with -C/-c/--amend)"
-msgstr "Setzt Sie als Autor des Commits (verwendet mit -C/-c/--amend)"
+msgstr "Sie als Autor des Commits setzen (verwendet mit -C/-c/--amend)=
"
=20
 #: builtin/commit.c:1578 builtin/log.c:1188 builtin/revert.c:86
 msgid "add Signed-off-by:"
-msgstr "f=C3=BCgt 'Signed-off-by:'-Zeile hinzu"
+msgstr "'Signed-off-by:'-Zeile hinzuf=C3=BCgen"
=20
 #: builtin/commit.c:1579
 msgid "use specified template file"
-msgstr "verwendet angegebene Vorlagendatei"
+msgstr "angegebene Vorlagendatei verwenden"
=20
 #: builtin/commit.c:1580
 msgid "force edit of commit"
-msgstr "erzwingt Bearbeitung des Commits"
+msgstr "Bearbeitung des Commits erzwingen"
=20
 #: builtin/commit.c:1581
 msgid "default"
@@ -4615,7 +4615,7 @@ msgstr ""
=20
 #: builtin/commit.c:1582
 msgid "include status in commit message template"
-msgstr "f=C3=BCgt Status in die Commit-Beschreibungsvorlage ein"
+msgstr "Status in die Commit-Beschreibungsvorlage einf=C3=BCgen"
=20
 #: builtin/commit.c:1583 builtin/merge.c:223 builtin/revert.c:92
 #: builtin/tag.c:604
@@ -4624,7 +4624,7 @@ msgstr "GPG-Schl=C3=BCsselkennung"
=20
 #: builtin/commit.c:1584 builtin/merge.c:224 builtin/revert.c:93
 msgid "GPG sign commit"
-msgstr "signiert Commit mit GPG"
+msgstr "Commit mit GPG signieren"
=20
 #: builtin/commit.c:1587
 msgid "Commit contents options"
@@ -4632,11 +4632,11 @@ msgstr "Optionen f=C3=BCr Commit-Inhalt"
=20
 #: builtin/commit.c:1588
 msgid "commit all changed files"
-msgstr "committet alle ge=C3=A4nderten Dateien"
+msgstr "alle ge=C3=A4nderten Dateien committen"
=20
 #: builtin/commit.c:1589
 msgid "add specified files to index for commit"
-msgstr "merkt die angegebenen Dateien zus=C3=A4tzlich zum Commit vor"
+msgstr "die angegebenen Dateien zus=C3=A4tzlich zum Commit vormerken"
=20
 #: builtin/commit.c:1590
 msgid "interactively add files"
--=20
2.1.0.368.g9f4fb5d
