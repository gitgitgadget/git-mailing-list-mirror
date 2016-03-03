From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 48 new messages
Date: Thu,  3 Mar 2016 20:20:26 +0100
Message-ID: <1457032826-1070-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 20:20:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abYnk-0004vt-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 20:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbcCCTUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2016 14:20:39 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36115 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbcCCTUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 14:20:38 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so4237886wmn.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 11:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PD18J0St2X13ZK5gLFAYrnJBb7TUXf68esKDFvf7RM=;
        b=q1HoLGiYjJUgmnB/BJrpxYaqkGzlsB89TaLMgzT3g7XS9Yfo6oEK4I1xthDW1oUG2+
         JOo2lqnyvMbzepLasr5T2RQ/MvAh7yK/iE47Hn9+aznxGsjMcaXUyAPiT0WkudeBvE0l
         B372lS//uWlEadVLpLb07M7W+TFEWcPq8yw7kDw8HthQL62TYmXH3hp5AaIC4A0QDCar
         SFYwzAC5NEPC9rsmQBNGTzvCJrjTAzQLPJf4RCqMjSRGRmECTFyVL58SMiBEL954dWvz
         MNSf1lkIxjkfzhsFe8It3a2A/430MVe36RA7MU3KrLyq0G6pi5Wz0hzNXU7xHYSqyJ3P
         5H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PD18J0St2X13ZK5gLFAYrnJBb7TUXf68esKDFvf7RM=;
        b=LmpDWAwRCwMGqcBcleJQkvI9kklqDDEXwAcw9Qr6ICQPGCV4DxE5bvAjaeoR9QQJrZ
         wUSnWGg+QbmU4RDgoDR1PQAInf8dszjdmCeU0yP71NLyCi1FAafQlDwQe1CjLmT7yBBa
         ipezUpxUwrpkRP0objbc6xuh1rQiu1ZndBw4xzajY4JMs3gMfT2MsG7eUwSkS/xcPEdw
         qoTZaqUlR/Vy2iAGlEARUWniYU6zviXNqk+7X+s3Z/47b3W1SrhZ403/9CGMZdQhnTnW
         uk3NIRGRdqiTv5WPQ0C5mjF4ya/B+65uxX0II1GndHaHAnD61u3mpQIBjrpFjFxdNTkd
         IDJA==
X-Gm-Message-State: AD7BkJIU2bmjRPYZ7p49WzyrccizMeeLdCo33GtlC4ENDUoOd51sYCEqZryw4QQT0F12pw==
X-Received: by 10.194.95.73 with SMTP id di9mr5125453wjb.152.1457032837005;
        Thu, 03 Mar 2016 11:20:37 -0800 (PST)
Received: from localhost (cable-86-56-25-49.cust.telecolumbus.net. [86.56.25.49])
        by smtp.gmail.com with ESMTPSA id ls5sm41826093wjb.33.2016.03.03.11.20.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 11:20:36 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.159.g391b917
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288206>

