From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv2] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 19:33:32 +0100
Message-ID: <1359398014-3325-1-git-send-email-ralf.thielow@gmail.com>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jojo@schmitz-digital.de
X-From: git-owner@vger.kernel.org Mon Jan 28 19:34:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztWz-0004Ej-IW
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab3A1Sds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 13:33:48 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:61569 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3A1Sdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:33:46 -0500
Received: by mail-bk0-f43.google.com with SMTP id jm19so1059784bkc.2
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4jT6VKnjfNJu4td0wRnRsMoi9SMQVgAvqtOS+9giMSY=;
        b=L7YVEbE3/JucigFk0ge7xfONlC/fvsDwqjwogK8ERshodrUBm1SaA5fWi47guF/ekf
         vQH2U0Am/0vzF2rIfdlBaDeDH5b+vGAwfyOAcKmkZdGaWPTzgp59pf++xbIyBS70P/0i
         xXZq7jCmTV7t4IoNRcvwftW2l57Vo7Co7qsXgpsQ8H4Ztq1ecTWakRXS4ONo237Kd5av
         oPqxDhETTv02CliVtui57OUMU0LSzvq4EzvOtQW8PvSzES0t4z1itgZGVIQ1ymRijGyd
         VuOSMjBeLH9XxuZIjoTpwY5H2jxT7NwWF/ZcyikRPTm77x/NxqB4YJXnrpsD5girs/bn
         DmnA==
X-Received: by 10.204.150.205 with SMTP id z13mr4335305bkv.16.1359398024845;
        Mon, 28 Jan 2013 10:33:44 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id n1sm7137805bkv.14.2013.01.28.10.33.43
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 10:33:44 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
In-Reply-To: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214851>

Translate 11 new messages came from git.pot update
in 46bc403 (l10n: Update git.pot (11 new, 7 removed
messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
Acked-by: Thomas Rast <trast@inf.ethz.ch>
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
