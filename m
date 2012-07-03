From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BRFC=5D=20l10n=3A=20de=2Epo=3A=20translate=2029=20new=20messages?=
Date: Tue,  3 Jul 2012 19:04:46 +0200
Message-ID: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue Jul 03 19:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm6XT-0001SY-6y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab2GCRFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 13:05:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52324 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab2GCRFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:05:07 -0400
Received: by bkwj10 with SMTP id j10so1899395bkw.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WHNXXtqPDGCLwA1EbFCpiBWFuF5IbkO66S2coG/clxw=;
        b=FM36KvRTWUC7HatbIVZ9SFf/FQCzKz2+dySGxZex7ag9FjrzRxvVvBrZKbRNsiWLMt
         rAOQkdgtg/UOO5QxM0lNeEtayNbwD8//RGxWF6qJ80fXIq8ZKKLKNrP8ZDDV93o/PWpA
         c3f7fYvHm8dAB+KiOIPKgaCtwPUaRDHyASD0CZn1vdYhEXhHnfT/3+jO7h+j4jvhBRiM
         0bisUkGhpca533fzQH2uwm2c6uuZl8kzMY8zdSblxURlABAKMnE5/J9frldVYYyw6aQY
         YM6vsgBd+31WnD6EY5vRLbWpZfxrEMWzMUJyDAzE7HYXhoWL0bO7iG6IDkXTYiZ6CU2r
         cBLg==
Received: by 10.204.141.18 with SMTP id k18mr10301730bku.27.1341335106000;
        Tue, 03 Jul 2012 10:05:06 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-202-234.pools.arcor-ip.net. [94.223.202.234])
        by mx.google.com with ESMTPS id ge7sm8344730bkc.5.2012.07.03.10.05.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Jul 2012 10:05:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200917>

Translate 29 new messages came from git.pot update
in 11b9017 (l10n: Update git.pot (29 new messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Hi German translation team,

please review this update of German translation.
This patch might not be applicable directly because
it's based on a preparation commit which just contains
changes of "msgmerge". After this patch passed the
review, i'll merge them together.

Thanks,
Ralf

 po/de.po | 92 +++++++++++++++++++++++++++-----------------------------=
--------
 1 Datei ge=C3=A4ndert, 38 Zeilen hinzugef=C3=BCgt(+), 54 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 96b993b..0cbcd64 100644
--- a/po/de.po
+++ b/po/de.po
@@ -71,9 +71,8 @@ msgstr[0] "Das Paket enth=C3=A4lt %d Referenz"
 msgstr[1] "Das Paket enth=C3=A4lt %d Referenzen"
=20
 #: bundle.c:192
-#, fuzzy
 msgid "The bundle records a complete history."
-msgstr "Das Paket ben=C3=B6tigt diese Referenz"
+msgstr "Das Paket speichert eine komplette Historie."
=20
 #: bundle.c:195
 #, c-format
@@ -696,11 +695,8 @@ msgstr ""
 "Bereitstellung)"
=20
 #: wt-status.c:174
-#, fuzzy
 msgid "  (use \"git add <file>...\" to mark resolution)"
-msgstr ""
-"  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung entspreche=
nd zu "
-"markieren)"
+msgstr "  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung zu =
markieren)"
=20
 #: wt-status.c:176 wt-status.c:180
 msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
@@ -709,11 +705,8 @@ msgstr ""
 "markieren)"
=20
 #: wt-status.c:178
-#, fuzzy
 msgid "  (use \"git rm <file>...\" to mark resolution)"
-msgstr ""
-"  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung entspreche=
nd zu "
-"markieren)"
+msgstr "  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung zu =
markieren)"
=20
 #: wt-status.c:189
 msgid "Changes to be committed:"
@@ -844,112 +837,104 @@ msgid "bug: unhandled diff status %c"
 msgstr "Fehler: unbehandelter Differenz-Status %c"
=20
 #: wt-status.c:786
