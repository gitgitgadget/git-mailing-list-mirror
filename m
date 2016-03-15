From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 22 new messages
Date: Tue, 15 Mar 2016 18:12:00 +0100
Message-ID: <1458061920-22666-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 18:12:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afsVv-0002kP-4j
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 18:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934877AbcCORMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 13:12:07 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38227 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934827AbcCORME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 13:12:04 -0400
Received: by mail-wm0-f51.google.com with SMTP id l68so36365386wml.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RX7aroNR8M/t02AHm5JAQQL43FIQFkIgMr0ZKkgqQvM=;
        b=NWXBqUQwMYKsZ0k7oFlXneslAulL7lv/I6ZeYQ1phPfy5j8RVbCax04DV5wMg6tXoC
         gLvlsxgIR06d1e0egMKESTtRTJ15uY37hxSbvpOtkXDXWKzB4nB9jzEkDyi/K6q8VIEN
         Ud/ZxvhlggcmXdcb4sBKY6XYjW+KIM+9BsPQMqhBFTGxA5NSrimu9A9y6u1kBpleIqJJ
         Ke3CLJO9Un+7tZ0yJpYklNordSGTI2IlaQY1SLOJ7krFe+MSblWQWLGvRjGBvBduxqnh
         FxDiqCCTXwh2s9j/lgeCQIHCYgNPBBbTiiVHoFW5Uo7l7ZrYBiwveAqj4qW/ZozO3H9N
         MMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RX7aroNR8M/t02AHm5JAQQL43FIQFkIgMr0ZKkgqQvM=;
        b=fzZrmF+cK57sX6QB+8j+7waKvOvct8m0UfbAhemhRoDJvAAAgdo9j/GO/Z5pNHbfMS
         V9UsIXG9t9AsvWDNZ0wiGzgTTQMUTyKiAFn4nf4H1kllUPMsi8oi1tJzlareAmIBW5WR
         P82+h3pRDf7doZcsiIX0CkdcOsnFI5QNt6pTuF4TZ6ArkSO4IV5lZwAFG9BV5OpVC9Lf
         xSIrxW4NTQc8PTBwSTwRFsWcLPhuVTueV8GCG4denqhRL6vUVceNFs3puxfVENhjCU/f
         lSc4yl8wkbddzozrlilWHf/yhN6MkJaZn/whqQhGzE8GJF9C/96c1HoYhvaITknoJBUp
         zMWw==
X-Gm-Message-State: AD7BkJJcgbrHZK7olNdHDog5mN2RGSgo60Tpy9aH/MWjMh2Q6Cfg8hx2pYwKoqwDlctymQ==
X-Received: by 10.194.8.38 with SMTP id o6mr31611483wja.31.1458061922980;
        Tue, 15 Mar 2016 10:12:02 -0700 (PDT)
Received: from localhost (cable-86-56-55-109.cust.telecolumbus.net. [86.56.55.109])
        by smtp.gmail.com with ESMTPSA id v188sm21621578wmv.3.2016.03.15.10.12.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 10:12:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.181.g7f8255e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288883>

Translate 22 new messages came from git.pot update in f1522b2
(l10n: git.pot: v2.8.0 round 2 (21 new, 1 removed)) and a5a4168
(l10n: git.pot: Add one new message for Git 2.8.0).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 68 ++++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/po/de.po b/po/de.po
index edee6db..7093139 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1150,14 +1150,14 @@ msgid "unrecognized format: %%(%s)"
 msgstr "nicht erkanntes Format: %%(%s)"
=20
 #: ref-filter.c:77
-#, fuzzy, c-format
+#, c-format
 msgid "%%(body) does not take arguments"
-msgstr "--worktrees akzeptiert keine weiteren Argumente"
+msgstr "%%(body) akzeptiert keine Argumente"
=20
 #: ref-filter.c:84
-#, fuzzy, c-format
+#, c-format
 msgid "%%(subject) does not take arguments"
-msgstr "--worktrees akzeptiert keine weiteren Argumente"
+msgstr "%%(subject) akzeptiert keine Argumente"
=20
 #: ref-filter.c:101
 #, c-format
@@ -1200,14 +1200,14 @@ msgid "positive width expected with the %%(alig=
n) atom"
 msgstr "Positive Breitenangabe f=C3=BCr %%(align) erwartet"
=20
 #: ref-filter.c:244
-#, fuzzy, c-format
+#, c-format
 msgid "malformed field name: %.*s"
-msgstr "Missgebildeter Objektname %s"
+msgstr "Fehlerhafter Feldname: %.*s"
=20
 #: ref-filter.c:270
-#, fuzzy, c-format
+#, c-format
 msgid "unknown field name: %.*s"
-msgstr "unbekanntes Argument f=C3=BCr Option --mirror: %s"
+msgstr "Unbekannter Feldname: %.*s"
=20
 #: ref-filter.c:372
 #, c-format
@@ -1215,33 +1215,33 @@ msgid "format: %%(end) atom used without corres=
ponding atom"
 msgstr "Format: %%(end) Atom ohne zugeh=C3=B6riges Atom verwendet"
=20
 #: ref-filter.c:424
-#, fuzzy, c-format
+#, c-format
 msgid "malformed format string %s"
-msgstr "Fehlerhafter Ident-String: '%s'"
+msgstr "Fehlerhafter Formatierungsstring %s"
=20
 #: ref-filter.c:878
 msgid ":strip=3D requires a positive integer argument"
-msgstr ""
+msgstr ":strip=3D erfordert eine positive Ganzzahl als Argument"
=20
 #: ref-filter.c:883
-#, fuzzy, c-format
+#, c-format
 msgid "ref '%s' does not have %ld components to :strip"