Translate 48 new messages came from git.pot update in
9eb3984 (l10n: git.pot: v2.8.0 round 1 (48 new, 16 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 144 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/po/de.po b/po/de.po
index 24ce2b7..e53e438 100644
--- a/po/de.po
+++ b/po/de.po
@@ -149,10 +149,15 @@ msgid ""
 "\n"
 "After fixing the error cause you may try to fix up\n"
 "the remote tracking information by invoking\n"
 "\"git branch --set-upstream-to=3D%s%s%s\"."
 msgstr ""
+"\n"
+"Nachdem Sie die Fehlerursache behoben haben, k=C3=B6nnen Sie\n"
+"die Tracking-Informationen mit"
+"\"git branch --set-upstream-to=3D%s%s%s\""
+"erneut setzen."
=20
 #: branch.c:67
 #, c-format
 msgid "Not setting branch %s as its own upstream."
 msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
@@ -199,11 +204,11 @@ msgstr ""
 msgid "Branch %s set up to track local ref %s."
 msgstr "Branch %s konfiguriert zum Folgen von lokaler Referenz %s."
=20
 #: branch.c:119
 msgid "Unable to write upstream branch configuration"
-msgstr ""
+msgstr "Konnte Konfiguration zu Upstream-Branch nicht schreiben."
=20
 #: branch.c:156
 #, c-format
 msgid "Not tracking: ambiguous information for ref %s"
 msgstr ""
@@ -375,18 +380,18 @@ msgstr "%s %s ist kein Commit!"
 #: compat/obstack.c:406 compat/obstack.c:408
 msgid "memory exhausted"
 msgstr "Speicher verbraucht"
=20
 #: config.c:475 config.c:477
-#, fuzzy, c-format
+#, c-format
 msgid "bad config line %d in %s %s"
-msgstr "Zeile %d in Konfigurationsdatei %s ist ung=C3=BCltig."
+msgstr "Zeile %d in Konfiguration %s %s ist ung=C3=BCltig."
=20
 #: config.c:593
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s' in %s %s: %s"
-msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s' in %s: %s"
+msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s' in %s %s: %s"
=20
 #: config.c:595
 #, c-format
 msgid "bad numeric config value '%s' for '%s': %s"
 msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s': %s"
@@ -432,13 +437,13 @@ msgstr "ung=C3=BCltige Konfigurationsvariable '%s=
' in Datei '%s' bei Zeile %d"
 #, c-format
 msgid "%s has multiple values"
 msgstr "%s hat mehrere Werte"
=20
 #: config.c:2226
-#, fuzzy, c-format
+#, c-format
 msgid "Could not set '%s' to '%s'"
-msgstr "Konnte '%s' nicht an '%s' anh=C3=A4ngen."
+msgstr "Konnte '%s' nicht zu '%s' setzen."
=20
 #: connected.c:69
 msgid "Could not run 'git rev-list'"
 msgstr "Konnte 'git rev-list' nicht ausf=C3=BChren"
=20
@@ -580,13 +585,13 @@ msgstr "Fehler beim Parsen des --submodule Option=
sparameters: '%s'"
 #: dir.c:2004
 msgid "failed to get kernel name and information"
 msgstr "Fehler beim Sammeln von Namen und Informationen zum Kernel"
=20
 #: dir.c:2123
-#, fuzzy
 msgid "Untracked cache is disabled on this system or location."
-msgstr "Cache f=C3=BCr unversionierte Dateien ist auf diesem System de=
aktiviert."
+msgstr "Cache f=C3=BCr unversionierte Dateien ist auf diesem System od=
er\n"
+"f=C3=BCr dieses Verzeichnis deaktiviert."
=20
 #: gpg-interface.c:166 gpg-interface.c:237
 msgid "could not run gpg."
 msgstr "konnte gpg nicht ausf=C3=BChren"
=20
@@ -1133,53 +1138,53 @@ msgstr "Konnte Referenz %s nicht l=C3=B6schen"
 #, c-format
 msgid "expected format: %%(color:<color>)"
 msgstr "Erwartetes Format: %%(color:<Farbe>)"
=20
 #: ref-filter.c:57
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized color: %%(color:%s)"
-msgstr "nicht erkannter Kopfbereich: %s%s (%d)"
+msgstr "nicht erkannte Farbe: %%(color:%s)"
=20
 #: ref-filter.c:71
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized format: %%(%s)"
-msgstr "nicht erkanntes Hilfeformat: %s"
+msgstr "nicht erkanntes Format: %%(%s)"
=20
 #: ref-filter.c:101
 #, c-format
 msgid "positive value expected contents:lines=3D%s"
 msgstr "Positiver Wert erwartet contents:lines=3D%s"
=20
 #: ref-filter.c:103
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(contents) argument: %s"
-msgstr "nicht erkanntes Argument: %s"
+msgstr "nicht erkanntes %%(contents) Argument: %s"
=20
 #: ref-filter.c:113
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(objectname) argument: %s"
-msgstr "nicht erkanntes Argument: %s"
+msgstr "nicht erkanntes %%(objectname) Argument: %s"
=20
 #: ref-filter.c:135
 #, c-format
 msgid "expected format: %%(align:<width>,<position>)"
 msgstr "Erwartetes Format: %%(align:<Breite>,<Position>)"
=20
 #: ref-filter.c:147
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized position:%s"
-msgstr "nicht erkannte Eingabe"
+msgstr "nicht erkannte Position:%s"
=20
 #: ref-filter.c:151
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized width:%s"
-msgstr "nicht erkannte Eingabe"
+msgstr "nicht erkannte Breite:%s"
=20
 #: ref-filter.c:157
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(align) argument: %s"
-msgstr "nicht erkanntes Argument: %s"
+msgstr "nicht erkanntes %%(align) Argument: %s"
=20
 #: ref-filter.c:161
 #, c-format
 msgid "positive width expected with the %%(align) atom"
 msgstr "Positive Breitenangabe f=C3=BCr %%(align) erwartet"
@@ -1693,28 +1698,27 @@ msgstr "konnte nicht von der Standard-Eingabe l=
esen"
 #, c-format
 msgid "could not stat %s"
 msgstr "Konnte '%s' nicht lesen"
=20
 #: trailer.c:859
-#, fuzzy, c-format
+#, c-format
 msgid "file %s is not a regular file"
-msgstr "'%s': keine regul=C3=A4re Datei oder symbolische Verkn=C3=BCpf=
ung"
+msgstr "Datei '%s' ist keine regul=C3=A4re Datei"
=20
 #: trailer.c:861
 #, c-format
 msgid "file %s is not writable by user"
-msgstr ""
+msgstr "Datei %s ist vom Benutzer nicht beschreibbar."
=20
 #: trailer.c:873
-#, fuzzy
 msgid "could not open temporary file"
-msgstr "konnte tempor=C3=A4re Datei '%s' nicht erstellen: %s"
+msgstr "konnte tempor=C3=A4re Datei '%s' nicht =C3=B6ffnen"
=20
 #: trailer.c:912
-#, fuzzy, c-format
+#, c-format
 msgid "could not rename temporary file to %s"
-msgstr "konnte tempor=C3=A4re Datei '%s' nicht erstellen: %s"
+msgstr "konnte tempor=C3=A4re Datei nicht zu %s umbenennen"
=20
 #: transport-helper.c:1041
 #, c-format
 msgid "Could not read ref %s"
 msgstr "Konnte Referenz %s nicht lesen."
@@ -3415,11 +3419,11 @@ msgstr "git blame [<Optionen>] [<rev-opts>] [<C=
ommit>] [--] <Datei>"
 msgid "<rev-opts> are documented in git-rev-list(1)"
 msgstr "<rev-opts> sind dokumentiert in git-rev-list(1)"
=20
 #: builtin/blame.c:1782
 msgid "Blaming lines"
-msgstr ""
+msgstr "Verarbeite Zeilen"
=20
 #: builtin/blame.c:2530
 msgid "Show blame entries as we find them, incrementally"
 msgstr "\"blame\"-Eintr=C3=A4ge schrittweise anzeigen, w=C3=A4hrend wi=
r sie generieren"
=20
@@ -3434,11 +3438,10 @@ msgstr "Ursprungs-Commit nicht als Grenzen beha=
ndeln (Standard: aus)"
 #: builtin/blame.c:2533
 msgid "Show work cost statistics"
 msgstr "Statistiken zum Arbeitsaufwand anzeigen"
=20
 #: builtin/blame.c:2534
-#, fuzzy
 msgid "Force progress reporting"
 msgstr "Fortschrittsanzeige erzwingen"
=20
 #: builtin/blame.c:2535
 msgid "Show output score for blame entries"
@@ -4112,11 +4115,11 @@ msgstr "keine Kontakte angegeben"
 msgid "git checkout-index [<options>] [--] [<file>...]"
 msgstr "git checkout-index [<Optionen>] [--] [<Datei>...]"
=20
 #: builtin/checkout-index.c:144
 msgid "stage should be between 1 and 3 or all"
-msgstr ""
+msgstr "--stage sollte zwischen 1 und 3 oder 'all' sein"
=20
 #: builtin/checkout-index.c:160
 msgid "check out all files in the index"
 msgstr "alle Dateien im Index auschecken"
=20
@@ -4761,15 +4764,15 @@ msgstr "Schl=C3=BCssel=3DWert"
 msgid "set config inside the new repository"
 msgstr "Konfiguration innerhalb des neuen Repositories setzen"
=20
 #: builtin/clone.c:96 builtin/fetch.c:131 builtin/push.c:536
 msgid "use IPv4 addresses only"
-msgstr ""
+msgstr "nur IPv4-Adressen benutzen"
=20
 #: builtin/clone.c:98 builtin/fetch.c:133 builtin/push.c:538
 msgid "use IPv6 addresses only"
-msgstr ""
+msgstr "nur IPv6-Adressen benutzen"
=20
 #: builtin/clone.c:305
 #, c-format
 msgid "reference repository '%s' as a linked checkout is not supported=
 yet."
 msgstr ""
@@ -5738,11 +5741,11 @@ msgstr "nur Variablennamen anzeigen"
 msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
=20
 #: builtin/config.c:86
 msgid "show origin of config (file, standard input, blob, command line=
)"
-msgstr ""
+msgstr "Ursprung der Konfiguration anzeigen (Datei, Standard-Eingabe, =
Blob, Befehlszeile)"
=20
 #: builtin/config.c:328
 msgid "unable to parse default color value"
 msgstr "konnte Standard-Farbwert nicht parsen"
