From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: address the user formally
Date: Wed, 26 Dec 2012 16:52:48 +0100
Message-ID: <1356537168-12615-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Wed Dec 26 17:00:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TntPO-000884-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 17:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2LZQAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Dec 2012 11:00:24 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:38561 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab2LZQAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 11:00:21 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Dec 2012 11:00:20 EST
Received: by mail-bk0-f49.google.com with SMTP id jm19so3993160bkc.36
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bLJPKjCgku8+ZOChGcububHM/mfSbXNZ9YfBu8XqLfs=;
        b=FiHdHzFGU+b4Je2ne0tR8OyOn9O97buB06TK2KysY3L5BhpMyP2NKZ+h+7/gCuLItl
         xdAfzBP9svwQ8LtSOEGXYMKNHC5du1nHSBg4+qNxpiuX0cI+GxdH1vWJb6BlFR0R9RQa
         Kp24oxyLhywaSQqc/XeASn1KqrfZ2/XTlPTwIRLNnMvb5AixE6QKS0w0FNOnpp/+gT4t
         MlKfjAoMugBL49y5qP9gCVv4gvpFaiTzYTo96d5k4nD4lMSwOtF9Q/E7xaCmHZM3ItCy
         NbQsqHi1c2shR+PQhSeWQXHRCpLMvtVFFX3muLvK/hEglfTaQUAyn7rRPCClMj366jkH
         byvw==
X-Received: by 10.204.145.217 with SMTP id e25mr13703385bkv.123.1356537188502;
        Wed, 26 Dec 2012 07:53:08 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id z5sm18750999bkv.11.2012.12.26.07.53.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Dec 2012 07:53:07 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212139>

Suggested-by: Christian Stimming <stimming@tuhh.de>
Suggested-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 484 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 242 insertions(+), 242 deletions(-)

diff --git a/po/de.po b/po/de.po
index 0e8ed54..c8ad2f0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -33,10 +33,10 @@ msgid ""
 "appropriate to mark resolution and make a commit,\n"
 "or use 'git commit -a'."
 msgstr ""
-"Korrigiere dies im Arbeitsbaum,\n"
-"und benutze dann 'git add/rm <Datei>'\n"
+"Korrigieren Sie dies im Arbeitsbaum,\n"
+"und benutzen Sie dann 'git add/rm <Datei>'\n"
 "um die Aufl=C3=B6sung entsprechend zu markieren und einzutragen,\n"
-"oder benutze 'git commit -a'."
+"oder benutzen Sie 'git commit -a'."
=20
 #: archive.c:10
 msgid "git archive [options] <tree-ish> [<path>...]"
@@ -131,7 +131,7 @@ msgid ""
 "Use '\\!' for literal leading exclamation."
 msgstr ""
 "Verneinende Muster sind in Git-Attributen verboten.\n"
-"Benutze '\\!' f=C3=BCr f=C3=BChrende Ausrufezeichen."
+"Benutzen Sie '\\!' f=C3=BCr f=C3=BChrende Ausrufezeichen."
=20
 #: bundle.c:36
 #, c-format
@@ -381,7 +381,7 @@ msgstr "Vorhandene Git-Kommandos in '%s'"
=20
 #: help.c:219
 msgid "git commands available from elsewhere on your $PATH"
-msgstr "Vorhandene Git-Kommandos irgendwo in deinem $PATH"
+msgstr "Vorhandene Git-Kommandos irgendwo in Ihrem $PATH"
=20
 #: help.c:275
 #, c-format
@@ -394,7 +394,7 @@ msgstr ""
=20
 #: help.c:332
 msgid "Uh oh. Your system reports no Git commands at all."
-msgstr "Uh oh. Keine Git-Kommandos auf deinem System vorhanden."
+msgstr "Uh oh. Keine Git-Kommandos auf Ihrem System vorhanden."
=20
 #: help.c:354
 #, c-format
@@ -402,8 +402,8 @@ msgid ""
 "WARNING: You called a Git command named '%s', which does not exist.\n=
"
 "Continuing under the assumption that you meant '%s'"
 msgstr ""
-"Warnung: Du hast das nicht existierende Git-Kommando '%s' ausgef=C3=BC=
hrt.\n"
-"Setze fort unter der Annahme das du '%s' gemeint hast"
+"Warnung: Sie haben das nicht existierende Git-Kommando '%s' ausgef=C3=
=BChrt.\n"
+"Setze fort unter der Annahme, dass Sie '%s' gemeint haben"
=20
 #: help.c:359
 #, c-format
@@ -424,10 +424,10 @@ msgid_plural ""
 "Did you mean one of these?"
 msgstr[0] ""
 "\n"
-"Hast du das gemeint?"
+"Haben Sie das gemeint?"
 msgstr[1] ""
 "\n"
-"Hast du eines von diesen gemeint?"
+"Haben Sie eines von diesen gemeint?"
=20
 #: merge.c:56
 msgid "failed to read the cache"
@@ -721,12 +721,12 @@ msgstr "    %s"
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
 msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
-msgstr[0] "Dein Zweig ist vor '%s' um %d Version.\n"
-msgstr[1] "Dein Zweig ist vor '%s' um %d Versionen.\n"
+msgstr[0] "Ihr Zweig ist vor '%s' um %d Version.\n"
+msgstr[1] "Ihr Zweig ist vor '%s' um %d Versionen.\n"
=20
 #: remote.c:1637
 msgid "  (use \"git push\" to publish your local commits)\n"
-msgstr "  (benutze \"git push\" um deine lokalen Versionen herauszubri=
ngen)\n"
+msgstr "  (benutzen Sie \"git push\" um lokalen Versionen herauszubrin=
gen)\n"
=20
 #: remote.c:1640
 #, c-format
@@ -734,15 +734,15 @@ msgid "Your branch is behind '%s' by %d commit, a=
nd can be fast-forwarded.\n"
 msgid_plural ""
 "Your branch is behind '%s' by %d commits, and can be fast-forwarded.\=
n"
 msgstr[0] ""
-"Dein Zweig ist zu '%s' um %d Version hinterher, und kann vorgespult w=
erden.\n"
+"Ihr Zweig ist zu '%s' um %d Version hinterher, und kann vorgespult we=
rden.\n"
 msgstr[1] ""
-"Dein Zweig ist zu '%s' um %d Versionen hinterher, und kann vorgespult=
 "
+"Ihr Zweig ist zu '%s' um %d Versionen hinterher, und kann vorgespult =
"
 "werden.\n"
=20
 #: remote.c:1647
 msgid "  (use \"git pull\" to update your local branch)\n"
 msgstr ""
-"  (benutze \"git pull\" um deinen lokalen Zweig zu aktualisieren)\n"
+"  (benutzen Sie \"git pull\" um Ihren lokalen Zweig zu aktualisieren)=
\n"
=20
 #: remote.c:1650
 #, c-format
@@ -753,16 +753,16 @@ msgid_plural ""
 "Your branch and '%s' have diverged,\n"
 "and have %d and %d different commits each, respectively.\n"
 msgstr[0] ""
-"Dein Zweig und '%s' sind divergiert,\n"
+"Ihr Zweig und '%s' sind divergiert,\n"
 "und haben jeweils %d und %d unterschiedliche Versionen.\n"
 msgstr[1] ""
-"Dein Zweig und '%s' sind divergiert,\n"
+"Ihr Zweig und '%s' sind divergiert,\n"
 "und haben jeweils %d und %d unterschiedliche Versionen.\n"
=20
 #: remote.c:1659
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
 msgstr ""
-"  (benutze \"git pull\" um deinen Zweig mit dem externen zusammenzuf=C3=
=BChren)\n"
+"  (benutzen Sie \"git pull\" um Ihren Zweig mit dem externen zusammen=
zuf=C3=BChren)\n"
=20
 #: sequencer.c:123 builtin/merge.c:761 builtin/merge.c:874 builtin/mer=
ge.c:984
 #: builtin/merge.c:994
@@ -781,7 +781,7 @@ msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
 "with 'git add <paths>' or 'git rm <paths>'"
 msgstr ""
-"nach Aufl=C3=B6sung der Konflikte, markiere die korrigierten Pfade\n"
+"nach Aufl=C3=B6sung der Konflikte, markieren Sie die korrigierten Pfa=
de\n"
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'"
=20
 #: sequencer.c:149
@@ -790,9 +790,9 @@ msgid ""
 "with 'git add <paths>' or 'git rm <paths>'\n"
 "and commit the result with 'git commit'"
 msgstr ""
-"nach Aufl=C3=B6sung der Konflikte, markiere die korrigierten Pfade\n"
-"mit 'git add <Pfade>' oder 'git rm <Pfade>'und trage das Ergebnis ein=
 mit "
-"'git commit'"
+"nach Aufl=C3=B6sung der Konflikte, markieren Sie die korrigierten Pfa=
de\n"
+"mit 'git add <Pfade>' oder 'git rm <Pfade>'und tragen Sie das Ergebni=
s mit\n"
+"'git commit' ein"
=20
 #: sequencer.c:162 sequencer.c:770 sequencer.c:853
 #, c-format
@@ -807,15 +807,15 @@ msgstr "Fehler bei Nachbereitung von %s"
 #: sequencer.c:180
 msgid "Your local changes would be overwritten by cherry-pick."
 msgstr ""
-"Deine lokalen =C3=84nderungen w=C3=BCrden von \"cherry-pick\" =C3=BCb=
erschrieben werden."
+"Ihre lokalen =C3=84nderungen w=C3=BCrden von \"cherry-pick\" =C3=BCbe=
rschrieben werden."
=20
 #: sequencer.c:182
 msgid "Your local changes would be overwritten by revert."
-msgstr "Deine lokalen =C3=84nderungen w=C3=BCrden von \"revert\" =C3=BC=
berschrieben werden."
+msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden von \"revert\" =C3=BC=
berschrieben werden."
=20
 #: sequencer.c:185
 msgid "Commit your changes or stash them to proceed."
-msgstr "Trage deine =C3=84nderungen ein oder benutze \"stash\" um fort=
zufahren."
+msgstr "Tragen Sie Ihre =C3=84nderungen ein oder benutzen Sie \"stash\=
" um fortzufahren."
=20
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: sequencer.c:235
@@ -843,11 +843,11 @@ msgstr "Konnte Elternversion %s nicht parsen\n"
=20
 #: sequencer.c:403
 msgid "Your index file is unmerged."
