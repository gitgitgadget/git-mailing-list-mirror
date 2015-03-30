From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] =?UTF-8?q?l10n:=20de.po:=20translate=20'symbolic=20link'?= =?UTF-8?q?=20as=20'symbolische=20Verkn=C3=BCpfung'?=
Date: Mon, 30 Mar 2015 19:41:24 +0200
Message-ID: <1427737284-5887-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:41:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdgy-00029w-Up
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbbC3Rlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 13:41:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34457 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbbC3Rl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:41:28 -0400
Received: by wibg7 with SMTP id g7so97357408wib.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=KNZ/PaqhWZPadDKb9ioB7AccTjJRQW2AQ24fGFFWiq0=;
        b=V6g6MtKqKIGz03VkttWdUajOenM+cN7iUeJttEqy7ycPQJr7AaqJ4uKG/Fl8t8iD0B
         TGg39zq/NhxUtvfMdX5NjnpivoTCxDRtjXCpj6GZBZOjV7T0EFkKLh6fQFt7MMF8EzUn
         eLLK3LSPVgB5MPhUaAwiqed3/IxwUtTRQ2bD3wA5jUjiBzIzpDEFSbrLmz+9V+QT7I2a
         hM/iSMLaRBZ8WOQFDc7ZczPuDyXsfYIk7WK/XUqiLbj4osqDA7TacmHQ5LLB3UnQ67J/
         iFnqLQou4c8Wbb5LguQpRe/OI98hJUwMxx752Qd4f8RsnF8BLXOcY8i7482F5Q2bxT4N
         bk8g==
X-Received: by 10.180.12.84 with SMTP id w20mr25330588wib.9.1427737286965;
        Mon, 30 Mar 2015 10:41:26 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id i3sm16644790wiy.23.2015.03.30.10.41.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 10:41:26 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.554.gb58f7a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266461>

=46rom: Matthias R=C3=BCster <matthias.ruester@gmail.com>

The use of 'symbolische Verkn=C3=BCpfung' for 'symbolic link' is more c=
ommon
than 'symbolischer Verweis'.

Signed-off-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/po/de.po b/po/de.po
index 58e0c8f..9f0137b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -710,7 +710,7 @@ msgstr "Fehler beim =C3=96ffnen von '%s'"
 #: merge-recursive.c:797
 #, c-format
 msgid "failed to symlink '%s'"
-msgstr "Fehler beim Erstellen eines symbolischen Verweises f=C3=BCr '%=
s'"
+msgstr "Fehler beim Erstellen einer symbolischen Verkn=C3=BCpfung f=C3=
=BCr '%s'"
=20
 #: merge-recursive.c:800
 #, c-format
@@ -1025,7 +1025,7 @@ msgstr ""
 #: pathspec.c:432
 #, c-format
 msgid "pathspec '%s' is beyond a symbolic link"
-msgstr "Pfadspezifikation '%s' ist hinter einem symbolischen Verweis"
+msgstr "Pfadspezifikation '%s' ist hinter einer symbolischen Verkn=C3=BC=
pfung"
=20
 #: pathspec.c:441
 msgid ""
@@ -2318,7 +2318,7 @@ msgstr "Patch mit nutzlosen Informationen bei Zei=
le %d"
 #: builtin/apply.c:2141
 #, c-format
 msgid "unable to read symlink %s"
-msgstr "konnte symbolischen Verweis %s nicht lesen"
+msgstr "konnte symbolische Verkn=C3=BCpfung %s nicht lesen"
=20
 #: builtin/apply.c:2145
 #, c-format
@@ -2386,7 +2386,7 @@ msgstr "Konnte %s nicht lesen"
 #: builtin/apply.c:3238
 #, c-format
 msgid "reading from '%s' beyond a symbolic link"
-msgstr "'%s' ist hinter einem symbolischen Verweis"
+msgstr "'%s' ist hinter einer symbolischen Verkn=C3=BCpfung"
=20
 #: builtin/apply.c:3266 builtin/apply.c:3488
 #, c-format
@@ -2450,7 +2450,7 @@ msgstr "neuer Modus (%o) von %s entspricht nicht =
dem alten Modus (%o) von %s"
 #: builtin/apply.c:3793
 #, c-format
 msgid "affected file '%s' is beyond a symbolic link"
-msgstr "betroffene Datei '%s' ist hinter einem symbolischen Verweis"
+msgstr "betroffene Datei '%s' ist hinter einer symbolischen Verkn=C3=BC=
pfung"
=20
 #: builtin/apply.c:3797
 #, c-format
@@ -5212,7 +5212,7 @@ msgstr "Die Option --dirty kann nicht mit Commits=
 verwendet werden."
 #: builtin/diff.c:86
 #, c-format
 msgid "'%s': not a regular file or symlink"
-msgstr "'%s': keine regul=C3=A4re Datei oder symbolischer Verweis"
+msgstr "'%s': keine regul=C3=A4re Datei oder symbolische Verkn=C3=BCpf=
ung"
=20
 #: builtin/diff.c:237
 #, c-format
@@ -6493,12 +6493,12 @@ msgstr "kann Verweis '%s' nicht lesen"
 #: builtin/init-db.c:99
 #, c-format
 msgid "insanely long symlink %s"
-msgstr "zu langer symbolischer Verweis %s"
+msgstr "zu lange symbolische Verkn=C3=BCpfung %s"
=20
 #: builtin/init-db.c:102
 #, c-format
 msgid "cannot symlink '%s' '%s'"
-msgstr "kann symbolischen Verweis '%s' auf '%s' nicht erstellen"
+msgstr "kann symbolische Verkn=C3=BCpfung '%s' auf '%s' nicht erstelle=
n"
=20
 #: builtin/init-db.c:106
 #, c-format
@@ -10370,7 +10370,7 @@ msgstr "zwei oder mehr Entwicklungszweige zusam=
menf=C3=BChren"
 #: common-cmds.h:20
 msgid "Move or rename a file, a directory, or a symlink"
 msgstr ""
-"eine Datei, ein Verzeichnis, oder einen symbolischen Verweis verschie=
ben "
+"eine Datei, ein Verzeichnis, oder eine symbolische Verkn=C3=BCpfung v=
erschieben "
 "oder umbenennen"
=20
 #: common-cmds.h:21
--=20
2.3.4.554.gb58f7a9