=20
@@ -6041,11 +6044,11 @@ msgstr "alle Tags und verbundene Objekte anford=
ern"
 msgid "do not fetch all tags (--no-tags)"
 msgstr "nicht alle Tags anfordern (--no-tags)"
=20
 #: builtin/fetch.c:105
 msgid "number of submodules fetched in parallel"
-msgstr ""
+msgstr "Anzahl der parallel anzufordernden Submodule"
=20
 #: builtin/fetch.c:107 builtin/pull.c:179
 msgid "prune remote-tracking branches no longer on remote"
 msgstr ""
 "Remote-Tracking-Branches entfernen, die sich nicht mehr im Remote-Rep=
ository "
@@ -6512,13 +6515,13 @@ msgstr "git grep [<Optionen>] [-e] <Muster> [<C=
ommit>...] [[--] <Pfad>...]"
 #, c-format
 msgid "grep: failed to create thread: %s"
 msgstr "grep: Fehler beim Erzeugen eines Thread: %s"
=20
 #: builtin/grep.c:277
-#, fuzzy, c-format
+#, c-format
 msgid "invalid number of threads specified (%d) for %s"
-msgstr "ung=C3=BCltige Anzahl von Threads angegeben (%d)"
+msgstr "ung=C3=BCltige Anzahl von Threads (%d) f=C3=BCr %s angegeben"
=20
 #: builtin/grep.c:452 builtin/grep.c:487
 #, c-format
 msgid "unable to read tree (%s)"
 msgstr "konnte \"Tree\"-Objekt (%s) nicht lesen"