-msgstr "Deine Bereitstellungsdatei ist nicht zusammengef=C3=BChrt."
+msgstr "Ihre Bereitstellungsdatei ist nicht zusammengef=C3=BChrt."
=20
 #: sequencer.c:406
 msgid "You do not have a valid HEAD"
-msgstr "Du hast keine g=C3=BCltige Zweigspitze (HEAD)"
+msgstr "Sie haben keine g=C3=BCltige Zweigspitze (HEAD)"
=20
 #: sequencer.c:421
 #, c-format
@@ -953,7 +953,7 @@ msgstr "\"cherry-pick\" oder \"revert\" ist bereits=
 im Gang"
=20
 #: sequencer.c:752
 msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
-msgstr "versuche \"git cherry-pick (--continue | --quit | --abort)\""
+msgstr "versuchen Sie \"git cherry-pick (--continue | --quit | --abort=
)\""
=20
 #: sequencer.c:756
 #, c-format
@@ -1053,28 +1053,28 @@ msgstr "Nicht zusammengef=C3=BChrte Pfade:"
 #, c-format
 msgid "  (use \"git reset %s <file>...\" to unstage)"
 msgstr ""
-"  (benutze \"git reset %s <Datei>...\" zum Herausnehmen aus der "
+"  (benutzen Sie \"git reset %s <Datei>...\" zum Herausnehmen aus der =
"
 "Bereitstellung)"
=20
 #: wt-status.c:169 wt-status.c:196
 msgid "  (use \"git rm --cached <file>...\" to unstage)"
 msgstr ""
-"  (benutze \"git rm --cached <Datei>...\" zum Herausnehmen aus der "
+"  (benutzen Sie \"git rm --cached <Datei>...\" zum Herausnehmen aus d=
er "
 "Bereitstellung)"
=20
 #: wt-status.c:173
 msgid "  (use \"git add <file>...\" to mark resolution)"
-msgstr "  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung zu =
markieren)"
+msgstr "  (benutzen Sie \"git add/rm <Datei>...\" um die Aufl=C3=B6sun=
g zu markieren)"
=20
 #: wt-status.c:175 wt-status.c:179
 msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
 msgstr ""
-"  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung entspreche=
nd zu "
+"  (benutzen Sie \"git add/rm <Datei>...\" um die Aufl=C3=B6sung entsp=
rechend zu "
 "markieren)"
=20
 #: wt-status.c:177
 msgid "  (use \"git rm <file>...\" to mark resolution)"
-msgstr "  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung zu =
markieren)"
+msgstr "  (benutzen Sie \"git add/rm <Datei>...\" um die Aufl=C3=B6sun=
g zu markieren)"
=20
 #: wt-status.c:188
 msgid "Changes to be committed:"
@@ -1086,29 +1086,29 @@ msgstr "=C3=84nderungen, die nicht zum Eintrage=
n bereitgestellt sind:"
=20
 #: wt-status.c:210
 msgid "  (use \"git add <file>...\" to update what will be committed)"
-msgstr "  (benutze \"git add <Datei>...\" zum Bereitstellen)"
+msgstr "  (benutzen Sie \"git add <Datei>...\" zum Bereitstellen)"
=20
 #: wt-status.c:212
 msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
-msgstr "  (benutze \"git add/rm <Datei>...\" zum Bereitstellen)"
+msgstr "  (benutzen Sie \"git add/rm <Datei>...\" zum Bereitstellen)"
=20
 #: wt-status.c:213
 msgid ""
 "  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
 msgstr ""
-"  (benutze \"git checkout -- <Datei>...\" um die =C3=84nderungen im "
+"  (benutzen Sie \"git checkout -- <Datei>...\" um die =C3=84nderungen=
 im "
 "Arbeitsverzeichnis zu verwerfen)"
=20
 #: wt-status.c:215
 msgid "  (commit or discard the untracked or modified content in submo=
dules)"
 msgstr ""
-"  (trage ein oder verwerfe den unbeobachteten oder ge=C3=A4nderten In=
halt in den "
+"  (tragen Sie ein oder verwerfen Sie den unbeobachteten oder ge=C3=A4=
nderten Inhalt in den "
 "Unterprojekten)"
=20
 #: wt-status.c:227
 #, c-format
 msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
-msgstr "  (benutze \"git %s <Datei>...\" zum Einf=C3=BCgen in die Eint=
ragung)"
+msgstr "  (benutzen Sie \"git %s <Datei>...\" zum Einf=C3=BCgen in die=
 Eintragung)"
=20
 #: wt-status.c:244
 msgid "bug"
@@ -1201,20 +1201,20 @@ msgstr "Fehler: unbehandelter Differenz-Status =
%c"
=20
 #: wt-status.c:785
 msgid "You have unmerged paths."
-msgstr "Du hast nicht zusammengef=C3=BChrte Pfade."
+msgstr "Sie haben nicht zusammengef=C3=BChrte Pfade."
=20
 #: wt-status.c:788 wt-status.c:912
 msgid "  (fix conflicts and run \"git commit\")"
-msgstr " (behebe die Konflikte und f=C3=BChre \"git commit\" aus)"
+msgstr " (beheben Sie die Konflikte und f=C3=BChren Sie \"git commit\"=
 aus)"
=20
 #: wt-status.c:791
 msgid "All conflicts fixed but you are still merging."
 msgstr ""
-"Alle Konflikte sind behoben, aber du bist immer noch beim Zusammenf=C3=
=BChren."
+"Alle Konflikte sind behoben, aber Sie sind immer noch beim Zusammenf=C3=
=BChren."
=20
 #: wt-status.c:794
 msgid "  (use \"git commit\" to conclude merge)"
-msgstr "  (benutze \"git commit\" um die Zusammenf=C3=BChrung abzuschl=
ie=C3=9Fen)"
+msgstr "  (benutzen Sie \"git commit\" um die Zusammenf=C3=BChrung abz=
uschlie=C3=9Fen)"
=20
 #: wt-status.c:804
 msgid "You are in the middle of an am session."
@@ -1226,80 +1226,80 @@ msgstr "Der aktuelle Patch ist leer."
=20
 #: wt-status.c:811
 msgid "  (fix conflicts and then run \"git am --resolved\")"
-msgstr "  (behebe die Konflikte und f=C3=BChre dann \"git am --resolve=
d\" aus)"
+msgstr "  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git am=
 --resolved\" aus)"
=20
 #: wt-status.c:813
 msgid "  (use \"git am --skip\" to skip this patch)"
-msgstr " (benutze \"git am --skip\" um diesen Patch auszulassen)"
+msgstr " (benutzen Sie \"git am --skip\" um diesen Patch auszulassen)"
=20
 #: wt-status.c:815
 msgid "  (use \"git am --abort\" to restore the original branch)"
 msgstr ""
-"  (benutze \"git am --abort\" um den urspr=C3=BCnglichen Zweig wieder=
herzustellen)"
+"  (benutzen Sie \"git am --abort\" um den urspr=C3=BCnglichen Zweig w=
iederherzustellen)"
=20
 #: wt-status.c:873 wt-status.c:883
 msgid "You are currently rebasing."
-msgstr "Du bist gerade beim Neuaufbau."
+msgstr "Sie sind gerade beim Neuaufbau."
=20
 #: wt-status.c:876
 msgid "  (fix conflicts and then run \"git rebase --continue\")"
-msgstr "  (behebe die Konflikte und f=C3=BChre dann \"git rebase --con=
tinue\" aus)"
+msgstr "  (beheben Sie die Konflikte und f=C3=BChren Sie dann \"git re=
base --continue\" aus)"
=20
 #: wt-status.c:878
 msgid "  (use \"git rebase --skip\" to skip this patch)"
-msgstr "  (benutze \"git rebase --skip\" um diesen Patch auszulassen)"
+msgstr "  (benutzen Sie \"git rebase --skip\" um diesen Patch auszulas=
sen)"
=20
 #: wt-status.c:880
 msgid "  (use \"git rebase --abort\" to check out the original branch)=
"
 msgstr ""
-"  (benutze \"git rebase --abort\" um den urspr=C3=BCnglichen Zweig au=
szuchecken)"
+"  (benutzen Sie \"git rebase --abort\" um den urspr=C3=BCnglichen Zwe=
ig auszuchecken)"
=20
 #: wt-status.c:886
 msgid "  (all conflicts fixed: run \"git rebase --continue\")"
-msgstr "  (alle Konflikte behoben: f=C3=BChre \"git rebase --continue\=
" aus)"
+msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git rebase --cont=
inue\" aus)"
=20
 #: wt-status.c:888
 msgid "You are currently splitting a commit during a rebase."
-msgstr "Du teilst gerade eine Version w=C3=A4hrend eines Neuaufbaus au=
f."
+msgstr "Sie teilen gerade eine Version w=C3=A4hrend eines Neuaufbaus a=
uf."
=20
 #: wt-status.c:891
 msgid "  (Once your working directory is clean, run \"git rebase --con=
tinue\")"
 msgstr ""
-"  (Sobald dein Arbeitsverzeichnis sauber ist, f=C3=BChre \"git rebase=
 --continue"
+"  (Sobald Ihr Arbeitsverzeichnis sauber ist, f=C3=BChren Sie \"git re=
base --continue"
 "\" aus)"
=20
 #: wt-status.c:893
 msgid "You are currently editing a commit during a rebase."
-msgstr "Du editierst gerade eine Version w=C3=A4hrend eines Neuaufbaus=
=2E"
+msgstr "Sie editieren gerade eine Version w=C3=A4hrend eines Neuaufbau=
s."
=20
 #: wt-status.c:896
 msgid "  (use \"git commit --amend\" to amend the current commit)"
 msgstr ""
-"  (benutze \"git commit --amend\" um die aktuelle Version nachzubesse=
rn)"
+"  (benutzen Sie \"git commit --amend\" um die aktuelle Version nachzu=
bessern)"
=20
 #: wt-status.c:898
 msgid ""
 "  (use \"git rebase --continue\" once you are satisfied with your cha=
nges)"
 msgstr ""
-"  (benutze \"git rebase --continue\" sobald deine =C3=84nderungen abg=
eschlossen "
+"  (benutzen Sie \"git rebase --continue\" sobald Ihre =C3=84nderungen=
 abgeschlossen "
 "sind)"
=20
 #: wt-status.c:908
 msgid "You are currently cherry-picking."
-msgstr "Du f=C3=BChrst gerade \"cherry-pick\" aus."
+msgstr "Sie f=C3=BChren gerade \"cherry-pick\" aus."
=20
 #: wt-status.c:915
 msgid "  (all conflicts fixed: run \"git commit\")"
