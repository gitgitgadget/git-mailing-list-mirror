From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BRFCv2=5D=20l10n=3A=20de=2Epo=3A=20translate=2027=20new=20messages?=
Date: Mon, 11 Jun 2012 19:07:14 +0200
Message-ID: <1339434434-2476-1-git-send-email-ralf.thielow@googlemail.com>
References: <87zk8amey7.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, worldhello.net@gmail.com,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Mon Jun 11 19:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se85Q-0005Xp-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab2FKRHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 13:07:24 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48282 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab2FKRHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:07:22 -0400
Received: by bkcji2 with SMTP id ji2so3742630bkc.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Y5P7xPykJXUyCvGGaWW8ZuxwvuYVrXwGuoiihEE7vNo=;
        b=DJh99Y3iT/Swub6IIIhqBWl+5WeirykmWswvCggMsmz51viY642/KAAJCCyX61xty5
         5LkyaXyc3PKF5ejAJpFfuQi8L0iM16IROAS0Nt2by7+A9um6Mir/3AyZk2ZVuqBhj2mi
         OcK7lOZ08xMmF7uZxeD4yL/0DbtRdRfGzR2BkU4FjbM0me+7nbGhIkKguUsQn2if0Bmh
         rmuJd91U2DdAnf3C8JY8Cvr+aBfBTzWFwb3vAmcnc2JwiC7ti9wDphObQ6qA09KG9yFk
         jHcy+er8FGpwLzPNDr00HJwFVDiQ2lQYUhpqTprZb3w4etiOTJb0aPDWUQwWgnH7phxA
         tyfw==
Received: by 10.204.153.6 with SMTP id i6mr10321278bkw.114.1339434440901;
        Mon, 11 Jun 2012 10:07:20 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id h18sm17262398bkh.8.2012.06.11.10.07.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 10:07:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc2.3.g909146e
In-Reply-To: <87zk8amey7.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199679>

Translate 27 new messages came from git.pot update
in 7256fd7 (l10n: Update git.pot (27 new, 1 removed messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 Datei ge=C3=A4ndert, 210 Zeilen hinzugef=C3=BCgt(+), 6 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 23829ef..70d8418 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git 1.7.11\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2012-06-02 07:03+0800\n"
+"POT-Creation-Date: 2012-06-08 10:20+0800\n"
 "PO-Revision-Date: 2012-03-28 18:46+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@googlemail.com>\n"
 "Language-Team: German\n"
@@ -4929,6 +4929,32 @@ msgstr ""
 msgid "You need to set your committer info first"
 msgstr "Du musst zuerst die Informationen des Eintragenden setzen."
=20
+#: git-am.sh:95
+msgid ""
+"You seem to have moved HEAD since the last 'am' failure.\n"
+"Not rewinding to ORIG_HEAD"
+msgstr ""
+"Du scheinst seit dem letzten gescheiterten 'am' die Zweigspitze (HEAD=
)\n"
+"ge=C3=A4ndert zu haben.\n"
+"Keine Zur=C3=BCcksetzung zu ORIG_HEAD."
+
+#: git-am.sh:105
+#, sh-format
+msgid ""
+"When you have resolved this problem run \"$cmdline --resolved\".\n"
+"If you would prefer to skip this patch, instead run \"$cmdline --skip=
\".\n"
+"To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
+msgstr ""
+"Wenn du das Problem aufgel=C3=B6st hast, f=C3=BChre \"$cmdline --reso=
lved\" aus.\n"
+"Falls du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen=
 "
+"\"$cmdline --skip\" aus.\n"
+"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der Patches\n"
+"abzubrechen, f=C3=BChre \"$cmdline --abort\" aus."
+
+#: git-am.sh:121
+msgid "Cannot fall back to three-way merge."
+msgstr "Kann nicht zu 3-Wege-Zusammenf=C3=BChrung zur=C3=BCckfallen."
+
 #: git-am.sh:137
 msgid "Repository lacks necessary blobs to fall back on 3-way merge."
 msgstr ""
@@ -4985,12 +5011,33 @@ msgid "Dirty index: cannot apply patches (dirty=
: $files)"
 msgstr ""
 "Unsaubere Bereitstellung: kann Patches nicht anwenden (unsauber: $fil=