@@ -6661,11 +6664,11 @@ msgstr "<n> Zeilen vor den =C3=9Cbereinstimmung=
en anzeigen"
 msgid "show <n> context lines after matches"
 msgstr "<n> Zeilen nach den =C3=9Cbereinstimmungen anzeigen"
=20
 #: builtin/grep.c:712
 msgid "use <n> worker threads"
-msgstr ""
+msgstr "<n> Threads benutzen"
=20
 #: builtin/grep.c:713
 msgid "shortcut for -C NUM"
 msgstr "Kurzform f=C3=BCr -C NUM"
=20
@@ -7321,22 +7324,20 @@ msgstr ""
 #, c-format
 msgid "Cannot access work tree '%s'"
 msgstr "Kann nicht auf Arbeitsverzeichnis '%s' zugreifen."
=20
 #: builtin/interpret-trailers.c:15
-#, fuzzy
 msgid ""
 "git interpret-trailers [--in-place] [--trim-empty] [(--trailer "
 "<token>[(=3D|:)<value>])...] [<file>...]"
 msgstr ""
-"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<Wer=
t>])...] "
-"[<Datei>...]"
+"git interpret-trailers [--in-place] [--trim-empty] [(--trailer "
+"<Token>[(=3D|:)<Wert>])...] [<Datei>...]"
=20
 #: builtin/interpret-trailers.c:26
-#, fuzzy
 msgid "edit files in place"
-msgstr "Hinzuf=C3=BCgen von Dateien fehlgeschlagen"
+msgstr "vorhandene Dateien direkt bearbeiten"
=20
 #: builtin/interpret-trailers.c:27
 msgid "trim empty trailers"
 msgstr "k=C3=BCrzt leere Anh=C3=A4nge"
=20
@@ -7348,11 +7349,11 @@ msgstr "Anhang"
 msgid "trailer(s) to add"
 msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
=20
 #: builtin/interpret-trailers.c:42
 msgid "no input file given for in-place editing"
-msgstr ""
+msgstr "keine Datei zur direkten Bearbeitung angegeben"
=20
 #: builtin/log.c:43
 msgid "git log [<options>] [<revision-range>] [[--] <path>...]"
 msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
