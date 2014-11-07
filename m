From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3 4/7] part4: l10n: de.po: use imperative form for command options
Date: Fri,  7 Nov 2014 21:11:17 +0100
Message-ID: <1415391080-26841-5-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
 <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 07 21:12:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmpsr-0002qR-1V
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbaKGULk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2014 15:11:40 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40877 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbaKGULd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:11:33 -0500
Received: by mail-wi0-f173.google.com with SMTP id n3so5661049wiv.6
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BRQbixlseMOchPQ2D8b+d3z/dPG8KI+NAU1E57zxRSA=;
        b=Cyxd+ye5VqApAGg202ghj1RryJJDHz62Dw4Afn/1FyZpqTyx6VA/G4ftiAgb2TDNQ4
         Fi6fjVcxJJf0wPFY4NO1WWQ/koMSoGqlq12jLckTNzj4dblhrbbd/E+dTU6n8zFiP7X0
         Pem4S2IczrNHBjqHOt+kMOXoI0kW29KAhSqOTge9aEO08DVl5OEUtrln3i4sgddFp5EP
         L5ESG0QHywUXNthMpyMIIEpbLGKt2zrGgmzYyZPe6XYkVknt5SGgJEK11CC9eA0HsD5o
         qmGXsHMXP+dLQFTiQ6LauWxfTnzd5crefbGKJGVeMlcd0+eDvjlQobgi6NUefCz/gzKr
         TsQw==
X-Received: by 10.194.63.79 with SMTP id e15mr20067452wjs.79.1415391091382;
        Fri, 07 Nov 2014 12:11:31 -0800 (PST)
Received: from localhost (dslb-088-073-206-248.088.073.pools.vodafone-ip.de. [88.73.206.248])
        by mx.google.com with ESMTPSA id kn5sm5471348wjb.48.2014.11.07.12.11.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 12:11:30 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc0.232.g8ec773f
In-Reply-To: <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 192 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/po/de.po b/po/de.po
index 8071fd1..64ee621 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5588,83 +5588,83 @@ msgstr "kann '%s' nicht =C3=B6ffnen"
=20
 #: builtin/grep.c:638
 msgid "search in index instead of in the work tree"
-msgstr "sucht in der Staging-Area anstatt im Arbeitsverzeichnis"
+msgstr "in der Staging-Area anstatt im Arbeitsverzeichnis suchen"
=20
 #: builtin/grep.c:640
 msgid "find in contents not managed by git"
-msgstr "findet auch in Inhalten, die nicht von Git verwaltet werden"
+msgstr "auch in Inhalten finden, die nicht von Git verwaltet werden"
=20
 #: builtin/grep.c:642
 msgid "search in both tracked and untracked files"
-msgstr "sucht in beobachteten und unbeobachteten Dateien"
+msgstr "in beobachteten und unbeobachteten Dateien suchen"
=20
 #: builtin/grep.c:644
 msgid "search also in ignored files"
-msgstr "sucht auch in ignorierten Dateien"
+msgstr "auch in ignorierten Dateien suchen"
=20
 #: builtin/grep.c:647
 msgid "show non-matching lines"
-msgstr "zeigt Zeilen ohne =C3=9Cbereinstimmungen"
+msgstr "Zeilen ohne =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/grep.c:649
 msgid "case insensitive matching"
-msgstr "findet =C3=9Cbereinstimmungen unabh=C3=A4ngig von Gro=C3=9F- u=
nd Kleinschreibung"
+msgstr "=C3=9Cbereinstimmungen unabh=C3=A4ngig von Gro=C3=9F- und Klei=
nschreibung finden"
=20
 #: builtin/grep.c:651
 msgid "match patterns only at word boundaries"
-msgstr "sucht nur ganze W=C3=B6rter"
+msgstr "nur ganze W=C3=B6rter suchen"
=20
 #: builtin/grep.c:653
 msgid "process binary files as text"
-msgstr "verarbeitet bin=C3=A4re Dateien als Text"
+msgstr "bin=C3=A4re Dateien als Text verarbeiten"
=20
 #: builtin/grep.c:655
 msgid "don't match patterns in binary files"
