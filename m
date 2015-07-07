From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 65 new messages
Date: Tue,  7 Jul 2015 07:31:09 +0200
Message-ID: <1436247069-4257-1-git-send-email-ralf.thielow@gmail.com>
References: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, phillip.szelat@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 07 07:31:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCLTZ-0006rJ-M5
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 07:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbbGGFbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 01:31:20 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34569 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbGGFbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 01:31:18 -0400
Received: by wgfr2 with SMTP id r2so2432121wgf.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=20gNhRhkf0Ev1TKSGunzb5VIsVuBMrurzZWyyVZO+sI=;
        b=dwzcyYXhLTQX+gqnrXn/pWz7J1VaBrnaHh09CRbSjoN6gztrMC5ZWDL0EMIB65eMOE
         1fXF2dozffe46AH3xRfJJWLLD4c5RMydu+XnELcrvyrjpbUN7o6wTKjknBJBC+5HC+2G
         BsiN/nTA6eqUGx6z6uj6gRo3j8L2Yi/9tClRRuYIqt7p8ZaOpJGNeg1/bVVOV3x/4cC0
         rLdsMqY0n4kAkOIeILY1rbtWBH/ab5Bygzedvu0RVjDobwJhxZcyqrRjFgDDI0zVqxx1
         BSwoCXPkq8x6N0lTH2SaneS0zAM/2rf9IkMrL69c94dtP+DOAmbHYgYmqtqkVUVmicq7
         ezCA==
X-Received: by 10.180.9.6 with SMTP id v6mr99001498wia.83.1436247077014;
        Mon, 06 Jul 2015 22:31:17 -0700 (PDT)
Received: from localhost (cable-86-56-39-17.cust.telecolumbus.net. [86.56.39.17])
        by mx.google.com with ESMTPSA id ma15sm50599087wic.20.2015.07.06.22.31.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 22:31:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.198.gb2acc3e
In-Reply-To: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273476>

Translate 65 new messages came from git.pot update in
64f23b0 (l10n: git.pot: v2.5.0 round 1 (65 new, 15 removed))".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 192 ++++++++++++++++++++++++++++++++-----------------------=
--------
 1 file changed, 98 insertions(+), 94 deletions(-)

diff --git a/po/de.po b/po/de.po
index d52184c..9c04ebf 100644
--- a/po/de.po
+++ b/po/de.po
@@ -539,19 +539,19 @@ msgstr ""
 #: diff.c:3570
 #, c-format
 msgid "Failed to parse --submodule option parameter: '%s'"
 msgstr "Fehler beim Parsen des --submodule Optionsparameters: '%s'"
=20
 #: dir.c:1852
 msgid "failed to get kernel name and information"
-msgstr ""
+msgstr "Fehler beim Sammeln von Namen und Informationen zum Kernel"
=20
 #: dir.c:1945
 msgid "Untracked cache is disabled on this system."
-msgstr ""
+msgstr "Cache f=C3=BCr unversionierte Dateien ist auf diesem System de=
aktiviert."
=20
 #: gpg-interface.c:129 gpg-interface.c:200
 msgid "could not run gpg."
 msgstr "konnte gpg nicht ausf=C3=BChren"
=20
 #: gpg-interface.c:141
 msgid "gpg did not accept the data"
@@ -589,19 +589,19 @@ msgstr "'%s': read() zu kurz %s"
 #: help.c:207
 #, c-format
 msgid "available git commands in '%s'"
 msgstr "Vorhandene Git-Kommandos in '%s'"
=20
 #: help.c:214
 msgid "git commands available from elsewhere on your $PATH"
-msgstr "Vorhandene Git-Kommandos irgendwo in Ihrem $PATH"
+msgstr "Vorhandene Git-Kommandos anderswo in Ihrem $PATH"
=20
 #: help.c:246
 msgid "These are common Git commands used in various situations:"
-msgstr ""
+msgstr "Allgemeine Git-Kommandos, verwendet in verschiedenen Situation=
en:"
=20
 #: help.c:311
 #, c-format
 msgid ""
 "'%s' appears to be a git command, but we were not\n"
 "able to execute it. Maybe git-%s is broken?"
 msgstr ""
