From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 104 new messages
Date: Fri,  3 Jun 2016 19:17:23 +0200
Message-ID: <20160603171723.24177-1-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 19:18:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sjK-0002Xm-PN
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbcFCRRu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 13:17:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34401 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbcFCRRs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:17:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so848219wmn.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/A9+kh1SDlplAxcs1CvHHjwlp97KTTmleI0uXQwZpY=;
        b=YBPLT9zc0C/2EiLHfhAuzQntIspUjRZtn1jZoN4B9E3z+7OQcwom2I5aMxJV638p3E
         3iKKU7mgWOuqEDSaEVq1BDe8P7OOwx83djoLGBvJHqqSquw43FxyQfXFovtlijUbrbNG
         bPq8ueNkQqVf8jxN4GxHVCrUc7zGTLKFLkvnpF9bYFFBnBlm1GThxYNIDIp0BKgBtSN8
         6qHnDxvHFcBp6UiM+6X3uj1r8kiLTYWaUBcGLBUIGAHd7fJdA4lsvCtfvFDAGIXiC4us
         5/inxc2fo4N9Q88xTFrS0KDXOHx/BL9JGJSPRkjZn7V/c0KMlrY/+icjDJ6kurRQabk2
         cQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/A9+kh1SDlplAxcs1CvHHjwlp97KTTmleI0uXQwZpY=;
        b=mBis6f6wrMBPl1Z4Gcop3uvNvGnRCrQ8TvU6P/irNXCPzfAW22XB6fFXjUjajPVyeZ
         b73f6bAlobrRpg87PRSyUyVXayglvzxfFDmhGa0jA8XsjzSL101bFTrmphhU28+NvSut
         WHx4/BQeuHt6a4skI+O6cHlzLAKWgOIc78qp16OhwV13MvCavSruA0W5wVwcTyzDOyrG
         57MuBwmqd51snmjFBvgHPp1Sgh0CSVNIJ8qpxK/Q3NFTIj3Ql5oZ7N29SwN+ZZKkxaPN
         ekcJ0QdprzHh5VSBu/1g1uNUyYGVO08U0IFKb+rGG+6FBQBzs4P3hSokg4U33AtxcWJ2
         TymQ==
X-Gm-Message-State: ALyK8tIVec1XX0DsUNSYh8BUMpg67q+sqOjFBdXsXiW29bH43kcsKUOT3EjkjhwxgPkWMA==
X-Received: by 10.194.173.132 with SMTP id bk4mr4892402wjc.92.1464974265132;
        Fri, 03 Jun 2016 10:17:45 -0700 (PDT)
Received: from localhost (cable-86-56-50-4.cust.telecolumbus.net. [86.56.50.4])
        by smtp.gmail.com with ESMTPSA id i190sm515275wmf.10.2016.06.03.10.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 10:17:44 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.255.g8a191e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296355>