=20
@@ -7683,13 +7684,12 @@ msgstr "Dateien im Dateisystem, die gel=C3=B6sc=
ht werden m=C3=BCssen, anzeigen"
 #: builtin/ls-files.c:446
 msgid "show 'other' directories' names only"
 msgstr "nur Namen von 'sonstigen' Verzeichnissen anzeigen"
=20
 #: builtin/ls-files.c:448
-#, fuzzy
 msgid "show line endings of files"
-msgstr "ignorierte Dateien anzeigen"
+msgstr "Zeilenenden von Dateien anzeigen"
=20
 #: builtin/ls-files.c:450
 msgid "don't show empty directories"
 msgstr "keine leeren Verzeichnisse anzeigen"
=20
@@ -7743,49 +7743,50 @@ msgstr "Ausgaben zur Fehlersuche anzeigen"
 msgid ""
 "git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]\n"
 "                     [-q | --quiet] [--exit-code] [--get-url]\n"
 "                     [--symref] [<repository> [<refs>...]]"
 msgstr ""
+"git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<Programm>=
]\n"
+"                     [-q | --quiet] [--exit-code] [--get-url]\n"
+"                     [--symref] [<Repository> [<Referenzen>...]]"
=20
 #: builtin/ls-remote.c:50
-#, fuzzy
 msgid "do not print remote URL"
-msgstr "keine Abfrage von Remote-Repositories"
+msgstr "URL des Remote-Repositories nicht ausgeben"
=20
 #: builtin/ls-remote.c:51 builtin/ls-remote.c:53
 msgid "exec"
-msgstr ""
+msgstr "Programm"
=20
 #: builtin/ls-remote.c:52 builtin/ls-remote.c:54
-#, fuzzy
 msgid "path of git-upload-pack on the remote host"
 msgstr "Pfad zu \"git-upload-pack\" auf der Gegenseite"
=20
 #: builtin/ls-remote.c:56
 msgid "limit to tags"
-msgstr ""
+msgstr "auf Tags einschr=C3=A4nken"
=20
 #: builtin/ls-remote.c:57
 msgid "limit to heads"
-msgstr ""
+msgstr "auf Branches einschr=C3=A4nken"
=20
 #: builtin/ls-remote.c:58
-#, fuzzy
 msgid "do not show peeled tags"
-msgstr "keine Fortschrittsanzeige anzeigen"
+msgstr "keine Tags anzeigen, die andere Tags enthalten"
=20
 #: builtin/ls-remote.c:60
 msgid "take url.<base>.insteadOf into account"
-msgstr ""
+msgstr "url.<Basis>.insteadOf ber=C3=BCcksichtigen"
=20
 #: builtin/ls-remote.c:62
 msgid "exit with exit code 2 if no matching refs are found"
-msgstr ""
+msgstr "mit R=C3=BCckkehrwert 2 beenden, wenn keine =C3=BCbereinstimme=
nden Referenzen\n"
+"gefunden wurden"
=20
 #: builtin/ls-remote.c:64
 msgid "show underlying ref in addition to the object pointed by it"
-msgstr ""
+msgstr "zus=C3=A4tzlich die auf durch dieses Objekt verwiesene Referen=
zen anzeigen"
=20
 #: builtin/ls-tree.c:28
 msgid "git ls-tree [<options>] <tree-ish> [<path>...]"
 msgstr "git ls-tree [<Optionen>] <Commit-Referenz> [<Pfad>...]"
=20
@@ -9003,11 +9004,11 @@ msgstr "den genannten Commit auf eine g=C3=BClt=
ige GPG-Signatur =C3=BCberpr=C3=BCfen"
 msgid "Options related to fetching"
 msgstr "Optionen bezogen auf Fetch"
=20
 #: builtin/pull.c:186
 msgid "number of submodules pulled in parallel"
-msgstr ""
+msgstr "Anzahl der parallel mit 'pull' zu verarbeitenden Submodule"
=20
 #: builtin/pull.c:275
 #, c-format
 msgid "Invalid value for pull.ff: %s"
 msgstr "Ung=C3=BCltiger Wert f=C3=BCr pull.ff: %s"
@@ -9774,13 +9775,13 @@ msgstr " ???"
 #, c-format
 msgid "invalid branch.%s.merge; cannot rebase onto > 1 branch"
 msgstr "ung=C3=BCltiges branch.%s.merge; kann Rebase nicht auf > 1 Bra=
nch ausf=C3=BChren"
=20
 #: builtin/remote.c:967
-#, fuzzy, c-format
+#, c-format
 msgid "rebases interactively onto remote %s"
