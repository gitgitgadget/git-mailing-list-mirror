From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH] git-gui: various French translation fixes
Date: Wed, 18 Mar 2009 21:54:10 +0100
Message-ID: <20090318205410.GA900@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:03:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk2v0-0002qT-4X
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbZCRVBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 17:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbZCRVBr
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:01:47 -0400
Received: from poulet.zoy.org ([80.65.228.129]:56544 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZCRVBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:01:45 -0400
Received: from poukram (localhost [127.0.0.1])
	by poulet.zoy.org (Postfix) with ESMTP id 07B1B120405;
	Wed, 18 Mar 2009 22:01:38 +0100 (CET)
Received: by poukram (Postfix, from userid 1000)
	id E6E837FA2B; Wed, 18 Mar 2009 21:54:10 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113663>

Mostly grammar, spelling and typography fixes, but also a few wording
enhancements here and there.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 po/fr.po |  196 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index 45773ab..eb5f68e 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -62,7 +62,7 @@ msgstr ""
 "\n"
 "%s n=E9cessite au moins Git 1.5.0.\n"
 "\n"
-"Peut'on consid=E9rer que '%s' est en version 1.5.0 ?\n"
+"Peut-on consid=E9rer que '%s' est en version 1.5.0 ?\n"
=20
 #: git-gui.sh:1062
 msgid "Git directory not found:"
@@ -82,7 +82,7 @@ msgstr "Aucun r=E9pertoire de travail"
=20
 #: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
-msgstr "Rafraichissement du status des fichiers..."
+msgstr "Rafra=EEchissement du statut des fichiers..."
=20
 #: git-gui.sh:1303
 msgid "Scanning for modified files ..."
@@ -163,7 +163,7 @@ msgstr "D=E9p=F4t"
=20
 #: git-gui.sh:2281
 msgid "Edit"
-msgstr "Edition"
+msgstr "=C9dition"
=20
 #: git-gui.sh:2283 lib/choose_rev.tcl:561
 msgid "Branch"
@@ -199,7 +199,7 @@ msgstr "Naviguer dans la branche..."
=20
 #: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
-msgstr "Visualiser historique branche courante"
+msgstr "Visualiser l'historique de la branche courante"
=20
 #: git-gui.sh:2320
 msgid "Visualize All Branch History"
@@ -208,12 +208,12 @@ msgstr "Voir l'historique de toutes les branches"
 #: git-gui.sh:2327
 #, tcl-format
 msgid "Browse %s's Files"
-msgstr "Naviguer l'arborescence de %s"
+msgstr "Parcourir l'arborescence de %s"
=20
 #: git-gui.sh:2329
 #, tcl-format
 msgid "Visualize %s's History"
-msgstr "Voir l'historique de la branche: %s"
+msgstr "Voir l'historique de la branche : %s"
=20
 #: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
@@ -230,7 +230,7 @@ msgstr "V=E9rifier le d=E9p=F4t"
 #: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
-msgstr "Cr=E9er ic=F4ne sur bureau"
+msgstr "Cr=E9er une ic=F4ne sur le bureau"
=20
 #: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
@@ -320,7 +320,7 @@ msgstr "D=E9sindexer"
=20
 #: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
-msgstr "Annuler les modifications (revert)"
+msgstr "R=E9voquer les modifications"
=20
 #: git-gui.sh:2491 git-gui.sh:3069
 msgid "Show Less Context"
@@ -382,7 +382,7 @@ msgstr "Documentation en ligne"
=20
 #: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
 msgid "Show SSH Key"
-msgstr "Montrer cl=E9 SSH"
+msgstr "Montrer la cl=E9 SSH"
=20
 #: git-gui.sh:2707
 #, tcl-format
@@ -445,7 +445,7 @@ msgstr "Fichier :"
=20
 #: git-gui.sh:3078
 msgid "Refresh"
-msgstr "Rafraichir"
+msgstr "Rafra=EEchir"
=20
 #: git-gui.sh:3099
 msgid "Decrease Font Size"
@@ -457,7 +457,7 @@ msgstr "Agrandir la police"
=20
 #: git-gui.sh:3111 lib/blame.tcl:281
 msgid "Encoding"
-msgstr "Encodage"
+msgstr "Codage des caract=E8res"
=20
 #: git-gui.sh:3122
 msgid "Apply/Reverse Hunk"
@@ -469,7 +469,7 @@ msgstr "Appliquer/Inverser la ligne"
=20
 #: git-gui.sh:3137
 msgid "Run Merge Tool"
-msgstr "Lancer outil de merge"
+msgstr "Lancer l'outil de fusion"
=20
 #: git-gui.sh:3142
 msgid "Use Remote Version"
@@ -527,7 +527,7 @@ msgid ""
 "Tcl binary distributed by Cygwin."
 msgstr ""
 "\n"
-"Ceci est du =E0 un probl=E8me connu avec\n"
+"Ceci est d=FB =E0 un probl=E8me connu avec\n"
 "le binaire Tcl distribu=E9 par Cygwin."
=20
 #: git-gui.sh:3336
@@ -630,11 +630,11 @@ msgstr "Fichier original :"
=20
 #: lib/blame.tcl:1021
 msgid "Cannot find HEAD commit:"
-msgstr "Impossible de trouver le commit HEAD:"
+msgstr "Impossible de trouver le commit HEAD :"
=20
 #: lib/blame.tcl:1076
 msgid "Cannot find parent commit:"
-msgstr "Impossible de trouver le commit parent:"
+msgstr "Impossible de trouver le commit parent :"
=20
 #: lib/blame.tcl:1091
 msgid "Unable to display parent"
@@ -646,7 +646,7 @@ msgstr "Erreur lors du chargement des diff=E9rences=
 :"
=20
 #: lib/blame.tcl:1232
 msgid "Originally By:"
-msgstr "A l'origine par :"
+msgstr "=C0 l'origine par :"
=20
 #: lib/blame.tcl:1238
 msgid "In File:"
@@ -691,11 +691,11 @@ msgstr "D=E9tacher de la branche locale"
=20
 #: lib/branch_create.tcl:22
 msgid "Create Branch"
-msgstr "Cr=E9er branche"
+msgstr "Cr=E9er une branche"
=20
 #: lib/branch_create.tcl:27
 msgid "Create New Branch"
-msgstr "Cr=E9er nouvelle branche"
+msgstr "Cr=E9er une nouvelle branche"
=20
 #: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
@@ -719,7 +719,7 @@ msgstr "R=E9vision initiale"
=20
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
-msgstr "Mettre =E0 jour branche existante :"
+msgstr "Mettre =E0 jour une branche existante :"
=20
 #: lib/branch_create.tcl:75
 msgid "No"
@@ -727,7 +727,7 @@ msgstr "Non"
=20
 #: lib/branch_create.tcl:80
 msgid "Fast Forward Only"
-msgstr "Mise-=E0-jour rectiligne seulement (fast-forward)"
+msgstr "Mise =E0 jour rectiligne seulement (fast-forward)"
=20
 #: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
 msgid "Reset"
@@ -769,7 +769,7 @@ msgstr "Branches locales"
=20
 #: lib/branch_delete.tcl:52
 msgid "Delete Only If Merged Into"
-msgstr "Supprimer seulement si fusionn=E9e dans:"
+msgstr "Supprimer seulement si fusionn=E9e dans :"
=20
 #: lib/branch_delete.tcl:54
 msgid "Always (Do not perform merge test.)"
@@ -786,7 +786,7 @@ msgid ""
 "\n"
 " Delete the selected branches?"
 msgstr ""
-"R=E9cup=E9rer des branches supprim=E9es est difficile.\n"
+"Il est difficile de r=E9cup=E9rer des branches supprim=E9es.\n"
 "\n"
 "Supprimer les branches s=E9lectionn=E9es ?"
=20
@@ -796,7 +796,7 @@ msgid ""
 "Failed to delete branches:\n"
 "%s"
 msgstr ""
-"La suppression des branches suivantes a =E9chou=E9e :\n"
+"La suppression des branches suivantes a =E9chou=E9 :\n"
 "%s"
=20
 #: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
@@ -902,11 +902,11 @@ msgstr "La strat=E9gie de fusion '%s' n'est pas s=
upport=E9e."
 #: lib/checkout_op.tcl:261
 #, tcl-format
 msgid "Failed to update '%s'."
-msgstr "La mise =E0 jour de '%s' a =E9chou=E9e."
+msgstr "La mise =E0 jour de '%s' a =E9chou=E9."
=20
 #: lib/checkout_op.tcl:273
 msgid "Staging area (index) is already locked."
-msgstr "L'index (staging area) est d=E9j=E0 v=E9rouill=E9"
+msgstr "L'index (staging area) est d=E9j=E0 verrouill=E9."
=20
 #: lib/checkout_op.tcl:288
 msgid ""
@@ -918,7 +918,7 @@ msgid ""
 "The rescan will be automatically started now.\n"
 msgstr ""
 "L'=E9tat lors de la derni=E8re synchronisation ne correspond plus =E0=
 l'=E9tat du "
-"d=E9p=F4t\n"
+"d=E9p=F4t.\n"
 "\n"
 "Un autre programme Git a modifi=E9 ce d=E9p=F4t depuis la derni=E8re =
"
 "synchronisation. Une resynchronisation doit =EAtre effectu=E9e avant =
de pouvoir "
@@ -956,9 +956,9 @@ msgid ""
 "If you wanted to be on a branch, create one now starting from 'This D=
etached "
 "Checkout'."
 msgstr ""
-"Vous n'=EAtes plus ur une branche locale.\n"
+"Vous n'=EAtes plus sur une branche locale.\n"
 "\n"
-"Si vous vouliez =EAtre sur une branche, cr=E9ez en une maintenant en =
partant de "
+"Si vous vouliez =EAtre sur une branche, cr=E9ez-en une maintenant en =
partant de "
 "'Cet emprunt d=E9tach=E9'."
=20
 #: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
@@ -1000,7 +1000,7 @@ msgstr ""
 "mis =E0 jour avec succ=E8s, mais la mise =E0 jour d'un fichier intern=
e =E0 Git a "
 "=E9chou=E9e.\n"
 "\n"
-"Cela n'aurait pas du se produire. %s va abandonner et se terminer."
+"Cela n'aurait pas d=FB se produire. %s va abandonner et se terminer."
=20
 #: lib/choose_font.tcl:39
 msgid "Select"
@@ -1023,8 +1023,8 @@ msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
 msgstr ""
-"C'est un texte d'exemple.\n"
-"Si vous aimez ce texte, vous pouvez choisir cette police"
+"Ceci est un texte d'exemple.\n"
+"Si vous aimez ce texte, vous pouvez choisir cette police."
=20
 #: lib/choose_repository.tcl:28
 msgid "Git Gui"
@@ -1040,7 +1040,7 @@ msgstr "Nouveau..."
=20
 #: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
 msgid "Clone Existing Repository"
-msgstr "Cloner d=E9p=F4t existant"
+msgstr "Cloner un d=E9p=F4t existant"
=20
 #: lib/choose_repository.tcl:106
 msgid "Clone..."
@@ -1048,7 +1048,7 @@ msgstr "Cloner..."
=20
 #: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
-msgstr "Ouvrir d=E9p=F4t existant"
+msgstr "Ouvrir un d=E9p=F4t existant"
=20
 #: lib/choose_repository.tcl:119
 msgid "Open..."
@@ -1056,17 +1056,17 @@ msgstr "Ouvrir..."
=20
 #: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
-msgstr "D=E9p=F4t r=E9cemment utilis=E9s"
+msgstr "D=E9p=F4ts r=E9cemment utilis=E9s"
=20
 #: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
-msgstr "Ouvrir d=E9p=F4t r=E9cent :"
+msgstr "Ouvrir un d=E9p=F4t r=E9cent :"
=20
 #: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
 #: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "La cr=E9ation du d=E9p=F4t %s a =E9chou=E9e :"
+msgstr "La cr=E9ation du d=E9p=F4t %s a =E9chou=E9 :"
=20
 #: lib/choose_repository.tcl:387
 msgid "Directory:"
@@ -1093,11 +1093,11 @@ msgstr "Cloner"
=20
 #: lib/choose_repository.tcl:473
 msgid "Source Location:"
-msgstr "Emplacement source:"
+msgstr "Emplacement source :"
=20
 #: lib/choose_repository.tcl:484
 msgid "Target Directory:"
-msgstr "R=E9pertoire cible:"
+msgstr "R=E9pertoire cible :"
=20
 #: lib/choose_repository.tcl:496
 msgid "Clone Type:"
@@ -1137,7 +1137,7 @@ msgstr "L'emplacement %s existe d=E9j=E0."
=20
 #: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
-msgstr "La configuration de l'origine a =E9chou=E9e."
+msgstr "La configuration de l'origine a =E9chou=E9."
=20
 #: lib/choose_repository.tcl:634
 msgid "Counting objects"
@@ -1242,7 +1242,7 @@ msgstr "fichiers"
=20
 #: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
-msgstr "Chargement initial du fichier =E9chou=E9."
+msgstr "Le chargement initial du fichier a =E9chou=E9."
=20
 #: lib/choose_repository.tcl:978
 msgid "Open"
@@ -1292,7 +1292,7 @@ msgstr "L'expression de r=E9vision est vide."
=20
 #: lib/choose_rev.tcl:531
 msgid "Updated"
-msgstr "Mise-=E0-jour:"
+msgstr "Mise =E0 jour:"
=20
 #: lib/choose_rev.tcl:559
 msgid "URL"
@@ -1320,8 +1320,8 @@ msgid ""
 msgstr ""
 "Impossible de corriger pendant une fusion.\n"
 "\n"
-"Vous =EAtes actuellement au milieu d'une fusion qui n'a pas =E9t=E9 c=
ompletement "
-"termin=E9e. Vous ne pouvez pas corriger le commit pr=E9c=E9dant sauf =
si vous "
+"Vous =EAtes actuellement au milieu d'une fusion qui n'a pas =E9t=E9 c=
ompl=E8tement "
+"termin=E9e. Vous ne pouvez pas corriger le commit pr=E9c=E9dent sauf =
si vous "
 "abandonnez la fusion courante.\n"
=20
 #: lib/commit.tcl:49
@@ -1409,7 +1409,7 @@ msgstr ""
 #: lib/commit.tcl:211
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
-msgstr "attention : Tcl ne supporte pas l'encodage '%s'."
+msgstr "attention : Tcl ne supporte pas le codage '%s'."
=20
 #: lib/commit.tcl:227
 msgid "Calling pre-commit hook..."
@@ -1469,12 +1469,12 @@ msgstr "commit-tree a =E9chou=E9 :"
=20
 #: lib/commit.tcl:373
 msgid "update-ref failed:"
-msgstr "update-ref a =E9chou=E9"
+msgstr "update-ref a =E9chou=E9 :"
=20
 #: lib/commit.tcl:461
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "Commit cr=E9=E9 %s : %s"
+msgstr "Commit %s cr=E9=E9 : %s"
=20
 #: lib/console.tcl:59
 msgid "Working... please wait..."
@@ -1581,24 +1581,24 @@ msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
 msgstr ""
-"LOCAL: supprim=E9\n"
-"DISTANT:\n"
+"LOCAL : supprim=E9\n"
+"DISTANT :\n"
=20
 #: lib/diff.tcl:125
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
 msgstr ""
-"DISTANT: supprim=E9\n"
-"LOCAL:\n"
+"DISTANT : supprim=E9\n"
+"LOCAL :\n"
=20
 #: lib/diff.tcl:132
 msgid "LOCAL:\n"
-msgstr "LOCAL:\n"
+msgstr "LOCAL :\n"
=20
 #: lib/diff.tcl:135
 msgid "REMOTE:\n"
-msgstr "DISTANT:\n"
+msgstr "DISTANT :\n"
=20
 #: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
@@ -1624,7 +1624,7 @@ msgid ""
 "* Showing only first %d bytes.\n"
 msgstr ""
 "* Le fichier non suivi fait %d octets.\n"
-"* On montre seulement les premiers %d octets.\n"
+"* Seuls les %d premiers octets sont montr=E9s.\n"
=20
 #: lib/diff.tcl:228
 #, tcl-format
@@ -1635,7 +1635,7 @@ msgid ""
 msgstr ""
 "\n"
 "* Fichier suivi raccourcis ici de %s.\n"
-"* Pour voir le fichier entier, utiliser un =E9diteur externe.\n"
+"* Pour voir le fichier entier, utilisez un =E9diteur externe.\n"
=20
 #: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
@@ -1680,7 +1680,7 @@ msgstr "Vous devez corriger les erreurs suivantes=
 avant de pouvoir commiter."
=20
 #: lib/index.tcl:6
 msgid "Unable to unlock the index."
-msgstr "Impossible de d=E9v=E9rouiller l'index."
+msgstr "Impossible de d=E9verrouiller l'index."
=20
 #: lib/index.tcl:15
 msgid "Index Error"
@@ -1700,12 +1700,12 @@ msgstr "Continuer"
=20
 #: lib/index.tcl:31
 msgid "Unlock Index"
-msgstr "D=E9verouiller l'index"
+msgstr "D=E9verrouiller l'index"
=20
 #: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "D=E9sindexation de: %s"
+msgstr "D=E9sindexation de : %s"
=20
 #: lib/index.tcl:326
 msgid "Ready to commit."
@@ -1719,18 +1719,18 @@ msgstr "Ajout de %s"
 #: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
-msgstr "Annuler les modifications dans le fichier %s ? "
+msgstr "R=E9voquer les modifications dans le fichier %s ? "
=20
 #: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "Annuler les modifications dans ces %i fichiers ?"
+msgstr "R=E9voquer les modifications dans ces %i fichiers ?"
=20
 #: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Toutes les modifications non-index=E9es seront d=E9finitivement perdu=
es par "
-"l'annulation."
+"la r=E9vocation."
=20
 #: lib/index.tcl:409
 msgid "Do Nothing"
@@ -1738,12 +1738,12 @@ msgstr "Ne rien faire"
=20
 #: lib/index.tcl:427
 msgid "Reverting selected files"
-msgstr "Annuler modifications dans fichiers selectionn=E9s"
+msgstr "R=E9vocation en cours des fichiers selectionn=E9s"
=20
 #: lib/index.tcl:431
 #, tcl-format
 msgid "Reverting %s"
-msgstr "Annulation des modifications dans %s"
+msgstr "R=E9vocation en cours de %s"
=20
 #: lib/merge.tcl:13
 msgid ""
@@ -1804,11 +1804,11 @@ msgid ""
 msgstr ""
 "Vous =EAtes au milieu d'une modification.\n"
 "\n"
-"Le fichier %s est modifi=E9.\n"
+"Le fichier %s a =E9t=E9 modifi=E9.\n"
 "\n"
 "Vous devriez terminer le commit courant avant de lancer une fusion. E=
n "
 "faisait comme cela, vous =E9viterez de devoir =E9ventuellement abando=
nner une "
-"fusion ayant =E9chou=E9e.\n"
+"fusion ayant =E9chou=E9.\n"
=20
 #: lib/merge.tcl:107
 #, tcl-format
@@ -1826,7 +1826,7 @@ msgstr "La fusion s'est faite avec succ=E8s."
=20
 #: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
-msgstr "La fusion a echou=E9e. Il est n=E9cessaire de r=E9soudre les c=
onflicts."
+msgstr "La fusion a echou=E9. Il est n=E9cessaire de r=E9soudre les co=
nflits."
=20
 #: lib/merge.tcl:158
 #, tcl-format
@@ -1914,16 +1914,16 @@ msgid ""
 "\n"
 "This operation can be undone only by restarting the merge."
 msgstr ""
-"Noter que le diff ne montre que les modifications en conflict.\n"
+"Noter que le diff ne montre que les modifications en conflit.\n"
 "\n"
 "%s sera =E9cras=E9.\n"
 "\n"
-"Cette op=E9ration ne peut =EAtre d=E9faite qu'en relan=E7ant la fusio=
n."
+"Cette op=E9ration ne peut =EAtre invers=E9e qu'en relan=E7ant la fusi=
on."
=20
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr "Le fichier %s semble avoir des conflicts non r=E9solus, ind=E9=
xer quand m=EAme ?"
+msgstr "Le fichier %s semble avoir des conflits non r=E9solus, indexer=
 quand m=EAme ?"
=20
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1932,11 +1932,11 @@ msgstr "Ajouter une r=E9solution pour %s"
=20
 #: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr "Impossible de r=E9soudre la suppression ou de relier des confl=
icts en utilisant un outil"
+msgstr "Impossible de r=E9soudre la suppression ou de relier des confl=
its en utilisant un outil"
=20
 #: lib/mergetool.tcl:146
 msgid "Conflict file does not exist"
-msgstr "Le fichier en conflict n'existe pas."
+msgstr "Le fichier en conflit n'existe pas."
=20
 #: lib/mergetool.tcl:264
 #, tcl-format
@@ -1958,7 +1958,7 @@ msgid ""
 "Error retrieving versions:\n"
 "%s"
 msgstr ""
-"Erreur lors de la r=E9cup=E9ration des versions:\n"
+"Erreur lors de la r=E9cup=E9ration des versions :\n"
 "%s"
=20
 #: lib/mergetool.tcl:343
@@ -1968,7 +1968,7 @@ msgid ""
 "\n"
 "%s"
 msgstr ""
-"Impossible de lancer l'outil de fusion:\n"
+"Impossible de lancer l'outil de fusion :\n"
 "\n"
 "%s"
=20
@@ -1983,12 +1983,12 @@ msgstr "L'outil de fusion a =E9chou=E9."
 #: lib/option.tcl:11
 #, tcl-format
 msgid "Invalid global encoding '%s'"
-msgstr "Encodage global invalide '%s'"
+msgstr "Codage global '%s' invalide"
=20
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "Encodage de d=E9p=F4t invalide '%s'"
+msgstr "Codage de d=E9p=F4t '%s' invalide"
=20
 #: lib/option.tcl:117
 msgid "Restore Defaults"
@@ -2001,7 +2001,7 @@ msgstr "Sauvegarder"
 #: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
-msgstr "D=E9p=F4t: %s"
+msgstr "D=E9p=F4t : %s"
=20
 #: lib/option.tcl:132
 msgid "Global (All Repositories)"
@@ -2069,7 +2069,7 @@ msgstr "Nouveau mod=E8le de nom de branche"
=20
 #: lib/option.tcl:155
 msgid "Default File Contents Encoding"
-msgstr "Encodage du contenu des fichiers par d=E9faut"
+msgstr "Codage du contenu des fichiers par d=E9faut"
=20
 #: lib/option.tcl:203
 msgid "Change"
@@ -2098,11 +2098,11 @@ msgstr "Pr=E9f=E9rences"
=20
 #: lib/option.tcl:314
 msgid "Failed to completely save options:"
-msgstr "La sauvegarde compl=E8te des options a =E9chou=E9e :"
+msgstr "La sauvegarde compl=E8te des options a =E9chou=E9 :"
=20
 #: lib/remote.tcl:163
 msgid "Remove Remote"
-msgstr "Supprimer d=E9p=F4t distant"
+msgstr "Supprimer un d=E9p=F4t distant"
=20
 #: lib/remote.tcl:168
 msgid "Prune from"
@@ -2118,11 +2118,11 @@ msgstr "Pousser vers"
=20
 #: lib/remote_add.tcl:19
 msgid "Add Remote"
-msgstr "Ajouter d=E9p=F4t distant"
+msgstr "Ajouter un d=E9p=F4t distant"
=20
 #: lib/remote_add.tcl:24
 msgid "Add New Remote"
-msgstr "Ajouter nouveau d=E9p=F4t distant"
+msgstr "Ajouter un nouveau d=E9p=F4t distant"
=20
 #: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
 msgid "Add"
@@ -2134,7 +2134,7 @@ msgstr "D=E9tails des d=E9p=F4ts distants"
=20
 #: lib/remote_add.tcl:50
 msgid "Location:"
-msgstr "Emplacement:"
+msgstr "Emplacement :"
=20
 #: lib/remote_add.tcl:62
 msgid "Further Action"
@@ -2146,7 +2146,7 @@ msgstr "R=E9cup=E9rer imm=E9diatement"
=20
 #: lib/remote_add.tcl:71
 msgid "Initialize Remote Repository and Push"
-msgstr "Initialiser d=E9p=F4t distant et pousser"
+msgstr "Initialiser un d=E9p=F4t distant et pousser"
=20
 #: lib/remote_add.tcl:77
 msgid "Do Nothing Else Now"
@@ -2193,7 +2193,7 @@ msgstr "Mise en place de %s (=E0 %s)"
=20
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Supprimer branche =E0 distance"
+msgstr "Supprimer une branche =E0 distance"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -2244,7 +2244,7 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
 msgstr ""
-"Une ou plusieurs des tests de fusion ont =E9chou=E9s parce que vous n=
'avez pas "
+"Un ou plusieurs des tests de fusion ont =E9chou=E9 parce que vous n'a=
vez pas "
 "r=E9cup=E9r=E9 les commits n=E9cessaires. Essayez de r=E9cup=E9r=E9 =E0=
 partir de %s d'abord."
=20
 #: lib/remote_branch_delete.tcl:207
@@ -2257,14 +2257,14 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"R=E9cup=E9rer des branches supprim=E9es est difficile.\n"
+"Il est difficile de r=E9cup=E9rer des branches supprim=E9es.\n"
 "\n"
-"Souhaitez vous supprimer les branches s=E9lectionn=E9es ?"
+"Supprimer les branches s=E9lectionn=E9es ?"
=20
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
-msgstr "Supprimer les branches de %s"
+msgstr "Suppression des branches de %s"
=20
 #: lib/remote_branch_delete.tcl:286
 msgid "No repository selected."
@@ -2285,7 +2285,7 @@ msgstr "Suivant"
=20
 #: lib/search.tcl:24
 msgid "Prev"
-msgstr "Pr=E9c=E9dant"
+msgstr "Pr=E9c=E9dent"
=20
 #: lib/search.tcl:25
 msgid "Case-Sensitive"
@@ -2293,7 +2293,7 @@ msgstr "Sensible =E0 la casse"
=20
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
-msgstr "Impossible d'=E9crire le raccourcis :"
+msgstr "Impossible d'=E9crire le raccourci :"
=20
 #: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
@@ -2318,7 +2318,7 @@ msgstr "R=E9initialisation du dictionnaire =E0 %s=
=2E"
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr "La v=E9rification d'orthographe a =E9chou=E9e silentieusement =
au d=E9marrage"
+msgstr "La v=E9rification d'orthographe a =E9chou=E9 silencieusement a=
u d=E9marrage"
=20
 #: lib/spellcheck.tcl:80
 msgid "Unrecognized spell checker"
@@ -2351,11 +2351,11 @@ msgstr "G=E9n=E9rer une cl=E9"
=20
 #: lib/sshkey.tcl:56
 msgid "Copy To Clipboard"
-msgstr "Copier dans le presse papier"
+msgstr "Copier dans le presse-papier"
=20
 #: lib/sshkey.tcl:70
 msgid "Your OpenSSH Public Key"
-msgstr "Votre cl=E9 publique Open SSH"
+msgstr "Votre cl=E9 publique OpenSSH"
=20
 #: lib/sshkey.tcl:78
 msgid "Generating..."
@@ -2368,7 +2368,7 @@ msgid ""
 "\n"
 "%s"
 msgstr ""
-"Impossible de lancer ssh-keygen:\n"
+"Impossible de lancer ssh-keygen :\n"
 "\n"
 "%s"
=20
@@ -2398,7 +2398,7 @@ msgstr "Lancer %s n=E9cessite qu'un fichier soit =
s=E9lectionn=E9."
 #: lib/tools.tcl:90
 #, tcl-format
 msgid "Are you sure you want to run %s?"
-msgstr "=CAtes vous s=FBr de vouloir lancer %s ?"
+msgstr "=CAtes-vous s=FBr de vouloir lancer %s ?"
=20
 #: lib/tools.tcl:110
 #, tcl-format
@@ -2422,11 +2422,11 @@ msgstr "L'outil a =E9chou=E9 : %s"
=20
 #: lib/tools_dlg.tcl:22
 msgid "Add Tool"
-msgstr "Ajouter outil"
+msgstr "Ajouter un outil"
=20
 #: lib/tools_dlg.tcl:28
 msgid "Add New Tool Command"
-msgstr "Ajouter nouvelle commande d'outil"
+msgstr "Ajouter une nouvelle commande d'outil"
=20
 #: lib/tools_dlg.tcl:33
 msgid "Add globally"
@@ -2438,7 +2438,7 @@ msgstr "D=E9tails sur l'outil"
=20
 #: lib/tools_dlg.tcl:48
 msgid "Use '/' separators to create a submenu tree:"
-msgstr "Utiliser les s=E9parateurs '/' pour cr=E9er un arbre de sous m=
enus :"
+msgstr "Utiliser les s=E9parateurs '/' pour cr=E9er un arbre de sous-m=
enus :"
=20
 #: lib/tools_dlg.tcl:61
 msgid "Command:"
@@ -2479,7 +2479,7 @@ msgid ""
 "Could not add tool:\n"
 "%s"
 msgstr ""
-"Impossible d'ajouter l'outil:\n"
+"Impossible d'ajouter l'outil :\n"
 "%s"
=20
 #: lib/tools_dlg.tcl:190
--=20
1.6.2