es)"
=20
+#: git-am.sh:671
+#, sh-format
+msgid ""
+"Patch is empty.  Was it split wrong?\n"
+"If you would prefer to skip this patch, instead run \"$cmdline --skip=
\".\n"
+"To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
+msgstr ""
+"Patch ist leer. Wurde er falsch aufgeteilt?\n"
+"Wenn du diesen Patch auslassen m=C3=B6chtest, f=C3=BChre stattdessen =
"
+"\"$cmdline --skip\" aus.\n"
+"Um den urspr=C3=BCnglichen Zweig wiederherzustellen und die Anwendung=
 der Patches\n"
+"abzubrechen, f=C3=BChre \"$cmdline --abort\" aus."
+
+#: git-am.sh:708
+msgid "Patch does not have a valid e-mail address."
+msgstr "Patch enth=C3=A4lt keine g=C3=BCltige eMail-Adresse."
+
 #: git-am.sh:755
 msgid "cannot be interactive without stdin connected to a terminal."
 msgstr ""
 "Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit einem =
"
 "Terminal verbunden ist."
=20
+#: git-am.sh:759
+msgid "Commit Body is:"
+msgstr "Beschreibung der Eintragung ist:"
+
 #. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
 #. in your translation. The program will only accept English
 #. input at this point.
@@ -5003,14 +5050,42 @@ msgstr "Anwenden? [y]es/[n]o/[e]dit/[v]iew patc=
h/[a]ccept all "
 msgid "Applying: $FIRSTLINE"
 msgstr "Wende an: $FIRSTLINE"
=20
+#: git-am.sh:823
+msgid ""
+"No changes - did you forget to use 'git add'?\n"
+"If there is nothing left to stage, chances are that something else\n"
+"already introduced the same changes; you might want to skip this patc=
h."
+msgstr ""
+"Keine =C3=84nderungen - hast du vergessen 'git add' zu benutzen?\n"
+"Wenn keine =C3=84nderungen mehr zum Bereitstellen vorhanden sind, k=C3=
=B6nnten\n"
+"diese bereits anderweitig eingef=C3=BCgt worden sein; du k=C3=B6nntes=
t diesen Patch\n"
+"auslassen."
+
+#: git-am.sh:831
+msgid ""
+"You still have unmerged paths in your index\n"
+"did you forget to use 'git add'?"
+msgstr ""
+"Du hast immer noch nicht zusammengef=C3=BChrte Pfade in der Bereitste=
llung.\n"
+"Hast du vergessen 'git add' zu benutzen?"
+
 #: git-am.sh:847
 msgid "No changes -- Patch already applied."
 msgstr "Keine =C3=84nderungen -- Patches bereits angewendet."
=20
+#: git-am.sh:857
+#, sh-format
+msgid "Patch failed at $msgnum $FIRSTLINE"
+msgstr "Anwendung des Patches fehlgeschlagen bei $msgnum $FIRSTLINE"
+
 #: git-am.sh:873
 msgid "applying to an empty history"
 msgstr "wende zu leerer Historie an"
=20
+#: git-bisect.sh:48
+msgid "You need to start by \"git bisect start\""
+msgstr "Du musst mit \"git bisect start\" beginnen."
+
 #. TRANSLATORS: Make sure to include [Y] and [n] in your
 #. translation. The program will only accept English input
 #. at this point.
@@ -5071,6 +5146,12 @@ msgstr "Ung=C3=BCltige Referenz-Eingabe: $rev"
 msgid "'git bisect bad' can take only one argument."
 msgstr "'git bisect bad' kann nur ein Argument entgegennehmen."
=20
+#. have bad but not good.  we could bisect although
+#. this is less optimum.
+#: git-bisect.sh:273
+msgid "Warning: bisecting only with a bad commit."
+msgstr "Warnung: halbiere nur mit einer fehlerhaften Version"
+
 #. TRANSLATORS: Make sure to include [Y] and [n] in your
 #. translation. The program will only accept English input
 #. at this point.
@@ -5078,6 +5159,29 @@ msgstr "'git bisect bad' kann nur ein Argument e=
ntgegennehmen."
 msgid "Are you sure [Y/n]? "
 msgstr "Bist du sicher [Y/n]? "
