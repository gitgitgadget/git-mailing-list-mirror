From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3 3/7] part3: l10n: de.po: use imperative form for command options
Date: Fri,  7 Nov 2014 21:11:16 +0100
Message-ID: <1415391080-26841-4-git-send-email-ralf.thielow@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
 <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 07 21:11:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmpsd-0002db-TD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaKGULd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2014 15:11:33 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59655 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbaKGULb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:11:31 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so4578919wgg.37
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 12:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fky4MTQQCuBURSCnxf++Ti3hphMmvDGRPRmKf6ysdTA=;
        b=mL1qCyl6nzPZwgUbtj5YNJnnBzGwMkDzHbCIgyHBhXOXR/Xv/1VkAGZFGQZvK2gndY
         BegXXHtF325fALvd5HlouQMToih03OQ339Wi/qzsvB8hXlWdv46ANaJnDiDTJwuk3YZZ
         FjPpdkudv5r1pUabYeuJ2kIY71Z0EVp186zUxPTEBXAZytP83LqUNGdbh8MP/eNJZxFB
         jniqnYDyqmKzIoodqmg2+GzwZhEirPGhaDwVX1osalx3jPPRTZfTz24rG+HMlSsTvJSB
         D2Ftnqc+4adYWeNyXYn+asxUo0tH3rzHYgF9BTArJvSaRv1uqx9xQVqavsmbZTD1II29
         1RCg==
X-Received: by 10.180.107.1 with SMTP id gy1mr8356266wib.8.1415391089664;
        Fri, 07 Nov 2014 12:11:29 -0800 (PST)
Received: from localhost (dslb-088-073-206-248.088.073.pools.vodafone-ip.de. [88.73.206.248])
        by mx.google.com with ESMTPSA id cv7sm13046675wjc.3.2014.11.07.12.11.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 12:11:29 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc0.232.g8ec773f
In-Reply-To: <1415391080-26841-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 160 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/po/de.po b/po/de.po
index 47b2d68..8071fd1 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4648,31 +4648,31 @@ msgstr "interaktives Hinzuf=C3=BCgen von =C3=84=
nderungen"
=20
 #: builtin/commit.c:1592
 msgid "commit only specified files"
-msgstr "committet nur die angegebenen Dateien"
+msgstr "nur die angegebenen Dateien committen"
=20
 #: builtin/commit.c:1593
 msgid "bypass pre-commit hook"
-msgstr "umgeht \"pre-commit hook\""
+msgstr "\"pre-commit hook\" umgehen"
=20
 #: builtin/commit.c:1594
 msgid "show what would be committed"
-msgstr "zeigt an, was committet werden w=C3=BCrde"
+msgstr "anzeigen, was committet werden w=C3=BCrde"
=20
 #: builtin/commit.c:1605
 msgid "amend previous commit"
-msgstr "=C3=A4ndert vorherigen Commit"
+msgstr "vorherigen Commit =C3=A4ndern"
=20
 #: builtin/commit.c:1606
 msgid "bypass post-rewrite hook"
-msgstr "umgeht \"post-rewrite hook\""
+msgstr "\"post-rewrite hook\" umgehen"
=20
 #: builtin/commit.c:1611
 msgid "ok to record an empty change"
-msgstr "erlaubt Aufzeichnung einer leeren =C3=84nderung"
+msgstr "Aufzeichnung einer leeren =C3=84nderung erlauben"
=20
 #: builtin/commit.c:1613
 msgid "ok to record a change with an empty message"
-msgstr "erlaubt Aufzeichnung einer =C3=84nderung mit einer leeren Besc=
hreibung"
+msgstr "Aufzeichnung einer =C3=84nderung mit einer leeren Beschreibung=
 erlauben"
=20
 #: builtin/commit.c:1641
 msgid "could not parse HEAD commit"
@@ -4740,19 +4740,19 @@ msgstr "Ort der Konfigurationsdatei"
=20
 #: builtin/config.c:54
 msgid "use global config file"
-msgstr "verwendet globale Konfigurationsdatei"
+msgstr "globale Konfigurationsdatei verwenden"
=20
 #: builtin/config.c:55
 msgid "use system config file"
-msgstr "verwendet systemweite Konfigurationsdatei"
+msgstr "systemweite Konfigurationsdatei verwenden"
=20
 #: builtin/config.c:56
 msgid "use repository config file"