-msgstr "  (alle Konflikte behoben: f=C3=BChre \"git commit\" aus)"
+msgstr "  (alle Konflikte behoben: f=C3=BChren Sie \"git commit\" aus)=
"
=20
 #: wt-status.c:924
 msgid "You are currently bisecting."
-msgstr "Du bist gerade beim Halbieren."
+msgstr "Sie sind gerade beim Halbieren."
=20
 #: wt-status.c:927
 msgid "  (use \"git bisect reset\" to get back to the original branch)=
"
 msgstr ""
-"  (benutze \"git bisect reset\" um zum urspr=C3=BCnglichen Zweig zur=C3=
=BCckzukehren)"
+"  (benutzen Sie \"git bisect reset\" um zum urspr=C3=BCnglichen Zweig=
 zur=C3=BCckzukehren)"
=20
 #: wt-status.c:978
 msgid "On branch "
@@ -1328,7 +1328,7 @@ msgstr "Unbeobachtete Dateien nicht aufgelistet%s=
"
=20
 #: wt-status.c:1017
 msgid " (use -u option to show untracked files)"
-msgstr " (benutze die Option -u um unbeobachteten Dateien anzuzeigen)"
+msgstr " (benutzen Sie die Option -u um unbeobachteten Dateien anzuzei=
gen)"
=20
 #: wt-status.c:1023
 msgid "No changes"
@@ -1338,7 +1338,7 @@ msgstr "Keine =C3=84nderungen"
 #, c-format
 msgid "no changes added to commit (use \"git add\" and/or \"git commit=
 -a\")\n"
 msgstr ""
-"keine =C3=84nderungen zum Eintragen hinzugef=C3=BCgt (benutze \"git a=
dd\" und/oder "
+"keine =C3=84nderungen zum Eintragen hinzugef=C3=BCgt (benutzen Sie \"=
git add\" und/oder "
 "\"git commit -a\")\n"
=20
 #: wt-status.c:1031
@@ -1353,7 +1353,7 @@ msgid ""
 "track)\n"
 msgstr ""
 "nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unbeobachtete Dat=
eien "
-"(benutze \"git add\" zum Beobachten)\n"
+"(benutzen Sie \"git add\" zum Beobachten)\n"
=20
 #: wt-status.c:1037
 #, c-format
@@ -1364,8 +1364,8 @@ msgstr "nichts zum Eintragen hinzugef=C3=BCgt, ab=
er es gibt unbeobachtete Dateien\n"
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to tra=
ck)\n"
 msgstr ""
-"nichts einzutragen (Erstelle/Kopiere Dateien und benutze \"git add\" =
zum "
-"Beobachten)\n"
+"nichts einzutragen (Erstellen/Kopieren Sie Dateien und benutzen Sie \=
"git add\" "
+"zum Beobachten)\n"
=20
 #: wt-status.c:1043 wt-status.c:1048
 #, c-format
@@ -1376,7 +1376,7 @@ msgstr "nichts einzutragen\n"
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
 msgstr ""
-"nichts einzutragen (benutze die Option -u, um unbeobachtete Dateien "
+"nichts einzutragen (benutzen Sie die Option -u, um unbeobachtete Date=
ien "
 "anzuzeigen)\n"
=20
 #: wt-status.c:1050
@@ -1477,7 +1477,7 @@ msgstr "Konnte '%s' nicht anwenden."
 #: builtin/add.c:313
 msgid "The following paths are ignored by one of your .gitignore files=
:\n"
 msgstr ""
-"Die folgenden Pfade werden durch eine deiner \".gitignore\" Dateien "
+"Die folgenden Pfade werden durch eine Ihrer \".gitignore\" Dateien "
 "ignoriert:\n"
=20
 #: builtin/add.c:319 builtin/clean.c:52 builtin/fetch.c:78 builtin/mv.=
c:63
@@ -1538,7 +1538,7 @@ msgstr "pr=C3=BCft ob - auch fehlende - Dateien i=
m Probelauf ignoriert werden"
 #: builtin/add.c:353
 #, c-format
 msgid "Use -f if you really want to add them.\n"
-msgstr "Verwende -f wenn du diese wirklich hinzuf=C3=BCgen m=C3=B6chte=
st.\n"
+msgstr "Verwenden Sie -f wenn Sie diese wirklich hinzuf=C3=BCgen m=C3=B6=
chten.\n"
=20
 #: builtin/add.c:354
 msgid "no files added"
@@ -1565,7 +1565,7 @@ msgstr "Nichts spezifiziert, nichts hinzugef=C3=BC=
gt.\n"
 #: builtin/add.c:415
 #, c-format
 msgid "Maybe you wanted to say 'git add .'?\n"
-msgstr "Wolltest du vielleicht 'git add .' sagen?\n"
+msgstr "Wollten Sie vielleicht 'git add .' sagen?\n"
=20
 #: builtin/add.c:421 builtin/clean.c:95 builtin/commit.c:291 builtin/m=
v.c:82
 #: builtin/rm.c:235
@@ -2269,7 +2269,7 @@ msgid ""
 "If you are sure you want to delete it, run 'git branch -D %s'."
 msgstr ""
 "Der Zweig '%s' ist nicht vollst=C3=A4ndig zusammengef=C3=BChrt.\n"
-"Wenn du sicher bist diesen Zweig zu entfernen, f=C3=BChre 'git branch=
 -D %s' aus."
+"Wenn Sie sicher sind diesen Zweig zu entfernen, f=C3=BChren Sie 'git =
branch -D %s' aus."
=20
 #: builtin/branch.c:180
 msgid "Update of config-file failed"
@@ -2287,7 +2287,7 @@ msgstr "Konnte Versionsobjekt f=C3=BCr Zweigspitz=
e (HEAD) nicht nachschlagen."
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
 msgstr ""
-"Kann Zweig '%s' nicht entfernen, da du dich gerade auf diesem befinde=
st."
+"Kann Zweig '%s' nicht entfernen, da Sie sich gerade auf diesem befind=
en."
=20
 #: builtin/branch.c:235
 #, c-format
@@ -2365,7 +2365,7 @@ msgstr "Konnte einige Referenzen nicht lesen"
 #: builtin/branch.c:638
 msgid "cannot rename the current branch while not on any."
 msgstr ""
-"Kann aktuellen Zweig nicht umbenennen, solange du dich auf keinem bef=
indest."
+"Kann aktuellen Zweig nicht umbenennen, solange Sie sich auf keinem be=
finden."
=20
 #: builtin/branch.c:648
 #, c-format
@@ -2527,8 +2527,8 @@ msgid ""
 "The --set-upstream flag is deprecated and will be removed. Consider u=
sing --"
 "track or --set-upstream-to\n"
 msgstr ""
-"Die --set-upstream Option ist veraltet und wird entfernt. Benutze --t=
rack "
-"oder --set-upstream-to\n"
+"Die --set-upstream Option ist veraltet und wird entfernt. Benutzen Si=
e "
+"--track oder --set-upstream-to\n"
=20
 #: builtin/branch.c:934
 #, c-format
@@ -2538,8 +2538,8 @@ msgid ""
 "\n"
 msgstr ""
 "\n"
-"Wenn du wolltest, dass '%s' den Zweig '%s' als externen =C3=9Cbernahm=
ezweig hat, "
-"f=C3=BChre aus:\n"
+"Wenn Sie wollten, dass '%s' den Zweig '%s' als externen =C3=9Cbernahm=
ezweig hat, "
+"f=C3=BChren Sie aus:\n"
=20
 #: builtin/branch.c:935
 #, c-format
@@ -2743,7 +2743,7 @@ msgstr "Pfad '%s' ist nicht zusammengef=C3=BChrt.=
"
=20
 #: builtin/checkout.c:448
 msgid "you need to resolve your current index first"
-msgstr "Du musst zuerst deine aktuelle Bereitstellung aufl=C3=B6sen."
+msgstr "Sie m=C3=BCssen zuerst Ihre aktuelle Bereitstellung aufl=C3=B6=
sen."
=20
 #: builtin/checkout.c:569
 #, c-format
@@ -2798,13 +2798,13 @@ msgid_plural ""
 "\n"
 "%s\n"
 msgstr[0] ""
-"Warnung: Du bist um %d Version hinterher, nicht verbunden zu\n"
-"einem deiner Zweige:\n"
+"Warnung: Sie sind um %d Version hinterher, nicht verbunden zu\n"
+"einem Ihrer Zweige:\n"
 "\n"
 "%s\n"
 msgstr[1] ""
-"Warnung: Du bist um %d Versionen hinterher, nicht verbunden zu\n"
-"einem deiner Zweige:\n"
+"Warnung: Sie sind um %d Versionen hinterher, nicht verbunden zu\n"
+"einem Ihrer Zweige:\n"
 "\n"
 "%s\n"
=20
@@ -2817,7 +2817,7 @@ msgid ""
 " git branch new_branch_name %s\n"
 "\n"
 msgstr ""
-"Wenn du diese durch einen neuen Zweig behalten m=C3=B6chtest, dann k=C3=
=B6nnte jetzt\n"
+"Wenn Sie diese durch einen neuen Zweig behalten m=C3=B6chten, dann k=C3=
=B6nnte jetzt\n"
 "ein guter Zeitpunkt sein dies zu tun mit:\n"
 "\n"
 " git branch neuer_zweig_name %s\n"
@@ -2833,7 +2833,7 @@ msgstr "Vorherige Position der Zweigspitze (HEAD)=
 war"
=20
 #: builtin/checkout.c:761 builtin/checkout.c:950
 msgid "You are on a branch yet to be born"
-msgstr "du bist auf einem Zweig, der noch geboren wird"
+msgstr "Sie sind auf einem Zweig, der noch geboren wird"
=20
 #. case (1)
 #: builtin/checkout.c:886
@@ -2946,7 +2946,7 @@ msgstr "--track ben=C3=B6tigt einen Zweignamen"
=20
 #: builtin/checkout.c:1081
 msgid "Missing branch name; try -b"
-msgstr "Vermisse Zweignamen; versuche -b"
+msgstr "Vermisse Zweignamen; versuchen Sie -b"
=20
 #: builtin/checkout.c:1116
 msgid "invalid path specification"
@@ -2959,7 +2959,7 @@ msgid ""
 "Did you intend to checkout '%s' which can not be resolved as commit?"
 msgstr ""
 "Kann nicht gleichzeitig Pfade aktualisieren und zu Zweig '%s' wechsel=