=20
+#: git-bisect.sh:289
+msgid ""
+"You need to give me at least one good and one bad revisions.\n"
+"(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
+msgstr ""
+"Du musst mindestens eine korrekte und eine fehlerhafte Version angebe=
n.\n"
+"(Du kannst daf=C3=BCr \"git bisect bad\" und \"git bisect good\" benu=
tzen.)"
+
+#: git-bisect.sh:292
+msgid ""
+"You need to start by \"git bisect start\".\n"
+"You then need to give me at least one good and one bad revisions.\n"
+"(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
+msgstr ""
+"Du musst mit \"git bisect start\" beginnen.\n"
+"Danach musst du mindestens eine korrekte und eine fehlerhafte Version=
 "
+"angeben.\n"
+"(Du kannst daf=C3=BCr \"git bisect bad\" und \"git bisect good\" benu=
tzen.)"
+
+#: git-bisect.sh:347 git-bisect.sh:474
+msgid "We are not bisecting."
+msgstr "Wir sind nicht beim Halbieren."
+
 #: git-bisect.sh:354
 #, sh-format
 msgid "'$invalid' is not a valid commit"
@@ -5105,9 +5209,36 @@ msgstr "kann $file nicht f=C3=BCr das Abspielen =
lesen"
 msgid "?? what are you talking about?"
 msgstr "?? Was redest du da?"
=20
-#: git-bisect.sh:474
-msgid "We are not bisecting."
-msgstr "Wir sind nicht beim Halbieren."
+#: git-bisect.sh:420
+#, sh-format
+msgid "running $command"
+msgstr "f=C3=BChre $command aus"
+
+#: git-bisect.sh:427
+#, sh-format
+msgid ""
+"bisect run failed:\n"
+"exit code $res from '$command' is < 0 or >=3D 128"
+msgstr ""
+"Ausf=C3=BChrung der Halbierung fehlgeschlagen:\n"
+"R=C3=BCckkehrwert $res von '$command' ist < 0 oder >=3D 128"
+
+#: git-bisect.sh:453
+msgid "bisect run cannot continue any more"
+msgstr "Ausf=C3=BChrung der Halbierung kann nicht mehr fortgesetzt wer=
den"
+
+#: git-bisect.sh:459
+#, sh-format
+msgid ""
+"bisect run failed:\n"
+"'bisect_state $state' exited with error code $res"
+msgstr ""
+"Ausf=C3=BChrung der Halbierung fehlgeschlagen:\n"
+"'bisect_state $state' wurde mit Fehlerwert $res beendet"
+
+#: git-bisect.sh:466
+msgid "bisect run success"
+msgstr "Halbierung erfolgreich ausgef=C3=BChrt"
=20
 #: git-pull.sh:21
 msgid ""
@@ -5130,6 +5261,20 @@ msgstr ""
 "Aktualisiere eine ungeborenen Zweig mit =C3=84nderungen, die zur Bere=
itstellung "
 "hinzugef=C3=BCgt wurden"
=20
+#. The fetch involved updating the current branch.
+#. The working tree and the index file is still based on the
+#. $orig_head commit, but we are merging into $curr_head.
+#. First update the working tree to match $curr_head.
+#: git-pull.sh:228
+#, sh-format
+msgid ""
+"Warning: fetch updated the current branch head.\n"
+"Warning: fast-forwarding your working tree from\n"
+"Warning: commit $orig_head."
+msgstr ""
+"Warnung: Die Anforderung aktualisierte die Spitze des aktuellen Zweig=
es.\n"
+"Warnung: Spule deinen Arbeitszweig von Version $orig_head vor."
+
 #: git-pull.sh:253
 msgid "Cannot merge multiple branches into empty head"
 msgstr "Kann nicht mehrere Zweige in einen ungeborenen Zweig zusammenf=
=C3=BChren"
@@ -5166,6 +5311,26 @@ msgstr "Kann tempor=C3=A4re Bereitstellung nicht=
 entfernen (kann nicht passieren)"
 msgid "Cannot record working tree state"
 msgstr "Kann Zustand des Arbeitsbaumes nicht aufzeichnen"