Translate 104 new messages came from git.pot update in f517e50
(l10n: git.pot: v2.9.0 round 1 (104 new, 37 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 413 ++++++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 212 insertions(+), 201 deletions(-)

diff --git a/po/de.po b/po/de.po
index 7422a8b..d50cb1b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -279,19 +279,19 @@ msgid "Not a valid branch point: '%s'."
 msgstr "Ung=C3=BCltiger Branchpunkt: '%s'"
=20
 #: branch.c:345
 #, c-format
 msgid "'%s' is already checked out at '%s'"
 msgstr "'%s' ist bereits in '%s' ausgecheckt"
=20
 #: branch.c:364
-#, fuzzy, c-format
+#, c-format
 msgid "HEAD of working tree %s is not updated"
-msgstr "Kann Zustand des Arbeitsverzeichnisses nicht aufzeichnen"
+msgstr "HEAD des Arbeitsverzeichnisses %s ist nicht aktualisiert."
=20
 #: bundle.c:34
 #, c-format
 msgid "'%s' does not look like a v2 bundle file"
 msgstr "'%s' sieht nicht wie eine v2 Paketdatei aus"
=20
 #: bundle.c:61
 #, c-format
@@ -440,38 +440,36 @@ msgid "bad config variable '%s' in file '%s' at l=
ine %d"
 msgstr "ung=C3=BCltige Konfigurationsvariable '%s' in Datei '%s' bei Z=
eile %d"
=20
 #: config.c:1690
 #, c-format
 msgid "%s has multiple values"
 msgstr "%s hat mehrere Werte"
=20
 #: config.c:2224
-#, fuzzy, c-format
+#, c-format
 msgid "could not set '%s' to '%s'"
 msgstr "Konnte '%s' nicht zu '%s' setzen."
=20
 #: config.c:2226
-#, fuzzy, c-format
+#, c-format
 msgid "could not unset '%s'"
-msgstr "Konnte '%s' nicht setzen"
+msgstr "Konnte '%s' nicht aufheben."
=20
 #: connected.c:69
 msgid "Could not run 'git rev-list'"
 msgstr "Konnte 'git rev-list' nicht ausf=C3=BChren"
=20
 #: connected.c:89
-#, fuzzy
 msgid "failed write to rev-list"
-msgstr "Fehler beim Schreiben nach rev-list: %s"
+msgstr "Fehler beim Schreiben nach rev-list"
=20
 #: connected.c:96
-#, fuzzy
 msgid "failed to close rev-list's stdin"
-msgstr "Fehler beim Schlie=C3=9Fen von rev-list's Standard-Eingabe: %s=
"
+msgstr "Fehler beim Schlie=C3=9Fen von rev-list's Standard-Eingabe"
=20
 #: date.c:95
 msgid "in the future"
 msgstr "in der Zukunft"
=20
 #: date.c:101
 #, c-format
 msgid "%lu second ago"
@@ -611,39 +609,39 @@ msgstr "konnte gpg nicht ausf=C3=BChren"
 msgid "gpg did not accept the data"
 msgstr "gpg hat die Daten nicht akzeptiert"
=20
 #: gpg-interface.c:189
 msgid "gpg failed to sign the data"
 msgstr "gpg beim Signieren der Daten fehlgeschlagen"
=20
 #: gpg-interface.c:222
-#, fuzzy, c-format
+#, c-format
 msgid "could not create temporary file '%s'"
-msgstr "konnte tempor=C3=A4re Datei '%s' nicht erstellen: %s"
+msgstr "konnte tempor=C3=A4re Datei '%s' nicht erstellen"
=20
 #: gpg-interface.c:224
-#, fuzzy, c-format
+#, c-format
 msgid "failed writing detached signature to '%s'"
-msgstr "Fehler beim Schreiben der Signatur nach '%s': %s"
+msgstr "Fehler beim Schreiben der losgel=C3=B6sten Signatur nach '%s'"
=20
 #: grep.c:1718
 #, c-format
 msgid "'%s': unable to read %s"
 msgstr "'%s': konnte %s nicht lesen"
=20
 #: grep.c:1735 builtin/clone.c:382 builtin/diff.c:84 builtin/rm.c:155
 #, c-format
 msgid "failed to stat '%s'"
 msgstr "Konnte '%s' nicht lesen"
=20
 #: grep.c:1746
-#, fuzzy, c-format
+#, c-format
 msgid "'%s': short read"
-msgstr "'%s': read() zu kurz %s"
+msgstr "'%s': read() zu kurz"
=20
 #: help.c:205
 #, c-format
 msgid "available git commands in '%s'"
 msgstr "Vorhandene Git-Befehle in '%s'"
=20
 #: help.c:212
 msgid "git commands available from elsewhere on your $PATH"
@@ -710,21 +708,29 @@ msgid ""
 "Unable to create '%s.lock': %s.\n"
 "\n"
 "Another git process seems to be running in this repository, e.g.\n"
 "an editor opened by 'git commit'. Please make sure all processes\n"
 "are terminated then try again. If it still fails, a git process\n"
 "may have crashed in this repository earlier:\n"
 "remove the file manually to continue."
 msgstr ""
+"Konnte '%s.lock' nicht erstellen: %s.\n"
+"\n"
+"Ein anderer Git-Prozess scheint in diesem Repository ausgef=C3=BChrt\=
n"
+"zu werden, zum Beispiel ein noch offener Editor von 'git commit'.\n"
+"Bitte stellen Sie sicher, dass alle Prozesse beendet wurden und\n"
+"versuchen Sie es erneut. Falls es immer noch fehlschl=C3=A4gt, k=C3=B6=
nnte\n"
+"ein fr=C3=BCherer Git-Prozess in diesem Repository abgest=C3=BCrzt se=
in:\n"
+"L=C3=B6schen Sie die Datei manuell um fortzufahren."
=20
 #: lockfile.c:160
-#, fuzzy, c-format
+#, c-format
 msgid "Unable to create '%s.lock': %s"
-msgstr "konnte '%s' nicht erstellen"
+msgstr "Konnte '%s.lock' nicht erstellen: %s"
=20
 #: merge.c:41
 msgid "failed to read the cache"
 msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
=20
 #: merge.c:94 builtin/am.c:2007 builtin/am.c:2042 builtin/checkout.c:3=
75
 #: builtin/checkout.c:586 builtin/clone.c:732
 msgid "unable to write new index file"
@@ -1490,22 +1496,21 @@ msgstr "Konnte nicht nach %s schreiben"
=20
 #: sequencer.c:193
 #, c-format
 msgid "Error wrapping up %s"
 msgstr "Fehler bei Nachbereitung von %s"
=20
 #: sequencer.c:208
 msgid "Your local changes would be overwritten by cherry-pick."
-msgstr ""
-"Ihre lokalen =C3=84nderungen w=C3=BCrden von \"cherry-pick\" =C3=BCbe=
rschrieben werden."
+msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden durch den Cherry-Pick=
 =C3=BCberschrieben werden."
=20
 #: sequencer.c:210
 msgid "Your local changes would be overwritten by revert."
-msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden von \"revert\" =C3=BC=
berschrieben werden."
+msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden durch den Revert =C3=BC=
berschrieben werden."
=20
 #: sequencer.c:213
 msgid "Commit your changes or stash them to proceed."
 msgstr ""
 "Committen Sie Ihre =C3=84nderungen oder benutzen Sie \"stash\", um fo=
rtzufahren."
=20
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: sequencer.c:300
@@ -1656,17 +1661,17 @@ msgstr "kein \"cherry-pick\" oder \"revert\" im=
 Gang"
 msgid "cannot resolve HEAD"
 msgstr "kann HEAD nicht aufl=C3=B6sen"
=20
 #: sequencer.c:858
 msgid "cannot abort from a branch yet to be born"
 msgstr "kann nicht abbrechen: bin auf einem Branch, der noch geboren w=
ird"
=20
 #: sequencer.c:878 builtin/fetch.c:610 builtin/fetch.c:851
-#, fuzzy, c-format
+#, c-format
 msgid "cannot open %s"
 msgstr "kann '%s' nicht =C3=B6ffnen"
=20
 #: sequencer.c:880
 #, c-format
 msgid "cannot read %s: %s"
 msgstr "Kann %s nicht lesen: %s"
=20
@@ -1705,21 +1710,21 @@ msgstr "Kann nicht als allerersten Commit einen=
 Cherry-Pick ausf=C3=BChren."
 #: setup.c:248
 #, c-format
 msgid "failed to read %s"
 msgstr "Fehler beim Lesen von %s"
=20
 #: setup.c:468
 #, c-format
 msgid "Expected git repo version <=3D %d, found %d"
-msgstr ""
+msgstr "Erwartete Git-Repository-Version <=3D %d, %d gefunden"
=20
 #: setup.c:476
 msgid "unknown repository extensions found:"
-msgstr ""
+msgstr "Unbekannte Repository-Erweiterungen gefunden:"
=20
 #: sha1_file.c:1080
 msgid "offset before end of packfile (broken .idx?)"
 msgstr "Offset vor Ende der Packdatei (fehlerhafte Indexdatei?)"
=20
 #: sha1_file.c:2458
 #, c-format
 msgid "offset before start of pack index for %s (corrupt index?)"
@@ -1777,22 +1782,22 @@ msgid "Could not remove .gitmodules entry for %=
s"
 msgstr "Konnte Eintrag '%s' nicht aus .gitmodules entfernen"
=20
 #: submodule.c:120
 msgid "staging updated .gitmodules failed"
 msgstr "Konnte aktualisierte .gitmodules-Datei nicht zum Commit vormer=
ken"
=20
 #: submodule.c:177
 msgid "negative values not allowed for submodule.fetchJobs"
-msgstr ""
+msgstr "Negative Werte f=C3=BCr submodule.fetchJobs nicht erlaubt"
=20
 #: submodule-config.c:355
-#, fuzzy, c-format
+#, c-format
 msgid "invalid value for %s"
-msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s: %s"
+msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s"
=20
 #: trailer.c:237
 #, c-format
 msgid "running trailer command '%s' failed"
 msgstr "Ausf=C3=BChren des Anhang-Befehls '%s' fehlgeschlagen"
=20
 #: trailer.c:492 trailer.c:496 trailer.c:500 trailer.c:554 trailer.c:5=
58
 #: trailer.c:562
@@ -1849,204 +1854,242 @@ msgid "Could not read ref %s"
 msgstr "Konnte Referenz %s nicht lesen."
=20
 #: unpack-trees.c:64
 #, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by che=
ckout:\n"
 "%%sPlease commit your changes or stash them before you can switch bra=
nches."
 msgstr ""
+"Ihre lokalen =C3=84nderungen in den folgenden Dateien w=C3=BCrden bei=
m Auschecken\n"
+"=C3=BCberschrieben werden:\n"
+"%%sBitte committen oder stashen Sie Ihre =C3=84nderungen, bevor Sie B=
ranches wechseln."
=20
 #: unpack-trees.c:66
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by che=
ckout:\n"
 "%%s"
 msgstr ""
-"Ihre lokalen =C3=84nderungen w=C3=BCrden von \"cherry-pick\" =C3=BCbe=
rschrieben werden."
+"Ihre lokalen =C3=84nderungen in den folgenden Dateien w=C3=BCrden bei=
m Auschecken\n"
+"=C3=BCberschrieben werden:\n"
+"%%s"
=20
 #: unpack-trees.c:69
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by mer=
ge:\n"
 "%%sPlease commit your changes or stash them before you can merge."
 msgstr ""
-"Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
+"Ihre lokalen =C3=84nderungen in den folgenden Dateien w=C3=BCrden dur=
ch den Merge\n"
+"=C3=BCberschrieben werden:\n"
+"%%sBitte committen oder stashen Sie Ihre =C3=84nderungen, bevor sie m=
ergen."
=20
 #: unpack-trees.c:71
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by mer=
ge:\n"
 "%%s"
-msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden von \"revert\" =C3=BC=
berschrieben werden."
+msgstr ""
+"Ihre lokalen =C3=84nderungen in den folgenden Dateien w=C3=BCrden dur=
ch den Merge\n"
+"=C3=BCberschrieben werden:\n"
+"%%s"
=20
 #: unpack-trees.c:74
 #, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by %s:=
\n"
 "%%sPlease commit your changes or stash them before you can %s."
 msgstr ""
+"Ihre lokalen =C3=84nderungen in den folgenden Dateien w=C3=BCrden dur=
ch %s\n"
+"=C3=BCberschrieben werden:\n"
+"%%sBitte committen oder stashen Sie Ihre =C3=84nderungen, bevor Sie %=
s ausf=C3=BChren."
=20
 #: unpack-trees.c:76
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Your local changes to the following files would be overwritten by %s:=
\n"
 "%%s"
-msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden von \"revert\" =C3=BC=
berschrieben werden."
+msgstr ""
+"Ihre lokalen =C3=84nderungen w=C3=BCrden durch %s =C3=BCberschrieben =
werden.\n"
+"%%s"
=20
 #: unpack-trees.c:81
 #, c-format
 msgid ""
 "Updating the following directories would lose untracked files in it:\=
n"
 "%s"
 msgstr ""
+"Durch die Aktualisierung der folgenden Verzeichnisse w=C3=BCrden unve=
rsionierte\n"
+"Dateien in diesen Verzeichnissen verloren gehen:\n"
+"%s"
=20
 #: unpack-trees.c:85
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by checko=
ut:\n"
 "%%sPlease move or remove them before you can switch branches."
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch\n"
+"den Checkout entfernt werden:\n"
+"%%sBitte verschieben oder entfernen Sie diese, bevor Sie Branches wec=
hseln."
=20
 #: unpack-trees.c:87
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by checko=
ut:\n"
 "%%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Checkout entfernt werden:\n"
+"%%s"
=20
 #: unpack-trees.c:90
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by merge:=
\n"
 "%%sPlease move or remove them before you can merge."
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Merge entfernt werden:\n"
+"%%sBitte verschieben oder entfernen Sie diese, bevor sie mergen."
=20
 #: unpack-trees.c:92
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by merge:=
\n"
 "%%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Merge entfernt werden:\n"
+"%%s"
=20
 #: unpack-trees.c:95
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by %s:\n"
 "%%sPlease move or remove them before you can %s."
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"%s entfernt werden:\n"
+"%%sBitte verschieben oder entfernen Sie diese, bevor sie %s ausf=C3=BC=
hren."
=20
 #: unpack-trees.c:97
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be removed by %s:\n"
 "%%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"%s entfernt werden:\n"
+"%%s"
=20
 #: unpack-trees.c:102
 #, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by "
 "checkout:\n"
 "%%sPlease move or remove them before you can switch branches."
 msgstr ""
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Checkout =C3=BCberschrieben werden:\n"
+"%%sBitte verschieben oder entfernen Sie diese, bevor Sie Branches wec=
hseln."
=20
 #: unpack-trees.c:104
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by "
 "checkout:\n"
 "%%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Checkout =C3=BCberschrieben werden:\n"
+"%%s"
=20
 #: unpack-trees.c:107
 #, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by me=
rge:\n"
 "%%sPlease move or remove them before you can merge."
 msgstr ""
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Merge =C3=BCberschrieben werden:\n"
+"%%sBitte verschieben oder entfernen Sie diese, bevor Sie mergen."
=20
 #: unpack-trees.c:109
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by me=
rge:\n"
 "%%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"Merge =C3=BCberschrieben werden:\n"
+"%%s"
=20
 #: unpack-trees.c:112
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by %s=
:\n"
 "%%sPlease move or remove them before you can %s."
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"%s =C3=BCberschrieben werden:\n"
+"%%sBitte verschieben oder entfernen Sie diese, bevor sie %s ausf=C3=BC=
hren."
=20
 #: unpack-trees.c:114
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following untracked working tree files would be overwritten by %s=
:\n"
 "%%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden unversionierten Dateien im Arbeitsverzeichnis w=C3=BCrd=
en durch den\n"
+"%s =C3=BCberschrieben werden:\n"
+"%%s"
=20
 #: unpack-trees.c:121
 #, c-format
 msgid "Entry '%s' overlaps with '%s'.  Cannot bind."
-msgstr ""
+msgstr "Eintrag '%s' =C3=BCberschneidet sich mit '%s'. Kann nicht verb=
inden."
=20
 #: unpack-trees.c:124
 #, c-format
 msgid ""
 "Cannot update sparse checkout: the following entries are not up-to-da=
te:\n"
 "%s"
 msgstr ""
+"Kann partiellen Checkout nicht aktualisieren: die folgenden Eintr=C3=A4=
ge sind nicht\n"
+"aktuell:\n"
+"%s"
=20
 #: unpack-trees.c:126
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following Working tree files would be overwritten by sparse check=
out "
 "update:\n"
 "%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden Dateien im Arbeitsbereich w=C3=BCrden durch die Aktuali=
sierung\n"
+"des partiellen Checkouts =C3=BCberschrieben werden:\n"
+"%s"
=20
 #: unpack-trees.c:128
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The following Working tree files would be removed by sparse checkout =
"
 "update:\n"
 "%s"
 msgstr ""
-"Die folgenden unbeobachteten Dateien w=C3=BCrden NICHT gespeichert we=
rden,\n"
-"m=C3=BCssen aber durch \"stash save\" entfernt werden:"
+"Die folgenden Dateien im Arbeitsbereich w=C3=BCrden durch die Aktuali=
sierung\n"
+"des partiellen Checkouts entfernt werden:\n"
+"%s"
=20
 #: unpack-trees.c:205
 #, c-format
 msgid "Aborting\n"
-msgstr ""
+msgstr "Abbruch\n"
=20
 #: unpack-trees.c:237
 msgid "Checking out files"
 msgstr "Checke Dateien aus"
=20
 #: urlmatch.c:120
 msgid "invalid URL scheme name or missing '://' suffix"
 msgstr "Ung=C3=BCltiges URL-Schema oder Suffix '://' fehlt"
@@ -3521,19 +3564,19 @@ msgid "Hunk #%d applied cleanly."
 msgstr "Patch-Bereich #%d sauber angewendet."
=20
 #: builtin/apply.c:4301
 #, c-format
 msgid "Rejected hunk #%d."
 msgstr "Patch-Block #%d zur=C3=BCckgewiesen."
=20
 #: builtin/apply.c:4387
-#, fuzzy, c-format
+#, c-format
 msgid "Skipped patch '%s'."
-msgstr "Ung=C3=BCltiger Pfad '%s'"
+msgstr "Patch '%s' ausgelassen."
=20
 #: builtin/apply.c:4395
 msgid "unrecognized input"
 msgstr "nicht erkannte Eingabe"
=20
 #: builtin/apply.c:4406
 msgid "unable to read index file"
 msgstr "Konnte Index-Datei nicht lesen"
@@ -3915,20 +3958,19 @@ msgstr "Aktualisierung der Konfigurationsdatei =
fehlgeschlagen."
 msgid "cannot use -a with -d"
 msgstr "kann -a nicht mit -d benutzen"
=20
 #: builtin/branch.c:212
 msgid "Couldn't look up commit object for HEAD"
 msgstr "Konnte Commit-Objekt f=C3=BCr HEAD nicht nachschlagen."
=20
 #: builtin/branch.c:226
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot delete branch '%s' checked out at '%s'"
-msgstr ""
-"Kann Branch '%s' nicht entfernen, da Sie sich gerade auf diesem befin=
den."
+msgstr "Kann Branch '%s' nicht entfernen, ausgecheckt in '%s'."
=20
 #: builtin/branch.c:241
 #, c-format
 msgid "remote-tracking branch '%s' not found."
 msgstr "Remote-Tracking-Branch '%s' nicht gefunden"
=20
 #: builtin/branch.c:242
 #, c-format
@@ -4025,22 +4067,22 @@ msgstr "(HEAD losgel=C3=B6st von %s)"
=20
 #: builtin/branch.c:390
 msgid "(no branch)"
 msgstr "(kein Branch)"
=20
 #: builtin/branch.c:541
 #, c-format
 msgid "Branch %s is being rebased at %s"
-msgstr ""
+msgstr "Branch %s wird auf %s umgesetzt"
=20
 #: builtin/branch.c:545
 #, c-format
 msgid "Branch %s is being bisected at %s"
-msgstr ""
+msgstr "Bin=C3=A4re Suche von Branch %s zu %s im Gange"
=20
 #: builtin/branch.c:560
 msgid "cannot rename the current branch while not on any."
 msgstr ""
 "Kann aktuellen Branch nicht umbenennen, solange Sie sich auf keinem b=
efinden."
=20
 #: builtin/branch.c:570
 #, c-format
@@ -4063,19 +4105,18 @@ msgstr "Branch umbenannt zu %s, aber HEAD ist n=
icht aktualisiert!"
=20
 #: builtin/branch.c:601
 msgid "Branch is renamed, but update of config-file failed"
 msgstr ""
 "Branch ist umbenannt, aber die Aktualisierung der Konfigurationsdatei=
 ist "
 "fehlgeschlagen."
=20
 #: builtin/branch.c:623
-#, fuzzy
 msgid "could not write branch description template"
-msgstr "Konnte Beschreibungsvorlage f=C3=BCr Branch nicht schreiben: %=
s"
+msgstr "Konnte Beschreibungsvorlage f=C3=BCr Branch nicht schreiben."
=20
 #: builtin/branch.c:651
 msgid "Generic options"
 msgstr "Allgemeine Optionen"
=20
 #: builtin/branch.c:653
 msgid "show hash and subject, give twice for upstream branch"
 msgstr "Hash und Betreff anzeigen; -vv: zus=C3=A4tzlich Upstream-Branc=
h"
@@ -4089,20 +4130,19 @@ msgid "set up tracking mode (see git-pull(1))"
 msgstr "den =C3=9Cbernahmemodus einstellen (siehe git-pull(1))"
=20
 #: builtin/branch.c:657
 msgid "change upstream info"
 msgstr "Informationen zum Upstream-Branch =C3=A4ndern"
=20
 #: builtin/branch.c:659
 msgid "upstream"
-msgstr ""
+msgstr "Upstream"
=20
 #: builtin/branch.c:659
-#, fuzzy
 msgid "change the upstream info"
 msgstr "Informationen zum Upstream-Branch =C3=A4ndern"
=20
 #: builtin/branch.c:661
 msgid "use colored output"
 msgstr "farbige Ausgaben verwenden"
=20
 #: builtin/branch.c:662
@@ -5038,19 +5078,18 @@ msgstr "lokal keine harten Verweise verwenden, =
immer Kopien"
 msgid "setup as shared repository"
 msgstr "als verteiltes Repository einrichten"
=20
 #: builtin/clone.c:75 builtin/clone.c:77
 msgid "initialize submodules in the clone"
 msgstr "Submodule im Klon initialisieren"
=20
 #: builtin/clone.c:79
-#, fuzzy
 msgid "number of submodules cloned in parallel"
-msgstr "Anzahl der parallel mit 'pull' zu verarbeitenden Submodule"
+msgstr "Anzahl der parallel zu klonenden Submodule"
=20
 #: builtin/clone.c:80 builtin/init-db.c:470
 msgid "template-directory"
 msgstr "Vorlagenverzeichnis"
=20
 #: builtin/clone.c:81 builtin/init-db.c:471
 msgid "directory from which templates will be used"
 msgstr "Verzeichnis, von welchem die Vorlagen verwendet werden"
@@ -5089,19 +5128,18 @@ msgid "create a shallow clone of that depth"
 msgstr ""
 "einen Klon mit unvollst=C3=A4ndiger Historie (shallow) in dieser Tief=
e erstellen"
=20
 #: builtin/clone.c:95
 msgid "clone only one branch, HEAD or --branch"
 msgstr "nur einen Branch klonen, HEAD oder --branch"
=20
 #: builtin/clone.c:97
-#, fuzzy
 msgid "any cloned submodules will be shallow"
-msgstr "Pfad f=C3=BCr neues Submodul"
+msgstr "jedes geklonte Submodul mit unvollst=C3=A4ndiger Historie (sha=
llow)"
=20
 #: builtin/clone.c:98 builtin/init-db.c:479
 msgid "gitdir"
 msgstr ".git-Verzeichnis"
=20
 #: builtin/clone.c:99 builtin/init-db.c:480
 msgid "separate git dir from working tree"
 msgstr "Git-Verzeichnis vom Arbeitsverzeichnis separieren"
@@ -7194,19 +7232,19 @@ msgid "Failed to parse emacsclient version."
 msgstr "Konnte Version des emacsclient nicht parsen."
=20
 #: builtin/help.c:112
 #, c-format
 msgid "emacsclient version '%d' too old (< 22)."
 msgstr "Version des emacsclient '%d' ist zu alt (< 22)."
=20
 #: builtin/help.c:130 builtin/help.c:151 builtin/help.c:160 builtin/he=
lp.c:168
-#, fuzzy, c-format
+#, c-format
 msgid "failed to exec '%s'"
-msgstr "Fehler beim Ausf=C3=BChren von '%s': %s"
+msgstr "Fehler beim Ausf=C3=BChren von '%s'"
=20
 #: builtin/help.c:205
 #, c-format
 msgid ""
 "'%s': path for unsupported man viewer.\n"
 "Please consider using 'man.<tool>.cmd' instead."
 msgstr ""
 "'%s': Pfad f=C3=BCr nicht unterst=C3=BCtzten Handbuchbetrachter.\n"
@@ -7454,20 +7492,20 @@ msgstr "L=C3=B6se Unterschiede auf"
 msgid "unable to create thread: %s"
 msgstr "kann Thread nicht erzeugen: %s"
=20
 #: builtin/index-pack.c:1247
 msgid "confusion beyond insanity"
 msgstr "Fehler beim Aufl=C3=B6sen der Unterschiede"
=20
 #: builtin/index-pack.c:1253
-#, fuzzy, c-format
+#, c-format
 msgid "completed with %d local object"
 msgid_plural "completed with %d local objects"
-msgstr[0] "abgeschlossen mit %d lokalen Objekten"
+msgstr[0] "abgeschlossen mit %d lokalem Objekt"
 msgstr[1] "abgeschlossen mit %d lokalen Objekten"
=20
 #: builtin/index-pack.c:1265
 #, c-format
 msgid "Unexpected tail checksum for %s (disk corruption?)"
 msgstr "Unerwartete Pr=C3=BCfsumme f=C3=BCr %s (Festplattenfehler?)"
=20
 #: builtin/index-pack.c:1269
@@ -7602,19 +7640,19 @@ msgid "ignoring template %s"
 msgstr "ignoriere Vorlage %s"
=20
 #: builtin/init-db.c:120
 #, c-format
 msgid "templates not found %s"
 msgstr "keine Vorlagen in '%s' gefunden"
=20
 #: builtin/init-db.c:135
-#, fuzzy, c-format
+#, c-format
 msgid "not copying templates from '%s': %s"
-msgstr "kopiere keine Vorlagen mit einer falschen Formatversion %d von=
 '%s'"
+msgstr "kopiere keine Vorlagen von '%s': %s"
=20
 #: builtin/init-db.c:312 builtin/init-db.c:315
 #, c-format
 msgid "%s already exists"
 msgstr "%s existiert bereits"
=20
 #: builtin/init-db.c:344
 #, c-format
@@ -7814,44 +7852,45 @@ msgstr "Unbekannter Commit %s"
 #: builtin/notes.c:306 builtin/notes.c:369 builtin/notes.c:424
 #: builtin/notes.c:510 builtin/notes.c:515 builtin/notes.c:593
 #: builtin/notes.c:656 builtin/notes.c:881 builtin/tag.c:455
 #, c-format
 msgid "Failed to resolve '%s' as a valid ref."
 msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
=20
 #: builtin/log.c:1231
-#, fuzzy
 msgid "Could not find exact merge base."
-msgstr "Konnte Merge-Strategie '%s' nicht finden.\n"
+msgstr "Konnte keine exakte Merge-Basis finden."
=20
 #: builtin/log.c:1235
 msgid ""
 "Failed to get upstream, if you want to record base commit automatical=
ly,\n"
 "please use git branch --set-upstream-to to track a remote branch.\n"
 "Or you could specify base commit by --base=3D<base-commit-id> manuall=
y."
 msgstr ""
+"Fehler beim Bestimmen des Upstream-Branches. Wenn Sie den Basis-Commi=
t\n"
+"automatisch speichern lassen m=C3=B6chten, benutzen Sie bitte\n"
+"'git branch --set-upstream-to', um einem Remote-Branch zu folgen.\n"
+"Oder geben Sie den Basis-Commit mit '--base=3D<Basis-Commit-Id>' manu=
ell an."
=20
 #: builtin/log.c:1255
-#, fuzzy
 msgid "Failed to find exact merge base"
-msgstr "Fehler beim Finden des \"Tree\"-Objektes von %s."
+msgstr "Fehler beim Finden einer exakten Merge-Basis."
=20
 #: builtin/log.c:1266
 msgid "base commit should be the ancestor of revision list"
-msgstr ""
+msgstr "Basis-Commit sollte der Vorg=C3=A4nger der Revisionsliste sein=
=2E"
=20
 #: builtin/log.c:1270
 msgid "base commit shouldn't be in revision list"
-msgstr ""
+msgstr "Basis-Commit sollte nicht in der Revisionsliste enthalten sein=
=2E"
=20
 #: builtin/log.c:1319
-#, fuzzy
 msgid "cannot get patch id"
-msgstr "kann -a nicht mit -d benutzen"
+msgstr "kann Patch-Id nicht lesen"
=20
 #: builtin/log.c:1377
 msgid "use [PATCH n/m] even with a single patch"
 msgstr "[PATCH n/m] auch mit einzelnem Patch verwenden"
=20
 #: builtin/log.c:1380
 msgid "use [PATCH] even with multiple patches"
 msgstr "[PATCH] auch mit mehreren Patches verwenden"
@@ -7975,23 +8014,22 @@ msgstr "Nachrichtenverkettung aktivieren, Stile=
: shallow, deep"
 msgid "signature"
 msgstr "Signatur"
=20
 #: builtin/log.c:1436
 msgid "add a signature"
 msgstr "eine Signatur hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1437
-#, fuzzy
 msgid "base-commit"
-msgstr "Commit"
+msgstr "Basis-Commit"
=20
 #: builtin/log.c:1438
 msgid "add prerequisite tree info to the patch series"
-msgstr ""
+msgstr "erforderliche Revisions-Informationen der Patch-Serie hinzuf=C3=
=BCgen"
=20
 #: builtin/log.c:1440
 msgid "add a signature from a file"
 msgstr "eine Signatur aus einer Datei hinzuf=C3=BCgen"
=20
 #: builtin/log.c:1441
 msgid "don't print the patch filenames"
 msgstr "keine Dateinamen der Patches anzeigen"
@@ -8329,17 +8367,17 @@ msgstr ""
 "Commit-Beschreibung zusammenf=C3=BChren (f=C3=BCr einen Merge, der ke=
in Vorspulen war)"
=20
 #: builtin/merge.c:224
 msgid "abort the current in-progress merge"
 msgstr "den sich im Gange befindlichen Merge abbrechen"