-msgstr "Pfad '%s' hat nicht alle notwendigen Versionen."
+msgstr "Referenz '%s' hat keine %ld Komponenten f=C3=BCr :strip"
=20
 #: ref-filter.c:1046
-#, fuzzy, c-format
+#, c-format
 msgid "unknown %.*s format %s"
-msgstr "Unbekannter Commit %s"
+msgstr "Unbekanntes %.*s Format %s"
=20
 #: ref-filter.c:1066 ref-filter.c:1097
-#, fuzzy, c-format
+#, c-format
 msgid "missing object %s for %s"
-msgstr "fehlende Objekte erlauben"
+msgstr "Objekt %s fehlt f=C3=BCr %s"
=20
 #: ref-filter.c:1069 ref-filter.c:1100
 #, c-format
 msgid "parse_object_buffer failed on %s for %s"
-msgstr ""
+msgstr "parse_object_buffer bei %s f=C3=BCr %s fehlgeschlagen"
=20
 #: ref-filter.c:1311
 #, c-format
@@ -1249,14 +1249,14 @@ msgid "malformed object at '%s'"
 msgstr "fehlerhaftes Objekt bei '%s'"
=20
 #: ref-filter.c:1373
-#, fuzzy, c-format
+#, c-format
 msgid "ignoring ref with broken name %s"
-msgstr "ignoriere Vorlage %s"
+msgstr "Ignoriere Referenz mit fehlerhaftem Namen %s"
=20
 #: ref-filter.c:1378
-#, fuzzy, c-format
+#, c-format
 msgid "ignoring broken ref %s"
-msgstr "ignoriere Vorlage %s"
+msgstr "Ignoriere fehlerhafte Referenz %s"
=20
 #: ref-filter.c:1651
 #, c-format
@@ -1680,17 +1680,17 @@ msgstr "Fehler beim Lesen von %s"
=20
 #: sha1_file.c:1080
 msgid "offset before end of packfile (broken .idx?)"
-msgstr ""
+msgstr "Offset vor Ende der Packdatei (fehlerhafte Indexdatei?)"
=20
 #: sha1_file.c:2459
 #, c-format
 msgid "offset before start of pack index for %s (corrupt index?)"
-msgstr ""
+msgstr "Offset vor Beginn des Pack-Index f=C3=BCr %s (besch=C3=A4digte=
r Index?)"
=20
 #: sha1_file.c:2463
 #, c-format
 msgid "offset beyond end of pack index for %s (truncated index?)"
-msgstr ""
+msgstr "Offset hinter Ende des Pack-Index f=C3=BCr %s (abgeschnittener=
 Index?)"
=20
 #: sha1_name.c:462
 msgid ""
@@ -1743,9 +1743,9 @@ msgid "staging updated .gitmodules failed"
 msgstr "Konnte aktualisierte .gitmodules-Datei nicht zum Commit vormer=
ken"
=20
 #: trailer.c:237
-#, fuzzy, c-format
+#, c-format
 msgid "running trailer command '%s' failed"
-msgstr "Zusammenf=C3=BChren der \"Tree\"-Objekte %s und %s fehlgeschla=
gen"
+msgstr "Ausf=C3=BChren des Anhang-Befehls '%s' fehlgeschlagen"
=20
 #: trailer.c:492 trailer.c:496 trailer.c:500 trailer.c:554 trailer.c:5=
58
 #: trailer.c:562
@@ -4324,9 +4324,8 @@ msgid "HEAD is now at"
 msgstr "HEAD ist jetzt bei"
=20
 #: builtin/checkout.c:665 builtin/clone.c:659
-#, fuzzy
 msgid "unable to update HEAD"
-msgstr "Konnte HEAD nicht aufl=C3=B6sen."
+msgstr "Konnte HEAD nicht aktualisieren."
=20
 #: builtin/checkout.c:669
 #, c-format
@@ -4864,6 +4863,8 @@ msgid ""
 "No directory name could be guessed.\n"
 "Please specify a directory on the command line"
 msgstr ""
+"Konnte keinen Verzeichnisnamen erraten.\n"
+"Bitte geben Sie ein Verzeichnis auf der Befehlszeile an."
=20
 #: builtin/clone.c:305
 #, c-format
@@ -4945,9 +4946,9 @@ msgid "remote did not send all necessary objects"
 msgstr "Remote-Repository hat nicht alle erforderlichen Objekte gesend=
et."
=20
 #: builtin/clone.c:647
-#, fuzzy, c-format
+#, c-format
 msgid "unable to update %s"
-msgstr "kann %s nicht =C3=B6ffnen"
+msgstr "kann %s nicht aktualisieren"
=20
 #: builtin/clone.c:696
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
@@ -4960,9 +4961,8 @@ msgid "unable to checkout working tree"
 msgstr "Arbeitsverzeichnis konnte nicht ausgecheckt werden"
=20
 #: builtin/clone.c:753
-#, fuzzy
 msgid "unable to write parameters to config file"
-msgstr "konnte Tag-Datei nicht schreiben"
+msgstr "konnte Parameter nicht in Konfigurationsdatei schreiben"
=20
 #: builtin/clone.c:816
 msgid "cannot repack to clean up"
@@ -11674,7 +11674,7 @@ msgstr "Remote-Referenzen mitsamt den verbunden=
en Objekten aktualisieren"
=20
 #: common-cmds.h:32
 msgid "Reapply commits on top of another base tip"
-msgstr ""
+msgstr "Wiederholtes Anwenden von Commits auf anderem Basis-Commit"
=20
 #: common-cmds.h:33
 msgid "Reset current HEAD to the specified state"
--=20
2.8.0.rc2.181.g7f8255e