-msgstr "verwendet Konfigurationsdatei des Repositories"
+msgstr "Konfigurationsdatei des Repositories verwenden"
=20
 #: builtin/config.c:57
 msgid "use given config file"
-msgstr "verwendet die angegebene Konfigurationsdatei"
+msgstr "die angegebene Konfigurationsdatei verwenden"
=20
 #: builtin/config.c:58
 msgid "blob-id"
@@ -4760,7 +4760,7 @@ msgstr "Blob-Id"
=20
 #: builtin/config.c:58
 msgid "read config from given blob object"
-msgstr "liest Konfiguration von angegebenem Blob-Objekt"
+msgstr "Konfiguration von angegebenem Blob-Objekt lesen"
=20
 #: builtin/config.c:59
 msgid "Action"
@@ -4768,51 +4768,51 @@ msgstr "Aktion"
=20
 #: builtin/config.c:60
 msgid "get value: name [value-regex]"
-msgstr "gibt Wert zur=C3=BCck: Name [Wert-regex]"
+msgstr "Wert zur=C3=BCckgeben: Name [Wert-regex]"
=20
 #: builtin/config.c:61
 msgid "get all values: key [value-regex]"
-msgstr "gibt alle Werte zur=C3=BCck: Schl=C3=BCssel [Wert-regex]"
+msgstr "alle Werte zur=C3=BCckgeben: Schl=C3=BCssel [Wert-regex]"
=20
 #: builtin/config.c:62
 msgid "get values for regexp: name-regex [value-regex]"
-msgstr "gibt Werte f=C3=BCr den regul=C3=A4ren Ausdruck zur=C3=BCck: N=
ame-regex [Wert-regex]"
+msgstr "Werte f=C3=BCr den regul=C3=A4ren Ausdruck zur=C3=BCckgeben: N=
ame-regex [Wert-regex]"
=20
 #: builtin/config.c:63
 msgid "get value specific for the URL: section[.var] URL"
-msgstr "gibt Wert spezifisch f=C3=BCr eine URL zur=C3=BCck: section[.v=
ar] URL"
+msgstr "Wert spezifisch f=C3=BCr eine URL zur=C3=BCckgeben: section[.v=
ar] URL"
=20
 #: builtin/config.c:64
 msgid "replace all matching variables: name value [value_regex]"
-msgstr "ersetzt alle passenden Variablen: Name Wert [Wert-regex] "
+msgstr "alle passenden Variablen ersetzen: Name Wert [Wert-regex] "
=20
 #: builtin/config.c:65
 msgid "add a new variable: name value"
-msgstr "f=C3=BCgt neue Variable hinzu: Name Wert"
+msgstr "neue Variable hinzuf=C3=BCgen: Name Wert"
=20
 #: builtin/config.c:66
 msgid "remove a variable: name [value-regex]"
-msgstr "entfernt eine Variable: Name [Wert-regex]"
+msgstr "eine Variable entfernen: Name [Wert-regex]"
=20
 #: builtin/config.c:67
 msgid "remove all matches: name [value-regex]"
-msgstr "entfernt alle =C3=9Cbereinstimmungen: Name [Wert-regex]"
+msgstr "alle =C3=9Cbereinstimmungen entfernen: Name [Wert-regex]"
=20
 #: builtin/config.c:68
 msgid "rename section: old-name new-name"
-msgstr "benennt eine Sektion um: alter-Name neuer-Name"
+msgstr "eine Sektion umbenennen: alter-Name neuer-Name"
=20
 #: builtin/config.c:69
 msgid "remove a section: name"
-msgstr "entfernt eine Sektion: Name"
+msgstr "eine Sektion entfernen: Name"
=20
 #: builtin/config.c:70
 msgid "list all"
-msgstr "listet alles auf"
+msgstr "alles auflisten"
=20
 #: builtin/config.c:71
 msgid "open an editor"
-msgstr "=C3=B6ffnet einen Editor"
+msgstr "einen Editor =C3=B6ffnen"
=20
 #: builtin/config.c:72 builtin/config.c:73
 msgid "slot"
@@ -4820,11 +4820,11 @@ msgstr "Slot"
=20
 #: builtin/config.c:72
 msgid "find the color configured: [default]"