=20
 #: builtin/merge.c:226 builtin/pull.c:169
 msgid "allow merging unrelated histories"
-msgstr ""
+msgstr "erlaube das Zusammenf=C3=BChren von nicht zusammenh=C3=A4ngend=
en Historien"
=20
 #: builtin/merge.c:254
 msgid "could not run stash."
 msgstr "Konnte \"stash\" nicht ausf=C3=BChren."
=20
 #: builtin/merge.c:259
 msgid "stash failed"
 msgstr "\"stash\" fehlgeschlagen"
@@ -8547,19 +8585,18 @@ msgid "Commit %s does not have a GPG signature.=
"
 msgstr "Commit %s hat keine GPG-Signatur."
=20
 #: builtin/merge.c:1353
 #, c-format
 msgid "Commit %s has a good GPG signature by %s\n"
 msgstr "Commit %s hat eine g=C3=BCltige GPG-Signatur von %s\n"
=20
 #: builtin/merge.c:1415
-#, fuzzy
 msgid "refusing to merge unrelated histories"
-msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen w=
=C3=BCrden"
+msgstr "Verweigere den Merge von nicht zusammenh=C3=A4ngenden Historie=
n."
=20
 #: builtin/merge.c:1439
 #, c-format
 msgid "Updating %s..%s\n"
 msgstr "Aktualisiere %s..%s\n"
