From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 03/10] =?UTF-8?q?l10n:=20de.po:=20translate=20"bad"=20as=20"?= =?UTF-8?q?ung=C3=BCltig"=20("invalid")?=
Date: Tue,  8 May 2012 19:33:38 +0200
Message-ID: <1336498425-17890-4-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJ5-00029S-CF
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab2EHRea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:30 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41121 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2EHRe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:28 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn19so437464wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a5B2EC18lAhA7v1t1rl12gzBo0ubnwndjLT3AGirLYY=;
        b=vvsvCip9QoHz1+yhdvU++ZXaoEesnH+RwG/HFHW0oB/oj775qnu1/gkZ+LxgvrOx+6
         5qC/oHE3vGaEavO16rB+07jKy0TEV2759XtHG/PbC2qu4toweuw1GiHVPYbnCadGBGmg
         +6S0zomWPlI3en+6pgDYTbfkJgkgvMSaNKEmOr0Arx2Rkfnk41ovVMcJb6pag5J0L4Vp
         jILCpQrSaQ1G52FIPFaBQI+fCJABfhHJM+6h7csrqjTmw/WUZnee25SgcRk/bbVN8GBk
         2Op03qGgltQDwrVgXHnUqrRf5LqNiPIK6IFktWJkWckqytWpQvW/od7eWXX3oWqkN9v+
         YFEQ==
Received: by 10.180.104.65 with SMTP id gc1mr46736683wib.13.1336498467659;
        Tue, 08 May 2012 10:34:27 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197401>

=46rom: Thomas Rast <trast@student.ethz.ch>

"schlecht" doesn't quite sound right to me, especially in messages
like "bad object" where the object doesn't even exist in the first
place.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   26 +++++++++++++-------------
 1 Datei ge=C3=A4ndert, 13 Zeilen hinzugef=C3=BCgt(+), 13 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 95f2b49..04e8468 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2076,7 +2076,7 @@ msgstr "keine Muster gegeben"
 #: builtin/grep.c:902
 #, c-format
 msgid "bad object %s"
-msgstr "schlechtes Objekt %s"
+msgstr "ung=C3=BCltiges Objekt %s"
=20
 #: builtin/grep.c:943
 msgid "--open-files-in-pager only works on the worktree"
@@ -2419,7 +2419,7 @@ msgstr "'%s' zeigt auf keine Version"
 #: builtin/merge.c:536
 #, c-format
 msgid "Bad branch.%s.mergeoptions string: %s"
-msgstr "Schlechter branch.%s.mergeoptions String: %s"
+msgstr "Ung=C3=BCltiger branch.%s.mergeoptions String: %s"
=20
 #: builtin/merge.c:629
 msgid "git write-tree failed to write a tree"
@@ -2634,7 +2634,7 @@ msgstr "Pr=C3=BCfe Umbenennen von '%s' nach '%s'\=
n"
=20
 #: builtin/mv.c:112
 msgid "bad source"
-msgstr "schlechte Quelle"
+msgstr "ung=C3=BCltige Quelle"
=20
 #: builtin/mv.c:115
 msgid "can not move directory into itself"
@@ -2761,7 +2761,7 @@ msgstr "Kann uninitialisierten/unreferenzierten N=
otiz-Baum nicht eintragen."
 #: builtin/notes.c:340
 #, c-format
 msgid "Bad notes.rewriteMode value: '%s'"
-msgstr "Schlechter notes.rewriteMode Wert: '%s'"
+msgstr "Ung=C3=BCltiger notes.rewriteMode Wert: '%s'"
=20
 #: builtin/notes.c:350
 #, c-format
@@ -2774,7 +2774,7 @@ msgstr ""
 #: builtin/notes.c:377
 #, c-format
 msgid "Bad %s value: '%s'"
-msgstr "Schlechter %s Wert: '%s'"
+msgstr "Ung=C3=BCltiger %s Wert: '%s'"
=20
 #: builtin/notes.c:441
 #, c-format
@@ -2856,7 +2856,7 @@ msgstr "Nicht unterst=C3=BCtzte Bereitstellungsve=
rsion %s"
 #: builtin/pack-objects.c:2314
 #, c-format
 msgid "bad index version '%s'"
-msgstr "Schlechte Bereitstellungsversion '%s'"
+msgstr "Ung=C3=BCltige Bereitstellungsversion '%s'"
=20
 #: builtin/pack-objects.c:2322
 #, c-format
@@ -2955,7 +2955,7 @@ msgstr ""
 #: builtin/push.c:176
 #, c-format
 msgid "bad repository '%s'"
-msgstr "schlechtes Projektarchiv '%s'"
+msgstr "ung=C3=BCltiges Projektarchiv '%s'"
=20
 #: builtin/push.c:177
 msgid ""
@@ -3214,7 +3214,7 @@ msgstr "konnte Markierungsdatei nicht schreiben"
=20
 #: builtin/tag.c:321
 msgid "bad object type."
-msgstr "schlechter Objekt-Typ"
+msgstr "ung=C3=BCltiger Objekt-Typ"
=20
 #: builtin/tag.c:334
 msgid "tag header too big."
@@ -3389,7 +3389,7 @@ msgstr "'$arg' scheint keine g=C3=BCltige Version=
 zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
-msgstr "Schlechte Zweigspitze (HEAD) - Ich brauche eine Zweigspitze (H=
EAD)"
+msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Ich brauche eine Zweigspit=
ze (HEAD)"
=20
 #: git-bisect.sh:130
 #, sh-format
@@ -3405,17 +3405,17 @@ msgstr "werde nicht auf gesuchtem Baum halbiere=
n"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
-msgstr "Schlechte Zweigspitze (HEAD) - merkw=C3=BCrdige symbolische Re=
ferenz"
+msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - merkw=C3=BCrdige symbolisc=
he Referenz"
=20
 #: git-bisect.sh:189
 #, sh-format
 msgid "Bad bisect_write argument: $state"
-msgstr "Schlechtes \"bisect_write\" Argument: $state"
+msgstr "Ung=C3=BCltiges \"bisect_write\" Argument: $state"
=20
 #: git-bisect.sh:218
 #, sh-format
 msgid "Bad rev input: $arg"
-msgstr "Schlechte Referenz-Eingabe: $arg"
+msgstr "Ung=C3=BCltige Referenz-Eingabe: $arg"
=20
 #: git-bisect.sh:232
 msgid "Please call 'bisect_state' with at least one argument."
@@ -3424,7 +3424,7 @@ msgstr "Bitte rufe 'bisect_state' mit mindestens =
einem Argument auf."
 #: git-bisect.sh:244
 #, sh-format
 msgid "Bad rev input: $rev"
-msgstr "Schlechte Referenz-Eingabe: $rev"
+msgstr "Ung=C3=BCltige Referenz-Eingabe: $rev"
=20
 #: git-bisect.sh:250
 msgid "'git bisect bad' can take only one argument."
--=20
1.7.10.129.g1ec31a3