n.\n"
-"Hast du beabsichtigt '%s' auszuchecken, welcher nicht als Version auf=
gel=C3=B6st "
+"Haben Sie beabsichtigt '%s' auszuchecken, welcher nicht als Version a=
ufgel=C3=B6st "
 "werden kann?"
=20
 #: builtin/checkout.c:1128
@@ -2973,7 +2973,7 @@ msgid ""
 "checking out of the index."
 msgstr ""
 "git checkout: --ours/--theirs, --force und --merge sind inkompatibel =
wenn\n"
-"du aus der Bereitstellung auscheckst."
+"Sie aus der Bereitstellung auschecken."
=20
 #: builtin/clean.c:19
 msgid "git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pa=
ths>..."
@@ -3203,7 +3203,7 @@ msgstr "Zu viele Argumente."
=20
 #: builtin/clone.c:694
 msgid "You must specify a repository to clone."
-msgstr "Du musst ein Projektarchiv zum Klonen angeben."
+msgstr "Sie m=C3=BCssen ein Projektarchiv zum Klonen angeben."
=20
 #: builtin/clone.c:705
 #, c-format
@@ -3217,7 +3217,7 @@ msgstr "Projektarchiv '%s' existiert nicht."
=20
 #: builtin/clone.c:724
 msgid "--depth is ignored in local clones; use file:// instead."
-msgstr "--depth wird in lokalen Klonen ignoriert; benutze stattdessen =
file://."
+msgstr "--depth wird in lokalen Klonen ignoriert; benutzen Sie stattde=
ssen file://."
=20
 #: builtin/clone.c:734
 #, c-format
@@ -3261,7 +3261,7 @@ msgstr "externer Zweig %s nicht im anderen Projek=
tarchiv %s gefunden"
=20
 #: builtin/clone.c:879
 msgid "You appear to have cloned an empty repository."
-msgstr "Du scheinst ein leeres Projektarchiv geklont zu haben."
+msgstr "Sie scheinen ein leeres Projektarchiv geklont zu haben."
=20
 #: builtin/column.c:9
 msgid "git column [options]"
@@ -3316,15 +3316,15 @@ msgid ""
 "\n"
 "    git commit --amend --reset-author\n"
 msgstr ""
-"Dein Name und E-Mail Adresse wurden automatisch auf Basis\n"
-"deines Benutzer- und Rechnernamens konfiguriert. Bitte pr=C3=BCfe, da=
ss diese\n"
-"zutreffend sind. Du kannst diese Meldung unterdr=C3=BCcken, indem du =
diese\n"
-"explizit setzt:\n"
+"Ihr Name und E-Mail Adresse wurden automatisch auf Basis\n"
+"Ihres Benutzer- und Rechnernamens konfiguriert. Bitte pr=C3=BCfen Sie=
, dass\n"
+"diese zutreffend sind. Sie k=C3=B6nnen diese Meldung unterdr=C3=BCcke=
n, indem Sie\n"
+"diese explizit setzen:\n"
 "\n"
-"    git config --global user.name \"Dein Name\"\n"
-"    git config --global user.email deine@emailadresse.de\n"
+"    git config --global user.name \"Ihr Name\"\n"
+"    git config --global user.email ihre@emailadresse.de\n"
 "\n"
-"Nachdem du das getan hast, kannst du deine Identit=C3=A4t f=C3=BCr di=
ese Version "
+"Nachdem Sie das getan hast, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=BC=
r diese Version "
 "=C3=A4ndern mit:\n"
 "\n"
 "    git commit --amend --reset-author\n"
@@ -3335,8 +3335,8 @@ msgid ""
 "it empty. You can repeat your command with --allow-empty, or you can\=
n"
 "remove the commit entirely with \"git reset HEAD^\".\n"
 msgstr ""
-"Du fragtest die j=C3=BCngste Version nachzubessern, aber das w=C3=BCr=
de diese leer\n"
-"machen. Du kannst Dein Kommando mit --allow-empty wiederholen, oder d=
ie\n"
+"Sie fragten die j=C3=BCngste Version nachzubessern, aber das w=C3=BCr=
de diese leer\n"
+"machen. Sie k=C3=B6nnen Ihr Kommando mit --allow-empty wiederholen, o=
der die\n"
 "Version mit \"git reset HEAD^\" vollst=C3=A4ndig entfernen.\n"
=20
 #: builtin/commit.c:61
@@ -3350,11 +3350,11 @@ msgid ""
 msgstr ""
 "Der letzte \"cherry-pick\" ist jetzt leer, m=C3=B6glicherweise durch =
eine "
 "Konfliktaufl=C3=B6sung.\n"
-"Wenn du dies trotzdem eintragen willst, benutze:\n"
+"Wenn Sie dies trotzdem eintragen wollen, benutzen Sie:\n"
 "\n"
 "    git commit --allow-empty\n"
 "\n"
-"Andernfalls benutze bitte 'git reset'\n"
+"Andernfalls benutzen Sie bitte 'git reset'\n"
=20
 #: builtin/commit.c:258
 msgid "failed to unpack HEAD tree object"
@@ -3456,10 +3456,10 @@ msgid ""
 "and try again.\n"
 msgstr ""
 "\n"
-"Es sieht so aus, als tr=C3=A4gst du eine Zusammenf=C3=BChrung ein.\n"
-"Falls das nicht korrekt ist, l=C3=B6sche bitte die Datei\n"
+"Es sieht so aus, als tragen Sie eine Zusammenf=C3=BChrung ein.\n"
+"Falls das nicht korrekt ist, l=C3=B6schen Sie bitte die Datei\n"
 "\t%s\n"
-"und versuche es erneut.\n"
+"und versuchen Sie es erneut.\n"
=20
 #: builtin/commit.c:723
 #, c-format
@@ -3471,17 +3471,17 @@ msgid ""
 "and try again.\n"
 msgstr ""
 "\n"
-"Es sieht so aus, als tr=C3=A4gst du ein \"cherry-pick\" ein.\n"
-"Falls das nicht korrekt ist, l=C3=B6sche bitte die Datei\n"
+"Es sieht so aus, als tragen Sie ein \"cherry-pick\" ein.\n"
+"Falls das nicht korrekt ist, l=C3=B6schen Sie bitte die Datei\n"
 "\t%s\n"
-"und versuche es erneut.\n"
+"und versuchen Sie es erneut.\n"
=20
 #: builtin/commit.c:735
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '#' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
-"Bitte gebe eine Versionsbeschreibung f=C3=BCr deine =C3=84nderungen e=
in. Zeilen,\n"
+"Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderung=
en ein. Zeilen,\n"
 "die mit '#' beginnen, werden ignoriert, und eine leere Versionsbeschr=
eibung\n"
 "bricht die Eintragung ab.\n"
=20
@@ -3491,8 +3491,8 @@ msgid ""
 "with '#' will be kept; you may remove them yourself if you want to.\n=
"
 "An empty message aborts the commit.\n"
 msgstr ""
-"Bitte gebe eine Versionsbeschreibung f=C3=BCr deine =C3=84nderungen e=
in. Zeilen, die\n"
-"mit '#' beginnen, werden beibehalten; wenn du m=C3=B6chtest, kannst d=
u diese "
+"Bitte geben Sie eine Versionsbeschreibung f=C3=BCr Ihre =C3=84nderung=
en ein. Zeilen, die\n"
+"mit '#' beginnen, werden beibehalten; wenn Sie m=C3=B6chten, k=C3=B6n=
nen Sie diese "
 "entfernen.\n"
 "Eine leere Versionsbeschreibung bricht die Eintragung ab.\n"
=20
@@ -3535,7 +3535,7 @@ msgstr "Verwendung von --reset-author und --autho=
r macht keinen Sinn."
=20
 #: builtin/commit.c:995
 msgid "You have nothing to amend."
-msgstr "Du hast nichts zum nachbessern."
+msgstr "Sie haben nichts zum nachbessern."
=20
 #: builtin/commit.c:998
 msgid "You are in the middle of a merge -- cannot amend."
@@ -3726,7 +3726,7 @@ msgstr ""
=20
 #: builtin/commit.c:1380
 msgid "the commit is authored by me now (used with -C/-c/--amend)"
-msgstr "Setze mich als Autor der Version (benutzt mit -C/-c/--amend)"
+msgstr "Setzt Sie als Autor der Version (benutzt mit -C/-c/--amend)"
=20
 #: builtin/commit.c:1381 builtin/log.c:1073 builtin/revert.c:109
 msgid "add Signed-off-by:"
@@ -3836,7 +3836,7 @@ msgstr "Konnte Versionsbeschreibung nicht lesen: =
%s"
 #: builtin/commit.c:1534
 #, c-format
 msgid "Aborting commit; you did not edit the message.\n"
-msgstr "Eintragung abgebrochen; du hast die Beschreibung nicht editier=
t.\n"
+msgstr "Eintragung abgebrochen; Sie haben die Beschreibung nicht editi=
ert.\n"
=20
 #: builtin/commit.c:1539
 #, c-format
@@ -3862,8 +3862,8 @@ msgid ""
 "not exceeded, and then \"git reset HEAD\" to recover."
 msgstr ""
 "Das Projektarchiv wurde aktualisiert, aber die \"new_index\"-Datei\n"
-"konnte nicht geschrieben werden. Pr=C3=BCfe, dass deine Festplatte ni=
cht\n"
-"voll und Dein Kontingent nicht aufgebraucht ist und f=C3=BChre\n"
+"konnte nicht geschrieben werden. Pr=C3=BCfen Sie, dass Ihre Festplatt=
e nicht\n"
+"voll und Ihr Kontingent nicht aufgebraucht ist und f=C3=BChren Sie\n"
 "anschlie=C3=9Fend \"git reset HEAD\" zu Wiederherstellung aus."
=20
 #: builtin/config.c:7
@@ -4041,7 +4041,7 @@ msgid ""
 "However, there were unannotated tags: try --tags."
 msgstr ""
 "Keine annotierten Markierungen k=C3=B6nnen '%s' beschreiben.\n"
-"Jedoch gab es nicht annotierte Markierungen: versuche --tags."
+"Jedoch gab es nicht annotierte Markierungen: versuchen Sie --tags."
=20
 #: builtin/describe.c:357
 #, c-format
@@ -4050,7 +4050,7 @@ msgid ""
 "Try --always, or create some tags."
 msgstr ""
 "Keine Markierungen k=C3=B6nnen '%s' beschreiben.\n"
-"Versuche --always oder erstelle einige Markierungen."
+"Versuchen Sie --always oder erstellen Sie einige Markierungen."
=20
 #: builtin/describe.c:378
 #, c-format