-msgstr "Rebase auf Remote-Branch %s"
+msgstr "interaktiver Rebase auf Remote-Branch %s"
=20
 #: builtin/remote.c:971
 #, c-format
 msgid " merges with remote %s"
 msgstr " f=C3=BChrt mit Remote-Branch %s zusammen"
@@ -10756,13 +10757,12 @@ msgid "skip and remove all lines starting wit=
h comment character"
 msgstr ""
 "alle Zeilen, die mit dem Kommentarzeichen beginnen, =C3=BCberspringen=
 und "
 "entfernen"
=20
 #: builtin/stripspace.c:38
-#, fuzzy
 msgid "prepend comment character and space to each line"
-msgstr "Kommentarzeichen mit Leerzeichen an jeder Zeile voranstellen"
+msgstr "Kommentarzeichen mit Leerzeichen an jede Zeile voranstellen"
=20
 #: builtin/submodule--helper.c:73 builtin/submodule--helper.c:161
 msgid "alternative anchor for relative paths"
 msgstr "Alternativer Anker f=C3=BCr relative Pfade"
=20
@@ -11103,13 +11103,13 @@ msgstr "Konnte Datei '%s' nicht l=C3=B6schen"
 #, c-format
 msgid "failed to delete directory %s"
 msgstr "Konnte Verzeichnis '%s' nicht l=C3=B6schen"
=20
 #: builtin/update-index.c:133
-#, fuzzy, c-format
+#, c-format
 msgid "Testing mtime in '%s' "
-msgstr "schlie=C3=9Fe Datei '%s'"
+msgstr "Pr=C3=BCfe mtime in '%s' "
=20
 #: builtin/update-index.c:145
 msgid "directory stat info does not change after adding a new file"
 msgstr ""
 "Verzeichnisinformationen haben sich nach Hinzuf=C3=BCgen einer neuen =
Datei nicht "
@@ -11274,26 +11274,25 @@ msgstr "Splitting des Index aktivieren oder d=
eaktivieren"
 msgid "enable/disable untracked cache"
 msgstr "Cache f=C3=BCr unversionierte Dateien aktivieren oder deaktivi=
eren"
=20
 #: builtin/update-index.c:1012
 msgid "test if the filesystem supports untracked cache"
-msgstr ""
+msgstr "pr=C3=BCfen ob das Dateisystem einen Cache f=C3=BCr unversioni=
erte Dateien unterst=C3=BCtzt"
=20
 #: builtin/update-index.c:1014
 msgid "enable untracked cache without testing the filesystem"
 msgstr ""
 "Cache f=C3=BCr unversionierte Dateien ohne Pr=C3=BCfung des Dateisyst=
ems aktivieren"
=20
 #: builtin/update-index.c:1134
-#, fuzzy
 msgid "Untracked cache disabled"
-msgstr "Cache f=C3=BCr unversionierte Dateien ist auf diesem System de=
aktiviert."
+msgstr "Cache f=C3=BCr unversionierte Dateien deaktiviert"
=20
 #: builtin/update-index.c:1146
-#, fuzzy, c-format
+#, c-format
 msgid "Untracked cache enabled for '%s'"
-msgstr "Cache f=C3=BCr unversionierte Dateien ist auf diesem System de=
aktiviert."
+msgstr "Cache f=C3=BCr unversionierte Dateien f=C3=BCr '%s' aktiviert"
=20
 #: builtin/update-ref.c:9
 msgid "git update-ref [<options>] -d <refname> [<old-val>]"
 msgstr "git update-ref [<Optionen>] -d <Referenzname> [<alter-Wert>]"
=20
@@ -11472,11 +11471,12 @@ msgstr ""
 "oder 'git help <Konzept>', um mehr =C3=BCber einen spezifischen Befeh=
l oder\n"
 "Konzept zu erfahren."
=20
 #: http.c:320
 msgid "Public key pinning not supported with cURL < 7.44.0"
-msgstr ""
+msgstr "Das Anheften des =C3=B6ffentlichen Schl=C3=BCssels wird mit cU=
RL < 7.44.0\n"
+"nicht unterst=C3=BCtzt."
=20
 #: common-cmds.h:9
 msgid "start a working area (see also: git help tutorial)"
 msgstr "Arbeitsverzeichnis anlegen (siehe auch: git help tutorial)"
=20
--=20
2.8.0.rc0.159.g391b917
