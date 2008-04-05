From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Git Gui: update french translation.
Date: Sat, 5 Apr 2008 06:06:17 +0200
Message-ID: <20080405060617.e3d8f1cd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 06:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhzbB-00069i-5Z
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 06:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbYDEEAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 00:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbYDEEAv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 00:00:51 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38532 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbYDEEAu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 00:00:50 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1401C1AB2C2;
	Sat,  5 Apr 2008 06:00:48 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B2EB41AB2C1;
	Sat,  5 Apr 2008 06:00:47 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78836>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 po/fr.po |   78 ++++++++++++++++++++++++++----------------------------=
-------
 1 files changed, 33 insertions(+), 45 deletions(-)

	Carefull, the encoding of this patch is probably broken.
	Please get it from the mob branch of git-gui-i18n.git instead.

diff --git a/po/fr.po b/po/fr.po
index d281938..89b6d51 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: fr\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-01-14 21:08+0100\n"
+"PO-Revision-Date: 2008-04-04 22:05+0200\n"
 "Last-Translator: Christian Couder <chriscool@tuxfamily.org>\n"
 "Language-Team: French\n"
 "MIME-Version: 1.0\n"
@@ -344,8 +344,7 @@ msgstr "Documentation en ligne"
 #: git-gui.sh:2238
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
-"fatale : pas d'infos sur le chemin %s : Fichier ou r=C3=A9pertoire in=
existant"
+msgstr "erreur fatale : pas d'infos sur le chemin %s : Fichier ou r=C3=
=A9pertoire inexistant"
=20
 #: git-gui.sh:2271
 msgid "Current Branch:"
@@ -630,8 +629,7 @@ msgstr "Merci de choisir une branche de suivi"
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr ""
-"La branche de suivi %s n'est pas une branche dans le r=C3=A9f=C3=A9re=
ntiel distant."
+msgstr "La branche de suivi %s n'est pas une branche dans le r=C3=A9f=C3=
=A9rentiel distant."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
@@ -751,7 +749,7 @@ msgstr "R=C3=A9cup=C3=A9ration de %s =C3=A0 partir =
de %s"
 #: lib/checkout_op.tcl:127
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr "Erreur fatale : Impossible de r=C3=A9soudre %s"
+msgstr "erreur fatale : Impossible de r=C3=A9soudre %s"
=20
 #: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
 msgid "Close"
@@ -798,12 +796,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du "
-"r=C3=A9f=C3=A9rentiel.\n"
+"L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du r=C3=A9f=C3=A9rentiel.\n"
 "\n"
-"Un autre programme Git a modifi=C3=A9 ce r=C3=A9f=C3=A9rentiel depuis=
 la derni=C3=A8re "
-"synchronisation. Une resynchronisation doit =C3=AAtre effectu=C3=A9e =
avant de pouvoir "
-"modifier la branche courante.\n"
+"Un autre programme Git a modifi=C3=A9 ce r=C3=A9f=C3=A9rentiel depuis=
 la derni=C3=A8re synchronisation. Une resynchronisation doit =C3=AAtre=
 effectu=C3=A9e avant de pouvoir modifier la branche courante.\n"
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement.\n"
=20
@@ -814,13 +809,12 @@ msgstr "Mise =C3=A0 jour du r=C3=A9pertoire coura=
nt avec '%s'..."
=20
 #: lib/checkout_op.tcl:323
 msgid "files checked out"
-msgstr ""
+msgstr "fichiers emprunt=C3=A9s"
=20
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr ""
-"Emprunt de '%s' abandonn=C3=A9. (Il est n=C3=A9cessaire de fusionner =
des fichiers.)"
+msgstr "Emprunt de '%s' abandonn=C3=A9. (Il est n=C3=A9cessaire de fus=
ionner des fichiers.)"
=20
 #: lib/checkout_op.tcl:354
 msgid "File level merge required."
@@ -1089,8 +1083,7 @@ msgstr ""
=20
 #: lib/choose_repository.tcl:880
 msgid "Cannot determine HEAD.  See console output for details."
-msgstr ""
-"Impossible de d=C3=A9terminer HEAD. Voir la sortie console pour plus =
de d=C3=A9tails."
+msgstr "Impossible de d=C3=A9terminer HEAD. Voir la sortie console pou=
r plus de d=C3=A9tails."
=20
 #: lib/choose_repository.tcl:889
 #, tcl-format
@@ -1292,32 +1285,31 @@ msgstr "attention : Tcl ne supporte pas l'encod=
age '%s'."
=20
 #: lib/commit.tcl:221
 msgid "Calling pre-commit hook..."
-msgstr ""
+msgstr "Appel du programme externe d'avant commit..."
=20
 #: lib/commit.tcl:236
 msgid "Commit declined by pre-commit hook."
-msgstr ""
+msgstr "Commit refus=C3=A9 par le programme externe d'avant commit."
=20
 #: lib/commit.tcl:259
 msgid "Calling commit-msg hook..."
-msgstr ""
+msgstr "Appel du programme externe de message de commit..."
=20
 #: lib/commit.tcl:274
 msgid "Commit declined by commit-msg hook."
-msgstr ""
+msgstr "Commit refus=C3=A9 par le programme externe de message de comm=
it."
=20
 #: lib/commit.tcl:287
 msgid "Committing changes..."
-msgstr ""
+msgstr "Commit des modifications..."
=20
 #: lib/commit.tcl:303
 msgid "write-tree failed:"
 msgstr "write-tree a =C3=A9chou=C3=A9 :"
=20
 #: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
-#, fuzzy
 msgid "Commit failed."
