From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20l10n=3A=20de=2Epo=3A=20fix=20a=20few=20minor=20typos?=
Date: Thu,  4 Oct 2012 19:50:10 +0200
Message-ID: <1349373010-6499-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: simon@ruderich.org, trast@student.ethz.ch, jk@jk.gs,
	stimming@tuhh.de, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 01:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtei-00033L-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945961Ab2JDRu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 13:50:27 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:55853 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab2JDRuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 13:50:25 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so2177965wgb.1
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=/gs3bf9Um1WUBnzIiA5A88NPp8ZUT0JDe1CJ+qGxbtI=;
        b=a13W85BU82zjXJBvT4rYEKekdxy4g4EEH4ZHnMJQDm7+QaOdZkqZoP4WVmwWM8hBbR
         PcmR1CTCPlK/Mx9TSW0Z1Hx0tOTdATsFrEuAGOpvM0y1zTfhBYxxMhNDi4uPOIB37BeR
         hLMA4dUnuk9T7vnRTywQsrtxPACthd+DQtOdFti6QQun2SqzaoyZG/m9Ex5DEr9Fr4BZ
         nYibKpvfPUVpngZ42djAYbA6Ep7hGHr8BDWnE9VywxJTHsQmQ+coRbzWXxLtBi9EzoRW
         iKqUgm/cRm/tun3tl9Om5zmRF/xjaztTEPKHFKcdnKR2batIf66T9QSCHuHhrFKAV57y
         d0Pw==
Received: by 10.180.24.4 with SMTP id q4mr39680589wif.19.1349373024123;
        Thu, 04 Oct 2012 10:50:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id ct3sm33467630wib.5.2012.10.04.10.50.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 10:50:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.440.g924b2e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207044>

=46rom: Simon Ruderich <simon@ruderich.org>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 14 +++++++-------
 1 Datei ge=C3=A4ndert, 7 Zeilen hinzugef=C3=BCgt(+), 7 Zeilen entfernt=
(-)

diff --git a/po/de.po b/po/de.po
index a3cf695..9e9f2da 100644
--- a/po/de.po
+++ b/po/de.po
@@ -55,7 +55,7 @@ msgstr "Konnte '%s' nicht =C3=B6ffnen"
=20
 #: bundle.c:140
 msgid "Repository lacks these prerequisite commits:"
-msgstr "Dem Projektarchiv fehlen folgende vorrausgesetzte Versionen:"
+msgstr "Dem Projektarchiv fehlen folgende vorausgesetzte Versionen:"
=20
 #: bundle.c:164 sequencer.c:550 sequencer.c:982 builtin/log.c:290
 #: builtin/log.c:726 builtin/log.c:1316 builtin/log.c:1535 builtin/mer=
ge.c:347
@@ -1758,7 +1758,7 @@ msgstr "Anzahl"
 #: builtin/apply.c:4291
 msgid "remove <num> leading slashes from traditional diff paths"
 msgstr ""
-"entfernt <Anzahl> vorrangestellte Schr=C3=A4gstriche von herk=C3=B6mm=
lichen "
+"entfernt <Anzahl> vorangestellte Schr=C3=A4gstriche von herk=C3=B6mml=
ichen "
 "Differenzpfaden"
=20
 #: builtin/apply.c:4294
@@ -2065,7 +2065,7 @@ msgstr "Konnte einige Referenzen nicht lesen"
 #: builtin/branch.c:613
 msgid "cannot rename the current branch while not on any."
 msgstr ""
-"Kann aktuellen Zweig nicht umbennen, solange du dich auf keinem befin=
dest."
+"Kann aktuellen Zweig nicht umbenennen, solange du dich auf keinem bef=
indest."
=20
 #: builtin/branch.c:623
 #, c-format
@@ -2353,7 +2353,7 @@ msgid ""
 "git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
 "checking out of the index."
 msgstr ""
-"git checkout: --ours/--theirs, --force and --merge sind inkompatibel =
wenn\n"
+"git checkout: --ours/--theirs, --force und --merge sind inkompatibel =
wenn\n"
 "du aus der Bereitstellung auscheckst."
=20
 #: builtin/checkout.c:1093
@@ -3666,7 +3666,7 @@ msgstr "Konnte %s nicht nach %s verschieben"
 #: builtin/init-db.c:363
 #, c-format
 msgid "Could not create git link %s"
-msgstr "Konnte git-Verkn=C3=BCfung %s nicht erstellen"
+msgstr "Konnte git-Verkn=C3=BCpfung %s nicht erstellen"
=20
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -3778,11 +3778,11 @@ msgstr "unechte Einreicher-Informationen %s"
=20
 #: builtin/log.c:1205
 msgid "-n and -k are mutually exclusive."
-msgstr "-n und -k schliessen sich gegenseitig aus"
+msgstr "-n und -k schlie=C3=9Fen sich gegenseitig aus"
=20
 #: builtin/log.c:1207
 msgid "--subject-prefix and -k are mutually exclusive."
-msgstr "--subject-prefix und -k schliessen sich gegenseitig aus"
+msgstr "--subject-prefix und -k schlie=C3=9Fen sich gegenseitig aus"
=20
 #: builtin/log.c:1215
 msgid "--name-only does not make sense"
--=20
1.7.12.440.g924b2e8