@@ -1089,55 +1089,56 @@ msgid "Internal error"
 msgstr "Interner Fehler"
=20
 #: remote.c:1723 remote.c:1766
 msgid "HEAD does not point to a branch"
 msgstr "HEAD zeigt auf keinen Branch"
=20
 #: remote.c:1732
-#, fuzzy, c-format
+#, c-format
 msgid "no such branch: '%s'"
-msgstr "Kein solcher Branch '%s'"
+msgstr "Kein solcher Branch: '%s'"
=20
 #: remote.c:1735
-#, fuzzy, c-format
+#, c-format
 msgid "no upstream configured for branch '%s'"
 msgstr "Kein Upstream-Branch f=C3=BCr Branch '%s' konfiguriert."
=20
 #: remote.c:1741
-#, fuzzy, c-format
+#, c-format
 msgid "upstream branch '%s' not stored as a remote-tracking branch"
-msgstr "Upstream-Branch '%s' ist nicht als Remote-Tracking-Branch gesp=
eichert"
+msgstr "Upstream-Branch '%s' nicht als Remote-Tracking-Branch gespeich=
ert"
=20
 #: remote.c:1756
 #, c-format
 msgid "push destination '%s' on remote '%s' has no local tracking bran=
ch"
-msgstr ""
+msgstr "Ziel f=C3=BCr \"push\" '%s' auf Remote-Repository '%s' hat kei=
nen lokal "
+"gefolgten Branch"
=20
 #: remote.c:1771
-#, fuzzy, c-format
+#, c-format
 msgid "branch '%s' has no remote for pushing"
 msgstr "Branch '%s' hat keinen Upstream-Branch gesetzt"
=20
 #: remote.c:1782
 #, c-format
 msgid "push refspecs for '%s' do not include '%s'"
-msgstr ""
+msgstr "Push-Refspecs f=C3=BCr '%s' beinhalten nicht '%s'"
=20
 #: remote.c:1795
 msgid "push has no destination (push.default is 'nothing')"
-msgstr ""
+msgstr "kein Ziel f=C3=BCr \"push\" (push.default ist 'nothing')"
=20
 #: remote.c:1817
 msgid "cannot resolve 'simple' push to a single destination"
-msgstr ""
+msgstr "kann einzelnes Ziel f=C3=BCr \"push\" im Modus 'simple' nicht =
aufl=C3=B6sen"
=20
 #: remote.c:2124
 #, c-format
 msgid "Your branch is based on '%s', but the upstream is gone.\n"
-msgstr "Ihr Branch basiert auf '%s', aber Upstream-Branch wurde entfer=
nt.\n"
+msgstr "Ihr Branch basiert auf '%s', aber der Upstream-Branch wurde en=
tfernt.\n"
=20
 #: remote.c:2128
 msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
 msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n=
"
=20
 #: remote.c:2131
 #, c-format
@@ -1463,17 +1464,17 @@ msgid "Can't revert as initial commit"
 msgstr "Kann nicht als allerersten Commit einen Revert ausf=C3=BChren.=
"
=20
 #: sequencer.c:1124
 msgid "Can't cherry-pick into empty head"
 msgstr "Kann nicht als allerersten Commit einen Cherry-Pick ausf=C3=BC=
hren."
=20
 #: setup.c:243
-#, fuzzy, c-format
+#, c-format
 msgid "failed to read %s"
-msgstr "Fehler beim L=C3=B6schen von %s"
+msgstr "Fehler beim Lesen von %s"
=20
 #: sha1_name.c:453
 msgid ""
 "Git normally never creates a ref that ends with 40 hex characters\n"
 "because it will be ignored when you just specify 40-hex. These refs\n=
"
 "may be created by mistake. For example,\n"
 "\n"
@@ -1604,27 +1605,27 @@ msgid "no such user"
 msgstr "kein solcher Benutzer"
=20
 #: wrapper.c:564
 msgid "unable to get current working directory"
 msgstr "Konnte aktuelles Arbeitsverzeichnis nicht bekommen."
=20
 #: wrapper.c:575
