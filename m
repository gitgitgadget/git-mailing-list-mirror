From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH de.po 4/5] =?UTF-8?q?de.po:=20translate=20"bad"=20as=20"ung=C3=BCl?= =?UTF-8?q?tig"=20("invalid")?=
Date: Wed, 2 May 2012 15:49:26 +0200
Message-ID: <c04a3a07011c5786bd8e6846a959c41d37bc68f3.1335966202.git.trast@student.ethz.ch>
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
X-From: git-owner@vger.kernel.org Wed May 02 15:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZwE-0004vt-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab2EBNte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:49:34 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:3500 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2EBNtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:49:32 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:49:29 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196819>

"schlecht" doesn't quite sound right to me, especially in messages
like "bad object" where the object doesn't even exist in the first
place.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 po/de.po |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/po/de.po b/po/de.po
index d391632..a1a765a 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2101,7 +2101,7 @@ msgstr "keine Muster gegeben"
 #: builtin/grep.c:902
 #, c-format
 msgid "bad object %s"
-msgstr "schlechtes Objekt %s"
+msgstr "ung=C3=BCltiges Objekt %s"
=20
 #: builtin/grep.c:943
 msgid "--open-files-in-pager only works on the worktree"
@@ -2444,7 +2444,7 @@ msgstr "'%s' zeigt auf keine Version"
 #: builtin/merge.c:536
 #, c-format
 msgid "Bad branch.%s.mergeoptions string: %s"
-msgstr "Schlechter branch.%s.mergeoptions String: %s"
+msgstr "Ung=C3=BCltiger branch.%s.mergeoptions String: %s"
=20
 #: builtin/merge.c:629
 msgid "git write-tree failed to write a tree"
@@ -2659,7 +2659,7 @@ msgstr "Pr=C3=BCfe Umbenennen von '%s' nach '%s'\=
n"
=20
 #: builtin/mv.c:112
 msgid "bad source"
-msgstr "schlechte Quelle"
+msgstr "ung=C3=BCltige Quelle"
=20
 #: builtin/mv.c:115
 msgid "can not move directory into itself"
@@ -2786,7 +2786,7 @@ msgstr "Kann uninitialisierten/unreferenzierten N=
otiz-Baum nicht eintragen."
 #: builtin/notes.c:340
 #, c-format
 msgid "Bad notes.rewriteMode value: '%s'"
-msgstr "Schlechter notes.rewriteMode Wert: '%s'"
+msgstr "Ung=C3=BCltiger notes.rewriteMode Wert: '%s'"
=20
 #: builtin/notes.c:350
 #, c-format
@@ -2799,7 +2799,7 @@ msgstr ""
 #: builtin/notes.c:377
 #, c-format
 msgid "Bad %s value: '%s'"
-msgstr "Schlechter %s Wert: '%s'"
+msgstr "Ung=C3=BCltiger %s Wert: '%s'"
=20
 #: builtin/notes.c:441
 #, c-format
@@ -2881,7 +2881,7 @@ msgstr "Nicht unterst=C3=BCtzte Bereitstellungsve=
rsion %s"
 #: builtin/pack-objects.c:2314
 #, c-format
 msgid "bad index version '%s'"
-msgstr "Schlechte Bereitstellungsversion '%s'"
+msgstr "Ung=C3=BCltige Bereitstellungsversion '%s'"
=20
 #: builtin/pack-objects.c:2322
 #, c-format
@@ -3007,7 +3007,7 @@ msgstr "Fehler beim Versenden einiger Referenzen =
nach '%s'"
 #: builtin/push.c:226
 #, c-format
 msgid "bad repository '%s'"
-msgstr "schlechtes Projektarchiv '%s'"
+msgstr "ung=C3=BCltiges Projektarchiv '%s'"
=20
 #: builtin/push.c:227
 msgid ""
@@ -3266,7 +3266,7 @@ msgstr "konnte Markierungsdatei nicht schreiben"
=20
 #: builtin/tag.c:321
 msgid "bad object type."
-msgstr "schlechter Objekt-Typ"
+msgstr "ung=C3=BCltiger Objekt-Typ"
=20
 #: builtin/tag.c:334
 msgid "tag header too big."
@@ -3441,7 +3441,7 @@ msgstr "'$arg' scheint keine g=C3=BCltige Version=
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
@@ -3457,17 +3457,17 @@ msgstr "werde nicht auf gesuchtem Baum halbiere=
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
@@ -3476,7 +3476,7 @@ msgstr "Bitte rufe 'bisect_state' mit mindestens =
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
1.7.10.625.g300dcf