-msgstr "Le clonage a =C3=A9chou=C3=A9."
+msgstr "Le commit a =C3=A9chou=C3=A9."
=20
 #: lib/commit.tcl:321
 #, tcl-format
@@ -1479,8 +1471,7 @@ msgstr "Erreur lors du chargement des diff=C3=A9r=
ences :"
=20
 #: lib/diff.tcl:303
 msgid "Failed to unstage selected hunk."
-msgstr ""
-"La suppression dans le pr=C3=A9-commit de la section s=C3=A9lectionn=C3=
=A9e a =C3=A9chou=C3=A9e."
+msgstr "La suppression dans le pr=C3=A9-commit de la section s=C3=A9le=
ctionn=C3=A9e a =C3=A9chou=C3=A9e."
=20
 #: lib/diff.tcl:310
 msgid "Failed to stage selected hunk."
@@ -1510,8 +1501,7 @@ msgstr "Erreur de pr=C3=A9-commit"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
-msgstr ""
-"Le pr=C3=A9-commit a =C3=A9chou=C3=A9. Une resynchronisation va =C3=AA=
tre lanc=C3=A9e automatiquement."
+msgstr "Le pr=C3=A9-commit a =C3=A9chou=C3=A9. Une resynchronisation v=
a =C3=AAtre lanc=C3=A9e automatiquement."
=20
 #: lib/index.tcl:27
 msgid "Continue"
@@ -1527,9 +1517,8 @@ msgid "Unstaging %s from commit"
 msgstr "Supprimer %s du commit"
=20
 #: lib/index.tcl:313
-#, fuzzy
 msgid "Ready to commit."
-msgstr "Pr=C3=A9-commit=C3=A9"
+msgstr "Pr=C3=AAt =C3=A0 =C3=AAtre commit=C3=A9."
=20
 #: lib/index.tcl:326
 #, tcl-format
@@ -1627,9 +1616,9 @@ msgid "%s of %s"
 msgstr "%s de %s"
=20
 #: lib/merge.tcl:119
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Merging %s and %s..."
-msgstr "Fusion de %s et %s"
+msgstr "Fusion de %s et %s..."
=20
 #: lib/merge.tcl:130
 msgid "Merge completed successfully."
@@ -1693,9 +1682,8 @@ msgid "Aborting"
 msgstr "Abandon"
=20
 #: lib/merge.tcl:238
-#, fuzzy
 msgid "files reset"
-msgstr "fichiers"
+msgstr "fichiers r=C3=A9initialis=C3=A9s"
=20
 #: lib/merge.tcl:265
 msgid "Abort failed."
@@ -1759,9 +1747,8 @@ msgid "Number of Diff Context Lines"
 msgstr "Nombre de lignes de contexte dans les diffs"
=20
 #: lib/option.tcl:127
-#, fuzzy
 msgid "Commit Message Text Width"
-msgstr "Message de commit :"
+msgstr "Largeur du texte de message de commit"
=20
 #: lib/option.tcl:128
 msgid "New Branch Name Template"
@@ -1769,7 +1756,7 @@ msgstr "Nouveau mod=C3=A8le de nom de branche"
=20
 #: lib/option.tcl:192
 msgid "Spelling Dictionary:"
-msgstr ""
+msgstr "Dictionnaire d'orthographe :"
=20
 #: lib/option.tcl:216
 msgid "Change Font"
@@ -1898,40 +1885,40 @@ msgstr "Impossible d'=C3=A9crire l'ic=C3=B4ne :=
"
=20
 #: lib/spellcheck.tcl:57
 msgid "Unsupported spell checker"
-msgstr ""
+msgstr "V=C3=A9rificateur d'orthographe non support=C3=A9"
=20
 #: lib/spellcheck.tcl:65
 msgid "Spell checking is unavailable"
-msgstr ""
+msgstr "La v=C3=A9rification d'orthographe n'est pas disponible"
=20
 #: lib/spellcheck.tcl:68
 msgid "Invalid spell checking configuration"
-msgstr ""
+msgstr "Configuration de v=C3=A9rification d'orthographe invalide"
=20
 #: lib/spellcheck.tcl:70
 #, tcl-format
 msgid "Reverting dictionary to %s."
-msgstr ""
+msgstr "R=C3=A9initialisation du dictionnaire =C3=A0 %s."
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr ""
+msgstr "La v=C3=A9rification d'orthographe a =C3=A9chou=C3=A9e silenti=
eusement au d=C3=A9marrage"
=20
 #: lib/spellcheck.tcl:80
 msgid "Unrecognized spell checker"
-msgstr ""
+msgstr "V=C3=A9rificateur d'orthographe non reconnu"
=20
 #: lib/spellcheck.tcl:180
 msgid "No Suggestions"
-msgstr ""
+msgstr "Aucune suggestion"
=20
 #: lib/spellcheck.tcl:381
 msgid "Unexpected EOF from spell checker"
-msgstr ""
+msgstr "Fin de fichier innatendue envoy=C3=A9e par le v=C3=A9rificateu=
r d'orthographe"
=20
 #: lib/spellcheck.tcl:385
 msgid "Spell Checker Failed"
-msgstr ""
+msgstr "Le v=C3=A9rificateur d'orthographe a =C3=A9chou=C3=A9"
=20
 #: lib/status_bar.tcl:83
 #, tcl-format
@@ -2002,3 +1989,4 @@ msgstr "Utiliser des petits paquets (pour les con=
nexions lentes)"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "Inclure les marques"
+
--=20
1.5.5.rc2.134.g08cc.dirty