-#, fuzzy, c-format
+#, c-format
 msgid "could not open %s for writing"
 msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
=20
 #: wrapper.c:587
-#, fuzzy, c-format
+#, c-format
 msgid "could not write to %s"
-msgstr "Konnte nicht nach %s schreiben"
+msgstr "Konnte nicht nach '%s' schreiben."
=20
 #: wrapper.c:593
-#, fuzzy, c-format
+#, c-format
 msgid "could not close %s"
-msgstr "konnte %s nicht parsen"
+msgstr "Konnte '%s' nicht schlie=C3=9Fen."
=20
 #: wt-status.c:150
 msgid "Unmerged paths:"
 msgstr "Nicht zusammengef=C3=BChrte Pfade:"
=20
 #: wt-status.c:177 wt-status.c:204
 #, c-format
@@ -2120,17 +2121,16 @@ msgid "Could not open '%s' for writing."
 msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
=20
 #: builtin/add.c:209
 msgid "Could not write patch"
 msgstr "Konnte Patch nicht schreiben"
=20
 #: builtin/add.c:212
-#, fuzzy
 msgid "editing patch failed"
-msgstr "Konnte '%s' nicht l=C3=B6schen"
+msgstr "Bearbeitung des Patches fehlgeschlagen"
=20
 #: builtin/add.c:215
 #, c-format
 msgid "Could not stat '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht lesen"
=20
 #: builtin/add.c:217
@@ -2800,17 +2800,16 @@ msgid "perform 'git bisect next'"
 msgstr "'git bisect next' ausf=C3=BChren"
=20
 #: builtin/bisect--helper.c:19
 msgid "update BISECT_HEAD instead of checking out the current commit"
 msgstr "BISECT_HEAD aktualisieren, anstatt den aktuellen Commit auszuc=
hecken"
=20
 #: builtin/blame.c:31
-#, fuzzy
 msgid "git blame [<options>] [<rev-opts>] [<rev>] [--] <file>"
-msgstr "git blame [<Optionen>] [<rev-opts>] [<Commit>] [--] Datei"
+msgstr "git blame [<Optionen>] [<rev-opts>] [<Commit>] [--] <Datei>"
=20
 #: builtin/blame.c:36
 msgid "<rev-opts> are documented in git-rev-list(1)"
 msgstr "<rev-opts> sind dokumentiert in git-rev-list(1)"
=20
 #: builtin/blame.c:2500
 msgid "Show blame entries as we find them, incrementally"
@@ -2981,37 +2980,37 @@ msgstr "Konnte Commit-Objekt f=C3=BCr HEAD nich=
t nachschlagen."
 #: builtin/branch.c:227
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
 msgstr ""
 "Kann Branch '%s' nicht entfernen, da Sie sich gerade auf diesem befin=
den."
=20
 #: builtin/branch.c:243
-#, fuzzy, c-format
+#, c-format
 msgid "remote-tracking branch '%s' not found."
-msgstr "Remote-Branch '%s' nicht gefunden"
+msgstr "Remote-Tracking-Branch '%s' nicht gefunden"
=20
 #: builtin/branch.c:244
 #, c-format
 msgid "branch '%s' not found."
 msgstr "Branch '%s' nicht gefunden."
=20
 #: builtin/branch.c:258
-#, fuzzy, c-format
+#, c-format
 msgid "Error deleting remote-tracking branch '%s'"
-msgstr "Fehler beim Entfernen des Remote-Branches '%s'"
+msgstr "Fehler beim Entfernen des Remote-Tracking-Branches '%s'"
=20
 #: builtin/branch.c:259
 #, c-format
 msgid "Error deleting branch '%s'"
 msgstr "Fehler beim Entfernen des Branches '%s'"
=20
 #: builtin/branch.c:266
-#, fuzzy, c-format
+#, c-format
 msgid "Deleted remote-tracking branch %s (was %s).\n"
-msgstr "Remote-Branch %s entfernt (war %s).\n"
+msgstr "Remote-Tracking-Branch %s entfernt (war %s).\n"
=20
 #: builtin/branch.c:267
 #, c-format
 msgid "Deleted branch %s (was %s).\n"
 msgstr "Branch %s entfernt (war %s).\n"
