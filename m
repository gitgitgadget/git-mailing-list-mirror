From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 07:14:59 +0100
Message-ID: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Jan 28 07:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzi0B-0004id-DP
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 07:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab3A1GPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 01:15:10 -0500
Received: from mail-ea0-f172.google.com ([209.85.215.172]:54298 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3A1GPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 01:15:08 -0500
Received: by mail-ea0-f172.google.com with SMTP id f13so1019944eaa.31
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 22:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=6OAz9btkJ6SZ62RMtzzl8gJgHr4dYNanQ0BDrTPi1nc=;
        b=ZrABlICD03kn5lCiIAeeVEcNTdscd+U+iVvVeHHfNxselEENkW1XtW7aMwcjYbFEwQ
         fAA55ZNYNQdjg1RnR/KaydaIke36Lt09/ayVRRtQ4xAVg98Y7Lx/Uiv1BWVpS9Bk1uU6
         Mm18JnGS9Z7R9Lo2A2zPDkX9W78qjzL78QzGH+7KFpdUxZ/mjxKPKmlAC9uJoyG6c1DS
         Aqz5SFXWbRcr9h6ZBefaD9MnczaWWe0VUTKQdS9ot26vub/UYIe3eSNaLnZM6ggBcjYX
         gMMvx8i3HO0Ayd1N6gmNJpTl0USPkUVMTIrhsARbHxQLxYWXhQybEWIDV9uPXB2V2WB6
         xj3Q==
X-Received: by 10.14.198.198 with SMTP id v46mr33533867een.4.1359353707162;
        Sun, 27 Jan 2013 22:15:07 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id t4sm14542369eel.0.2013.01.27.22.15.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 22:15:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214811>

Translate 11 new messages came from git.pot update
in 46bc403 (l10n: Update git.pot (11 new, 7 removed
messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/po/de.po b/po/de.po
index 3779f4c..ed8330a 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5,7 +5,7 @@
 #
 msgid ""
 msgstr ""
-"Project-Id-Version: git 1.8.1\n"
+"Project-Id-Version: git 1.8.2\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2013-01-25 12:33+0800\n"
 "PO-Revision-Date: 2012-10-02 19:35+0200\n"
@@ -1033,9 +1033,9 @@ msgid "unable to access '%s': %s"
 msgstr "konnte nicht auf '%s' zugreifen: %s"
=20
 #: wrapper.c:423
-#, fuzzy, c-format
+#, c-format
 msgid "unable to access '%s'"
-msgstr "konnte nicht auf '%s' zugreifen: %s"
+msgstr "konnte nicht auf '%s' zugreifen"
=20
 #: wrapper.c:434
 #, c-format
@@ -2997,14 +2997,14 @@ msgid "Would remove %s\n"
 msgstr "W=C3=BCrde %s l=C3=B6schen\n"
=20
 #: builtin/clean.c:26
-#, fuzzy, c-format
+#, c-format
 msgid "Skipping repository %s\n"
-msgstr "ung=C3=BCltiges Projektarchiv '%s'"
+msgstr "=C3=9Cberspringe Projektarchiv %s\n"
=20
 #: builtin/clean.c:27
-#, fuzzy, c-format
+#, c-format
 msgid "Would skip repository %s\n"
-msgstr "ung=C3=BCltiges Projektarchiv '%s'"
+msgstr "W=C3=BCrde Projektarchiv %s =C3=BCberspringen\n"
=20
 #: builtin/clean.c:28
 #, c-format
@@ -3223,9 +3223,8 @@ msgid "--bare and --origin %s options are incompa=
tible."
 msgstr "Die Optionen --bare und --origin %s sind inkompatibel."
=20
 #: builtin/clone.c:708
-#, fuzzy
 msgid "--bare and --separate-git-dir are incompatible."
-msgstr "Die Optionen --bare und --origin %s sind inkompatibel."
+msgstr "Die Optionen --bare und --separate-git-dir sind inkompatibel."
=20
 #: builtin/clone.c:721
 #, c-format
@@ -5449,7 +5448,7 @@ msgstr "zeigt Quelle"
=20
 #: builtin/log.c:104
 msgid "Use mail map file"
-msgstr ""
+msgstr "verwendet \"mailmap\"-Datei"
=20
 #: builtin/log.c:105
 msgid "decorate options"
@@ -5542,7 +5541,7 @@ msgstr "beginnt die Nummerierung der Patches bei =
<n> anstatt bei 1"
=20
 #: builtin/log.c:1114
 msgid "mark the series as Nth re-roll"
-msgstr ""
+msgstr "kennzeichnet die Serie als n-te Fassung"
=20
 #: builtin/log.c:1116
 msgid "Use [<prefix>] instead of [PATCH]"
@@ -7099,6 +7098,8 @@ msgid ""
 "Updates were rejected because the destination reference already exist=
s\n"
 "in the remote."
 msgstr ""
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Zielreferenz be=
reits\n"
+"im Fernarchiv existiert."
=20
 #: builtin/push.c:269
 #, c-format
@@ -7841,14 +7842,12 @@ msgstr ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Versi=
on>]"
=20
 #: builtin/reset.c:26
-#, fuzzy
 msgid "git reset [-q] <tree-ish> [--] <paths>..."
-msgstr "git reset [-q] <Version> [--] <Pfade>..."
+msgstr "git reset [-q] <Versionsreferenz> [--] <Pfade>..."
=20
 #: builtin/reset.c:27
-#, fuzzy
 msgid "git reset --patch [<tree-ish>] [--] [<paths>...]"
-msgstr "git reset --patch [<Version>] [--] [<Pfade>...]"
+msgstr "git reset --patch [<Versionsreferenz>] [--] [<Pfade>...]"
=20
 #: builtin/reset.c:33
 msgid "mixed"
@@ -7916,9 +7915,9 @@ msgid "reset HEAD but keep local changes"
 msgstr "setzt Zweigspitze (HEAD) zur=C3=BCck, beh=C3=A4lt aber lokale =
=C3=84nderungen"
=20
 #: builtin/reset.c:275
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to resolve '%s' as a valid revision."
-msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
+msgstr "Konnte '%s' nicht als g=C3=BCltige Revision aufl=C3=B6sen."
=20
 #: builtin/reset.c:278 builtin/reset.c:286
 #, c-format
@@ -7926,9 +7925,9 @@ msgid "Could not parse object '%s'."
 msgstr "Konnte Objekt '%s' nicht parsen."
=20
 #: builtin/reset.c:283
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to resolve '%s' as a valid tree."
-msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6sen."
+msgstr "Konnte '%s' nicht als g=C3=BCltigen Baum aufl=C3=B6sen."
=20
 #: builtin/reset.c:292
 msgid "--patch is incompatible with --{hard,mixed,soft}"
--=20
1.8.1.1.439.g50a6b54
