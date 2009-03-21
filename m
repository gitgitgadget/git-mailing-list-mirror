From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH v2 1/2] git-gui: various French translation fixes
Date: Sat, 21 Mar 2009 15:47:05 +0100
Message-ID: <7102a296e91c8602c200b1431a74c7eb6592146e.1237646585.git.nicolas.s-dev@laposte.net>
References: <20090321102748.GC12971@vidovic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: alexandre.bourget@savoirfairelinux.com, mh@glandium.org,
	sam@zoy.org, chriscool@tuxfamily.org, nico@cam.org,
	git@vger.kernel.org, Nicolas Sebrecht <nicolas.s-dev@laposte.net>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Mar 21 15:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll2VW-0001gT-HI
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 15:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbZCUOrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 10:47:35 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754916AbZCUOre
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 10:47:34 -0400
Received: from out6.laposte.net ([193.251.214.123]:44193 "EHLO
	out5.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754856AbZCUOrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 10:47:32 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8407.laposte.net (SMTP Server) with ESMTP id 7C6D07000095;
	Sat, 21 Mar 2009 15:47:23 +0100 (CET)
Received: from localhost (91-164-138-157.rev.libertysurf.net [91.164.138.157])
	by mwinf8407.laposte.net (SMTP Server) with ESMTP id BC6247000093;
	Sat, 21 Mar 2009 15:47:22 +0100 (CET)
X-ME-UUID: 20090321144722771.BC6247000093@mwinf8407.laposte.net
X-Mailer: git-send-email 1.6.2.169.g92418
In-Reply-To: <20090321102748.GC12971@vidovic>
In-Reply-To: <20090321102748.GC12971@vidovic>
References: <20090321102748.GC12971@vidovic>
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (0)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeduucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114039>


=46rom: Sam Hocevar <sam@zoy.org>

Mostly grammar, spelling and typography fixes, but also a few wording
enhancements here and there.

Signed-off-by: Sam Hocevar <sam@zoy.org>
Signed-off-by: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
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
 "%s n=C3=A9cessite au moins Git 1.5.0.\n"
 "\n"
-"Peut'on consid=C3=A9rer que '%s' est en version 1.5.0 ?\n"
+"Peut-on consid=C3=A9rer que '%s' est en version 1.5.0 ?\n"
=20
 #: git-gui.sh:1062
 msgid "Git directory not found:"
@@ -82,7 +82,7 @@ msgstr "Aucun r=C3=A9pertoire de travail"
=20
 #: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
-msgstr "Rafraichissement du status des fichiers..."
+msgstr "Rafra=C3=AEchissement du statut des fichiers..."
=20
 #: git-gui.sh:1303
 msgid "Scanning for modified files ..."
@@ -163,7 +163,7 @@ msgstr "D=C3=A9p=C3=B4t"
=20
 #: git-gui.sh:2281
 msgid "Edit"
-msgstr "Edition"
+msgstr "=C3=89dition"
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
@@ -230,7 +230,7 @@ msgstr "V=C3=A9rifier le d=C3=A9p=C3=B4t"
 #: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
-msgstr "Cr=C3=A9er ic=C3=B4ne sur bureau"
+msgstr "Cr=C3=A9er une ic=C3=B4ne sur le bureau"
=20
 #: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
@@ -320,7 +320,7 @@ msgstr "D=C3=A9sindexer"
=20
 #: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
-msgstr "Annuler les modifications (revert)"
+msgstr "R=C3=A9voquer les modifications"
=20
 #: git-gui.sh:2491 git-gui.sh:3069
 msgid "Show Less Context"
@@ -382,7 +382,7 @@ msgstr "Documentation en ligne"
=20
 #: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
 msgid "Show SSH Key"
-msgstr "Montrer cl=C3=A9 SSH"
+msgstr "Montrer la cl=C3=A9 SSH"
=20
 #: git-gui.sh:2707
 #, tcl-format
@@ -445,7 +445,7 @@ msgstr "Fichier :"
=20
 #: git-gui.sh:3078
 msgid "Refresh"
-msgstr "Rafraichir"
+msgstr "Rafra=C3=AEchir"
=20
 #: git-gui.sh:3099
 msgid "Decrease Font Size"
@@ -457,7 +457,7 @@ msgstr "Agrandir la police"
=20
 #: git-gui.sh:3111 lib/blame.tcl:281
 msgid "Encoding"
-msgstr "Encodage"
+msgstr "Codage des caract=C3=A8res"
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
-"Ceci est du =C3=A0 un probl=C3=A8me connu avec\n"
+"Ceci est d=C3=BB =C3=A0 un probl=C3=A8me connu avec\n"
 "le binaire Tcl distribu=C3=A9 par Cygwin."
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
@@ -646,7 +646,7 @@ msgstr "Erreur lors du chargement des diff=C3=A9ren=
ces :"
=20
 #: lib/blame.tcl:1232
 msgid "Originally By:"
-msgstr "A l'origine par :"
+msgstr "=C3=80 l'origine par :"
=20
 #: lib/blame.tcl:1238
 msgid "In File:"
@@ -691,11 +691,11 @@ msgstr "D=C3=A9tacher de la branche locale"
=20
 #: lib/branch_create.tcl:22
 msgid "Create Branch"
-msgstr "Cr=C3=A9er branche"
+msgstr "Cr=C3=A9er une branche"
=20
 #: lib/branch_create.tcl:27
 msgid "Create New Branch"
-msgstr "Cr=C3=A9er nouvelle branche"
+msgstr "Cr=C3=A9er une nouvelle branche"
=20
 #: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
@@ -719,7 +719,7 @@ msgstr "R=C3=A9vision initiale"
=20
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
-msgstr "Mettre =C3=A0 jour branche existante :"
+msgstr "Mettre =C3=A0 jour une branche existante :"
=20
 #: lib/branch_create.tcl:75
 msgid "No"
@@ -727,7 +727,7 @@ msgstr "Non"
=20
 #: lib/branch_create.tcl:80
 msgid "Fast Forward Only"
-msgstr "Mise-=C3=A0-jour rectiligne seulement (fast-forward)"
+msgstr "Mise =C3=A0 jour rectiligne seulement (fast-forward)"
=20
 #: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
 msgid "Reset"
@@ -769,7 +769,7 @@ msgstr "Branches locales"
=20
 #: lib/branch_delete.tcl:52
 msgid "Delete Only If Merged Into"
-msgstr "Supprimer seulement si fusionn=C3=A9e dans:"
+msgstr "Supprimer seulement si fusionn=C3=A9e dans :"
=20
 #: lib/branch_delete.tcl:54
 msgid "Always (Do not perform merge test.)"
@@ -786,7 +786,7 @@ msgid ""
 "\n"
 " Delete the selected branches?"
 msgstr ""
-"R=C3=A9cup=C3=A9rer des branches supprim=C3=A9es est difficile.\n"
+"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9es.=
\n"
 "\n"
 "Supprimer les branches s=C3=A9lectionn=C3=A9es ?"
=20
@@ -796,7 +796,7 @@ msgid ""
 "Failed to delete branches:\n"
 "%s"
 msgstr ""
-"La suppression des branches suivantes a =C3=A9chou=C3=A9e :\n"
+"La suppression des branches suivantes a =C3=A9chou=C3=A9 :\n"
 "%s"
=20
 #: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
@@ -902,11 +902,11 @@ msgstr "La strat=C3=A9gie de fusion '%s' n'est pa=
s support=C3=A9e."
 #: lib/checkout_op.tcl:261
 #, tcl-format
 msgid "Failed to update '%s'."
-msgstr "La mise =C3=A0 jour de '%s' a =C3=A9chou=C3=A9e."
+msgstr "La mise =C3=A0 jour de '%s' a =C3=A9chou=C3=A9."
=20
 #: lib/checkout_op.tcl:273
 msgid "Staging area (index) is already locked."
-msgstr "L'index (staging area) est d=C3=A9j=C3=A0 v=C3=A9rouill=C3=A9"
+msgstr "L'index (staging area) est d=C3=A9j=C3=A0 verrouill=C3=A9."
=20
 #: lib/checkout_op.tcl:288
 msgid ""
@@ -918,7 +918,7 @@ msgid ""
 "The rescan will be automatically started now.\n"
 msgstr ""
 "L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du "
-"d=C3=A9p=C3=B4t\n"
+"d=C3=A9p=C3=B4t.\n"
 "\n"
 "Un autre programme Git a modifi=C3=A9 ce d=C3=A9p=C3=B4t depuis la de=
rni=C3=A8re "
 "synchronisation. Une resynchronisation doit =C3=AAtre effectu=C3=A9e =
avant de pouvoir "
@@ -956,9 +956,9 @@ msgid ""
 "If you wanted to be on a branch, create one now starting from 'This D=
etached "
 "Checkout'."
 msgstr ""
-"Vous n'=C3=AAtes plus ur une branche locale.\n"
+"Vous n'=C3=AAtes plus sur une branche locale.\n"
 "\n"
-"Si vous vouliez =C3=AAtre sur une branche, cr=C3=A9ez en une maintena=
nt en partant de "
+"Si vous vouliez =C3=AAtre sur une branche, cr=C3=A9ez-en une maintena=
nt en partant de "
 "'Cet emprunt d=C3=A9tach=C3=A9'."
=20
 #: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
@@ -1000,7 +1000,7 @@ msgstr ""
 "mis =C3=A0 jour avec succ=C3=A8s, mais la mise =C3=A0 jour d'un fichi=
er interne =C3=A0 Git a "
 "=C3=A9chou=C3=A9e.\n"
 "\n"
-"Cela n'aurait pas du se produire. %s va abandonner et se terminer."
+"Cela n'aurait pas d=C3=BB se produire. %s va abandonner et se termine=
r."
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
-msgstr "Cloner d=C3=A9p=C3=B4t existant"
+msgstr "Cloner un d=C3=A9p=C3=B4t existant"
=20
 #: lib/choose_repository.tcl:106
 msgid "Clone..."
@@ -1048,7 +1048,7 @@ msgstr "Cloner..."
=20
 #: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
-msgstr "Ouvrir d=C3=A9p=C3=B4t existant"
+msgstr "Ouvrir un d=C3=A9p=C3=B4t existant"
=20
 #: lib/choose_repository.tcl:119
 msgid "Open..."
@@ -1056,17 +1056,17 @@ msgstr "Ouvrir..."
=20
 #: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
-msgstr "D=C3=A9p=C3=B4t r=C3=A9cemment utilis=C3=A9s"
+msgstr "D=C3=A9p=C3=B4ts r=C3=A9cemment utilis=C3=A9s"
=20
 #: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
-msgstr "Ouvrir d=C3=A9p=C3=B4t r=C3=A9cent :"
+msgstr "Ouvrir un d=C3=A9p=C3=B4t r=C3=A9cent :"
=20
 #: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
 #: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "La cr=C3=A9ation du d=C3=A9p=C3=B4t %s a =C3=A9chou=C3=A9e :"
+msgstr "La cr=C3=A9ation du d=C3=A9p=C3=B4t %s a =C3=A9chou=C3=A9 :"
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
-msgstr "R=C3=A9pertoire cible:"
+msgstr "R=C3=A9pertoire cible :"
=20
 #: lib/choose_repository.tcl:496
 msgid "Clone Type:"
@@ -1137,7 +1137,7 @@ msgstr "L'emplacement %s existe d=C3=A9j=C3=A0."
=20
 #: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
-msgstr "La configuration de l'origine a =C3=A9chou=C3=A9e."
+msgstr "La configuration de l'origine a =C3=A9chou=C3=A9."
=20
 #: lib/choose_repository.tcl:634
 msgid "Counting objects"
@@ -1242,7 +1242,7 @@ msgstr "fichiers"
=20
 #: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
-msgstr "Chargement initial du fichier =C3=A9chou=C3=A9."
+msgstr "Le chargement initial du fichier a =C3=A9chou=C3=A9."
=20
 #: lib/choose_repository.tcl:978
 msgid "Open"
@@ -1292,7 +1292,7 @@ msgstr "L'expression de r=C3=A9vision est vide."
=20
 #: lib/choose_rev.tcl:531
 msgid "Updated"
-msgstr "Mise-=C3=A0-jour:"
+msgstr "Mise =C3=A0 jour:"
=20
 #: lib/choose_rev.tcl:559
 msgid "URL"
@@ -1320,8 +1320,8 @@ msgid ""
 msgstr ""
 "Impossible de corriger pendant une fusion.\n"
 "\n"
-"Vous =C3=AAtes actuellement au milieu d'une fusion qui n'a pas =C3=A9=
t=C3=A9 completement "
-"termin=C3=A9e. Vous ne pouvez pas corriger le commit pr=C3=A9c=C3=A9d=
ant sauf si vous "
+"Vous =C3=AAtes actuellement au milieu d'une fusion qui n'a pas =C3=A9=
t=C3=A9 compl=C3=A8tement "
+"termin=C3=A9e. Vous ne pouvez pas corriger le commit pr=C3=A9c=C3=A9d=
ent sauf si vous "
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
@@ -1469,12 +1469,12 @@ msgstr "commit-tree a =C3=A9chou=C3=A9 :"
=20
 #: lib/commit.tcl:373
 msgid "update-ref failed:"
-msgstr "update-ref a =C3=A9chou=C3=A9"
+msgstr "update-ref a =C3=A9chou=C3=A9 :"
=20
 #: lib/commit.tcl:461
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "Commit cr=C3=A9=C3=A9 %s : %s"
+msgstr "Commit %s cr=C3=A9=C3=A9 : %s"
=20
 #: lib/console.tcl:59
 msgid "Working... please wait..."
@@ -1581,24 +1581,24 @@ msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
 msgstr ""
-"LOCAL: supprim=C3=A9\n"
-"DISTANT:\n"
+"LOCAL : supprim=C3=A9\n"
+"DISTANT :\n"
=20
 #: lib/diff.tcl:125
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
 msgstr ""
-"DISTANT: supprim=C3=A9\n"
-"LOCAL:\n"
+"DISTANT : supprim=C3=A9\n"
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
+"* Seuls les %d premiers octets sont montr=C3=A9s.\n"
=20
 #: lib/diff.tcl:228
 #, tcl-format
@@ -1635,7 +1635,7 @@ msgid ""
 msgstr ""
 "\n"
 "* Fichier suivi raccourcis ici de %s.\n"
-"* Pour voir le fichier entier, utiliser un =C3=A9diteur externe.\n"
+"* Pour voir le fichier entier, utilisez un =C3=A9diteur externe.\n"
=20
 #: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
@@ -1680,7 +1680,7 @@ msgstr "Vous devez corriger les erreurs suivantes=
 avant de pouvoir commiter."
=20
 #: lib/index.tcl:6
 msgid "Unable to unlock the index."
-msgstr "Impossible de d=C3=A9v=C3=A9rouiller l'index."
+msgstr "Impossible de d=C3=A9verrouiller l'index."
=20
 #: lib/index.tcl:15
 msgid "Index Error"
@@ -1700,12 +1700,12 @@ msgstr "Continuer"
=20
 #: lib/index.tcl:31
 msgid "Unlock Index"
-msgstr "D=C3=A9verouiller l'index"
+msgstr "D=C3=A9verrouiller l'index"
=20
 #: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "D=C3=A9sindexation de: %s"
+msgstr "D=C3=A9sindexation de : %s"
=20
 #: lib/index.tcl:326
 msgid "Ready to commit."
@@ -1719,18 +1719,18 @@ msgstr "Ajout de %s"
 #: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
-msgstr "Annuler les modifications dans le fichier %s ? "
+msgstr "R=C3=A9voquer les modifications dans le fichier %s ? "
=20
 #: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "Annuler les modifications dans ces %i fichiers ?"
+msgstr "R=C3=A9voquer les modifications dans ces %i fichiers ?"
=20
 #: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues par "
-"l'annulation."
+"la r=C3=A9vocation."
=20
 #: lib/index.tcl:409
 msgid "Do Nothing"
@@ -1738,12 +1738,12 @@ msgstr "Ne rien faire"
=20
 #: lib/index.tcl:427
 msgid "Reverting selected files"
-msgstr "Annuler modifications dans fichiers selectionn=C3=A9s"
+msgstr "R=C3=A9vocation en cours des fichiers selectionn=C3=A9s"
=20
 #: lib/index.tcl:431
 #, tcl-format
 msgid "Reverting %s"
-msgstr "Annulation des modifications dans %s"
+msgstr "R=C3=A9vocation en cours de %s"
=20
 #: lib/merge.tcl:13
 msgid ""
@@ -1804,11 +1804,11 @@ msgid ""
 msgstr ""
 "Vous =C3=AAtes au milieu d'une modification.\n"
 "\n"
-"Le fichier %s est modifi=C3=A9.\n"
+"Le fichier %s a =C3=A9t=C3=A9 modifi=C3=A9.\n"
 "\n"
 "Vous devriez terminer le commit courant avant de lancer une fusion. E=
n "
 "faisait comme cela, vous =C3=A9viterez de devoir =C3=A9ventuellement =
abandonner une "
-"fusion ayant =C3=A9chou=C3=A9e.\n"
+"fusion ayant =C3=A9chou=C3=A9.\n"
=20
 #: lib/merge.tcl:107
 #, tcl-format
@@ -1826,7 +1826,7 @@ msgstr "La fusion s'est faite avec succ=C3=A8s."
=20
 #: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
-msgstr "La fusion a echou=C3=A9e. Il est n=C3=A9cessaire de r=C3=A9sou=
dre les conflicts."
+msgstr "La fusion a echou=C3=A9. Il est n=C3=A9cessaire de r=C3=A9soud=
re les conflits."
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
 "%s sera =C3=A9cras=C3=A9.\n"
 "\n"
-"Cette op=C3=A9ration ne peut =C3=AAtre d=C3=A9faite qu'en relan=C3=A7=
ant la fusion."
+"Cette op=C3=A9ration ne peut =C3=AAtre invers=C3=A9e qu'en relan=C3=A7=
ant la fusion."
=20
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr "Le fichier %s semble avoir des conflicts non r=C3=A9solus, ind=
=C3=A9xer quand m=C3=AAme ?"
+msgstr "Le fichier %s semble avoir des conflits non r=C3=A9solus, inde=
xer quand m=C3=AAme ?"
=20
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1932,11 +1932,11 @@ msgstr "Ajouter une r=C3=A9solution pour %s"
=20
 #: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr "Impossible de r=C3=A9soudre la suppression ou de relier des co=
nflicts en utilisant un outil"
+msgstr "Impossible de r=C3=A9soudre la suppression ou de relier des co=
nflits en utilisant un outil"
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
-"Erreur lors de la r=C3=A9cup=C3=A9ration des versions:\n"
+"Erreur lors de la r=C3=A9cup=C3=A9ration des versions :\n"
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
@@ -1983,12 +1983,12 @@ msgstr "L'outil de fusion a =C3=A9chou=C3=A9."
 #: lib/option.tcl:11
 #, tcl-format
 msgid "Invalid global encoding '%s'"
-msgstr "Encodage global invalide '%s'"
+msgstr "Codage global '%s' invalide"
=20
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "Encodage de d=C3=A9p=C3=B4t invalide '%s'"
+msgstr "Codage de d=C3=A9p=C3=B4t '%s' invalide"
=20
 #: lib/option.tcl:117
 msgid "Restore Defaults"
@@ -2001,7 +2001,7 @@ msgstr "Sauvegarder"
 #: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
-msgstr "D=C3=A9p=C3=B4t: %s"
+msgstr "D=C3=A9p=C3=B4t : %s"
=20
 #: lib/option.tcl:132
 msgid "Global (All Repositories)"
@@ -2069,7 +2069,7 @@ msgstr "Nouveau mod=C3=A8le de nom de branche"
=20
 #: lib/option.tcl:155
 msgid "Default File Contents Encoding"
-msgstr "Encodage du contenu des fichiers par d=C3=A9faut"
+msgstr "Codage du contenu des fichiers par d=C3=A9faut"
=20
 #: lib/option.tcl:203
 msgid "Change"
@@ -2098,11 +2098,11 @@ msgstr "Pr=C3=A9f=C3=A9rences"
=20
 #: lib/option.tcl:314
 msgid "Failed to completely save options:"
-msgstr "La sauvegarde compl=C3=A8te des options a =C3=A9chou=C3=A9e :"
+msgstr "La sauvegarde compl=C3=A8te des options a =C3=A9chou=C3=A9 :"
=20
 #: lib/remote.tcl:163
 msgid "Remove Remote"
-msgstr "Supprimer d=C3=A9p=C3=B4t distant"
+msgstr "Supprimer un d=C3=A9p=C3=B4t distant"
=20
 #: lib/remote.tcl:168
 msgid "Prune from"
@@ -2118,11 +2118,11 @@ msgstr "Pousser vers"
=20
 #: lib/remote_add.tcl:19
 msgid "Add Remote"
-msgstr "Ajouter d=C3=A9p=C3=B4t distant"
+msgstr "Ajouter un d=C3=A9p=C3=B4t distant"
=20
 #: lib/remote_add.tcl:24
 msgid "Add New Remote"
-msgstr "Ajouter nouveau d=C3=A9p=C3=B4t distant"
+msgstr "Ajouter un nouveau d=C3=A9p=C3=B4t distant"
=20
 #: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
 msgid "Add"
@@ -2134,7 +2134,7 @@ msgstr "D=C3=A9tails des d=C3=A9p=C3=B4ts distant=
s"
=20
 #: lib/remote_add.tcl:50
 msgid "Location:"
-msgstr "Emplacement:"
+msgstr "Emplacement :"
=20
 #: lib/remote_add.tcl:62
 msgid "Further Action"
@@ -2146,7 +2146,7 @@ msgstr "R=C3=A9cup=C3=A9rer imm=C3=A9diatement"
=20
 #: lib/remote_add.tcl:71
 msgid "Initialize Remote Repository and Push"
-msgstr "Initialiser d=C3=A9p=C3=B4t distant et pousser"
+msgstr "Initialiser un d=C3=A9p=C3=B4t distant et pousser"
=20
 #: lib/remote_add.tcl:77
 msgid "Do Nothing Else Now"
@@ -2193,7 +2193,7 @@ msgstr "Mise en place de %s (=C3=A0 %s)"
=20
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Supprimer branche =C3=A0 distance"
+msgstr "Supprimer une branche =C3=A0 distance"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -2244,7 +2244,7 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
 msgstr ""
-"Une ou plusieurs des tests de fusion ont =C3=A9chou=C3=A9s parce que =
vous n'avez pas "
+"Un ou plusieurs des tests de fusion ont =C3=A9chou=C3=A9 parce que vo=
us n'avez pas "
 "r=C3=A9cup=C3=A9r=C3=A9 les commits n=C3=A9cessaires. Essayez de r=C3=
=A9cup=C3=A9r=C3=A9 =C3=A0 partir de %s d'abord."
=20
 #: lib/remote_branch_delete.tcl:207
@@ -2257,14 +2257,14 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"R=C3=A9cup=C3=A9rer des branches supprim=C3=A9es est difficile.\n"
+"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9es.=
\n"
 "\n"
-"Souhaitez vous supprimer les branches s=C3=A9lectionn=C3=A9es ?"
+"Supprimer les branches s=C3=A9lectionn=C3=A9es ?"
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
-msgstr "Pr=C3=A9c=C3=A9dant"
+msgstr "Pr=C3=A9c=C3=A9dent"
=20
 #: lib/search.tcl:25
 msgid "Case-Sensitive"
@@ -2293,7 +2293,7 @@ msgstr "Sensible =C3=A0 la casse"
=20
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
-msgstr "Impossible d'=C3=A9crire le raccourcis :"
+msgstr "Impossible d'=C3=A9crire le raccourci :"
=20
 #: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
@@ -2318,7 +2318,7 @@ msgstr "R=C3=A9initialisation du dictionnaire =C3=
=A0 %s."
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr "La v=C3=A9rification d'orthographe a =C3=A9chou=C3=A9e silenti=
eusement au d=C3=A9marrage"
+msgstr "La v=C3=A9rification d'orthographe a =C3=A9chou=C3=A9 silencie=
usement au d=C3=A9marrage"
=20
 #: lib/spellcheck.tcl:80
 msgid "Unrecognized spell checker"
@@ -2351,11 +2351,11 @@ msgstr "G=C3=A9n=C3=A9rer une cl=C3=A9"
=20
 #: lib/sshkey.tcl:56
 msgid "Copy To Clipboard"
-msgstr "Copier dans le presse papier"
+msgstr "Copier dans le presse-papier"
=20
 #: lib/sshkey.tcl:70
 msgid "Your OpenSSH Public Key"
-msgstr "Votre cl=C3=A9 publique Open SSH"
+msgstr "Votre cl=C3=A9 publique OpenSSH"
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
@@ -2398,7 +2398,7 @@ msgstr "Lancer %s n=C3=A9cessite qu'un fichier so=
it s=C3=A9lectionn=C3=A9."
 #: lib/tools.tcl:90
 #, tcl-format
 msgid "Are you sure you want to run %s?"
-msgstr "=C3=8Ates vous s=C3=BBr de vouloir lancer %s ?"
+msgstr "=C3=8Ates-vous s=C3=BBr de vouloir lancer %s ?"
=20
 #: lib/tools.tcl:110
 #, tcl-format
@@ -2422,11 +2422,11 @@ msgstr "L'outil a =C3=A9chou=C3=A9 : %s"
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
@@ -2438,7 +2438,7 @@ msgstr "D=C3=A9tails sur l'outil"
=20
 #: lib/tools_dlg.tcl:48
 msgid "Use '/' separators to create a submenu tree:"
-msgstr "Utiliser les s=C3=A9parateurs '/' pour cr=C3=A9er un arbre de =
sous menus :"
+msgstr "Utiliser les s=C3=A9parateurs '/' pour cr=C3=A9er un arbre de =
sous-menus :"
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
1.6.2.169.g92418