-msgstr "findet keine Muster in Bin=C3=A4rdateien"
+msgstr "keine Muster in Bin=C3=A4rdateien finden"
=20
 #: builtin/grep.c:658
 msgid "process binary files with textconv filters"
-msgstr "verarbeitet bin=C3=A4re Dateien mit \"textconv\"-Filtern"
+msgstr "bin=C3=A4re Dateien mit \"textconv\"-Filtern verarbeiten"
=20
 #: builtin/grep.c:660
 msgid "descend at most <depth> levels"
-msgstr "durchl=C3=A4uft h=C3=B6chstens <Tiefe> Ebenen"
+msgstr "h=C3=B6chstens <Tiefe> Ebenen durchlaufen"
=20
 #: builtin/grep.c:664
 msgid "use extended POSIX regular expressions"
-msgstr "verwendet erweiterte regul=C3=A4re Ausdr=C3=BCcke aus POSIX"
+msgstr "erweiterte regul=C3=A4re Ausdr=C3=BCcke aus POSIX verwenden"
=20
 #: builtin/grep.c:667
 msgid "use basic POSIX regular expressions (default)"
-msgstr "verwendet grundlegende regul=C3=A4re Ausdr=C3=BCcke aus POSIX =
(Standard)"
+msgstr "grundlegende regul=C3=A4re Ausdr=C3=BCcke aus POSIX verwenden =
(Standard)"
=20
 #: builtin/grep.c:670
 msgid "interpret patterns as fixed strings"
-msgstr "interpretiert Muster als feste Zeichenketten"
+msgstr "Muster als feste Zeichenketten interpretieren"
=20
 #: builtin/grep.c:673
 msgid "use Perl-compatible regular expressions"
-msgstr "verwendet Perl-kompatible regul=C3=A4re Ausdr=C3=BCcke"
+msgstr "Perl-kompatible regul=C3=A4re Ausdr=C3=BCcke verwenden"
=20
 #: builtin/grep.c:676
 msgid "show line numbers"
-msgstr "zeigt Zeilennummern"
+msgstr "Zeilennummern anzeigen"
=20
 #: builtin/grep.c:677
 msgid "don't show filenames"
-msgstr "zeigt keine Dateinamen"
+msgstr "keine Dateinamen anzeigen"
=20
 #: builtin/grep.c:678
 msgid "show filenames"
-msgstr "zeigt Dateinamen"
+msgstr "Dateinamen anzeigen"
=20
 #: builtin/grep.c:680
 msgid "show filenames relative to top directory"
-msgstr "zeigt Dateinamen relativ zum Projektverzeichnis"
+msgstr "Dateinamen relativ zum Projektverzeichnis anzeigen"
=20
 #: builtin/grep.c:682
 msgid "show only filenames instead of matching lines"
-msgstr "zeigt nur Dateinamen anstatt =C3=BCbereinstimmende Zeilen"
+msgstr "nur Dateinamen anzeigen anstatt =C3=BCbereinstimmende Zeilen"
=20
 #: builtin/grep.c:684
 msgid "synonym for --files-with-matches"
@@ -5672,42 +5672,42 @@ msgstr "Synonym f=C3=BCr --files-with-matches"
=20
 #: builtin/grep.c:687
 msgid "show only the names of files without match"
-msgstr "zeigt nur die Dateinamen ohne =C3=9Cbereinstimmungen"
+msgstr "nur die Dateinamen ohne =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/grep.c:689
 msgid "print NUL after filenames"
-msgstr "gibt NUL-Zeichen nach Dateinamen aus"
+msgstr "NUL-Zeichen nach Dateinamen ausgeben"
=20
 #: builtin/grep.c:691
 msgid "show the number of matches instead of matching lines"
-msgstr "zeigt, anstatt der Zeilen, die Anzahl der =C3=BCbereinstimmend=
en Zeilen"
+msgstr "anstatt der Zeilen, die Anzahl der =C3=BCbereinstimmenden Zeil=
en anzeigen"
=20
 #: builtin/grep.c:692
 msgid "highlight matches"