=20
 #: builtin/branch.c:368
@@ -3354,26 +3353,28 @@ msgid "Need a repository to create a bundle."
 msgstr "Um ein Paket zu erstellen wird ein Repository ben=C3=B6tigt."
=20
 #: builtin/bundle.c:68
 msgid "Need a repository to unbundle."
 msgstr "Zum Entpacken wird ein Repository ben=C3=B6tigt."
=20
 #: builtin/cat-file.c:369
-#, fuzzy
 msgid ""
 "git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|=
-p|"
 "<type>|--textconv) <object>"
-msgstr "git cat-file (-t | -s | -e | -p | <Art> | --textconv) <Objekt>=
"
+msgstr ""
+"git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|=
-p|"
+"<Art>|--textconv) <Objekt>"
=20
 #: builtin/cat-file.c:370
-#, fuzzy
 msgid ""
 "git cat-file (--batch | --batch-check) [--follow-symlinks] < <list-of=
-"
 "objects>"
-msgstr "git cat-file (--batch | --batch-check) < <Liste-von-Objekten>"
+msgstr ""
+"git cat-file (--batch | --batch-check) [--follow-symlinks] < <Liste-v=
on-"
+"Objekten"
=20
 #: builtin/cat-file.c:407
 msgid "<type> can be one of: blob, tree, commit, tag"
 msgstr "<Art> kann sein: blob, tree, commit, tag"
=20
 #: builtin/cat-file.c:408
 msgid "show object type"
@@ -3393,30 +3394,31 @@ msgstr "ansprechende Anzeige des Objektinhaltes=
"
=20
 #: builtin/cat-file.c:414
 msgid "for blob objects, run textconv on object's content"
 msgstr "eine Textkonvertierung auf den Inhalt von Blob-Objekten ausf=C3=
=BChren"
=20
 #: builtin/cat-file.c:416
 msgid "allow -s and -t to work with broken/corrupt objects"
-msgstr ""
+msgstr "-s und -t mit besch=C3=A4digten Objekten erlauben"
=20
 #: builtin/cat-file.c:418
 msgid "show info and content of objects fed from the standard input"
 msgstr ""
 "Anzeige von Informationen und Inhalt von Objekten, gelesen von der St=
andard-"
 "Eingabe"
=20
 #: builtin/cat-file.c:421
 msgid "show info about objects fed from the standard input"
 msgstr ""
 "Anzeige von Informationen =C3=BCber Objekte, gelesen von der Standard=
-Eingabe"
=20
 #: builtin/cat-file.c:424
 msgid "follow in-tree symlinks (used with --batch or --batch-check)"
-msgstr ""
+msgstr "symbolischen Verkn=C3=BCpfungen innerhalb des Repositories fol=
gen "
+"(verwendet mit --batch oder --batch-check)"
=20
 #: builtin/check-attr.c:11
 msgid "git check-attr [-a | --all | <attr>...] [--] <pathname>..."
 msgstr "git check-attr [-a | --all | <Attribut>...] [--] <Pfadname>...=
"
=20
 #: builtin/check-attr.c:12
 msgid "git check-attr --stdin [-z] [-a | --all | <attr>...] < <list-of=
-paths>"
@@ -3578,15 +3580,15 @@ msgstr "Pfad '%s': kann nicht zusammenf=C3=BChr=
en"
 msgid "Unable to add merge result for '%s'"
 msgstr "Konnte Merge-Ergebnis von '%s' nicht hinzuf=C3=BCgen."
=20
 #: builtin/checkout.c:255 builtin/checkout.c:258 builtin/checkout.c:26=
1
 #: builtin/checkout.c:264 builtin/checkout.c:277
 #, c-format
 msgid "'%s' cannot be used with updating paths"
-msgstr "'%s' kann nicht mit Pfaden verwendet werden"
+msgstr "'%s' kann nicht mit der Aktualisierung von Pfaden verwendet we=
rden"
=20
 #: builtin/checkout.c:267 builtin/checkout.c:270
 #, c-format
 msgid "'%s' cannot be used with %s"
 msgstr "'%s' kann nicht mit '%s' verwendet werden"