=20
 #: builtin/merge.c:1476
 #, c-format
@@ -9173,31 +9210,30 @@ msgstr ""
 "<Objektliste>]"
=20
 #: builtin/pack-objects.c:175 builtin/pack-objects.c:178
 #, c-format
 msgid "deflate error (%d)"
 msgstr "Fehler beim Komprimieren (%d)"
=20
 #: builtin/pack-objects.c:763
-#, fuzzy
 msgid "disabling bitmap writing, packs are split due to pack.packSizeL=
imit"
 msgstr ""
-"Deaktiviere Schreiben des Bitmap-Index, da einige Objekte nicht in\n"
-"eine Pack-Datei geschrieben wurden"
+"Deaktiviere Schreiben der Bitmap, Pakete wurden durch pack.packSizeLi=
mit\n"
+"aufgetrennt."
=20
 #: builtin/pack-objects.c:776
 msgid "Writing objects"
 msgstr "Schreibe Objekte"
=20
 #: builtin/pack-objects.c:1017
 msgid "disabling bitmap writing, as some objects are not being packed"
 msgstr ""
-"Deaktiviere Schreiben des Bitmap-Index, da einige Objekte nicht in\n"
-"eine Pack-Datei geschrieben wurden"
+"Deaktiviere Schreiben der Bitmap, da einige Objekte nicht in eine Pac=
k-Datei\n"
+"geschrieben wurden."
=20
 #: builtin/pack-objects.c:2177
 msgid "Compressing objects"
 msgstr "Komprimiere Objekte"