-msgstr "hebt =C3=9Cbereinstimmungen hervor"
+msgstr "=C3=9Cbereinstimmungen hervorheben"
=20
 #: builtin/grep.c:694
 msgid "print empty line between matches from different files"
 msgstr ""
-"gibt eine Leerzeile zwischen =C3=9Cbereinstimmungen in verschiedenen =
Dateien aus"
+"eine Leerzeile zwischen =C3=9Cbereinstimmungen in verschiedenen Datei=
en ausgeben"
=20
 #: builtin/grep.c:696
 msgid "show filename only once above matches from same file"
 msgstr ""
-"zeigt den Dateinamen nur einmal oberhalb der =C3=9Cbereinstimmungen a=
us dieser "
-"Datei an"
+"den Dateinamen nur einmal oberhalb der =C3=9Cbereinstimmungen aus die=
ser "
+"Datei anzeigen"
=20
 #: builtin/grep.c:699
 msgid "show <n> context lines before and after matches"
-msgstr "zeigt <n> Zeilen vor und nach den =C3=9Cbereinstimmungen an"
+msgstr "<n> Zeilen vor und nach den =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/grep.c:702
 msgid "show <n> context lines before matches"
-msgstr "zeigt <n> Zeilen vor den =C3=9Cbereinstimmungen an"
+msgstr "<n> Zeilen vor den =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/grep.c:704
 msgid "show <n> context lines after matches"
-msgstr "zeigt <n> Zeilen nach den =C3=9Cbereinstimmungen an"
+msgstr "<n> Zeilen nach den =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/grep.c:705
 msgid "shortcut for -C NUM"
@@ -5715,35 +5715,35 @@ msgstr "Kurzform f=C3=BCr -C NUM"
=20
 #: builtin/grep.c:708
 msgid "show a line with the function name before matches"
-msgstr "zeigt eine Zeile mit dem Funktionsnamen vor =C3=9Cbereinstimmu=
ngen an"
+msgstr "eine Zeile mit dem Funktionsnamen vor =C3=9Cbereinstimmungen a=
nzeigen"
=20
 #: builtin/grep.c:710
 msgid "show the surrounding function"
-msgstr "zeigt die umgebende Funktion an"
+msgstr "die umgebende Funktion anzeigen"
=20
 #: builtin/grep.c:713
 msgid "read patterns from file"
-msgstr "liest Muster von einer Datei"
+msgstr "Muster von einer Datei lesen"
=20
 #: builtin/grep.c:715
 msgid "match <pattern>"
-msgstr "findet <Muster>"
+msgstr "<Muster> finden"
=20
 #: builtin/grep.c:717
 msgid "combine patterns specified with -e"
-msgstr "kombiniert Muster, die mit -e angegeben wurden"
+msgstr "Muster kombinieren, die mit -e angegeben wurden"
=20
 #: builtin/grep.c:729
 msgid "indicate hit with exit status without output"
-msgstr "zeigt =C3=9Cbereinstimmungen nur durch Beendigungsstatus an"
+msgstr "=C3=9Cbereinstimmungen nur durch Beendigungsstatus anzeigen"
=20
 #: builtin/grep.c:731
 msgid "show only matches from files that match all patterns"
-msgstr "zeigt nur =C3=9Cbereinstimmungen von Dateien, die allen Muster=
n entsprechen"
+msgstr "nur =C3=9Cbereinstimmungen von Dateien anzeigen, die allen Mus=
tern entsprechen"
=20
 #: builtin/grep.c:733
 msgid "show parse tree for grep expression"
-msgstr "zeigt geparstes Verzeichnis f=C3=BCr \"grep\"-Ausdruck"
+msgstr "geparstes Verzeichnis f=C3=BCr \"grep\"-Ausdruck anzeigen"
=20
 #: builtin/grep.c:737
 msgid "pager"
@@ -5751,15 +5751,15 @@ msgstr "Anzeigeprogramm"
=20
 #: builtin/grep.c:737
 msgid "show matching files in the pager"