@@ -4354,7 +4354,7 @@ msgid ""
 "some local refs could not be updated; try running\n"
 " 'git remote prune %s' to remove any old, conflicting branches"
 msgstr ""
-"Einige lokale Referenzen konnten nicht aktualisiert werden; versuche\=
n"
+"Einige lokale Referenzen konnten nicht aktualisiert werden; versuchen=
 Sie\n"
 "'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen Z=
weig zu l=C3=B6schen."
=20
 #: builtin/fetch.c:549
@@ -4412,13 +4412,13 @@ msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
 msgstr ""
-"Kein externes Projektarchiv angegeben. Bitte gebe entweder eine URL\n=
"
+"Kein externes Projektarchiv angegeben. Bitte geben Sie entweder eine =
URL\n"
 "oder den Namen des externen Archivs an, von welchem neue\n"
 "Versionen angefordert werden sollen."
=20
 #: builtin/fetch.c:932
 msgid "You need to specify a tag name."
-msgstr "Du musst den Namen der Markierung angeben."
+msgstr "Sie m=C3=BCssen den Namen der Markierung angeben."
=20
 #: builtin/fetch.c:984
 msgid "fetch --all does not take a repository argument"
@@ -4587,15 +4587,15 @@ msgid ""
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
 "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce\n"
-"komprimiert. Du kannst auch \"git gc\" manuell ausf=C3=BChren.\n"
+"komprimiert. Sie k=C3=B6nnen auch \"git gc\" manuell ausf=C3=BChren.\=
n"
 "Siehe \"git help gc\" f=C3=BCr weitere Informationen.\n"
=20
 #: builtin/gc.c:249
 msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
 msgstr ""
-"Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git prune' a=
us, um diese "
-"zu l=C3=B6schen."
+"Es gibt zu viele unerreichbare lose Objekte; f=C3=BChren Sie 'git pru=
ne' aus, um "
+"diese zu l=C3=B6schen."
=20
 #: builtin/grep.c:22
 msgid "git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"
@@ -4918,7 +4918,7 @@ msgid ""
 "Please consider using 'man.<tool>.cmd' instead."
 msgstr ""
 "'%s': Pfad f=C3=BCr nicht unterst=C3=BCtzten Handbuchbetrachter.\n"
-"Du k=C3=B6nntest stattdessen 'man.<Werkzeug>.cmd' benutzen."
+"Sie k=C3=B6nnten stattdessen 'man.<Werkzeug>.cmd' benutzen."
=20
 #: builtin/help.c:229
 #, c-format
@@ -4927,7 +4927,7 @@ msgid ""
 "Please consider using 'man.<tool>.path' instead."
 msgstr ""
 "'%s': Kommando f=C3=BCr unterst=C3=BCtzten Handbuchbetrachter.\n"
-"Du k=C3=B6nntest stattdessen 'man.<Werkzeug>.path' benutzen."
+"Sie k=C3=B6nnten stattdessen 'man.<Werkzeug>.path' benutzen."
=20
 #: builtin/help.c:299
 msgid "The most commonly used git commands are:"
@@ -5636,8 +5636,8 @@ msgstr "git cherry [-v] [<=C3=9Cbernahmezweig> [<=
Arbeitszweig> [<Limit>]]]"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten, externen Zweig nicht finden, bitte gebe <upstream> =
manuell "
-"an.\n"
+"Konnte gefolgten, externen Zweig nicht finden, bitte geben Sie <upstr=
eam> "
+"manuell an.\n"
=20
 #: builtin/log.c:1517 builtin/log.c:1519 builtin/log.c:1531
 #, c-format
@@ -5956,7 +5956,7 @@ msgstr "konnte nicht von '%s' lesen"
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
 msgstr ""
-"Zusammenf=C3=BChrung wurde nicht eingetragen; benutze 'git commit' um=
 die "
+"Zusammenf=C3=BChrung wurde nicht eingetragen; benutzen Sie 'git commi=
t' um die "
 "Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
=20
 #: builtin/merge.c:788
@@ -5967,7 +5967,7 @@ msgid ""
 "Lines starting with '#' will be ignored, and an empty message aborts\=
n"
 "the commit.\n"
 msgstr ""
-"Bitte gebe eine Versionsbeschreibung ein um zu erkl=C3=A4ren, warum d=
iese "
+"Bitte geben Sie eine Versionsbeschreibung ein um zu erkl=C3=A4ren, wa=
rum diese "
 "Zusammenf=C3=BChrung erforderlich ist,\n"
 "insbesondere wenn es einen aktualisierten, externen Zweig mit einem T=
hema-"
 "Zweig zusammenf=C3=BChrt.\n"
@@ -5988,8 +5988,8 @@ msgstr "Wunderbar.\n"
 #, c-format
 msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
 msgstr ""
-"Automatische Zusammenf=C3=BChrung fehlgeschlagen; behebe die Konflikt=
e und trage "
-"dann das Ergebnis ein.\n"
+"Automatische Zusammenf=C3=BChrung fehlgeschlagen; beheben Sie die Kon=
flikte und tragen "
+"Sie dann das Ergebnis ein.\n"
=20
 #: builtin/merge.c:905
 #, c-format
@@ -5998,7 +5998,7 @@ msgstr "'%s' ist keine Version"
=20
 #: builtin/merge.c:946
 msgid "No current branch."
-msgstr "Du befindest dich auf keinem Zweig."
+msgstr "Sie befinden sich auf keinem Zweig."
=20
 #: builtin/merge.c:948
 msgid "No remote for the current branch."
@@ -6029,34 +6029,34 @@ msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you can merge."
 msgstr ""
-"Du hast deine Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD ex=
istiert).\n"
-"Bitte trage deine =C3=84nderungen ein, bevor du zusammenf=C3=BChren k=
annst."
+"Sie haben Ihre Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD e=
xistiert).\n"
+"Bitte tragen Sie Ihre =C3=84nderungen ein, bevor Sie zusammenf=C3=BCh=
ren k=C3=B6nnen."
=20
 #: builtin/merge.c:1129 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr ""
-"Du hast deine Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD ex=
istiert)."
+"Sie haben Ihre Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD e=
xistiert)."
=20
 #: builtin/merge.c:1133
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you can merge."
 msgstr ""
-"Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt).\n"
-"Bitte trage deine =C3=84nderungen ein, bevor du zusammenf=C3=BChren k=
annst."
+"Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert).\n"
+"Bitte tragen Sie Ihre =C3=84nderungen ein, bevor Sie zusammenf=C3=BCh=
ren k=C3=B6nnen."
=20
 #: builtin/merge.c:1136
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
 msgstr ""
-"Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt)."
+"Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert)."
=20
 #: builtin/merge.c:1145
 msgid "You cannot combine --squash with --no-ff."
-msgstr "Du kannst --squash nicht mit --no-ff kombinieren."
+msgstr "Sie k=C3=B6nnen --squash nicht mit --no-ff kombinieren."
=20
 #: builtin/merge.c:1150
 msgid "You cannot combine --no-ff with --ff-only."
-msgstr "Du kannst --no-ff nicht mit --ff--only kombinieren."
+msgstr "Sie k=C3=B6nnen --no-ff nicht mit --ff--only kombinieren."
=20
 #: builtin/merge.c:1157
 msgid "No commit specified and merge.defaultToUpstream not set."
@@ -6116,7 +6116,7 @@ msgstr "Zusammenf=C3=BChrung mit Strategie %s feh=
lgeschlagen.\n"
 #: builtin/merge.c:1491
 #, c-format
 msgid "Using the %s to prepare resolving by hand.\n"
-msgstr "Benutze \"%s\" um die Aufl=C3=B6sung per Hand vorzubereiten.\n=
"
+msgstr "Benutzen Sie \"%s\" um die Aufl=C3=B6sung per Hand vorzubereit=
en.\n"
=20
 #: builtin/merge.c:1503
 #, c-format
@@ -6461,7 +6461,7 @@ msgstr "konnte Datei '%s' nicht erstellen"
=20
 #: builtin/notes.c:192
 msgid "Please supply the note contents using either -m or -F option"
-msgstr "Bitte liefere den Notiz-Inhalt unter Verwendung der Option -m =
oder -F."
+msgstr "Bitte liefern Sie den Notiz-Inhalt unter Verwendung der Option=
 -m oder -F."
=20
 #: builtin/notes.c:213 builtin/notes.c:976
 #, c-format
@@ -6575,7 +6575,7 @@ msgid ""
 "existing notes"
 msgstr ""
 "Konnte Notizen nicht hinzuf=C3=BCgen. Existierende Notizen f=C3=BCr O=
bjekt %s "
-"gefunden. Verwende '-f' um die existierenden Notizen zu =C3=BCberschr=
eiben."
+"gefunden. Verwenden Sie '-f' um die existierenden Notizen zu =C3=BCbe=
rschreiben."
=20
 #: builtin/notes.c:588 builtin/notes.c:665
 #, c-format
@@ -6603,7 +6603,7 @@ msgid ""
 "existing notes"
 msgstr ""
 "Kann Notizen nicht kopieren. Existierende Notizen f=C3=BCr Objekt %s =
gefunden. "
-"Verwende '-f' um die existierenden Notizen zu =C3=BCberschreiben."
+"Verwenden Sie '-f' um die existierenden Notizen zu =C3=BCberschreiben=
=2E"
=20
 #: builtin/notes.c:671
 #, c-format
@@ -6617,7 +6617,7 @@ msgid ""
 "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
 msgstr ""
 "Die Optionen -m/-F/-c/-C sind f=C3=BCr das Unterkommando 'edit' veral=
tet.\n"
-"Bitte benutze stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
+"Bitte benutzen Sie stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
=20
 #: builtin/notes.c:867
 msgid "General options"
@@ -6908,14 +6908,14 @@ msgid ""
 "    git push %s %s\n"
 "%s"
 msgstr ""
-"Der Name des externen =C3=9Cbernahmezweiges stimmt nicht mit dem Name=
n deines\n"
+"Der Name des externen =C3=9Cbernahmezweiges stimmt nicht mit dem Name=
n Ihres\n"
 "aktuellen Zweiges =C3=BCberein. Um auf den =C3=9Cbernahmezweig in dem=
 externen\n"
-"Projektarchiv zu versenden, benutze:\n"
+"Projektarchiv zu versenden, benutzen Sie:\n"
 "\n"
 "    git push %s HEAD:%s\n"
 "\n"
 "Um auf den Zweig mit dem selben Namen in dem externen Projekarchiv\n"
-"zu versenden, benutze:\n"
+"zu versenden, benutzen Sie:\n"
 "\n"
 "    git push %s %s\n"
 "%s"