=20
 #: builtin/checkout.c:273
@@ -3667,15 +3669,15 @@ msgstr[0] ""
 msgstr[1] ""
 "Warnung: Sie lassen %d Commits zur=C3=BCck. Folgende Commits sind in\=
n"
 "keinem Ihrer Branches enthalten:\n"
 "\n"
 "%s\n"
=20
 #: builtin/checkout.c:765
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "If you want to keep it by creating a new branch, this may be a good t=
ime\n"
 "to do so with:\n"
 "\n"
 " git branch <new-branch-name> %s\n"
 "\n"
 msgid_plural ""
@@ -3706,43 +3708,42 @@ msgid "Previous HEAD position was"
 msgstr "Vorherige Position von HEAD war"
=20
 #: builtin/checkout.c:832 builtin/checkout.c:1280
 msgid "You are on a branch yet to be born"
 msgstr "Sie sind auf einem Branch, der noch geboren wird"
=20
 #: builtin/checkout.c:893
-#, fuzzy
 msgid "no branch specified"
-msgstr "Kein Branchname spezifiziert"
+msgstr "Kein Branch spezifiziert"
=20
 #: builtin/checkout.c:895
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' already exists"
-msgstr "%s existiert bereits"
+msgstr "'%s' existiert bereits"
=20
 #: builtin/checkout.c:910 builtin/checkout.c:937 builtin/clone.c:842
 #: builtin/clone.c:853
 #, c-format
 msgid "could not create leading directories of '%s'"
 msgstr "Konnte f=C3=BChrende Verzeichnisse von '%s' nicht erstellen."
=20
 #: builtin/checkout.c:924
-#, fuzzy, c-format
+#, c-format
 msgid "could not create directory of '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
 #: builtin/checkout.c:960
 #, c-format
 msgid "Enter %s (identifier %s)"
-msgstr ""
+msgstr "Betrete %s (Identifikation %s)"
=20
 #: builtin/checkout.c:1070
 #, c-format
 msgid "'%s' is already checked out at '%s'"
-msgstr ""
+msgstr "'%s' ist bereits in '%s' ausgecheckt"
=20
 #: builtin/checkout.c:1176
 #, c-format
 msgid "only one reference expected, %d given."
 msgstr "nur eine Referenz erwartet, %d gegeben."
=20
 #: builtin/checkout.c:1215
@@ -3841,22 +3842,21 @@ msgid "do not limit pathspecs to sparse entries=
 only"
 msgstr "keine Einschr=C3=A4nkung bei Pfadspezifikationen zum partielle=
n Auschecken"
=20
 #: builtin/checkout.c:1368
 msgid "second guess 'git checkout <no-such-branch>'"
 msgstr "second guess 'git checkout <no-such-branch>'"
=20
 #: builtin/checkout.c:1370
-#, fuzzy
 msgid "check a branch out in a separate working directory"
-msgstr "Branches oder Pfade im Arbeitsverzeichnis auschecken"
+msgstr "Branch in separatem Arbeitsverzeichnis auschecken"
=20
 #: builtin/checkout.c:1372
-#, fuzzy
 msgid "do not check if another worktree is holding the given ref"
-msgstr "das Arbeitsverzeichnis nach dem Merge nicht pr=C3=BCfen"
+msgstr "Pr=C3=BCfung, ob die Referenz bereits in einem anderen Arbeits=
verzeichnis "
+"ausgecheckt wurde, deaktivieren"
=20
 #: builtin/checkout.c:1406
 msgid "-b, -B and --orphan are mutually exclusive"
 msgstr "Die Optionen -b, -B und --orphan schlie=C3=9Fen sich gegenseit=
ig aus."
=20
 #: builtin/checkout.c:1423
 msgid "--track needs a branch name"
@@ -5150,26 +5150,26 @@ msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
=20
 #: builtin/config.c:316
 msgid "unable to parse default color value"
 msgstr "konnte Standard-Farbwert nicht parsen"