-msgstr "zeigt Dateien mit =C3=9Cbereinstimmungen im Anzeigeprogramm"
+msgstr "Dateien mit =C3=9Cbereinstimmungen im Anzeigeprogramm anzeigen=
"
=20
 #: builtin/grep.c:740
 msgid "allow calling of grep(1) (ignored by this build)"
-msgstr "erlaubt den Aufruf von grep(1) (von dieser Programmversion ign=
oriert)"
+msgstr "den Aufruf von grep(1) erlauben (von dieser Programmversion ig=
noriert)"
=20
 #: builtin/grep.c:741 builtin/show-ref.c:187
 msgid "show usage"
-msgstr "zeigt Verwendung"
+msgstr "Verwendung anzeigen"
=20
 #: builtin/grep.c:808
 msgid "no pattern given."
@@ -5815,39 +5815,39 @@ msgstr "Art des Objektes"
=20
 #: builtin/hash-object.c:73
 msgid "write the object into the object database"
-msgstr "schreibt das Objekt in die Objektdatenbank"
+msgstr "das Objekt in die Objektdatenbank schreiben"
=20
 #: builtin/hash-object.c:74
 msgid "read the object from stdin"
-msgstr "liest das Objekt von der Standard-Eingabe"
+msgstr "das Objekt von der Standard-Eingabe lesen"
=20
 #: builtin/hash-object.c:76
 msgid "store file as is without filters"
-msgstr "speichert Datei wie sie ist, ohne Filter"
+msgstr "Datei wie sie ist speichern, ohne Filter"
=20
 #: builtin/hash-object.c:77
 msgid "process file as it were from this path"
-msgstr "verarbeitet Datei, als ob sie von diesem Pfad w=C3=A4re"
+msgstr "Datei verarbeiten, als ob sie von diesem Pfad w=C3=A4re"
=20
 #: builtin/help.c:41
 msgid "print all available commands"
-msgstr "Anzeige aller vorhandenen Kommandos"
+msgstr "alle vorhandenen Kommandos anzeigen"
=20
 #: builtin/help.c:42
 msgid "print list of useful guides"
-msgstr "zeigt Liste von allgemein verwendeten Anleitungen"
+msgstr "Liste von allgemein verwendeten Anleitungen anzeigen"
=20
 #: builtin/help.c:43
 msgid "show man page"
-msgstr "zeigt Handbuch"
+msgstr "Handbuch anzeigen"
=20
 #: builtin/help.c:44
 msgid "show manual in web browser"
-msgstr "zeigt Handbuch in einem Webbrowser"
+msgstr "Handbuch in einem Webbrowser anzeigen"
=20
 #: builtin/help.c:46
 msgid "show info page"
-msgstr "zeigt Info-Seite"
+msgstr "Info-Seite anzeigen"
=20
 #: builtin/help.c:52
 msgid "git help [--all] [--guides] [--man|--web|--info] [command]"
@@ -6361,7 +6361,7 @@ msgstr "Berechtigungen"
=20
 #: builtin/init-db.c:489
 msgid "specify that the git repository is to be shared amongst several=
 users"
-msgstr "gibt an, dass das Git-Repository mit mehreren Benutzern geteil=
t wird"
+msgstr "angeben, dass das Git-Repository mit mehreren Benutzern geteil=
t wird"
=20
 #: builtin/init-db.c:491 builtin/prune-packed.c:79 builtin/repack.c:17=
2
 msgid "be quiet"
@@ -6405,15 +6405,15 @@ msgstr "   oder: git show [Optionen] <Objekt>..=
=2E"
=20
 #: builtin/log.c:127
 msgid "suppress diff output"
-msgstr "unterdr=C3=BCckt Ausgabe der Unterschiede"
+msgstr "Ausgabe der Unterschiede unterdr=C3=BCcken"
=20
 #: builtin/log.c:128
 msgid "show source"
-msgstr "zeigt Quelle"
+msgstr "Quelle anzeigen"
=20
 #: builtin/log.c:129
 msgid "Use mail map file"
-msgstr "verwendet \"mailmap\"-Datei"
+msgstr "\"mailmap\"-Datei verwenden"
=20
 #: builtin/log.c:130
 msgid "decorate options"