@@ -6929,9 +6929,9 @@ msgid ""
 "\n"
 "    git push %s HEAD:<name-of-remote-branch>\n"
 msgstr ""
-"Du befindest dich sich im Moment auf keinem Zweig.\n"
+"Sie befinden sich im Moment auf keinem Zweig.\n"
 "Um die Historie, f=C3=BChrend zum aktuellen (freistehende Zweigspitze=
 (HEAD))\n"
-"Status zu versenden, benutze\n"
+"Status zu versenden, benutzen Sie\n"
 "\n"
 "    git push %s HEAD:<Name-des-externen-Zweiges>\n"
=20
@@ -6945,7 +6945,7 @@ msgid ""
 msgstr ""
 "Der aktuelle Zweig %s hat keinen Zweig im externen Projektarchiv.\n"
 "Um den aktuellen Zweig zu versenden und das Fernarchiv als externes\n=
"
-"Projektarchiv zu verwenden, benutze\n"
+"Projektarchiv zu verwenden, benutzen Sie\n"
 "\n"
 "    git push --set-upstream %s %s\n"
=20
@@ -6961,7 +6961,7 @@ msgid ""
 "your current branch '%s', without telling me what to push\n"
 "to update which remote branch."
 msgstr ""
-"Du versendest nach '%s', welches kein externes Projektarchiv deines\n=
"
+"Sie versenden nach '%s', welches kein externes Projektarchiv Ihres\n"
 "aktuellen Zweiges '%s' ist, ohne mir mitzuteilen, was ich versenden\n=
"
 "soll, um welchen externen Zweig zu aktualisieren."
=20
@@ -6985,26 +6985,25 @@ msgstr ""
 "'push.default' ist nicht gesetzt; der implizit gesetzte Wert\n"
 "wird in Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese =
Meldung zu\n"
 "unterdr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des S=
tandardwertes\n"
-"beizubehalten, benutze:\n"
+"beizubehalten, benutzen Sie:\n"
 "  git config --global push.default matching\n"
 "\n"
 "Um diese Meldung zu unterdr=C3=BCcken und das neue Verhalten jetzt zu=
 "
-"=C3=BCbernehmen,\n"
-"benutze:\n"
+"=C3=BCbernehmen, benutzen Sie:\n"
 "\n"
 "  git config --global push.default simple\n"
 "\n"
-"F=C3=BChre 'git help config' aus und suche nach 'push.default' f=C3=BC=
r weitere "
-"Informationen.\n"
+"F=C3=BChren Sie 'git help config' aus und suchen Sie nach 'push.defau=
lt' f=C3=BCr "
+"weitere Informationen.\n"
 "(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutze den =
=C3=A4hnlichen "
-"Modus 'current' anstatt 'simple', falls du gelegentlich =C3=A4ltere V=
ersionen von "
-"Git benutzt.)"
+"Modus 'current' anstatt 'simple', falls Sie gelegentlich =C3=A4ltere =
Versionen von "
+"Git benutzen.)"
=20
 #: builtin/push.c:199
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
-"Du hast keine Referenzspezifikationen zum Versenden angegeben, und pu=
sh."
+"Sie haben keine Referenzspezifikationen zum Versenden angegeben, und =
push."
 "default ist \"nothing\"."
=20
 #: builtin/push.c:206
@@ -7014,9 +7013,10 @@ msgid ""
 "before pushing again.\n"
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
-"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze deines a=
ktuellen\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. F=C3=BChre die\n"
-"externen =C3=84nderungen zusammen (z.B. 'git pull') bevor du erneut v=
ersendest.\n"
+"Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres ak=
tuellen\n"
+"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. F=C3=BChren Sie\n"
+"die externen =C3=84nderungen zusammen (z.B. 'git pull') bevor Sie ern=
eut\n"
+"versenden.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -7028,8 +7028,8 @@ msgid ""
 "to 'simple', 'current' or 'upstream' to push only the current branch.=
"
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Wenn du nicht\n"
-"beabsichtigt hast, diesen Zweig zu versenden, kannst du auch den zu "
+"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Wenn Sie nicht\n"
+"beabsichtigt haben, diesen Zweig zu versenden, k=C3=B6nnen Sie auch d=
en zu "
 "versendenden\n"
 "Zweig spezifizieren oder die Konfigurationsvariable 'push.default' zu=
 "
 "'simple', 'current'\n"
@@ -7043,9 +7043,9 @@ msgid ""
 "See the 'Note about fast-forwards' in 'git push --help' for details."
 msgstr ""
 "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines ve=
rsendeten\n"
-"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Checke diesen\n"
-"Zweig aus und f=C3=BChre die externen =C3=84nderungen zusammen (z.B. =
'git pull')\n"
-"bevor du erneut versendest.\n"
+"Zweiges hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen is=
t. Checken Sie\n"
+"diesen Zweig aus und f=C3=BChren Sie die externen =C3=84nderungen zus=
ammen\n"
+"(z.B. 'git pull') bevor Sie erneut versenden.\n"
 "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --help=
'\n"
 "f=C3=BCr weitere Details."
=20
@@ -7077,12 +7077,12 @@ msgid ""
 "    git push <name>\n"
 msgstr ""
 "Kein Ziel zum Versenden konfiguriert.\n"
-"Entweder spezifizierst du die URL von der Kommandozeile oder konfigur=
ierst "
+"Entweder spezifizieren Sie die URL von der Kommandozeile oder konfigu=
rieren "
 "ein externes Projektarchiv unter Benutzung von\n"
 "\n"
 "    git remote add <Name> <URL>\n"
 "\n"
-"und versendest dann unter Benutzung dieses Namens\n"
+"und versenden dann unter Benutzung dieses Namens\n"
 "\n"
 "    git push <Name>\n"
=20
@@ -7331,7 +7331,7 @@ msgid ""
 "\t use --mirror=3Dfetch or --mirror=3Dpush instead"
 msgstr ""
 "--mirror ist gef=C3=A4hrlich und veraltet; bitte\n"
-"\t benutze stattdessen --mirror=3Dfetch oder --mirror=3Dpush"
+"\t benutzen Sie stattdessen --mirror=3Dfetch oder --mirror=3Dpush"
=20
 #: builtin/remote.c:147
 #, c-format
@@ -7440,7 +7440,7 @@ msgstr ""
 "Keine Aktualisierung der nicht standardm=C3=A4=C3=9Figen Referenzspez=
ifikation zum "
 "Abholen\n"
 "\t%s\n"
-"\tBitte aktualisiere, falls notwendig, die Konfiguration manuell."
+"\tBitte aktualisieren Sie, falls notwendig, die Konfiguration manuell=
=2E"
=20
 #: builtin/remote.c:683
 #, c-format
@@ -7477,11 +7477,11 @@ msgid_plural ""
 msgstr[0] ""
 "Hinweis: Ein Zweig au=C3=9Ferhalb der /refs/remotes/ Hierachie wurde =
nicht "
 "gel=C3=B6scht;\n"
-"um diesen zu l=C3=B6schen, benutze:"
+"um diesen zu l=C3=B6schen, benutzen Sie:"
 msgstr[1] ""
 "Hinweis: Einige Zweige au=C3=9Fer der /refs/remotes/ Hierarchie wurde=
n nicht "
 "entfernt;\n"
-"um diese zu entfernen, benutze:"
+"um diese zu entfernen, benutzen Sie:"
=20
 #: builtin/remote.c:943
 #, c-format
@@ -7494,7 +7494,7 @@ msgstr " gefolgt"
=20
 #: builtin/remote.c:948
 msgid " stale (use 'git remote prune' to remove)"
-msgstr " veraltet (benutze 'git remote prune' zum L=C3=B6schen)"
+msgstr " veraltet (benutzen Sie 'git remote prune' zum L=C3=B6schen)"
=20
 #: builtin/remote.c:950
 msgid " ???"
@@ -7647,8 +7647,8 @@ msgstr "Kann Hauptzweig des externen Projektarchi=
vs nicht bestimmen"
 #: builtin/remote.c:1218
 msgid "Multiple remote HEAD branches. Please choose one explicitly wit=
h:"
 msgstr ""
-"Mehrere Hauptzweige im externen Projektarchiv. Bitte w=C3=A4hle expli=
zit einen "
-"aus mit:"
+"Mehrere Hauptzweige im externen Projektarchiv. Bitte w=C3=A4hlen Sie =
explizit "
+"einen aus mit:"
=20
 #: builtin/remote.c:1228
 #, c-format
@@ -7814,7 +7814,7 @@ msgstr "keep"
=20
 #: builtin/reset.c:77
 msgid "You do not have a valid HEAD."
-msgstr "Du hast keine g=C3=BCltige Zweigspitze (HEAD)."
+msgstr "Sie haben keine g=C3=BCltige Zweigspitze (HEAD)."
=20
 #: builtin/reset.c:79
 msgid "Failed to find tree of HEAD."
@@ -7881,7 +7881,8 @@ msgstr "--patch ist inkompatibel mit --{hard,mixe=
d,soft}"
 #: builtin/reset.c:317
 msgid "--mixed with paths is deprecated; use 'git reset -- <paths>' in=
stead."
 msgstr ""
-"--mixed mit Pfaden ist veraltet; benutze stattdessen 'git reset -- <P=
fade>'."
+"--mixed mit Pfaden ist veraltet; benutzen Sie stattdessen "
+"'git reset -- <Pfade>'."
=20
 #: builtin/reset.c:319
 #, c-format
@@ -7922,7 +7923,7 @@ msgstr ""
 "   oder: git rev-parse --sq-quote [<Argumente>...]\n"
 "   oder: git rev-parse [Optionen] [<Argumente>...]\n"
 "\n"
-"F=C3=BChre \"git rev-parse --parseopt -h\" f=C3=BCr weitere Informati=
onen bei erster "
+"F=C3=BChren Sie \"git rev-parse --parseopt -h\" f=C3=BCr weitere Info=
rmationen bei erster "
 "Verwendung aus."
=20
 #: builtin/revert.c:22
@@ -8025,8 +8026,8 @@ msgid ""
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
 "Unterprojekt '%s' (oder ein geschachteltes Unterprojekt hiervon) verw=
endet\n"
-"ein .git-Verzeichnis (benutze 'rm -rf' wenn du dieses wirklich mitsam=
t\n"
-"seiner Historie l=C3=B6schen m=C3=B6chtest)"
+"ein .git-Verzeichnis (benutzen Sie 'rm -rf' wenn Sie dieses wirklich =
mitsamt\n"
+"seiner Historie l=C3=B6schen m=C3=B6chten)"
=20
 #: builtin/rm.c:174
 #, c-format
