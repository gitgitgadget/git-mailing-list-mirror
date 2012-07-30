From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH/RFC=5D=20l10n=3A=20de=2Epo=3A=20translate=204=20new=20messages?=
Date: Mon, 30 Jul 2012 18:08:56 +0200
Message-ID: <1343664536-11408-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Jul 30 18:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvsX8-0001V1-D3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab2G3QJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 12:09:21 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51039 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab2G3QJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:09:20 -0400
Received: by bkwj10 with SMTP id j10so2901484bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4k+AGhPfGPU513fQWZ4nYEM4cXRpN4MLH2liCRz5WYQ=;
        b=E3v5U7QvSvfccIUyPVtrgLv2u4QFs4wJ9ji/EyOSlZG+Dxlgmys819gSXljxiFu84Z
         VQduidgeBDpKtifRXr3v4fKVQzhhrRnu3jxDSXp9fden1+ZpBnQU29lS+XkEkrUpdotN
         hZEoaqQe137x8lTX8bGcV1BI5Cvd1nTFBDuLPVgj559FGPfqelbFx/YHJFjO9kn74DG5
         ygLj4wyRBkXsgt3dgoMSIuaMuGrPy5QaZyzjcb1c9Uxy/2mPmZxqwmkS4roq3GM1Ho6u
         G2JuIL2Y5ocrMAj7F21T3Yizw3AiaDTysp7ELOgAvmWH38WZDbORqKPfKss4YcAy6HZo
         UlsQ==
Received: by 10.205.117.141 with SMTP id fm13mr4202177bkc.125.1343664558766;
        Mon, 30 Jul 2012 09:09:18 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id fu8sm4090493bkc.5.2012.07.30.09.09.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 09:09:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202570>

Translate 4 new messages came from git.pot update in 0bbe5b4
(l10n: Update git.pot (4 new, 3 removed messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Hi German l10n team,

please review this small update on German
translation.

Thanks,
Ralf

 po/de.po | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/po/de.po b/po/de.po
index 0f9323d..c44cabe 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5,7 +5,7 @@
 #
 msgid ""
 msgstr ""
-"Project-Id-Version: git 1.7.11\n"
+"Project-Id-Version: git 1.7.12\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2012-07-30 09:18+0800\n"
 "PO-Revision-Date: 2012-03-28 18:46+0200\n"
@@ -1320,9 +1320,9 @@ msgid "patch failed: %s:%ld"
 msgstr "Anwendung des Patches fehlgeschlagen: %s:%ld"
=20
 #: builtin/apply.c:3061
-#, fuzzy, c-format
+#, c-format
 msgid "cannot checkout %s"
-msgstr "kann nicht in Verzeichnis %s wechseln"
+msgstr "kann %s nicht auschecken"
=20
 #: builtin/apply.c:3106 builtin/apply.c:3115 builtin/apply.c:3159
 #, c-format
@@ -1330,9 +1330,9 @@ msgid "read of %s failed"
 msgstr "Konnte %s nicht lesen"
=20
 #: builtin/apply.c:3139 builtin/apply.c:3361
-#, fuzzy, c-format
+#, c-format
 msgid "path %s has been renamed/deleted"
-msgstr "Patch %s wurde umbenannt/gel=C3=B6scht"
+msgstr "Pfad %s wurde umbenannt/gel=C3=B6scht"
=20
 #: builtin/apply.c:3220 builtin/apply.c:3375
 #, c-format
@@ -1537,7 +1537,8 @@ msgstr "wendet den Patch an (Benutzung mit --stat=
/--summary/--check)"
=20
 #: builtin/apply.c:4312
 msgid "attempt three-way merge if a patch does not apply"
-msgstr ""
+msgstr "versucht 3-Wege-Zusammenf=C3=BChrung, wenn der Patch nicht ang=
ewendet "
+"werden konnte"
=20
 #: builtin/apply.c:4314
 msgid "build a temporary index based on embedded index information"
@@ -1605,9 +1606,8 @@ msgid "prepend <root> to all filenames"
 msgstr "stellt <Wurzelverzeichnis> vor alle Dateinamen"
=20
 #: builtin/apply.c:4367
-#, fuzzy
 msgid "--3way outside a repository"
-msgstr "--cached au=C3=9Ferhalb eines Projektarchivs"
+msgstr "--3way au=C3=9Ferhalb eines Projektarchivs"
=20
 #: builtin/apply.c:4375
 msgid "--index outside a repository"
--=20
1.7.11.2