-msgstr "findet die konfigurierte Farbe: [Standard]"
+msgstr "die konfigurierte Farbe finden: [Standard]"
=20
 #: builtin/config.c:73
 msgid "find the color setting: [stdout-is-tty]"
-msgstr "findet die Farbeinstellung: [Standard-Ausgabe-ist-Terminal]"
+msgstr "die Farbeinstellung finden: [Standard-Ausgabe-ist-Terminal]"
=20
 #: builtin/config.c:74
 msgid "Type"
@@ -4948,43 +4948,43 @@ msgstr ""
=20
 #: builtin/describe.c:395
 msgid "find the tag that comes after the commit"
-msgstr "findet das Tag, das nach Commit kommt"
+msgstr "das Tag finden, das nach dem Commit kommt"
=20
 #: builtin/describe.c:396
 msgid "debug search strategy on stderr"
-msgstr "protokolliert die Suchstrategie in der Standard-Fehlerausgabe"
+msgstr "die Suchstrategie in der Standard-Fehlerausgabe protokollieren=
"
=20
 #: builtin/describe.c:397
 msgid "use any ref"
-msgstr "verwendet alle Referenzen"
+msgstr "alle Referenzen verwenden"
=20
 #: builtin/describe.c:398
 msgid "use any tag, even unannotated"
-msgstr "verwendet jedes Tag, auch nicht-annotierte"
+msgstr "jedes Tag verwenden, auch nicht-annotierte"
=20
 #: builtin/describe.c:399
 msgid "always use long format"
-msgstr "verwendet immer langes Format"
+msgstr "immer langes Format verwenden"
=20
 #: builtin/describe.c:400
 msgid "only follow first parent"
-msgstr "folgt nur erstem Elternteil"
+msgstr "nur erstem Elternteil folgen"
=20
 #: builtin/describe.c:403
 msgid "only output exact matches"
-msgstr "gibt nur exakte =C3=9Cbereinstimmungen aus"
+msgstr "nur exakte =C3=9Cbereinstimmungen ausgeben"
=20
 #: builtin/describe.c:405
 msgid "consider <n> most recent tags (default: 10)"
-msgstr "betrachtet die j=C3=BCngsten <n> Tags (Standard: 10)"
+msgstr "die j=C3=BCngsten <n> Tags betrachten (Standard: 10)"
=20
 #: builtin/describe.c:407
 msgid "only consider tags matching <pattern>"
-msgstr "betrachtet nur Tags die <Muster> entsprechen"
+msgstr "nur Tags, die <Muster> entsprechen, betrachten"
=20
 #: builtin/describe.c:409 builtin/name-rev.c:318
 msgid "show abbreviated commit object as fallback"
-msgstr "zeigt gek=C3=BCrztes Commit-Objekt, wenn sonst nichts zutrifft=
"
+msgstr "gek=C3=BCrztes Commit-Objekt anzeigen, wenn sonst nichts zutri=
fft"
=20
 #: builtin/describe.c:410
 msgid "mark"
@@ -4993,7 +4993,7 @@ msgstr "Kennzeichen"
 #: builtin/describe.c:411
 msgid "append <mark> on dirty working tree (default: \"-dirty\")"
 msgstr ""