=20
+#. TRANSLATORS: $option is an invalid option, like
+#. `--blah-blah'. The 7 spaces at the beginning of the
+#. second line correspond to "error: ". So you should line
+#. up the second line with however many characters the
+#. translation of "error: " takes in your language. E.g. in
+#. English this is:
+#.
+#. $ git stash save --blah-blah 2>&1 | head -n 2
+#. error: unknown option for 'stash save': --blah-blah
+#. To provide a message, use git stash save -- '--blah-blah'
+#: git-stash.sh:202
+#, sh-format
+msgid ""
+"error: unknown option for 'stash save': $option\n"
+"       To provide a message, use git stash save -- '$option'"
+msgstr ""
+"Fehler: unbekannte Option f=C3=BCr 'stash save': $option\n"
+"        Um eine Beschreibung anzugeben, benutze \"git stash save -- "
+"'$option'\""
+
 #: git-stash.sh:223
 msgid "No local changes to save"
 msgstr "Keine lokalen =C3=84nderungen zum Speichern"
@@ -5227,6 +5392,10 @@ msgstr "Konnte Bereitstellungsbaum nicht speiche=
rn"
 msgid "Cannot unstage modified files"
 msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Bereitstellung herau=
snehmen"
=20
+#: git-stash.sh:474
+msgid "Index was not unstashed."
+msgstr "Bereitstellung wurde nicht ausgelagert."
+
 #: git-stash.sh:491
 #, sh-format
 msgid "Dropped ${REV} ($s)"
@@ -5277,6 +5446,24 @@ msgstr "repo URL: '$repo' muss absolut sein oder=
 mit ./|../ beginnen"
 msgid "'$sm_path' already exists in the index"
 msgstr "'$sm_path' existiert bereits in der Bereitstellung"
=20
+#: git-submodule.sh:270
+#, sh-format
+msgid ""
+"The following path is ignored by one of your .gitignore files:\n"
+"$sm_path\n"
+"Use -f if you really want to add it."
+msgstr ""
+"Der folgende Pfad wird durch eine deiner \".gitignore\" Dateien "
+"ignoriert:\n"
+"$sm_path\n"
+"Benutze -f wenn du diesen wirklich hinzuf=C3=BCgen m=C3=B6chtest."
+
+#: git-submodule.sh:281
+#, sh-format
+msgid "Adding existing repo at '$sm_path' to the index"
+msgstr "F=C3=BCge existierendes Projektarchiv in '$sm_path' der Bereit=
stellung "
+"hinzu."
+
 #: git-submodule.sh:283
 #, sh-format
 msgid "'$sm_path' already exists and is not a valid git repo"
@@ -5385,8 +5572,14 @@ msgid "Failed to recurse into submodule path '$s=
m_path'"
 msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$sm_path'"
=20
 #: git-submodule.sh:713
-msgid "--"
-msgstr "--"
+msgid "--cached cannot be used with --files"
+msgstr "--cached kann nicht mit --files benutzt werden"
+
+#. unexpected type
+#: git-submodule.sh:753
+#, sh-format
+msgid "unexpected mode $mod_dst"
+msgstr "unerwarteter Modus $mod_dst"
=20
 #: git-submodule.sh:771
 #, sh-format
@@ -5412,11 +5605,22 @@ msgstr "Blob"
 msgid "submodule"
 msgstr "Unterprojekt"
=20
+#: git-submodule.sh:840
+msgid "# Submodules changed but not updated:"
+msgstr "# Unterprojekte ge=C3=A4ndert, aber nicht aktualisiert:"
+
+#: git-submodule.sh:842
+msgid "# Submodule changes to be committed:"
+msgstr "# =C3=84nderungen in Unterprojekt zum Eintragen:"
+
 #: git-submodule.sh:974
 #, sh-format
 msgid "Synchronizing submodule url for '$name'"
 msgstr "Synchronisiere Unterprojekt-URL f=C3=BCr '$name'"
=20
+#~ msgid "--"
+#~ msgstr "--"
+
 #~ msgid "Could not extract email from committer identity."
 #~ msgstr "Konnte E-Mail-Adresse des Einreichers nicht extrahieren."
=20
--=20
1.7.11.rc2.3.g909146e