=20
 #: builtin/config.c:457
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "# This is Git's per-user configuration file.\n"
 "[user]\n"
 "# Please adapt and uncomment the following lines:\n"
 "#\tname =3D %s\n"
 "#\temail =3D %s\n"
 msgstr ""
 "# Das ist Git's benutzerspezifische Konfiguraionsdatei.\n"
-"[core]\n"
+"[user]\n"
 "# Bitte passen Sie die folgenden Zeilen an und kommentieren Sie diese=
 aus:\n"
-"#\tuser =3D %s\n"
+"#\tname =3D %s\n"
 "#\temail =3D %s\n"
=20
 #: builtin/config.c:587
 #, c-format
 msgid "cannot create configuration file %s"
 msgstr "Konnte Konfigurationsdatei '%s' nicht erstellen."
=20
@@ -6741,15 +6741,14 @@ msgid "trailer"
 msgstr "Anhang"
=20
 #: builtin/interpret-trailers.c:27
 msgid "trailer(s) to add"
 msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
=20
 #: builtin/log.c:41
-#, fuzzy
 msgid "git log [<options>] [<revision-range>] [[--] <path>...]"
 msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
=20
 #: builtin/log.c:42
 msgid "git show [<options>] <object>..."
 msgstr "git show [<Optionen>] <Objekt>..."
=20
@@ -7395,17 +7394,17 @@ msgstr ""
=20
 #: builtin/merge.c:944
 #, c-format
 msgid "No remote-tracking branch for %s from %s"
 msgstr "Kein Remote-Tracking-Branch f=C3=BCr %s von %s"
=20
 #: builtin/merge.c:1081
-#, fuzzy, c-format
+#, c-format
 msgid "could not close '%s'"
-msgstr "Konnte '%s' nicht =C3=B6ffnen"
+msgstr "Konnte '%s' nicht schlie=C3=9Fen"
=20
 #: builtin/merge.c:1208
 msgid "There is no merge to abort (MERGE_HEAD missing)."
 msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
=20
 #: builtin/merge.c:1224
 msgid ""
@@ -8320,63 +8319,63 @@ msgid "Removing duplicate objects"
 msgstr "L=C3=B6sche doppelte Objekte"
=20
 #: builtin/prune.c:12
 msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
 msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head>...]"
=20
 #: builtin/prune.c:86
-#, fuzzy, c-format
+#, c-format
 msgid "Removing worktrees/%s: not a valid directory"
-msgstr "Entferne %s, um Platz f=C3=BCr Unterverzeichnis zu schaffen\n"
+msgstr "L=C3=B6sche worktrees/%s: kein g=C3=BCltiges Verzeichnis"
=20
 #: builtin/prune.c:92
 #, c-format
 msgid "Removing worktrees/%s: gitdir file does not exist"
-msgstr ""
+msgstr "L=C3=B6sche worktrees/%s: gitdir-Datei existiert nicht"
=20
 #: builtin/prune.c:97
 #, c-format
 msgid "Removing worktrees/%s: unable to read gitdir file (%s)"
-msgstr ""
+msgstr "L=C3=B6sche worktrees/%s: konnte gitdir-Datei (%s) nicht lesen=
"
=20
 #: builtin/prune.c:108
 #, c-format
 msgid "Removing worktrees/%s: invalid gitdir file"
-msgstr ""
+msgstr "L=C3=B6sche worktrees/%s: ung=C3=BCltige gitdir-Datei"
=20
 #: builtin/prune.c:124
 #, c-format
 msgid "Removing worktrees/%s: gitdir file points to non-existent locat=
ion"
-msgstr ""
+msgstr "L=C3=B6sche worktrees/%s: gitdir-Datei verweist auf nicht exis=
tierenden Ort"
=20
 #: builtin/prune.c:159
-#, fuzzy, c-format
+#, c-format
 msgid "failed to remove: %s"
-msgstr "Fehler beim L=C3=B6schen von %s"
+msgstr "Fehler beim L=C3=B6schen: %s"
=20
 #: builtin/prune.c:196
 msgid "do not remove, show only"
 msgstr "nicht l=C3=B6schen, nur anzeigen"
=20
 #: builtin/prune.c:197
 msgid "report pruned objects"
 msgstr "gel=C3=B6schte Objekte melden"