@@ -6474,11 +6474,11 @@ msgstr "Zwei Ausgabeverzeichnisse?"
=20
 #: builtin/log.c:1183
 msgid "use [PATCH n/m] even with a single patch"
-msgstr "verwendet [PATCH n/m] auch mit einzelnem Patch"
+msgstr "[PATCH n/m] auch mit einzelnem Patch verwenden"
=20
 #: builtin/log.c:1186
 msgid "use [PATCH] even with multiple patches"
-msgstr "verwendet [PATCH] auch mit mehreren Patches"
+msgstr "[PATCH] auch mit mehreren Patches verwenden"
=20
 #: builtin/log.c:1190
 msgid "print patches to standard out"
@@ -6486,11 +6486,11 @@ msgstr "Ausgabe der Patches in Standard-Ausgabe=
"
=20
 #: builtin/log.c:1192
 msgid "generate a cover letter"
-msgstr "erzeugt ein Deckblatt"
+msgstr "ein Deckblatt erzeugen"
=20
 #: builtin/log.c:1194
 msgid "use simple number sequence for output file names"
-msgstr "verwendet einfache Nummernfolge f=C3=BCr die Namen der Ausgabe=
dateien"
+msgstr "einfache Nummernfolge f=C3=BCr die Namen der Ausgabedateien ve=
rwenden"
=20
 #: builtin/log.c:1195
 msgid "sfx"
@@ -6498,40 +6498,40 @@ msgstr "Dateiendung"
=20
 #: builtin/log.c:1196
 msgid "use <sfx> instead of '.patch'"
-msgstr "verwendet <Dateiendung> anstatt '.patch'"
+msgstr "<Dateiendung> anstatt '.patch' verwenden"
=20
 #: builtin/log.c:1198
 msgid "start numbering patches at <n> instead of 1"
-msgstr "beginnt die Nummerierung der Patches bei <n> anstatt bei 1"
+msgstr "die Nummerierung der Patches bei <n> anstatt bei 1 beginnen"
=20
 #: builtin/log.c:1200
 msgid "mark the series as Nth re-roll"
-msgstr "kennzeichnet die Serie als n-te Fassung"
+msgstr "die Serie als n-te Fassung kennzeichnen"
=20
 #: builtin/log.c:1202
 msgid "Use [<prefix>] instead of [PATCH]"
-msgstr "verwendet [<Pr=C3=A4fix>] anstatt [PATCH]"
+msgstr "[<Pr=C3=A4fix>] anstatt [PATCH] verwenden"
=20
 #: builtin/log.c:1205
 msgid "store resulting files in <dir>"
-msgstr "speichert erzeugte Dateien in <Verzeichnis>"
+msgstr "erzeugte Dateien in <Verzeichnis> speichern"
=20
 #: builtin/log.c:1208
 msgid "don't strip/add [PATCH]"
-msgstr "[PATCH] wird nicht entfernt/hinzugef=C3=BCgt"
+msgstr "[PATCH] nicht entfernen/hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1211
 msgid "don't output binary diffs"
-msgstr "gibt keine bin=C3=A4ren Unterschiede aus"
+msgstr "keine bin=C3=A4ren Unterschiede ausgeben"
=20
 #: builtin/log.c:1213
 msgid "don't include a patch matching a commit upstream"
 msgstr ""
-"schlie=C3=9Ft keine Patches ein, die einem Commit im Upstream-Branch =
entsprechen"
+"keine Patches einschlie=C3=9Fen, die einem Commit im Upstream-Branch =
entsprechen"
=20
 #: builtin/log.c:1215
 msgid "show patch format instead of default (patch + stat)"
-msgstr "zeigt Patchformat anstatt des Standards (Patch + Zusammenfassu=
ng)"
+msgstr "Patchformat anstatt des Standards anzeigen (Patch + Zusammenfa=
ssung)"
=20
 #: builtin/log.c:1217
 msgid "Messaging"
@@ -6543,7 +6543,7 @@ msgstr "Header"
=20
 #: builtin/log.c:1219
 msgid "add email header"
