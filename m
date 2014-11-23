From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typos
Date: Sun, 23 Nov 2014 17:41:17 +0100
Message-ID: <1416760877-6050-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com, worldhello.net@gmail.com,
	Hartmut Henkel <hartmut_henkel@gmx.de>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 23 17:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsaE9-0007Mn-At
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 17:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaKWQl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 11:41:29 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54294 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaKWQl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 11:41:28 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so3537247wiv.6
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=npabC352wcZAuQiAON2Ch7jJJSEeBtaM0f54+rBFQLI=;
        b=oLQa4s9s6cL/VPJwwFiHqcr7dxSaY9S9lVnW63X6QO+Z+wUJyv66IA+umdGquy1aji
         3IVJ1VOhI+yiedyKmg0FPplHuBfqAva9zpqVIWoq1QiAW3sHQn5y+7BSYz6jwOE7uk3k
         GPChpQbz/kO8ifdXhiHpX5TwNVF4/ihCh+QS3dXHEkO/5ByOyiH7RjtNO8Q5M8wkJ6vN
         BlJc9UDYaNxgS2cyBkSBnSljvMk3BIvVAmdsGKnEKkTjltr2VhYC3FJm43rIoWHeP4fk
         kj/QP0OyTS7wwXRIw/4rNeKl/jrIw+jqQREq8brSk9LBEse8h6EFRFXDIOWOw9FEpgl4
         40dA==
X-Received: by 10.181.27.135 with SMTP id jg7mr14320602wid.56.1416760886721;
        Sun, 23 Nov 2014 08:41:26 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id gi5sm17076258wjd.26.2014.11.23.08.41.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 08:41:26 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3.268.gf546f9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260089>

=46rom: Hartmut Henkel <hartmut_henkel@gmx.de>

Signed-off-by: Hartmut Henkel <hartmut_henkel@gmx.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Junio,

please apply this patch directly to your
tree.

Thanks!

 po/de.po | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index 56263b4..5a93ea8 100644
--- a/po/de.po
+++ b/po/de.po
@@ -644,11 +644,11 @@ msgstr "%s: %s - %s"
=20
 #: lockfile.c:275
 msgid "BUG: reopen a lockfile that is still open"
-msgstr "FEHLER: Wiederer=C3=B6ffnen einer bereits ge=C3=B6ffneten Lock=
-Datei"
+msgstr "FEHLER: Wieder=C3=B6ffnen einer bereits ge=C3=B6ffneten Lock-D=
atei"
=20
 #: lockfile.c:277
 msgid "BUG: reopen a lockfile that has been committed"
-msgstr "FEHLER: Wiederer=C3=B6ffnen einer bereits committeten Lock-Dat=
ei"
+msgstr "FEHLER: Wieder=C3=B6ffnen einer bereits committeten Lock-Datei=
"
=20
 #: merge.c:41
 msgid "failed to read the cache"
@@ -1956,7 +1956,7 @@ msgstr "Unbeobachtete Dateien nicht aufgelistet%s=
"
=20
 #: wt-status.c:1370
 msgid " (use -u option to show untracked files)"
-msgstr " (benutzen Sie die Option -u, um unbeobachteten Dateien anzuze=
igen)"
+msgstr " (benutzen Sie die Option -u, um unbeobachtete Dateien anzuzei=
gen)"
=20
 #: wt-status.c:1376
 msgid "No changes"
@@ -2810,7 +2810,7 @@ msgstr "Commits von <Datei> benutzen, anstatt \"g=
it-rev-list\" aufzurufen"
=20
 #: builtin/blame.c:2518
 msgid "Use <file>'s contents as the final image"
-msgstr "Inhalte der <Datei>en als entg=C3=BCltiges Abbild benutzen"
+msgstr "Inhalte der <Datei>en als endg=C3=BCltiges Abbild benutzen"
=20
 #: builtin/blame.c:2519 builtin/blame.c:2520
 msgid "score"
@@ -3078,7 +3078,7 @@ msgstr "Informationen zum Upstream-Branch =C3=A4n=
dern"
=20
 #: builtin/branch.c:823
 msgid "use colored output"
-msgstr "farbliche Ausgaben verwenden"
+msgstr "farbige Ausgaben verwenden"
=20
 #: builtin/branch.c:824
 msgid "act on remote-tracking branches"
@@ -5585,7 +5585,7 @@ msgstr "Platzhalter als Python-String formatieren=
"
=20
 #: builtin/for-each-ref.c:1078
 msgid "quote placeholders suitably for tcl"
-msgstr "Platzhalter als TCL-String formatieren"
+msgstr "Platzhalter als Tcl-String formatieren"
=20
 #: builtin/for-each-ref.c:1081
 msgid "show only <n> matched refs"
@@ -6892,7 +6892,7 @@ msgstr ""
=20
 #: builtin/ls-files.c:462
 msgid "show cached files in the output (default)"
-msgstr "zwischengespeicherten Dateien in der Ausgabe anzeigen (Standar=
d)"
+msgstr "zwischengespeicherte Dateien in der Ausgabe anzeigen (Standard=
)"
=20
 #: builtin/ls-files.c:464
 msgid "show deleted files in the output"
@@ -8119,7 +8119,7 @@ msgstr "Komprimierungsgrad f=C3=BCr Paketierung"
=20
 #: builtin/pack-objects.c:2685
 msgid "do not hide commits by grafts"
-msgstr "keine k=C3=BCnstlichen Vorg=C3=A4nger-Commit (\"grafts\") verb=
ergen"
+msgstr "keine k=C3=BCnstlichen Vorg=C3=A4nger-Commits (\"grafts\") ver=
bergen"
=20
 #: builtin/pack-objects.c:2687
 msgid "use a bitmap index if available to speed up counting objects"
@@ -9695,7 +9695,7 @@ msgstr "Remote-Tracking-Branches anzeigen"
=20
 #: builtin/show-branch.c:653
 msgid "color '*!+-' corresponding to the branch"
-msgstr "'*!+-' entsprechend des Branches einf=C3=A4rgen"
+msgstr "'*!+-' entsprechend des Branches einf=C3=A4rben"
=20
 #: builtin/show-branch.c:655
 msgid "show <n> more commits after the common ancestor"
--=20
2.2.0.rc3.268.gf546f9c