=20
 #: builtin/prune.c:199
 msgid "prune .git/worktrees"
-msgstr ""
+msgstr "Informationen zu nicht mehr existierenden Arbeitsverzeichnisse=
n in "
+".git/worktrees entfernen"
=20
 #: builtin/prune.c:201
 msgid "expire objects older than <time>"
 msgstr "Objekte =C3=A4lter als <Zeit> verfallen lassen"
=20
 #: builtin/prune.c:216
-#, fuzzy
 msgid "--worktrees does not take extra arguments"
-msgstr "fetch --all akzeptiert kein Repository als Argument"
+msgstr "--worktrees akzeptiert keine weiteren Argumente"
=20
 #: builtin/push.c:14
 msgid "git push [<options>] [<repository> [<refspec>...]]"
 msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
=20
 #: builtin/push.c:85
 msgid "tag shorthand without <tag>"
@@ -10252,70 +10251,75 @@ msgid "Updated tag '%s' (was %s)\n"
 msgstr "Tag '%s' aktualisiert (war %s)\n"
=20
 #: builtin/unpack-objects.c:489
 msgid "Unpacking objects"
 msgstr "Entpacke Objekte"
=20
 #: builtin/update-index.c:70
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create directory %s"
 msgstr "Fehler beim Erstellen von Verzeichnis '%s'"
=20
 #: builtin/update-index.c:76
-#, fuzzy, c-format
+#, c-format
 msgid "failed to stat %s"
-msgstr "Konnte %s nicht lesen\n"
+msgstr "Konnte '%s' nicht lesen"
=20
 #: builtin/update-index.c:86
-#, fuzzy, c-format
+#, c-format
 msgid "failed to create file %s"
-msgstr "Konnte Verweis '%s' nicht erstellen"
+msgstr "Konnte Datei '%s' nicht erstellen"
=20
 #: builtin/update-index.c:94
-#, fuzzy, c-format
+#, c-format
 msgid "failed to delete file %s"
-msgstr "Konnte Verweis '%s' nicht erstellen"
+msgstr "Konnte Datei '%s' nicht l=C3=B6schen"
=20
 #: builtin/update-index.c:101 builtin/update-index.c:203
-#, fuzzy, c-format
+#, c-format
 msgid "failed to delete directory %s"
-msgstr "Fehler beim Erstellen von Verzeichnis '%s'"
+msgstr "Konnte Verzeichnis '%s' nicht l=C3=B6schen"
=20
 #: builtin/update-index.c:124
-#, fuzzy, c-format
+#, c-format
 msgid "Testing "
-msgstr "Fordere an von %s\n"
+msgstr "Pr=C3=BCfe "
=20
 #: builtin/update-index.c:136
 msgid "directory stat info does not change after adding a new file"
-msgstr ""
+msgstr "Verzeichnisinformationen haben sich nach Hinzuf=C3=BCgen einer=
 neuen Datei "
+"nicht ge=C3=A4ndert"
=20
 #: builtin/update-index.c:149
 msgid "directory stat info does not change after adding a new director=
y"
-msgstr ""
+msgstr "Verzeichnisinformationen haben sich nach Hinzuf=C3=BCgen eines=
 neuen "
+"Verzeichnisses nicht ge=C3=A4ndert"
=20
 #: builtin/update-index.c:162
 msgid "directory stat info changes after updating a file"
-msgstr ""
+msgstr "Verzeichnisinformationen haben sich nach Aktualisierung einer =
Datei ge=C3=A4ndert"
=20
 #: builtin/update-index.c:173
 msgid "directory stat info changes after adding a file inside subdirec=
tory"
-msgstr ""
+msgstr "Verzeichnisinformationen haben sich nach Hinzuf=C3=BCgen einer=
 Datei in ein "
+"Unterverzeichnis ge=C3=A4ndert"
=20
 #: builtin/update-index.c:184
 msgid "directory stat info does not change after deleting a file"
-msgstr ""
+msgstr "Verzeichnisinformationen haben sich nach dem L=C3=B6schen eine=
r Datei nicht "
+"ge=C3=A4ndert"
=20
 #: builtin/update-index.c:197
 msgid "directory stat info does not change after deleting a directory"