-msgstr "f=C3=BCgt E-Mail-Header hinzu"
+msgstr "E-Mail-Header hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1220 builtin/log.c:1222
 msgid "email"
@@ -6551,11 +6551,11 @@ msgstr "E-Mail"
=20
 #: builtin/log.c:1220
 msgid "add To: header"
-msgstr "f=C3=BCgt  \"To:\"-Header hinzu"
+msgstr "\"To:\"-Header hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1222
 msgid "add Cc: header"
-msgstr "f=C3=BCgt \"Cc:\"-Header hinzu"
+msgstr "\"Cc:\"-Header hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1224
 msgid "ident"
@@ -6564,7 +6564,7 @@ msgstr "Ident"
 #: builtin/log.c:1225
 msgid "set From address to <ident> (or committer ident if absent)"
 msgstr ""
-"setzt \"From\"-Adresse auf <Ident> (oder Ident des Commit-Erstellers,=
wenn "
+"\"From\"-Adresse auf <Ident> setzen (oder Ident des Commit-Erstellers=
, wenn "
 "fehlend)"
=20
 #: builtin/log.c:1227
@@ -6573,7 +6573,7 @@ msgstr "message-id"
=20
 #: builtin/log.c:1228
 msgid "make first mail a reply to <message-id>"
-msgstr "macht aus erster E-Mail eine Antwort zu <message-id>"
+msgstr "aus erster E-Mail eine Antwort zu <message-id> machen"
=20
 #: builtin/log.c:1229 builtin/log.c:1232
 msgid "boundary"
@@ -6581,15 +6581,15 @@ msgstr "Grenze"
=20
 #: builtin/log.c:1230
 msgid "attach the patch"
-msgstr "h=C3=A4ngt einen Patch an"
+msgstr "den Patch anh=C3=A4ngen"
=20
 #: builtin/log.c:1233
 msgid "inline the patch"
-msgstr "f=C3=BCgt den Patch direkt in die Nachricht ein"
+msgstr "den Patch direkt in die Nachricht einf=C3=BCgen"
=20
 #: builtin/log.c:1237
 msgid "enable message threading, styles: shallow, deep"
-msgstr "aktiviert Nachrichtenverkettung, Stile: shallow, deep"
+msgstr "Nachrichtenverkettung aktivieren, Stile: shallow, deep"
=20
 #: builtin/log.c:1239
 msgid "signature"
@@ -6597,15 +6597,15 @@ msgstr "Signatur"
=20
 #: builtin/log.c:1240
 msgid "add a signature"
-msgstr "f=C3=BCgt eine Signatur hinzu"
+msgstr "eine Signatur hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1242
 msgid "add a signature from a file"
-msgstr "f=C3=BCgt eine Signatur aus einer Datei hinzu"
+msgstr "eine Signatur aus einer Datei hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1243
 msgid "don't print the patch filenames"
-msgstr "zeigt keine Dateinamen der Patches"
+msgstr "keine Dateinamen der Patches anzeigen"
=20
 #: builtin/log.c:1317
 #, c-format
@@ -6673,74 +6673,74 @@ msgstr "git ls-files [Optionen] [<Datei>...]"
=20
 #: builtin/ls-files.c:458
 msgid "identify the file status with tags"
-msgstr "zeigt den Dateistatus mit Tags"
+msgstr "den Dateistatus mit Tags anzeigen"
=20
 #: builtin/ls-files.c:460
 msgid "use lowercase letters for 'assume unchanged' files"
 msgstr ""
-"verwendet Kleinbuchstaben f=C3=BCr Dateien mit 'assume unchanged' Mar=
kierung"
+"Kleinbuchstaben f=C3=BCr Dateien mit 'assume unchanged' Markierung ve=
rwenden"
=20
 #: builtin/ls-files.c:462
 msgid "show cached files in the output (default)"
-msgstr "zeigt zwischengespeicherten Dateien in der Ausgabe an (Standar=
d)"
+msgstr "zwischengespeicherten Dateien in der Ausgabe anzeigen (Standar=
d)"
=20
 #: builtin/ls-files.c:464
 msgid "show deleted files in the output"