=20
 #: builtin/pack-objects.c:2563
 #, c-format
 msgid "unsupported index version %s"
@@ -9414,17 +9450,17 @@ msgid "allow fast-forward"
 msgstr "Vorspulen erlauben"
=20
 #: builtin/pull.c:153
 msgid "verify that the named commit has a valid GPG signature"
 msgstr "den genannten Commit auf eine g=C3=BCltige GPG-Signatur =C3=BC=
berpr=C3=BCfen"
=20
 #: builtin/pull.c:156
 msgid "automatically stash/stash pop before and after rebase"
-msgstr ""
+msgstr "automatischer Stash/Stash-Pop vor und nach eines Rebase"
=20
 #: builtin/pull.c:172
 msgid "Options related to fetching"
 msgstr "Optionen bezogen auf Fetch"
=20
 #: builtin/pull.c:194
 msgid "number of submodules pulled in parallel"
 msgstr "Anzahl der parallel mit 'pull' zu verarbeitenden Submodule"
@@ -9500,55 +9536,48 @@ msgid "Please specify which branch you want to =
merge with."
 msgstr "Bitte geben Sie den Branch an, welchen Sie zusammenf=C3=BChren=
 m=C3=B6chten."
=20
 #: builtin/pull.c:479 builtin/pull.c:494
 msgid "See git-pull(1) for details."
 msgstr "Siehe git-pull(1) f=C3=BCr weitere Details."