@@ -8035,7 +8036,7 @@ msgid ""
 "(use -f to force removal)"
 msgstr ""
 "'%s' hat bereitgestellten Inhalt unterschiedlich zu der Datei und der=
\n"
-"Zweigspitze (HEAD) (benutze -f um die Entfernung zu erzwingen)"
+"Zweigspitze (HEAD) (benutzen Sie -f um die Entfernung zu erzwingen)"
=20
 #: builtin/rm.c:180
 #, c-format
@@ -8044,7 +8045,7 @@ msgid ""
 "(use --cached to keep the file, or -f to force removal)"
 msgstr ""
 "'%s' hat =C3=84nderungen in der Bereitstellung\n"
-"(benutze --cached um die Datei zu behalten, oder -f um die Entfernung=
 zu "
+"(benutzen Sie --cached um die Datei zu behalten, oder -f um die Entfe=
rnung zu "
 "erzwingen)"
=20
 #: builtin/rm.c:191
@@ -8054,7 +8055,7 @@ msgid ""
 "(use --cached to keep the file, or -f to force removal)"
 msgstr ""
 "'%s' hat lokale Modifikationen\n"
-"(benutze --cached um die Datei zu behalten, oder -f um die Entfernung=
 zu "
+"(benutzen Sie --cached um die Datei zu behalten, oder -f um die Entfe=
rnung zu "
 "erzwingen)"
=20
 #: builtin/rm.c:207
@@ -8334,7 +8335,7 @@ msgid ""
 msgstr ""
 "\n"
 "#\n"
-"# Gebe eine Markierungsbeschreibung ein\n"
+"# Geben Sie eine Markierungsbeschreibung ein.\n"
 "# Zeilen, die mit '#' beginnen, werden ignoriert.\n"
 "#\n"
=20
@@ -8349,9 +8350,9 @@ msgid ""
 msgstr ""
 "\n"
 "#\n"
-"# Gebe eine Markierungsbeschreibung ein\n"
-"# Zeilen, die mit '#' beginnen, werden behalten; du darfst diese\n"
-"# selbst entfernen wenn du m=C3=B6chtest.\n"
+"# Geben Sie eine Markierungsbeschreibung ein.\n"
+"# Zeilen, die mit '#' beginnen, werden behalten; Sie d=C3=BCrfen dies=
e\n"
+"# selbst entfernen wenn Sie m=C3=B6chten.\n"
 "#\n"
=20
 #: builtin/tag.c:298
@@ -8790,14 +8791,14 @@ msgstr ""
=20
 #: git-am.sh:50
 msgid "You need to set your committer info first"
-msgstr "Du musst zuerst die Informationen des Eintragenden setzen."
+msgstr "Sie m=C3=BCssen zuerst die Informationen des Eintragenden setz=
en."
=20
 #: git-am.sh:95
 msgid ""
 "You seem to have moved HEAD since the last 'am' failure.\n"
 "Not rewinding to ORIG_HEAD"
 msgstr ""
-"Du scheinst seit dem letzten gescheiterten 'am' die Zweigspitze (HEAD=
)\n"
+"Sie scheinen seit dem letzten gescheiterten 'am' die Zweigspitze (HEA=
D)\n"
 "ge=C3=A4ndert zu haben.\n"
 "Keine Zur=C3=BCcksetzung zu ORIG_HEAD."
=20
@@ -8808,12 +8809,11 @@ msgid ""
 "If you prefer to skip this patch, run \"$cmdline --skip\" instead.\n"
 "To restore the original branch and stop patching, run \"$cmdline --ab=
ort\"."
 msgstr ""
-"Wenn du das Problem gel=C3=B6st hast, f=C3=BChre \"$cmdline --resolve=
d\" aus.\n"
-"Falls du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen=
 \"$cmdline --skip"
-"\" aus.\n"
-"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der "
-"Patches\n"
-"abzubrechen, f=C3=BChre \"$cmdline --abort\" aus."
+"Wenn Sie das Problem gel=C3=B6st haben, f=C3=BChren Sie \"$cmdline --=
resolved\" aus.\n"
+"Falls Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattd=
essen\n"
+"\"$cmdline --skip\" aus.\n"
+"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der\n"
+"Patches abzubrechen, f=C3=BChren Sie \"$cmdline --abort\" aus."
=20
 #: git-am.sh:121
 msgid "Cannot fall back to three-way merge."
@@ -8836,7 +8836,7 @@ msgid ""
 "Did you hand edit your patch?\n"
 "It does not apply to blobs recorded in its index."
 msgstr ""
-"Hast du den Patch per Hand editiert?\n"
+"Haben Sie den Patch per Hand editiert?\n"
 "Er kann nicht auf die Blobs in seiner 'index' Zeile angewendet werden=
=2E"
=20
 #: git-am.sh:163
@@ -8877,7 +8877,7 @@ msgstr ""
=20
 #: git-am.sh:482
 msgid "Please make up your mind. --skip or --abort?"
-msgstr "Bitte werde dir klar. --skip oder --abort?"
+msgstr "Bitte werden Sie sich klar. --skip oder --abort?"
=20
 #: git-am.sh:509
 msgid "Resolve operation not in progress, we are not resuming."
@@ -8897,11 +8897,11 @@ msgid ""
 "To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
 msgstr ""
 "Patch ist leer. Wurde er falsch aufgeteilt?\n"
-"Wenn du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen =
\"$cmdline --skip"
-"\" aus.\n"
+"Wenn Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattde=
ssen\n"
+"\"$cmdline --skip\" aus.\n"
 "Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der "
 "Patches\n"
-"abzubrechen, f=C3=BChre \"$cmdline --abort\" aus."
+"abzubrechen, f=C3=BChren Sie \"$cmdline --abort\" aus."
=20
 #: git-am.sh:706
 msgid "Patch does not have a valid e-mail address."
@@ -8935,9 +8935,9 @@ msgid ""
 "If there is nothing left to stage, chances are that something else\n"
 "already introduced the same changes; you might want to skip this patc=
h."
 msgstr ""
-"Keine =C3=84nderungen - hast du vergessen 'git add' zu benutzen?\n"
+"Keine =C3=84nderungen - haben Sie vergessen 'git add' zu benutzen?\n"
 "Wenn keine =C3=84nderungen mehr zum Bereitstellen vorhanden sind, k=C3=
=B6nnten\n"
-"diese bereits anderweitig eingef=C3=BCgt worden sein; du k=C3=B6nntes=
t diesen Patch\n"
+"diese bereits anderweitig eingef=C3=BCgt worden sein; Sie k=C3=B6nnte=
n diesen Patch\n"
 "auslassen."
=20
 #: git-am.sh:829
@@ -8945,8 +8945,8 @@ msgid ""
 "You still have unmerged paths in your index\n"
 "did you forget to use 'git add'?"
 msgstr ""
-"Du hast immer noch nicht zusammengef=C3=BChrte Pfade in der Bereitste=
llung.\n"
-"Hast du vergessen 'git add' zu benutzen?"
+"Sie haben immer noch nicht zusammengef=C3=BChrte Pfade in der Bereits=
tellung.\n"
+"Haben Sie vergessen 'git add' zu benutzen?"
=20
 #: git-am.sh:845
 msgid "No changes -- Patch already applied."
@@ -8972,14 +8972,14 @@ msgstr "wende zu leerer Historie an"
=20
 #: git-bisect.sh:48
 msgid "You need to start by \"git bisect start\""
-msgstr "Du musst mit \"git bisect start\" beginnen."
+msgstr "Sie m=C3=BCssen mit \"git bisect start\" beginnen."
=20
 #. TRANSLATORS: Make sure to include [Y] and [n] in your
 #. translation. The program will only accept English input
 #. at this point.
 #: git-bisect.sh:54
 msgid "Do you want me to do it for you [Y/n]? "
-msgstr "Willst du, dass ich es f=C3=BCr dich mache [Y/n]? "
+msgstr "Wollen Sie, dass ich es f=C3=BCr Sie mache [Y/n]? "
=20
 #: git-bisect.sh:95
 #, sh-format
@@ -9000,7 +9000,7 @@ msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Zweig=
spitze (HEAD) wird ben=C3=B6tigt"
 msgid ""
 "Checking out '$start_head' failed. Try 'git bisect reset <validbranch=
>'."
 msgstr ""
-"Auschecken von '$start_head' fehlgeschlagen. Versuche 'git bisect res=
et "
+"Auschecken von '$start_head' fehlgeschlagen. Versuchen Sie 'git bisec=
t reset "
 "<gueltigerzweig>'."
=20
 #: git-bisect.sh:140
@@ -9023,7 +9023,7 @@ msgstr "Ung=C3=BCltige Referenz-Eingabe: $arg"
=20
 #: git-bisect.sh:232
 msgid "Please call 'bisect_state' with at least one argument."
-msgstr "Bitte rufe 'bisect_state' mit mindestens einem Argument auf."
+msgstr "Bitte rufen Sie 'bisect_state' mit mindestens einem Argument a=
uf."
=20
 #: git-bisect.sh:244
 #, sh-format
@@ -9045,15 +9045,15 @@ msgstr "Warnung: halbiere nur mit einer fehlerh=
aften Version"
 #. at this point.
 #: git-bisect.sh:279
 msgid "Are you sure [Y/n]? "
-msgstr "Bist du sicher [Y/n]? "
+msgstr "Sind Sie sicher [Y/n]? "
=20
 #: git-bisect.sh:289
 msgid ""
 "You need to give me at least one good and one bad revisions.\n"
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
 msgstr ""
-"Du musst mindestens eine korrekte und eine fehlerhafte Version angebe=
n.\n"
-"(Du kannst daf=C3=BCr \"git bisect bad\" und \"git bisect good\" benu=
tzen.)"
+"Sie m=C3=BCssen mindestens eine korrekte und eine fehlerhafte Version=
 angeben.\n"
+"(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
=20
 #: git-bisect.sh:292
 msgid ""
@@ -9061,10 +9061,10 @@ msgid ""
 "You then need to give me at least one good and one bad revisions.\n"
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
 msgstr ""
-"Du musst mit \"git bisect start\" beginnen.\n"
-"Danach musst du mindestens eine korrekte und eine fehlerhafte Version=
 "
+"Sie m=C3=BCssen mit \"git bisect start\" beginnen.\n"
+"Danach m=C3=BCssen Sie mindestens eine korrekte und eine fehlerhafte =
Version "
 "angeben.\n"