-#, fuzzy
 msgid "You have unmerged paths."
-msgstr "Nicht zusammengef=C3=BChrte Pfade:"
+msgstr "Du hast nicht zusammengef=C3=BChrte Pfade."
=20
 #: wt-status.c:789 wt-status.c:913
-#, fuzzy
 msgid "  (fix conflicts and run \"git commit\")"
-msgstr " (benutze \"git add\" und/oder \"git commit -a\")"
+msgstr " (behebe die Konflikte und f=C3=BChre \"git commit\" aus)"
=20
 #: wt-status.c:792
 msgid "All conflicts fixed but you are still merging."
-msgstr ""
+msgstr "Alle Konflikte sind behoben, aber du bist immer noch beim "
+"Zusammenf=C3=BChren."
=20
 #: wt-status.c:795
-#, fuzzy
 msgid "  (use \"git commit\" to conclude merge)"
-msgstr ""
-"Zusammenf=C3=BChrung wurde nicht eingetragen; benutze 'git commit' um=
 die "
-"Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
+msgstr "  (benutze \"git commit\" um die Zusammenf=C3=BChrung abzuschl=
ie=C3=9Fen)"
=20
 #: wt-status.c:805
-#, fuzzy
 msgid "You are in the middle of an am session."
-msgstr "Eine Zusammenf=C3=BChrung ist im Gange -- kann nicht nachbesse=
rn."
+msgstr "Eine \"am\"-Sitzung ist im Gange."
=20
 #: wt-status.c:808
 msgid "The current patch is empty."
-msgstr ""
+msgstr "Der aktuelle Patch ist leer."
=20
 #: wt-status.c:812
 msgid "  (fix conflicts and then run \"git am --resolved\")"
-msgstr ""
+msgstr "  (behebe die Konflikte und f=C3=BChre dann \"git am --resolve=
d\" aus)"
=20
 #: wt-status.c:814
-#, fuzzy
 msgid "  (use \"git am --skip\" to skip this patch)"
-msgstr " (benutze \"git add\" zum Beobachten)"
+msgstr " (benutze \"git am --skip\" um diesen Patch auszulassen)"
=20
 #: wt-status.c:816
 msgid "  (use \"git am --abort\" to restore the original branch)"
-msgstr ""
+msgstr "  (benutze \"git am --abort\" um den urspr=C3=BCnglichen Zweig=
 "
+"wiederherzustellen)"
=20
 #: wt-status.c:874 wt-status.c:884
-#, fuzzy
 msgid "You are currently rebasing."
-msgstr "Du befindest dich auf keinem Zweig."
+msgstr "Du bist gerade beim Neuaufbau."
=20
 #: wt-status.c:877
 msgid "  (fix conflicts and then run \"git rebase --continue\")"
-msgstr ""
+msgstr "  (behebe die Konflikte und f=C3=BChre dann \"git rebase --con=
tinue\" aus)"
=20
 #: wt-status.c:879
-#, fuzzy
 msgid "  (use \"git rebase --skip\" to skip this patch)"
-msgstr ""
-"  (benutze \"git reset %s <Datei>...\" zum Herausnehmen aus der "
-"Bereitstellung)"
+msgstr "  (benutze \"git rebase --skip\" um diesen Patch auszulassen)"
=20
 #: wt-status.c:881
 msgid "  (use \"git rebase --abort\" to check out the original branch)=
"
-msgstr ""
+msgstr "  (benutze \"git rebase --abort\" um den urspr=C3=BCnglichen Z=
weig "
+"auszuchecken)"
=20
 #: wt-status.c:887
 msgid "  (all conflicts fixed: run \"git rebase --continue\")"
-msgstr ""
+msgstr "  (alle Konflikte behoben: f=C3=BChre \"git rebase --continue\=
" aus)"
=20
 #: wt-status.c:889
 msgid "You are currently splitting a commit during a rebase."