=20
 #: builtin/pull.c:481 builtin/pull.c:487 builtin/pull.c:496
 #: git-parse-remote.sh:64
-#, fuzzy
 msgid "<remote>"
-msgstr "* Remote-Repository %s"
+msgstr "<Remote-Repository>"
=20
 #: builtin/pull.c:481 builtin/pull.c:496 builtin/pull.c:501
 #: git-parse-remote.sh:65
-#, fuzzy
 msgid "<branch>"
-msgstr "Branch"
+msgstr "<Branch>"
=20
 #: builtin/pull.c:489 git-parse-remote.sh:75
 msgid "There is no tracking information for the current branch."
 msgstr "Es gibt keine Tracking-Informationen f=C3=BCr den aktuellen Br=
anch."
=20
 #: builtin/pull.c:498 git-parse-remote.sh:95
-#, fuzzy
 msgid ""
 "If you wish to set tracking information for this branch you can do so=
 with:"
 msgstr ""
-"Wenn Sie Tracking-Informationen f=C3=BCr diesen Branch setzen m=C3=B6=
chten, k=C3=B6nnen "
-"Sie\n"
-"dies tun mit:\n"
-"\n"
-" git branch --set-upstream-to=3D%s/<Branch> %s\n"
+"Wenn Sie Tracking-Informationen f=C3=BCr diesen Branch setzen m=C3=B6=
chten, k=C3=B6nnen Sie\n"
+"dies tun mit:"
=20
 #: builtin/pull.c:503
 #, c-format
 msgid ""
 "Your configuration specifies to merge with the ref '%s'\n"
 "from the remote, but no such ref was fetched."
 msgstr ""
 "Ihre Konfiguration gibt an, den Merge mit Referenz '%s'\n"
 "des Remote-Repositories durchzuf=C3=BChren, aber diese Referenz\n"
 "wurde nicht angefordert."
=20
 #: builtin/pull.c:864
-#, fuzzy
 msgid "--[no-]autostash option is only valid with --rebase."
-msgstr "--non-matching ist nur mit --verbose zul=C3=A4ssig"
+msgstr "--[no-]autostash ist nur mit --rebase zul=C3=A4ssig."
=20
 #: builtin/pull.c:872
 msgid "Updating an unborn branch with changes added to the index."
 msgstr ""
 "Aktualisiere einen ungeborenen Branch mit =C3=84nderungen, die zum Co=
mmit "
 "vorgemerkt sind."
=20
 #: builtin/pull.c:900
@@ -9947,36 +9976,33 @@ msgid "don't check the working tree after mergi=
ng"
 msgstr "das Arbeitsverzeichnis nach dem Merge nicht pr=C3=BCfen"
=20
 #: builtin/read-tree.c:135
 msgid "don't update the index or the work tree"
 msgstr "weder den Index, noch das Arbeitsverzeichnis aktualisieren"
=20
 #: builtin/read-tree.c:137
 msgid "skip applying sparse checkout filter"
-msgstr "Anwendung des Filters f=C3=BCr sp=C3=A4rliches Auschecken =C3=BC=
berspringen"
+msgstr "Anwendung des Filters f=C3=BCr partielles Auschecken =C3=BCber=
springen"
=20
 #: builtin/read-tree.c:139
 msgid "debug unpack-trees"
 msgstr "Entpacken der B=C3=A4ume protokollieren"
=20
 #: builtin/receive-pack.c:25
-#, fuzzy
 msgid "git receive-pack <git-dir>"
-msgstr "git repack [<Optionen>]"
+msgstr "git receive-pack <Git-Verzeichnis>"
=20
 #: builtin/receive-pack.c:1719
-#, fuzzy
 msgid "quiet"
 msgstr "weniger Ausgaben"
=20
 #: builtin/receive-pack.c:1733
-#, fuzzy
 msgid "You must specify a directory."
-msgstr "Sie m=C3=BCssen ein Repository zum Klonen angeben."
+msgstr "Sie m=C3=BCssen ein Repository angeben."
=20
 #: builtin/reflog.c:423
 #, c-format
 msgid "'%s' for '%s' is not a valid timestamp"
 msgstr "'%s' ist kein g=C3=BCltiger Zeitstempel f=C3=BCr '%s'"
=20
 #: builtin/reflog.c:540 builtin/reflog.c:545
 #, c-format
@@ -11204,78 +11230,73 @@ msgstr ""
 "alle Zeilen, die mit dem Kommentarzeichen beginnen, =C3=BCberspringen=
 und "
 "entfernen"
=20
 #: builtin/stripspace.c:38
 msgid "prepend comment character and space to each line"
 msgstr "Kommentarzeichen mit Leerzeichen an jede Zeile voranstellen"
=20
 #: builtin/submodule--helper.c:24
-#, fuzzy, c-format
+#, c-format
 msgid "No such ref: %s"
-msgstr "Kein solches Remote-Repository: %s"
+msgstr "Referenz nicht gefunden: %s"
=20
 #: builtin/submodule--helper.c:31
 #, c-format
 msgid "Expecting a full ref name, got %s"
-msgstr ""
+msgstr "Vollst=C3=A4ndiger Referenzname erwartet, %s erhalten"
=20
 #: builtin/submodule--helper.c:71
-#, fuzzy, c-format
+#, c-format
 msgid "cannot strip one component off url '%s'"
-msgstr "Kann eine Komponente von URL '$remoteurl' nicht extrahieren"
+msgstr "Kann eine Komponente von URL '%s' nicht extrahieren"
=20
 #: builtin/submodule--helper.c:278 builtin/submodule--helper.c:405
 #: builtin/submodule--helper.c:486
 msgid "alternative anchor for relative paths"
 msgstr "Alternativer Anker f=C3=BCr relative Pfade"
=20
 #: builtin/submodule--helper.c:283
 msgid "git submodule--helper list [--prefix=3D<path>] [<path>...]"
 msgstr "git submodule--helper list [--prefix=3D<Pfad>] [<Pfad>...]"
=20
 #: builtin/submodule--helper.c:326 builtin/submodule--helper.c:340
-#, fuzzy, c-format
+#, c-format
 msgid "No url found for submodule path '%s' in .gitmodules"
-msgstr "Keine URL f=C3=BCr Submodul-Pfad '$displaypath' in .gitmodules=
 gefunden"