-"(Du kannst daf=C3=BCr \"git bisect bad\" und \"git bisect good\" benu=
tzen.)"
+"(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
=20
 #: git-bisect.sh:347 git-bisect.sh:474
 msgid "We are not bisecting."
@@ -9082,7 +9082,7 @@ msgid ""
 "Try 'git bisect reset <commit>'."
 msgstr ""
 "Konnte die urspr=C3=BCngliche Zweigspitze (HEAD) '$branch' nicht ausc=
hecken.\n"
-"Versuche 'git bisect reset <Version>'."
+"Versuchen Sie 'git bisect reset <Version>'."
=20
 #: git-bisect.sh:390
 msgid "No logfile given"
@@ -9095,7 +9095,7 @@ msgstr "kann $file nicht f=C3=BCr das Abspielen l=
esen"
=20
 #: git-bisect.sh:408
 msgid "?? what are you talking about?"
-msgstr "?? Was redest du da?"
+msgstr "?? Was reden Sie da?"
=20
 #: git-bisect.sh:420
 #, sh-format
@@ -9134,14 +9134,14 @@ msgid ""
 "Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
 "as appropriate to mark resolution, or use 'git commit -a'."
 msgstr ""
-"\"pull\" ist nicht m=C3=B6glich, weil du nicht zusammengef=C3=BChrte =
Dateien hast.\n"
-"Bitte korrigiere dies im Arbeitsbaum und benutze dann 'git add/rm <Da=
tei>'\n"
-"um die Aufl=C3=B6sung entsprechend zu markieren, oder benutze 'git co=
mmit -a'."
+"\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben.\n"
+"Bitte korrigieren Sie dies im Arbeitsbaum und benutzen Sie dann 'git =
add/rm <Datei>'\n"
+"um die Aufl=C3=B6sung entsprechend zu markieren, oder benutzen Sie 'g=
it commit -a'."
=20
 #: git-pull.sh:25
 msgid "Pull is not possible because you have unmerged files."
 msgstr ""
-"\"pull\" ist nicht m=C3=B6glich, weil du nicht zusammengef=C3=BChrte =
Dateien hast."
+"\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben."
=20
 #: git-pull.sh:197
 msgid "updating an unborn branch with changes added to the index"
@@ -9161,7 +9161,7 @@ msgid ""
 "Warning: commit $orig_head."
 msgstr ""
 "Warnung: Die Anforderung aktualisierte die Spitze des aktuellen Zweig=
es.\n"
-"Warnung: Spule deinen Arbeitszweig von Version $orig_head vor."
+"Warnung: Spule Ihren Arbeitszweig von Version $orig_head vor."
=20
 #: git-pull.sh:254
 msgid "Cannot merge multiple branches into empty head"
@@ -9178,12 +9178,12 @@ msgid ""
 "To check out the original branch and stop rebasing, run \"git rebase =
--abort"
 "\"."
 msgstr ""
-"Wenn du das Problem aufgel=C3=B6st hast, f=C3=BChre \"git rebase --co=
ntinue\" aus.\n"
-"Falls du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen=
 \"git rebase --"
+"Wenn Sie das Problem aufgel=C3=B6st haben, f=C3=BChren Sie \"git reba=
se --continue\" aus.\n"
+"Falls Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie stattd=
essen \"git rebase --"
 "skip\" aus.\n"
 "Um den urspr=C3=BCnglichen Zweig wiederherzustellen und den Neuaufbau=
 "
 "abzubrechen,\n"
-"f=C3=BChre \"git rebase --abort\" aus."
+"f=C3=BChren Sie \"git rebase --abort\" aus."
=20
 #: git-rebase.sh:160
 msgid "The pre-rebase hook refused to rebase."
@@ -9215,7 +9215,7 @@ msgid ""
 "You must edit all merge conflicts and then\n"
 "mark them as resolved using git add"
 msgstr ""
-"Du musst alle Zusammenf=C3=BChrungskonflikte editieren und diese dann=
\n"
+"Sie m=C3=BCssen alle Zusammenf=C3=BChrungskonflikte editieren und die=
se dann\n"
 "mittels \"git add\" als aufgel=C3=B6st markieren"
=20
 #: git-rebase.sh:340
@@ -9237,11 +9237,11 @@ msgid ""
 msgstr ""
 "Es sieht so aus, als ob es das Verzeichnis $state_dir_base bereits gi=
bt\n"
 "und es k=C3=B6nnte ein anderer Neuaufbau im Gange sein. Wenn das der =
=46all ist,\n"
-"probiere bitte\n"
+"probieren Sie bitte\n"
 "\t$cmd_live_rebase\n"
-"Wenn das nicht der Fall ist, probiere bitte\n"
+"Wenn das nicht der Fall ist, probieren Sie bitte\n"
 "\t$cmd_clear_stale_rebase\n"
-"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 noch\n"
+"und f=C3=BChren Sie dieses Kommando nochmal aus. Es wird angehalten, =
falls noch\n"
 "etwas Sch=C3=BCtzenswertes vorhanden ist."
=20
 #: git-rebase.sh:404
@@ -9271,7 +9271,7 @@ msgstr "fatal: Zweig $branch_name nicht gefunden"
=20
 #: git-rebase.sh:483
 msgid "Please commit or stash them."
-msgstr "Bitte trage die =C3=84nderungen ein oder benutze \"stash\"."
+msgstr "Bitte tragen Sie die =C3=84nderungen ein oder benutzen Sie \"s=
tash\"."
=20
 #: git-rebase.sh:501
 #, sh-format
@@ -9293,7 +9293,7 @@ msgstr "=C3=84nderungen von $mb zu $onto:"
 #: git-rebase.sh:524
 msgid "First, rewinding head to replay your work on top of it..."
 msgstr ""
-"Zun=C3=A4chst wird die Zweigspitze zur=C3=BCckgespult, um deine =C3=84=
nderungen\n"
+"Zun=C3=A4chst wird die Zweigspitze zur=C3=BCckgespult, um Ihre =C3=84=
nderungen\n"
 "darauf neu anzuwenden..."
=20
 #: git-rebase.sh:532
@@ -9307,7 +9307,7 @@ msgstr "git stash clear mit Parametern ist nicht =
implementiert"
=20
 #: git-stash.sh:74
 msgid "You do not have the initial commit yet"
-msgstr "Du hast bisher noch keine initiale Version"
+msgstr "Sie haben bisher noch keine initiale Version"
=20
 #: git-stash.sh:89
 msgid "Cannot save the current index state"
@@ -9346,7 +9346,7 @@ msgid ""
 "       To provide a message, use git stash save -- '$option'"
 msgstr ""
 "Fehler: unbekannte Option f=C3=BCr 'stash save': $option\n"
-"        Um eine Beschreibung anzugeben, benutze \"git stash save -- "
+"        Um eine Beschreibung anzugeben, benutzen Sie \"git stash save=
 -- "
 "'$option'\""
=20
 #: git-stash.sh:223
@@ -9400,7 +9400,7 @@ msgstr ""
=20
 #: git-stash.sh:424
 msgid "Conflicts in index. Try without --index."
-msgstr "Konflikte in der Bereitstellung. Versuche es ohne --index."
+msgstr "Konflikte in der Bereitstellung. Versuchen Sie es ohne --index=
=2E"
=20
 #: git-stash.sh:426
 msgid "Could not save index tree"
@@ -9430,7 +9430,7 @@ msgstr "Kein Zweigname spezifiziert"
=20
 #: git-stash.sh:571
 msgid "(To restore them type \"git stash apply\")"
-msgstr "(Zur Wiederherstellung gebe \"git stash apply\" ein)"
+msgstr "(Zur Wiederherstellung geben Sie \"git stash apply\" ein)"
=20
 #: git-submodule.sh:89
 #, sh-format
@@ -9471,9 +9471,9 @@ msgid ""
 "$sm_path\n"
 "Use -f if you really want to add it."
 msgstr ""
-"Der folgende Pfad wird durch eine deiner \".gitignore\" Dateien ignor=
iert:\n"
+"Der folgende Pfad wird durch eine Ihrer \".gitignore\" Dateien ignori=
ert:\n"
 "$sm_path\n"
-"Benutze -f wenn du diesen wirklich hinzuf=C3=BCgen m=C3=B6chtest."
+"Benutzen Sie -f wenn Sie diesen wirklich hinzuf=C3=BCgen m=C3=B6chten=
=2E"
=20
 #: git-submodule.sh:355
 #, sh-format
@@ -9497,7 +9497,7 @@ msgstr "Ein Git-Verzeichnis f=C3=BCr '$sm_name' w=
urde lokal gefunden mit den "
 msgid ""
 "If you want to reuse this local git directory instead of cloning agai=
n from"
 msgstr ""
-"Wenn du dieses lokale Git-Verzeichnis wiederverwenden m=C3=B6chtest, =
anstatt "
+"Wenn Sie dieses lokale Git-Verzeichnis wiederverwenden m=C3=B6chtest,=
 anstatt "
 "erneut zu klonen"
=20
 #: git-submodule.sh:369
@@ -9505,7 +9505,7 @@ msgstr ""
 msgid ""
 "use the '--force' option. If the local git directory is not the corre=
ct repo"
 msgstr ""
-"benutze die Option '--force'. Wenn das lokale Git-Verzeichnis nicht d=
as "
+"benutzen Sie die Option '--force'. Wenn das lokale Git-Verzeichnis ni=
cht das "
 "korrekte Projektarchiv ist"
=20
 #: git-submodule.sh:370
@@ -9514,8 +9514,8 @@ msgid ""
 "or you are unsure what this means choose another name with the '--nam=
e' "
 "option."
 msgstr ""
-"oder du dir unsicher bist, was das bedeutet, w=C3=A4hle einen anderen=
 Namen mit "
-"der Option '--name'."
+"oder Sie sich unsicher sind, was das bedeutet, w=C3=A4hlen Sie einen =
anderen Namen"
+"mit der Option '--name'."
=20
 #: git-submodule.sh:372
 #, sh-format
@@ -9576,7 +9576,7 @@ msgid ""
 "Maybe you want to use 'update --init'?"
 msgstr ""
 "Unterprojekt-Pfad '$sm_path' ist nicht initialisiert\n"
-"Vielleicht m=C3=B6chtest du 'update --init' benutzen?"
+"Vielleicht m=C3=B6chten Sie 'update --init' benutzen?"
=20
 #: git-submodule.sh:627
 #, sh-format
--=20
1.8.1.rc3.dirty