-msgstr ""
+msgstr "Verzeichnisinformationen haben sich nach dem L=C3=B6schen eine=
s "
+"Verzeichnisses nicht ge=C3=A4ndert"
=20
 #: builtin/update-index.c:204
 msgid " OK"
-msgstr ""
+msgstr " OK"
=20
 #: builtin/update-index.c:564
 msgid "git update-index [<options>] [--] [<file>...]"
 msgstr "git update-index [<Optionen>] [--] [<Datei>...]"
=20
 #: builtin/update-index.c:918
 msgid "continue refresh even when index needs update"
@@ -10433,19 +10437,19 @@ msgstr "Index-Datei in diesem Format schreibe=
n"
=20
 #: builtin/update-index.c:996
 msgid "enable or disable split index"
 msgstr "Splitting des Index aktivieren oder deaktivieren"
=20
 #: builtin/update-index.c:998
 msgid "enable/disable untracked cache"
-msgstr ""
+msgstr "Cache f=C3=BCr unversionierte Dateien aktivieren oder deaktivi=
eren"
=20
 #: builtin/update-index.c:1000
 msgid "enable untracked cache without testing the filesystem"
-msgstr ""
+msgstr "Cache f=C3=BCr unversionierte Dateien ohne Pr=C3=BCfung des Da=
teisystems aktivieren"
=20
 #: builtin/update-ref.c:9
 msgid "git update-ref [<options>] -d <refname> [<old-val>]"
 msgstr "git update-ref [<Optionen>] -d <Referenzname> [<alter-Wert>]"
=20
 #: builtin/update-ref.c:10
 msgid "git update-ref [<options>]    <refname> <new-val> [<old-val>]"
@@ -10537,31 +10541,31 @@ msgstr ""
 "'git help -a' und 'git help -g' listet verf=C3=BCgbare Unterkommandos=
 und\n"
 "einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Komm=
ando>'\n"
 "oder 'git help <Konzept>', um mehr =C3=BCber ein spezifisches Kommand=
o oder\n"
 "Konzept zu erfahren."
=20
 #: common-cmds.h:10
 msgid "start a working area (see also: git help tutorial)"
-msgstr ""
+msgstr "Arbeitsverzeichnis anlegen (siehe auch: git help tutorial)"
=20
 #: common-cmds.h:11
 msgid "work on the current change (see also: git help everyday)"
-msgstr ""
+msgstr "an aktuellen =C3=84nderungen arbeiten (siehe auch: git help ev=
eryday)"
=20
 #: common-cmds.h:12
 msgid "examine the history and state (see also: git help revisions)"
-msgstr ""
+msgstr "Historie und Status untersuchen (siehe auch: git help revision=
s)"
=20
 #: common-cmds.h:13
 msgid "grow, mark and tweak your common history"
-msgstr ""
+msgstr "Historie erweitern und bearbeiten"
=20
 #: common-cmds.h:14
 msgid "collaborate (see also: git help workflows)"
-msgstr ""
+msgstr "mit anderen zusammenarbeiten (siehe auch: git help workflows)"
=20
 #: common-cmds.h:18
 msgid "Add file contents to the index"
 msgstr "Dateiinhalte zum Commit vormerken"
=20
 #: common-cmds.h:19
 msgid "Find by binary search the change that introduced a bug"
@@ -11296,15 +11300,15 @@ msgstr "Kann den aktuellen Status nicht speic=
hern"
 #: git-stash.sh:288
 msgid "Cannot remove worktree changes"
 msgstr "Kann =C3=84nderungen im Arbeitsverzeichnis nicht l=C3=B6schen"
=20
 #: git-stash.sh:389
 #, sh-format
 msgid "unknown option: $opt"
-msgstr ""
+msgstr "unbekannte Option: $opt"
=20
 #: git-stash.sh:399
 msgid "No stash found."
 msgstr "Kein \"stash\" gefunden."
=20
 #: git-stash.sh:406
 #, sh-format
--=20
2.5.0.rc1.198.gb2acc3e