+msgstr "Keine URL f=C3=BCr Submodul-Pfad '%s' in .gitmodules gefunden"
=20
 #: builtin/submodule--helper.c:366
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to register url for submodule path '%s'"
-msgstr ""
-"Fehler beim Eintragen der URL f=C3=BCr Submodul-Pfad '$displaypath' i=
n die "
-"Konfiguration."
+msgstr "Fehler beim Eintragen der URL f=C3=BCr Submodul-Pfad '%s' in d=
ie Konfiguration."
=20
 #: builtin/submodule--helper.c:370
-#, fuzzy, c-format
+#, c-format
 msgid "Submodule '%s' (%s) registered for path '%s'\n"
-msgstr ""
-"Submodul '$name' ($url) f=C3=BCr Pfad '$displaypath' in die Konfigura=
tion "
-"eingetragen."
+msgstr "Submodul '%s' (%s) f=C3=BCr Pfad '%s' in die Konfiguration ein=
getragen.\n"
=20
 #: builtin/submodule--helper.c:380
 #, c-format
 msgid "warning: command update mode suggested for submodule '%s'\n"
-msgstr ""
+msgstr "Warnung: 'update'-Modus f=C3=BCr Submodul '%s' vorgeschlagen\n=
"
=20
 #: builtin/submodule--helper.c:387
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to register update mode for submodule path '%s'"
 msgstr ""
-"Fehler bei =C3=84nderung des Aktualisierungsmodus f=C3=BCr Submodul-P=
fad "
-"'$displaypath' in der Konfiguration."
+"Fehler bei =C3=84nderung des Aktualisierungsmodus f=C3=BCr Submodul-P=
fad '%s' in der\n"
+"Konfiguration."
=20
 #: builtin/submodule--helper.c:406
 msgid "Suppress output for initializing a submodule"
-msgstr ""
+msgstr "Ausgaben bei Initialisierung eines Submoduls unterdr=C3=BCcken=
"
=20
 #: builtin/submodule--helper.c:411
-#, fuzzy
 msgid "git submodule--helper init [<path>]"
-msgstr "git submodule--helper name <Pfad>"
+msgstr "git submodule--helper init [<Pfad>]"
=20
 #: builtin/submodule--helper.c:432
 msgid "git submodule--helper name <path>"
 msgstr "git submodule--helper name <Pfad>"
=20
 #: builtin/submodule--helper.c:438
 #, c-format
 msgid "no submodule mapping found in .gitmodules for path '%s'"
@@ -11293,23 +11314,20 @@ msgstr "Name des neuen Submoduls"
 msgid "url where to clone the submodule from"
 msgstr "URL von der das Submodul geklont wird"
=20
 #: builtin/submodule--helper.c:501
 msgid "depth for shallow clones"
 msgstr "Tiefe des Klons mit unvollst=C3=A4ndiger Historie (shallow)"
=20
 #: builtin/submodule--helper.c:507
-#, fuzzy
 msgid ""
 "git submodule--helper clone [--prefix=3D<path>] [--quiet] [--referenc=
e "
 "<repository>] [--name <name>] [--depth <depth>] --url <url> --path <p=
ath>"
-msgstr ""
-"git submodule--helper clone [--prefix=3D<Pfad>] [--quiet] [--referenc=
e "
-"<Repository>] [--name <Name>] [--url <URL>][--depth <Tiefe>] [--] [<P=
fad>...]"
+msgstr "git submodule--helper clone [--prefix=3D<Pfad>] [--quiet] [--r=
eference <Repository>] [--name <Name>] [--url <URL>] [--name <Name>] [-=
-depth <Tiefe>] --url <URL> --path <Pfad>"
=20
 #: builtin/submodule--helper.c:532 builtin/submodule--helper.c:538
 #, c-format
 msgid "could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
 #: builtin/submodule--helper.c:534
 #, c-format
@@ -11329,78 +11347,74 @@ msgstr "Konnte Datei '%s' nicht schlie=C3=9Fe=
n."
 #: builtin/submodule--helper.c:562
 #, c-format
 msgid "could not get submodule directory for '%s'"
 msgstr "Konnte Submodul-Verzeichnis '%s' nicht finden."
=20
 #: builtin/submodule--helper.c:609
 #, c-format
 msgid "Submodule path '%s' not initialized"
-msgstr ""
+msgstr "Submodul-Pfad '%s' nicht initialisiert"
=20
 #: builtin/submodule--helper.c:613
-#, fuzzy
 msgid "Maybe you want to use 'update --init'?"
-msgstr "Meinten Sie vielleicht 'git add .'?\n"
+msgstr "Meinten Sie vielleicht 'update --init'?"
=20
 #: builtin/submodule--helper.c:639
-#, fuzzy, c-format
+#, c-format
 msgid "Skipping unmerged submodule %s"
-msgstr "nicht zusammengef=C3=BChrte Notizen eintragen"
+msgstr "=C3=9Cberspringe nicht zusammengef=C3=BChrtes Submodul %s"
=20
 #: builtin/submodule--helper.c:660
-#, fuzzy, c-format
+#, c-format
 msgid "Skipping submodule '%s'"
-msgstr "Definition von Submodul-Eigenschaften"
+msgstr "=C3=9Cberspringe Submodul '%s'"
=20
 #: builtin/submodule--helper.c:768
-#, fuzzy
 msgid "path into the working tree"
-msgstr "den Zustand des Arbeitsverzeichnisses anzeigen"
+msgstr "Pfad zum Arbeitsverzeichnis"
=20
 #: builtin/submodule--helper.c:771
 msgid "path into the working tree, across nested submodule boundaries"
-msgstr ""
+msgstr "Pfad zum Arbeitsverzeichnis, =C3=BCber verschachtelte Submodul=
-Grenzen hinweg"
=20
 #: builtin/submodule--helper.c:775
 msgid "rebase, merge, checkout or none"
-msgstr ""
+msgstr "rebase, merge, checkout oder none"
=20
 #: builtin/submodule--helper.c:779
 msgid "Create a shallow clone truncated to the specified number of rev=
isions"
 msgstr ""
+"Erstellung eines Klons mit unvollst=C3=A4ndiger Historie (shallow), a=
bgeschnitten bei\n"
+"der angegebenen Anzahl von Commits."
=20
 #: builtin/submodule--helper.c:782
 msgid "parallel jobs"
-msgstr ""
+msgstr "Parallele Ausf=C3=BChrungen"
=20
 #: builtin/submodule--helper.c:783
-#, fuzzy
 msgid "don't print cloning progress"
-msgstr "Kein Rebase im Gange?"
+msgstr "keine Fortschrittsanzeige beim Klonen"
=20
 #: builtin/submodule--helper.c:788
-#, fuzzy
 msgid "git submodule--helper update_clone [--prefix=3D<path>] [<path>.=
=2E.]"
-msgstr "git submodule--helper list [--prefix=3D<Pfad>] [<Pfad>...]"
+msgstr "git submodule--helper update_clone [--prefix=3D<Pfad>] [<Pfad>=
=2E..]"
=20
 #: builtin/submodule--helper.c:798
-#, fuzzy
 msgid "bad value for update parameter"
-msgstr "Fehlerhafter --author Parameter"
+msgstr "Fehlerhafter Wert f=C3=BCr --update Parameter"
=20
 #: builtin/submodule--helper.c:855
-#, fuzzy
 msgid "submodule--helper subcommand must be called with a subcommand"
-msgstr "fatal: submodule--helper muss mit einem Unterbefehl aufgerufen=
 werden"
