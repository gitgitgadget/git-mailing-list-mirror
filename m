From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH de.po 2/5] =?UTF-8?q?de.po:=20translate=20"bare"=20as=20"blo=C3=9F?= =?UTF-8?q?"?=
Date: Wed, 2 May 2012 15:49:24 +0200
Message-ID: <53df440b95ea19567a12f4a58410cc0fe0aa43b5.1335966202.git.trast@student.ethz.ch>
References: <cover.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:49:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZwF-0004vt-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab2EBNtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:49:41 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27485 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab2EBNtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:49:31 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:49:27 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 15:49:28 +0200
X-Mailer: git-send-email 1.7.10.625.g300dcf
In-Reply-To: <cover.1335966202.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196821>

git-gui has had precedent for "leer" since ab2d3b0 (git-gui: Update
German translation (12 new or changed strings)., 2010-01-26).
However, that would be "empty".

Change it both in git-gui and git itself.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-gui/po/de.po |    4 ++--
 po/de.po         |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-gui/po/de.po b/git-gui/po/de.po
index 44c5ddc..9458f6e 100644
--- a/git-gui/po/de.po
+++ b/git-gui/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2010-01-26 22:22+0100\n"
-"PO-Revision-Date: 2010-01-26 22:25+0100\n"
+"PO-Revision-Date: 2012-05-02 11:54+0200\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
 "MIME-Version: 1.0\n"
@@ -72,7 +72,7 @@ msgstr ""
=20
 #: git-gui.sh:1154
 msgid "Cannot use bare repository:"
-msgstr "Leeres Projektarchiv kann nicht benutzt werden:"
+msgstr "Blo=C3=9Fes Projektarchiv kann nicht benutzt werden:"
=20
 #: git-gui.sh:1162
 msgid "No working directory"
diff --git a/po/de.po b/po/de.po
index a43f646..a7a39ed 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,7 +8,7 @@ msgstr ""
 "Project-Id-Version: git 1.7.10\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2012-04-28 20:17+0800\n"
-"PO-Revision-Date: 2012-03-28 18:46+0200\n"
+"PO-Revision-Date: 2012-05-02 15:10+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@googlemail.com>\n"
 "Language-Team: German\n"
 "Language: de\n"
@@ -1376,7 +1376,7 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht erst=
ellen."
 #: builtin/clone.c:728
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
-msgstr "Klone in leeres Projektarchiv '%s'...\n"
+msgstr "Klone in blo=C3=9Fes Projektarchiv '%s'...\n"
=20
 #: builtin/clone.c:730
 #, c-format
@@ -3133,7 +3133,7 @@ msgstr "Kann keine %s Zur=C3=BCcksetzung mit Pfad=
en machen."
 #: builtin/reset.c:325
 #, c-format
 msgid "%s reset is not allowed in a bare repository"
-msgstr "%s Zur=C3=BCcksetzung ist in einem leeren Projektarchiv nicht =
erlaubt"
+msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=9Fen Projektarchiv=
 nicht erlaubt"
=20
 #: builtin/reset.c:341
 #, c-format
--=20
1.7.10.625.g300dcf