-msgstr ""
+msgstr "Du teilst gerade eine Version w=C3=A4hrend eines Neuaufbaus au=
f."
=20
 #: wt-status.c:892
 msgid "  (Once your working directory is clean, run \"git rebase --con=
tinue\")"
-msgstr ""
+msgstr "  (Sobald dein Arbeitsverzeichnis sauber ist, f=C3=BChre "
+"\"git rebase --continue\" aus)"
=20
 #: wt-status.c:894
-#, fuzzy
 msgid "You are currently editing a commit during a rebase."
-msgstr ""
-"Kann keine partielle Eintragung durchf=C3=BChren, w=C3=A4hrend eine Z=
usammenf=C3=BChrung im "
-"Gange ist."
+msgstr "Du editierst gerade eine Version w=C3=A4hrend eines Neuaufbaus=
=2E"
=20
 #: wt-status.c:897
 msgid "  (use \"git commit --amend\" to amend the current commit)"
-msgstr ""
+msgstr "  (benutze \"git commit --amend\" um die aktuelle Version "
+"nachzubessern)"
=20
 #: wt-status.c:899
 msgid ""
 "  (use \"git rebase --continue\" once you are satisfied with your cha=
nges)"
-msgstr ""
+msgstr "  (benutze \"git rebase --continue\" sobald deine =C3=84nderun=
gen "
+"abgeschlossen sind)"
=20
 #: wt-status.c:909
 msgid "You are currently cherry-picking."
-msgstr ""
+msgstr "Du f=C3=BChrst gerade \"cherry-pick\" aus."
=20
 #: wt-status.c:916
 msgid "  (all conflicts fixed: run \"git commit\")"
-msgstr ""
+msgstr "  (alle Konflikte behoben: f=C3=BChre \"git commit\" aus)"
=20
 #: wt-status.c:925
-#, fuzzy
 msgid "You are currently bisecting."
-msgstr "Wir sind nicht beim Halbieren."
+msgstr "Du bist gerade beim Halbieren."
=20
 #: wt-status.c:928
 msgid "  (use \"git bisect reset\" to get back to the original branch)=
"
-msgstr ""
+msgstr "  (benutze \"git bisect reset\" um zum urspr=C3=BCnglichen Zwe=
ig "
+"zur=C3=BCckzukehren)"
=20
 #: wt-status.c:979
 msgid "On branch "
@@ -3175,9 +3160,9 @@ msgstr "SHA1 KOLLISION MIT %s GEFUNDEN !"
=20
 #: builtin/index-pack.c:649 builtin/pack-objects.c:170
 #: builtin/pack-objects.c:262
-#, fuzzy, c-format
+#, c-format
 msgid "unable to read %s"
-msgstr "konnte %s nicht schreiben"
+msgstr "kann %s nicht lesen"
=20
 #: builtin/index-pack.c:715
 #, c-format
@@ -3228,9 +3213,8 @@ msgid "pack has junk at the end"
 msgstr "Paketende enth=C3=A4lt nicht verwendbaren Inhalt"
=20
 #: builtin/index-pack.c:1028
-#, fuzzy
 msgid "confusion beyond insanity in parse_pack_objects()"
-msgstr "Fehler beim Aufl=C3=B6sen der Unterschiede"
+msgstr "Fehler beim Ausf=C3=BChren von \"parse_pack_objects()\""
=20
 #: builtin/index-pack.c:1051
 msgid "Resolving deltas"
@@ -4066,9 +4050,9 @@ msgid "Unknown subcommand: %s"
 msgstr "Unbekanntes Unterkommando: %s"
=20
 #: builtin/pack-objects.c:183 builtin/pack-objects.c:186
-#, fuzzy, c-format
+#, c-format
 msgid "deflate error (%d)"
-msgstr "Fehler am anderen Ende: %s"
+msgstr "Fehler beim Komprimieren (%d)"
=20
 #: builtin/pack-objects.c:2398
 #, c-format
--=20
1.7.11.1