-"f=C3=BCgt <Kennzeichen> bei ge=C3=A4ndertem Arbeitsverzeichnis hinzu =
(Standard: \"-"
+"<Kennzeichen> bei ge=C3=A4ndertem Arbeitsverzeichnis hinzuf=C3=BCgen =
(Standard: \"-"
 "dirty\")"
=20
 #: builtin/describe.c:429
@@ -5043,39 +5043,39 @@ msgstr "git fast-export [rev-list-opts]"
=20
 #: builtin/fast-export.c:702
 msgid "show progress after <n> objects"
-msgstr "zeigt Fortschritt nach <n> Objekten an"
+msgstr "Fortschritt nach <n> Objekten anzeigen"
=20
 #: builtin/fast-export.c:704
 msgid "select handling of signed tags"
-msgstr "w=C3=A4hlt Behandlung von signierten Tags"
+msgstr "Behandlung von signierten Tags w=C3=A4hlen"
=20
 #: builtin/fast-export.c:707
 msgid "select handling of tags that tag filtered objects"
-msgstr "w=C3=A4hlt Behandlung von Tags, die gefilterte Objekte markier=
en"
+msgstr "Behandlung von Tags w=C3=A4hlen, die gefilterte Objekte markie=
ren"
=20
 #: builtin/fast-export.c:710
 msgid "Dump marks to this file"
-msgstr "Schreibt Kennzeichen in diese Datei"
+msgstr "Kennzeichen in diese Datei schreiben"
=20
 #: builtin/fast-export.c:712
 msgid "Import marks from this file"
-msgstr "Importiert Kennzeichen von dieser Datei"
+msgstr "Kennzeichen von dieser Datei importieren"
=20
 #: builtin/fast-export.c:714
 msgid "Fake a tagger when tags lack one"
-msgstr "erzeugt k=C3=BCnstlich einen Tag-Ersteller, wenn das Tag keine=
n hat"
+msgstr "k=C3=BCnstlich einen Tag-Ersteller erzeugen, wenn das Tag kein=
en hat"
=20
 #: builtin/fast-export.c:716
 msgid "Output full tree for each commit"
-msgstr "gibt f=C3=BCr jeden Commit das gesamte Verzeichnis aus"
+msgstr "f=C3=BCr jeden Commit das gesamte Verzeichnis ausgeben"
=20
 #: builtin/fast-export.c:718
 msgid "Use the done feature to terminate the stream"
-msgstr "Benutzt die \"done\"-Funktion, um den Strom abzuschlie=C3=9Fen=
"
+msgstr "die \"done\"-Funktion benutzen, um den Datenstrom abzuschlie=C3=
=9Fen"
=20
 #: builtin/fast-export.c:719
 msgid "Skip output of blob data"
-msgstr "=C3=9Cberspringt Ausgabe von Blob-Daten"
+msgstr "Ausgabe von Blob-Daten =C3=BCberspringen"
=20
 #: builtin/fast-export.c:720
 msgid "refspec"
@@ -5083,7 +5083,7 @@ msgstr "Refspec"
=20
 #: builtin/fast-export.c:721
 msgid "Apply refspec to exported refs"
-msgstr "Wendet Refspec auf exportierte Referenzen an"
+msgstr "Refspec auf exportierte Referenzen anwenden"
=20
 #: builtin/fetch.c:20
 msgid "git fetch [<options>] [<repository> [<refspec>...]]"
@@ -5107,7 +5107,7 @@ msgstr "fordert von allen Remote-Repositories an"
=20
 #: builtin/fetch.c:92
 msgid "append to .git/FETCH_HEAD instead of overwriting"
-msgstr "h=C3=A4ngt an .git/FETCH_HEAD an, anstatt zu =C3=BCberschreibe=
n"
+msgstr "an .git/FETCH_HEAD anh=C3=A4ngen, anstatt zu =C3=BCberschreibe=
n"
=20
 #: builtin/fetch.c:94
 msgid "path to upload pack on remote end"
@@ -5115,24 +5115,24 @@ msgstr "Pfad des Programms zum Hochladen von Pa=
keten auf der Gegenseite"
=20
 #: builtin/fetch.c:95
 msgid "force overwrite of local branch"
-msgstr "erzwingt das =C3=9Cberschreiben von lokalen Branches"
+msgstr "das =C3=9Cberschreiben von lokalen Branches erzwingen"
=20
 #: builtin/fetch.c:97
 msgid "fetch from multiple remotes"
-msgstr "fordert von mehreren Remote-Repositories an"
+msgstr "von mehreren Remote-Repositories anfordern"
=20
 #: builtin/fetch.c:99
 msgid "fetch all tags and associated objects"
-msgstr "fordert alle Tags und verbundene Objekte an"
+msgstr "alle Tags und verbundene Objekte anfordern"
=20
 #: builtin/fetch.c:101
 msgid "do not fetch all tags (--no-tags)"
-msgstr "fordert nicht alle Tags an (--no-tags)"
+msgstr "nicht alle Tags anfordern (--no-tags)"
=20
 #: builtin/fetch.c:103
 msgid "prune remote-tracking branches no longer on remote"
 msgstr ""
-"entfernt Remote-Tracking-Branches, die sich nicht mehr im Remote-Repo=
sitory "
+"Remote-Tracking-Branches entfernen, die sich nicht mehr im Remote-Rep=
ository "
 "befinden"
=20
 #: builtin/fetch.c:104
@@ -5141,24 +5141,24 @@ msgstr "bei-Bedarf"
=20
 #: builtin/fetch.c:105
 msgid "control recursive fetching of submodules"
-msgstr "kontrolliert rekursive Anforderungen von Submodulen"
+msgstr "rekursive Anforderungen von Submodulen kontrollieren"
=20
 #: builtin/fetch.c:109
 msgid "keep downloaded pack"
-msgstr "beh=C3=A4lt heruntergeladenes Paket"
+msgstr "heruntergeladenes Paket behalten"
=20
 #: builtin/fetch.c:111
 msgid "allow updating of HEAD ref"
-msgstr "erlaubt Aktualisierung der \"HEAD\"-Referenz"
+msgstr "Aktualisierung der \"HEAD\"-Referenz erlauben"
=20
 #: builtin/fetch.c:114
 msgid "deepen history of shallow clone"
 msgstr ""
-"vertieft die Historie eines Klons mit unvollst=C3=A4ndiger Historie (=
shallow)"
+"die Historie eines Klons mit unvollst=C3=A4ndiger Historie (shallow) =
vertiefen"
=20
 #: builtin/fetch.c:116
 msgid "convert to a complete repository"
-msgstr "konvertiert zu einem vollst=C3=A4ndigen Repository"
+msgstr "zu einem vollst=C3=A4ndigen Repository konvertieren"
=20
 #: builtin/fetch.c:118 builtin/log.c:1205
 msgid "dir"
@@ -5166,7 +5166,7 @@ msgstr "Verzeichnis"
=20
 #: builtin/fetch.c:119
 msgid "prepend this to submodule path output"
-msgstr "stellt dies an die Ausgabe der Submodul-Pfade voran"
+msgstr "dies an die Ausgabe der Submodul-Pfade voranstellen"
=20
 #: builtin/fetch.c:122
 msgid "default mode for recursion"
@@ -5174,7 +5174,7 @@ msgstr "Standard-Modus f=C3=BCr Rekursion"
=20
 #: builtin/fetch.c:124
 msgid "accept refs that update .git/shallow"
-msgstr "akzeptiert Referenzen die .git/shallow aktualisieren"
+msgstr "Referenzen, die .git/shallow aktualisieren, akzeptieren"
=20
 #: builtin/fetch.c:125
 msgid "refmap"
@@ -5182,7 +5182,7 @@ msgstr "Refmap"
=20
 #: builtin/fetch.c:126
 msgid "specify fetch refmap"
-msgstr "Angabe der Refmap f=C3=BCr 'fetch'"
+msgstr "Refmap f=C3=BCr 'fetch' angeben"
=20
 #: builtin/fetch.c:376
 msgid "Couldn't find remote ref HEAD"
@@ -5377,7 +5377,7 @@ msgstr "Anzahl"
=20
 #: builtin/fmt-merge-msg.c:664
 msgid "populate log with at most <n> entries from shortlog"
-msgstr "f=C3=BCgt Historie mit h=C3=B6chstens <n> Eintr=C3=A4gen von \=
"shortlog\" hinzu"
+msgstr "Historie mit h=C3=B6chstens <n> Eintr=C3=A4gen von \"shortlog\=
" hinzuf=C3=BCgen"
=20
 #: builtin/fmt-merge-msg.c:667
 msgid "alias for --log (deprecated)"
@@ -5389,7 +5389,7 @@ msgstr "Text"
=20
 #: builtin/fmt-merge-msg.c:671
 msgid "use <text> as start of message"
-msgstr "verwendet <Text> als Beschreibungsanfang"
+msgstr "<Text> als Beschreibungsanfang verwenden"
=20
 #: builtin/fmt-merge-msg.c:672
 msgid "file to read from"
@@ -5401,23 +5401,23 @@ msgstr "git for-each-ref [Optionen] [<Muster>]"
=20
 #: builtin/for-each-ref.c:1066
 msgid "quote placeholders suitably for shells"
-msgstr "formatiert Platzhalter als Shell-String"
+msgstr "Platzhalter als Shell-String formatieren"
=20
 #: builtin/for-each-ref.c:1068
 msgid "quote placeholders suitably for perl"
-msgstr "formatiert Platzhalter als Perl-String"
+msgstr "Platzhalter als Perl-String formatieren"
=20
 #: builtin/for-each-ref.c:1070
 msgid "quote placeholders suitably for python"
-msgstr "formatiert Platzhalter als Python-String"
+msgstr "Platzhalter als Python-String formatieren"
=20
 #: builtin/for-each-ref.c:1072
 msgid "quote placeholders suitably for tcl"
-msgstr "formatiert Platzhalter als TCL-String"
+msgstr "Platzhalter als TCL-String formatieren"
=20
 #: builtin/for-each-ref.c:1075
 msgid "show only <n> matched refs"
-msgstr "zeigt nur <n> passende Referenzen"
+msgstr "nur <n> passende Referenzen anzeigen"
=20
 #: builtin/for-each-ref.c:1076 builtin/replace.c:435
 msgid "format"
@@ -5449,27 +5449,27 @@ msgstr "git fsck [Optionen] [<Objekt>...]"
=20
 #: builtin/fsck.c:607
 msgid "show unreachable objects"
-msgstr "zeigt unerreichbare Objekte"
+msgstr "unerreichbare Objekte anzeigen"
=20
 #: builtin/fsck.c:608
 msgid "show dangling objects"
-msgstr "zeigt unreferenzierte Objekte"
+msgstr "unreferenzierte Objekte anzeigen"
=20
 #: builtin/fsck.c:609
 msgid "report tags"
-msgstr "meldet Tags"
+msgstr "Tags melden"
=20
 #: builtin/fsck.c:610
 msgid "report root nodes"
-msgstr "meldet Hauptwurzeln"
+msgstr "Hauptwurzeln melden"
=20
 #: builtin/fsck.c:611
 msgid "make index objects head nodes"
-msgstr "pr=C3=BCft Objekte in der Staging-Area"
+msgstr "Objekte in der Staging-Area pr=C3=BCfen"
=20
 #: builtin/fsck.c:612
 msgid "make reflogs head nodes (default)"
-msgstr "pr=C3=BCft die Reflogs (Standard)"
+msgstr "die Reflogs pr=C3=BCfen (Standard)"
=20
 #: builtin/fsck.c:613
 msgid "also consider packs and alternate objects"
@@ -5477,15 +5477,15 @@ msgstr ""
=20
 #: builtin/fsck.c:614
 msgid "enable more strict checking"
-msgstr "aktiviert genauere Pr=C3=BCfung"
+msgstr "genauere Pr=C3=BCfung aktivieren"
=20
 #: builtin/fsck.c:616
 msgid "write dangling objects in .git/lost-found"
-msgstr "schreibt unreferenzierte Objekte nach .git/lost-found"
+msgstr "unreferenzierte Objekte nach .git/lost-found schreiben"
=20
 #: builtin/fsck.c:617 builtin/prune.c:144
 msgid "show progress"
-msgstr "zeigt Fortschrittsanzeige"
+msgstr "Fortschrittsanzeige anzeigen"
=20
 #: builtin/fsck.c:667
 msgid "Checking objects"
@@ -5507,7 +5507,7 @@ msgstr "zu langes Objekt-Verzeichnis %.*s"
=20
 #: builtin/gc.c:287
 msgid "prune unreferenced objects"
-msgstr "entfernt unreferenzierte Objekte"
+msgstr "unreferenzierte Objekte entfernen"
=20
 #: builtin/gc.c:289
 msgid "be more thorough (increased runtime)"
@@ -5515,12 +5515,12 @@ msgstr "mehr Gr=C3=BCndlichkeit (erh=C3=B6ht La=
ufzeit)"
=20
 #: builtin/gc.c:290
 msgid "enable auto-gc mode"
-msgstr "aktiviert \"auto-gc\" Modus"
+msgstr "\"auto-gc\" Modus aktivieren"
=20
 #: builtin/gc.c:291
 msgid "force running gc even if there may be another gc running"
 msgstr ""
-"erzwingt Ausf=C3=BChrung von \"git gc\" selbst wenn ein anderes\n"
+"Ausf=C3=BChrung von \"git gc\" erwzingen, selbst wenn ein anderes\n"
 "\"git gc\" bereits ausgef=C3=BChrt wird"
=20
 #: builtin/gc.c:332
--=20
2.2.0.rc0.232.g8ec773f