-msgstr "zeigt entfernte Dateien in der Ausgabe an"
+msgstr "entfernte Dateien in der Ausgabe anzeigen"
=20
 #: builtin/ls-files.c:466
 msgid "show modified files in the output"
-msgstr "zeigt ge=C3=A4nderte Dateien in der Ausgabe an"
+msgstr "ge=C3=A4nderte Dateien in der Ausgabe anzeigen"
=20
 #: builtin/ls-files.c:468
 msgid "show other files in the output"
-msgstr "zeigt sonstige Dateien in der Ausgabe an"
+msgstr "sonstige Dateien in der Ausgabe anzeigen"
=20
 #: builtin/ls-files.c:470
 msgid "show ignored files in the output"
-msgstr "zeigt ignorierte Dateien in der Ausgabe an"
+msgstr "ignorierte Dateien in der Ausgabe anzeigen"
=20
 #: builtin/ls-files.c:473
 msgid "show staged contents' object name in the output"
 msgstr ""
-"zeigt Objektnamen von Inhalten, die zum Commit vorgemerkt sind, in de=
r "
-"Ausgabe an"
+"Objektnamen von Inhalten, die zum Commit vorgemerkt sind, in der "
+"Ausgabe anzeigen"
=20
 #: builtin/ls-files.c:475
 msgid "show files on the filesystem that need to be removed"
-msgstr "zeigt Dateien im Dateisystem, die gel=C3=B6scht werden m=C3=BC=
ssen, an"
+msgstr "Dateien im Dateisystem, die gel=C3=B6scht werden m=C3=BCssen, =
anzeigen"
=20
 #: builtin/ls-files.c:477
 msgid "show 'other' directories' name only"
-msgstr "zeigt nur Namen von 'sonstigen' Verzeichnissen an"
+msgstr "nur Namen von 'sonstigen' Verzeichnissen anzeigen"
=20
 #: builtin/ls-files.c:480
 msgid "don't show empty directories"
-msgstr "zeigt keine leeren Verzeichnisse an"
+msgstr "keine leeren Verzeichnisse anzeigen"
=20
 #: builtin/ls-files.c:483
 msgid "show unmerged files in the output"
-msgstr "zeigt nicht zusammengef=C3=BChrte Dateien in der Ausgabe an"
+msgstr "nicht zusammengef=C3=BChrte Dateien in der Ausgabe anzeigen"
=20
 #: builtin/ls-files.c:485
 msgid "show resolve-undo information"
-msgstr "zeigt 'resolve-undo' Informationen an"
+msgstr "'resolve-undo' Informationen anzeigen"
=20
 #: builtin/ls-files.c:487
 msgid "skip files matching pattern"
-msgstr "l=C3=A4sst Dateien aus, die einem Muster entsprechen"
+msgstr "Dateien auslassen, die einem Muster entsprechen"
=20
 #: builtin/ls-files.c:490
 msgid "exclude patterns are read from <file>"
-msgstr "schlie=C3=9Ft Muster, gelesen von <Datei>, aus"
+msgstr "Muster, gelesen von <Datei>, ausschlie=C3=9Fen"
=20
 #: builtin/ls-files.c:493
 msgid "read additional per-directory exclude patterns in <file>"
-msgstr "liest zus=C3=A4tzliche pro-Verzeichnis Auschlussmuster aus <Da=
tei>"
+msgstr "zus=C3=A4tzliche pro-Verzeichnis Auschlussmuster aus <Datei> a=
uslesen"
=20
 #: builtin/ls-files.c:495
 msgid "add the standard git exclusions"
-msgstr "f=C3=BCgt die standardm=C3=A4=C3=9Figen Git-Ausschl=C3=BCsse h=
inzu"
+msgstr "die standardm=C3=A4=C3=9Figen Git-Ausschl=C3=BCsse hinzuf=C3=BC=
gen"
=20
 #: builtin/ls-files.c:498
 msgid "make the output relative to the project top directory"
--=20
2.2.0.rc0.232.g8ec773f