+msgstr "submodule--helper muss mit einem Unterbefehl aufgerufen werden=
"
=20
 #: builtin/submodule--helper.c:862
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a valid submodule--helper subcommand"
-msgstr "fatal: '%s' ist kein g=C3=BCltiger Unterbefehl von submodule--=
helper"
+msgstr "'%s' ist kein g=C3=BCltiger Unterbefehl von submodule--helper"
=20
 #: builtin/symbolic-ref.c:7
 msgid "git symbolic-ref [<options>] <name> [<ref>]"
 msgstr "git symbolic-ref [<Optionen>] <Name> [<Referenz>]"
=20
 #: builtin/symbolic-ref.c:8
 msgid "git symbolic-ref -d [-q] <name>"
 msgstr "git symbolic-ref -d [-q] <Name>"
@@ -11949,19 +11963,19 @@ msgid "Removing worktrees/%s: invalid gitdir =
file"
 msgstr "L=C3=B6sche worktrees/%s: ung=C3=BCltige gitdir-Datei"
=20
 #: builtin/worktree.c:78
 #, c-format
 msgid "Removing worktrees/%s: gitdir file points to non-existent locat=
ion"
 msgstr "L=C3=B6sche worktrees/%s: gitdir-Datei verweist auf nicht exis=
tierenden Ort"
=20
 #: builtin/worktree.c:113
-#, fuzzy, c-format
+#, c-format
 msgid "failed to remove '%s'"
-msgstr "Fehler beim L=C3=B6schen von %s"
+msgstr "Fehler beim L=C3=B6schen von '%s'"
=20
 #: builtin/worktree.c:202
 #, c-format
 msgid "'%s' already exists"
 msgstr "'%s' existiert bereits"
=20
 #: builtin/worktree.c:234
 #, c-format
@@ -11987,19 +12001,18 @@ msgstr "neuen Branch erstellen"
 msgid "create or reset a branch"
 msgstr "Branch erstellen oder umsetzen"
=20
 #: builtin/worktree.c:327
 msgid "detach HEAD at named commit"
 msgstr "HEAD bei benanntem Commit losl=C3=B6sen"
=20
 #: builtin/worktree.c:328
-#, fuzzy
 msgid "populate the new working tree"
-msgstr "Arbeitsverzeichnis konnte nicht ausgecheckt werden"
+msgstr "das neue Arbeitsverzeichnis auschecken"
=20
 #: builtin/worktree.c:336
 msgid "-b, -B, and --detach are mutually exclusive"
 msgstr "-b, -B und --detach schlie=C3=9Fen sich gegenseitig aus"
=20
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
 msgstr "git write-tree [--missing-ok] [--prefix=3D<Pr=C3=A4fix>/]"
@@ -12758,36 +12771,36 @@ msgid "Failed to add submodule '$sm_path'"
 msgstr "Hinzuf=C3=BCgen von Submodul '$sm_path' fehlgeschlagen"
=20
 #: git-submodule.sh:311
 #, sh-format
 msgid "Failed to register submodule '$sm_path'"
 msgstr "Fehler beim Eintragen von Submodul '$sm_path' in die Konfigura=
tion."
=20
 #: git-submodule.sh:355
-#, fuzzy, sh-format
+#, sh-format
 msgid "Entering '$displaypath'"
-msgstr "Betrete '$prefix$displaypath'"
+msgstr "Betrete '$displaypath'"
=20
 #: git-submodule.sh:375
-#, fuzzy, sh-format
+#, sh-format
 msgid "Stopping at '$displaypath'; script returned non-zero status."
-msgstr "Stoppe bei '$prefix$displaypath'; Skript gab nicht-Null Status=
 zur=C3=BCck."
+msgstr "Stoppe bei '$displaypath'; Skript gab nicht-Null Status zur=C3=
=BCck."
=20
 #: git-submodule.sh:448
-#, fuzzy, sh-format
+#, sh-format
 msgid "pathspec and --all are incompatible"
-msgstr "Die Optionen --all und --tags sind inkompatibel."
+msgstr "Pfadspezifikationen und --all sind inkompatibel."
=20
 #: git-submodule.sh:453
-#, fuzzy, sh-format
+#, sh-format
 msgid "Use '--all' if you really want to deinitialize all submodules"
 msgstr ""
-"Verwenden Sie '.' wenn Sie wirklich alle Submodule\n"
-"deinitialisieren m=C3=B6chten."
+"Verwenden Sie '--all', wenn Sie wirklich alle Submodule deinitialisie=
ren\n"
+"m=C3=B6chten."
=20
 #: git-submodule.sh:470
 #, sh-format
 msgid "Submodule work tree '$displaypath' contains a .git directory"
 msgstr ""
 "Arbeitsverzeichnis des Submoduls in '$displaypath' enth=C3=A4lt ein .=
git-"
 "Verzeichnis"
=20
@@ -12873,26 +12886,24 @@ msgid "Unable to merge '$sha1' in submodule p=
ath '$displaypath'"
 msgstr "Merge von '$sha1' in Submodul-Pfad '$displaypath' fehlgeschlag=
en"
=20
 #: git-submodule.sh:692
 #, sh-format
 msgid "Submodule path '$displaypath': merged in '$sha1'"
 msgstr "Submodul-Pfad '$displaypath': zusammengef=C3=BChrt in '$sha1'"
=20
 #: git-submodule.sh:697
-#, fuzzy, sh-format
+#, sh-format
 msgid "Execution of '$command $sha1' failed in submodule path '$displa=
ypath'"
-msgstr ""
-"Ausf=C3=BChrung von '$command $sha1' in Submodul-Pfad '$prefix$sm_pat=
h' "
-"fehlgeschlagen"
+msgstr "Ausf=C3=BChrung von '$command $sha1' in Submodul-Pfad '$displa=
ypath' fehlgeschlagen"
=20
 #: git-submodule.sh:698
-#, fuzzy, sh-format
+#, sh-format
 msgid "Submodule path '$displaypath': '$command $sha1'"
-msgstr "Submodul-Pfad '$prefix$sm_path': '$command $sha1'"
+msgstr "Submodul-Pfad '$displaypath': '$command $sha1'"
=20
 #: git-submodule.sh:729
 #, sh-format
 msgid "Failed to recurse into submodule path '$displaypath'"
 msgstr "Fehler bei Rekursion in Submodul-Pfad '$displaypath'"
=20
 #: git-submodule.sh:837
 msgid "The --cached option cannot be used with the --files option"
@@ -12930,19 +12941,19 @@ msgid "Failed to recurse into submodule path =
'$sm_path'"
 msgstr "Fehler bei Rekursion in Submodul-Pfad '$sm_path'"
=20
 #: git-submodule.sh:1123
 #, sh-format
 msgid "Synchronizing submodule url for '$displaypath'"
 msgstr "Synchronisiere Submodul-URL f=C3=BCr '$displaypath'"
=20
 #: git-parse-remote.sh:89
-#, fuzzy, sh-format
+#, sh-format
 msgid "See git-${cmd}(1) for details."
-msgstr "Siehe git-pull(1) f=C3=BCr weitere Details."
+msgstr "Siehe git-${cmd}(1) f=C3=BCr weitere Details."
=20
 #~ msgid "'%s': %s"
 #~ msgstr "'%s': %s"
=20
 #~ msgid "unable to access '%s': %s"
 #~ msgstr "konnte nicht auf '%s' zugreifen: %s"
=20
 #~ msgid "could not open '%s' for reading: %s"
--=20
2.9.0.rc1.255.g8a191e1
