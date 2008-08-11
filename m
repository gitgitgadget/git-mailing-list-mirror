From: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
Subject: [PATCH] Update french translation
Date: Mon, 11 Aug 2008 10:39:52 -0400
Message-ID: <1218465592-2446-2-git-send-email-alexandre.bourget@savoirfairelinux.com>
References: <>
 <1218465592-2446-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 17:08:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSYzs-0005jj-Nj
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYHKPGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:06:43 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYHKPGn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:06:43 -0400
Received: from mail.savoirfairelinux.net ([69.28.212.163]:52108 "EHLO
	open-xchange.savoirfairelinux.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630AbYHKPGm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 11:06:42 -0400
X-Greylist: delayed 1627 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Aug 2008 11:06:41 EDT
Received: from localhost (unknown [127.0.0.1])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id B6CF0461961;
	Mon, 11 Aug 2008 14:39:34 +0000 (UTC)
Received: from open-xchange.savoirfairelinux.net ([127.0.0.1])
	by localhost (open-xchange.savoirfairelinux.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBl7XstNnqly; Mon, 11 Aug 2008 10:39:29 -0400 (EDT)
Received: from xenon.inside.savoirfairelinux.net (mtl.savoirfairelinux.net [199.243.85.90])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 0EB0D46195B;
	Mon, 11 Aug 2008 10:39:24 -0400 (EDT)
Received: from localhost.localdomain (dyn221.inside.savoirfairelinux.net [192.168.1.221])
	by xenon.inside.savoirfairelinux.net (Postfix) with ESMTP id 52B9ED6C22;
	Mon, 11 Aug 2008 10:39:23 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1218465592-2446-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91944>

---
 git-gui/po/fr.po |  251 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 126 insertions(+), 125 deletions(-)

diff --git a/git-gui/po/fr.po b/git-gui/po/fr.po
index 89b6d51..31e55fd 100644
--- a/git-gui/po/fr.po
+++ b/git-gui/po/fr.po
@@ -1,17 +1,18 @@
-# translation of fr.po to French
+# translation of fr.po to Fran=C3=A7ais
 # Translation of git-gui to French.
 # Copyright (C) 2008 Shawn Pearce, et al.
 # This file is distributed under the same license as the git package.
 #
 # Christian Couder <chriscool@tuxfamily.org>, 2008.
+# Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>, 2008.
 msgid ""
 msgstr ""
 "Project-Id-Version: fr\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-04-04 22:05+0200\n"
-"Last-Translator: Christian Couder <chriscool@tuxfamily.org>\n"
-"Language-Team: French\n"
+"PO-Revision-Date: 2008-08-06 14:25-0400\n"
+"Last-Translator: Alexandre Bourget <alexandre.bourget@savoirfairelinu=
x.com>\n"
+"Language-Team: Fran=C3=A7ais <fr@li.org>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -26,15 +27,15 @@ msgstr "git-gui: erreur fatale"
 #: git-gui.sh:593
 #, tcl-format
 msgid "Invalid font specified in %s:"
-msgstr "Invalide fonte sp=C3=A9cifi=C3=A9e dans %s :"
+msgstr "Police invalide sp=C3=A9cifi=C3=A9e dans %s :"
=20
 #: git-gui.sh:620
 msgid "Main Font"
-msgstr "Fonte principale"
+msgstr "Police principale"
=20
 #: git-gui.sh:621
 msgid "Diff/Console Font"
-msgstr "Fonte diff/console"
+msgstr "Police diff/console"
=20
 #: git-gui.sh:635
 msgid "Cannot find git in PATH."
@@ -65,7 +66,7 @@ msgstr ""
=20
 #: git-gui.sh:918
 msgid "Git directory not found:"
-msgstr "Impossible de trouver le r=C3=A9pertoire de Git :"
+msgstr "Impossible de trouver le r=C3=A9pertoire git :"
=20
 #: git-gui.sh:925
 msgid "Cannot move to top of working directory:"
@@ -73,11 +74,11 @@ msgstr "Impossible d'aller =C3=A0 la racine du r=C3=
=A9pertoire de travail :"
=20
 #: git-gui.sh:932
 msgid "Cannot use funny .git directory:"
-msgstr "Impossible d'utiliser un dr=C3=B4le de r=C3=A9pertoire git :"
+msgstr "Impossible d'utiliser le r=C3=A9pertoire .git:"
=20
 #: git-gui.sh:937
 msgid "No working directory"
-msgstr "Pas de r=C3=A9pertoire de travail"
+msgstr "Aucun r=C3=A9pertoire de travail"
=20
 #: git-gui.sh:1084 lib/checkout_op.tcl:283
 msgid "Refreshing file status..."
@@ -97,23 +98,23 @@ msgstr "Non modifi=C3=A9"
=20
 #: git-gui.sh:1592
 msgid "Modified, not staged"
-msgstr "Modifi=C3=A9, non pr=C3=A9-commit=C3=A9"
+msgstr "Modifi=C3=A9, pas index=C3=A9"
=20
 #: git-gui.sh:1593 git-gui.sh:1598
 msgid "Staged for commit"
-msgstr "Pr=C3=A9-commit=C3=A9"
+msgstr "Index=C3=A9"
=20
 #: git-gui.sh:1594 git-gui.sh:1599
 msgid "Portions staged for commit"
-msgstr "En partie pr=C3=A9-commit=C3=A9"
+msgstr "Portions index=C3=A9es"
=20
 #: git-gui.sh:1595 git-gui.sh:1600
 msgid "Staged for commit, missing"
-msgstr "Pr=C3=A9-commit=C3=A9, manquant"
+msgstr "Index=C3=A9s, manquant"
=20
 #: git-gui.sh:1597
 msgid "Untracked, not staged"
-msgstr "Non suivi, non pr=C3=A9-commit=C3=A9"
+msgstr "Non versionn=C3=A9, non index=C3=A9"
=20
 #: git-gui.sh:1602
 msgid "Missing"
@@ -121,11 +122,11 @@ msgstr "Manquant"
=20
 #: git-gui.sh:1603
 msgid "Staged for removal"
-msgstr "Pr=C3=A9-commit=C3=A9 pour suppression"
+msgstr "Index=C3=A9 pour suppression"
=20
 #: git-gui.sh:1604
 msgid "Staged for removal, still present"
-msgstr "Pr=C3=A9-commit=C3=A9 pour suppression, toujours pr=C3=A9sent"
+msgstr "Index=C3=A9 pour suppression, toujours pr=C3=A9sent"
=20
 #: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
 msgid "Requires merge resolution"
@@ -133,7 +134,7 @@ msgstr "N=C3=A9cessite la r=C3=A9solution d'une fus=
ion"
=20
 #: git-gui.sh:1644
 msgid "Starting gitk... please wait..."
-msgstr "Lancement de gitk... merci de patienter..."
+msgstr "Lancement de gitk... un instant..."
=20
 #: git-gui.sh:1653
 #, tcl-format
@@ -148,11 +149,11 @@ msgstr ""
=20
 #: git-gui.sh:1860 lib/choose_repository.tcl:36
 msgid "Repository"
-msgstr "R=C3=A9f=C3=A9rentiel"
+msgstr "D=C3=A9p=C3=B4t"
=20
 #: git-gui.sh:1861
 msgid "Edit"
-msgstr "Editer"
+msgstr "Edition"
=20
 #: git-gui.sh:1863 lib/choose_rev.tcl:561
 msgid "Branch"
@@ -168,15 +169,15 @@ msgstr "Fusionner"
=20
 #: git-gui.sh:1870 lib/choose_rev.tcl:557
 msgid "Remote"
-msgstr "R=C3=A9f=C3=A9rentiel distant"
+msgstr "D=C3=A9p=C3=B4t distant"
=20
 #: git-gui.sh:1879
 msgid "Browse Current Branch's Files"
-msgstr "Visionner fichiers dans branche courante"
+msgstr "Naviguer dans la branche courante"
=20
 #: git-gui.sh:1883
 msgid "Browse Branch Files..."
-msgstr "Visionner fichiers de branche"
+msgstr "Naviguer dans la branche..."
=20
 #: git-gui.sh:1888
 msgid "Visualize Current Branch's History"
@@ -184,29 +185,29 @@ msgstr "Visualiser historique branche courante"
=20
 #: git-gui.sh:1892
 msgid "Visualize All Branch History"
-msgstr "Visualiser historique toutes branches"
+msgstr "Voir l'historique de toutes les branches"
=20
 #: git-gui.sh:1899
 #, tcl-format
 msgid "Browse %s's Files"
-msgstr "Visionner fichiers de %s"
+msgstr "Naviguer l'arborescence de %s"
=20
 #: git-gui.sh:1901
 #, tcl-format
 msgid "Visualize %s's History"
-msgstr "Visualiser historique de %s"
+msgstr "Voir l'historique de la branche: %s"
=20
 #: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
-msgstr "Statistiques base de donn=C3=A9e"
+msgstr "Statistiques du d=C3=A9p=C3=B4t"
=20
 #: git-gui.sh:1909 lib/database.tcl:34
 msgid "Compress Database"
-msgstr "Comprimer base de donn=C3=A9e"
+msgstr "Comprimer le d=C3=A9p=C3=B4t"
=20
 #: git-gui.sh:1912
 msgid "Verify Database"
-msgstr "V=C3=A9rifier base de donn=C3=A9e"
+msgstr "V=C3=A9rifier le d=C3=A9p=C3=B4t"
=20
 #: git-gui.sh:1919 git-gui.sh:1923 git-gui.sh:1927 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
@@ -253,7 +254,7 @@ msgstr "Cr=C3=A9er..."
=20
 #: git-gui.sh:1974
 msgid "Checkout..."
-msgstr "Emprunter... "
+msgstr "Charger (checkout)..."
=20
 #: git-gui.sh:1980
 msgid "Rename..."
@@ -277,27 +278,27 @@ msgstr "Corriger dernier commit"
=20
 #: git-gui.sh:2019 git-gui.sh:2356 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
-msgstr "Resynchroniser"
+msgstr "Recharger modifs."
=20
 #: git-gui.sh:2025
 msgid "Stage To Commit"
-msgstr "Commiter un pr=C3=A9-commit"
+msgstr "Indexer"
=20
 #: git-gui.sh:2031
 msgid "Stage Changed Files To Commit"
-msgstr "Commiter fichiers modifi=C3=A9s dans pr=C3=A9-commit"
+msgstr "Indexer toutes modifications"
=20
 #: git-gui.sh:2037
 msgid "Unstage From Commit"
-msgstr "Commit vers pr=C3=A9-commit"
+msgstr "D=C3=A9sindexer"
=20
 #: git-gui.sh:2042 lib/index.tcl:395
 msgid "Revert Changes"
-msgstr "Inverser modification"
+msgstr "Annuler les modifications (revert)"
=20
 #: git-gui.sh:2049 git-gui.sh:2368 git-gui.sh:2467
 msgid "Sign Off"
-msgstr "Se d=C3=A9sinscrire"
+msgstr "Signer"
=20
 #: git-gui.sh:2053 git-gui.sh:2372
 msgid "Commit@@verb"
@@ -323,7 +324,7 @@ msgstr "Pomme"
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
 #, tcl-format
 msgid "About %s"
-msgstr "A propos de %s"
+msgstr "=C3=80 propos de %s"
=20
 #: git-gui.sh:2099
 msgid "Preferences..."
@@ -352,15 +353,15 @@ msgstr "Branche courante :"
=20
 #: git-gui.sh:2292
 msgid "Staged Changes (Will Commit)"
-msgstr "Modifications pr=C3=A9-commit=C3=A9es"
+msgstr "Modifs. index=C3=A9es (pour commit)"
=20
 #: git-gui.sh:2312
 msgid "Unstaged Changes"
-msgstr "Modifications non pr=C3=A9-commit=C3=A9es"
+msgstr "Modifs. non index=C3=A9es"
=20
 #: git-gui.sh:2362
 msgid "Stage Changed"
-msgstr "Pr=C3=A9-commit modifi=C3=A9"
+msgstr "Indexer modifs."
=20
 #: git-gui.sh:2378 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
@@ -416,19 +417,19 @@ msgstr "Rafraichir"
=20
 #: git-gui.sh:2631
 msgid "Decrease Font Size"
-msgstr "R=C3=A9duire fonte"
+msgstr "Diminuer la police"
=20
 #: git-gui.sh:2635
 msgid "Increase Font Size"
-msgstr "Agrandir fonte"
+msgstr "Agrandir la police"
=20
 #: git-gui.sh:2646
 msgid "Unstage Hunk From Commit"
-msgstr "Enlever section pr=C3=A9-commit=C3=A9e"
+msgstr "D=C3=A9sindexer la section"
=20
 #: git-gui.sh:2648
 msgid "Stage Hunk For Commit"
-msgstr "Pr=C3=A9-commiter section"
+msgstr "Indexer la section"
=20
 #: git-gui.sh:2667
 msgid "Initializing..."
@@ -545,11 +546,11 @@ msgstr "Copi=C3=A9 ou d=C3=A9plac=C3=A9 ici par :=
"
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
-msgstr "Emprunter branche"
+msgstr "Charger la branche (checkout)"
=20
 #: lib/branch_checkout.tcl:23
 msgid "Checkout"
-msgstr "Emprunter"
+msgstr "Charger (checkout)"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
@@ -568,11 +569,11 @@ msgstr "Options"
=20
 #: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Branche suivant r=C3=A9cup=C3=A9ration"
+msgstr "R=C3=A9cup=C3=A9rer la branche de suivi"
=20
 #: lib/branch_checkout.tcl:44
 msgid "Detach From Local Branch"
-msgstr "D=C3=A9tacher de branche locale"
+msgstr "D=C3=A9tacher de la branche locale"
=20
 #: lib/branch_create.tcl:22
 msgid "Create Branch"
@@ -600,7 +601,7 @@ msgstr "Trouver nom de branche de suivi"
=20
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
-msgstr "D=C3=A9but de r=C3=A9vision"
+msgstr "R=C3=A9vision initiale"
=20
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
@@ -612,7 +613,7 @@ msgstr "Non"
=20
 #: lib/branch_create.tcl:80
 msgid "Fast Forward Only"
-msgstr "Avance rapide seulement"
+msgstr "Mise-=C3=A0-jour rectiligne seulement (fast-forward)"
=20
 #: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
 msgid "Reset"
@@ -620,20 +621,20 @@ msgstr "R=C3=A9initialiser"
=20
 #: lib/branch_create.tcl:97
 msgid "Checkout After Creation"
-msgstr "Emprunt apr=C3=A8s cr=C3=A9ation"
+msgstr "Charger (checkout) apr=C3=A8s cr=C3=A9ation"
=20
 #: lib/branch_create.tcl:131
 msgid "Please select a tracking branch."
-msgstr "Merci de choisir une branche de suivi"
+msgstr "Choisissez une branche de suivi"
=20
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "La branche de suivi %s n'est pas une branche dans le r=C3=A9f=C3=
=A9rentiel distant."
+msgstr "La branche de suivi %s n'est pas une branche dans le d=C3=A9p=C3=
=B4t distant."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
-msgstr "Merci de fournir un nom de branche."
+msgstr "Fournissez un nom de branche."
=20
 #: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
 #, tcl-format
@@ -712,7 +713,7 @@ msgstr "La branche '%s' existe d=C3=A9j=C3=A0."
 #: lib/branch_rename.tcl:117
 #, tcl-format
 msgid "Failed to rename '%s'."
-msgstr "Le renommage de '%s' a =C3=A9chou=C3=A9."
+msgstr "=C3=89chec pour renommer '%s'."
=20
 #: lib/browser.tcl:17
 msgid "Starting..."
@@ -733,13 +734,13 @@ msgstr "[Jusqu'au parent]"
=20
 #: lib/browser.tcl:267 lib/browser.tcl:273
 msgid "Browse Branch Files"
-msgstr "Visionner fichiers de branches"
+msgstr "Naviguer fichiers de branches"
=20
 #: lib/browser.tcl:278 lib/choose_repository.tcl:387
 #: lib/choose_repository.tcl:474 lib/choose_repository.tcl:484
 #: lib/choose_repository.tcl:987
 msgid "Browse"
-msgstr "Visionner"
+msgstr "Naviguer"
=20
 #: lib/checkout_op.tcl:79
 #, tcl-format
@@ -770,7 +771,7 @@ msgid ""
 msgstr ""
 "La branche '%s' existe d=C3=A9j=C3=A0.\n"
 "\n"
-"Impossible d'avancer rapidement =C3=A0 %s.\n"
+"Impossible de mettre =C3=A0 jour de mani=C3=A8re rectiligne (fast for=
ward) =C3=A0 %s.\n"
 "Une fusion est n=C3=A9cessaire."
=20
 #: lib/checkout_op.tcl:220
@@ -785,7 +786,7 @@ msgstr "La mise =C3=A0 jour de '%s' a =C3=A9chou=C3=
=A9e."
=20
 #: lib/checkout_op.tcl:251
 msgid "Staging area (index) is already locked."
-msgstr "L'espace de pr=C3=A9-commit ('index' ou 'staging') est d=C3=A9=
j=C3=A0 v=C3=A9rouill=C3=A9."
+msgstr "L'index (staging area) est d=C3=A9j=C3=A0 v=C3=A9rouill=C3=A9"
=20
 #: lib/checkout_op.tcl:266
 msgid ""
@@ -796,9 +797,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du r=C3=A9f=C3=A9rentiel.\n"
+"L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du d=C3=A9p=C3=B4t\n"
 "\n"
-"Un autre programme Git a modifi=C3=A9 ce r=C3=A9f=C3=A9rentiel depuis=
 la derni=C3=A8re synchronisation. Une resynchronisation doit =C3=AAtre=
 effectu=C3=A9e avant de pouvoir modifier la branche courante.\n"
+"Un autre programme Git a modifi=C3=A9 ce d=C3=A9p=C3=B4tdepuis la der=
ni=C3=A8re synchronisation. Une resynchronisation doit =C3=AAtre effect=
u=C3=A9e avant de pouvoir modifier la branche courante.\n"
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement.\n"
=20
@@ -809,12 +810,12 @@ msgstr "Mise =C3=A0 jour du r=C3=A9pertoire coura=
nt avec '%s'..."
=20
 #: lib/checkout_op.tcl:323
 msgid "files checked out"
-msgstr "fichiers emprunt=C3=A9s"
+msgstr "fichiers charg=C3=A9s"
=20
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr "Emprunt de '%s' abandonn=C3=A9. (Il est n=C3=A9cessaire de fus=
ionner des fichiers.)"
+msgstr "Chargement de '%s' abandonn=C3=A9. (Il est n=C3=A9cessaire de =
fusionner des fichiers.)"
=20
 #: lib/checkout_op.tcl:354
 msgid "File level merge required."
@@ -840,7 +841,7 @@ msgstr ""
 #: lib/checkout_op.tcl:446 lib/checkout_op.tcl:450
 #, tcl-format
 msgid "Checked out '%s'."
-msgstr "'%s' emprunt=C3=A9."
+msgstr "'%s' charg=C3=A9."
=20
 #: lib/checkout_op.tcl:478
 #, tcl-format
@@ -884,15 +885,15 @@ msgstr "S=C3=A9lectionner"
=20
 #: lib/choose_font.tcl:53
 msgid "Font Family"
-msgstr "Famille de fonte"
+msgstr "Familles de polices"
=20
 #: lib/choose_font.tcl:74
 msgid "Font Size"
-msgstr "Taille de fonte"
+msgstr "Taille de police"
=20
 #: lib/choose_font.tcl:91
 msgid "Font Example"
-msgstr "Exemple de fonte"
+msgstr "Exemple de police"
=20
 #: lib/choose_font.tcl:103
 msgid ""
@@ -900,7 +901,7 @@ msgid ""
 "If you like this text, it can be your font."
 msgstr ""
 "C'est un texte d'exemple.\n"
-"Si vous aimez ce texte, vous pouvez choisir cette fonte."
+"Si vous aimez ce texte, vous pouvez choisir cette police"
=20
 #: lib/choose_repository.tcl:28
 msgid "Git Gui"
@@ -908,7 +909,7 @@ msgstr "Git Gui"
=20
 #: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
 msgid "Create New Repository"
-msgstr "Cr=C3=A9er nouveau r=C3=A9f=C3=A9rentiel"
+msgstr "Cr=C3=A9er nouveau d=C3=A9p=C3=B4t"
=20
 #: lib/choose_repository.tcl:87
 msgid "New..."
@@ -916,7 +917,7 @@ msgstr "Nouveau..."
=20
 #: lib/choose_repository.tcl:94 lib/choose_repository.tcl:460
 msgid "Clone Existing Repository"
-msgstr "Cloner r=C3=A9f=C3=A9rentiel existant"
+msgstr "Cloner d=C3=A9p=C3=B4t existant"
=20
 #: lib/choose_repository.tcl:100
 msgid "Clone..."
@@ -924,7 +925,7 @@ msgstr "Cloner..."
=20
 #: lib/choose_repository.tcl:107 lib/choose_repository.tcl:976
 msgid "Open Existing Repository"
-msgstr "Ouvrir r=C3=A9f=C3=A9rentiel existant"
+msgstr "Ouvrir d=C3=A9p=C3=B4t existant"
=20
 #: lib/choose_repository.tcl:113
 msgid "Open..."
@@ -932,17 +933,17 @@ msgstr "Ouvrir..."
=20
 #: lib/choose_repository.tcl:126
 msgid "Recent Repositories"
-msgstr "R=C3=A9f=C3=A9rentiels r=C3=A9cents"
+msgstr "D=C3=A9p=C3=B4t r=C3=A9cemment utilis=C3=A9s"
=20
 #: lib/choose_repository.tcl:132
 msgid "Open Recent Repository:"
-msgstr "Ouvrir r=C3=A9f=C3=A9rentiel r=C3=A9cent :"
+msgstr "Ouvrir d=C3=A9p=C3=B4t r=C3=A9cent :"
=20
 #: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
 #: lib/choose_repository.tcl:310
 #, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "La cr=C3=A9ation du r=C3=A9f=C3=A9rentiel %s a =C3=A9chou=C3=A9=
e :"
+msgstr "La cr=C3=A9ation du d=C3=A9p=C3=B4t %s a =C3=A9chou=C3=A9e :"
=20
 #: lib/choose_repository.tcl:381 lib/choose_repository.tcl:478
 msgid "Directory:"
@@ -951,7 +952,7 @@ msgstr "R=C3=A9pertoire :"
 #: lib/choose_repository.tcl:412 lib/choose_repository.tcl:537
 #: lib/choose_repository.tcl:1011
 msgid "Git Repository"
-msgstr "R=C3=A9f=C3=A9rentiel Git"
+msgstr "D=C3=A9p=C3=B4t Git"
=20
 #: lib/choose_repository.tcl:437
 #, tcl-format
@@ -992,15 +993,15 @@ msgstr "Partag=C3=A9 (le plus rapide, non recomma=
nd=C3=A9, pas de sauvegarde)"
 #: lib/choose_repository.tcl:1017 lib/choose_repository.tcl:1025
 #, tcl-format
 msgid "Not a Git repository: %s"
-msgstr "'%s' n'est pas un r=C3=A9f=C3=A9rentiel Git."
+msgstr "'%s' n'est pas un d=C3=A9p=C3=B4t Git."
=20
 #: lib/choose_repository.tcl:579
 msgid "Standard only available for local repository."
-msgstr "Standard n'est disponible que pour un r=C3=A9f=C3=A9rentiel lo=
cal."
+msgstr "Standard n'est disponible que pour un d=C3=A9p=C3=B4t local."
=20
 #: lib/choose_repository.tcl:583
 msgid "Shared only available for local repository."
-msgstr "Partag=C3=A9 n'est disponible que pour un r=C3=A9f=C3=A9rentie=
l local."
+msgstr "Partag=C3=A9 n'est disponible que pour un d=C3=A9p=C3=B4t loca=
l."
=20
 #: lib/choose_repository.tcl:604
 #, tcl-format
@@ -1013,7 +1014,7 @@ msgstr "La configuration de l'origine a =C3=A9cho=
u=C3=A9e."
=20
 #: lib/choose_repository.tcl:627
 msgid "Counting objects"
-msgstr "Comptage des objets"
+msgstr "D=C3=A9compte des objets"
=20
 #: lib/choose_repository.tcl:628
 msgid "buckets"
@@ -1032,11 +1033,11 @@ msgstr "Il n'y a rien =C3=A0 cloner depuis %s."
 #: lib/choose_repository.tcl:690 lib/choose_repository.tcl:904
 #: lib/choose_repository.tcl:916
 msgid "The 'master' branch has not been initialized."
-msgstr "Cette branche 'master' n'a pas =C3=A9t=C3=A9 initialis=C3=A9e.=
"
+msgstr "La branche 'master' n'a pas =C3=A9t=C3=A9 initialis=C3=A9e."
=20
 #: lib/choose_repository.tcl:703
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "Les liens durs ne sont pas disponibles. On se r=C3=A9soud =C3=A0=
 copier."
+msgstr "Les liens durs ne sont pas support=C3=A9s. Une copie sera effe=
ctu=C3=A9e =C3=A0 la place."
=20
 #: lib/choose_repository.tcl:715
 #, tcl-format
@@ -1078,7 +1079,7 @@ msgstr ""
 #: lib/choose_repository.tcl:856
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
-"Impossible de r=C3=A9cup=C3=A9rer les marques. Voir la sortie console=
 pour plus de "
+"Impossible de r=C3=A9cup=C3=A9rer les marques (tags). Voir la sortie =
console pour plus de "
 "d=C3=A9tails."
=20
 #: lib/choose_repository.tcl:880
@@ -1114,7 +1115,7 @@ msgstr "fichiers"
=20
 #: lib/choose_repository.tcl:955
 msgid "Initial file checkout failed."
-msgstr "L'emprunt initial de fichier a =C3=A9chou=C3=A9."
+msgstr "Checkement initial du fichier =C3=A9chou=C3=A9."
=20
 #: lib/choose_repository.tcl:971
 msgid "Open"
@@ -1122,12 +1123,12 @@ msgstr "Ouvrir"
=20
 #: lib/choose_repository.tcl:981
 msgid "Repository:"
-msgstr "R=C3=A9f=C3=A9rentiel :"
+msgstr "D=C3=A9p=C3=B4t :"
=20
 #: lib/choose_repository.tcl:1031
 #, tcl-format
 msgid "Failed to open repository %s:"
-msgstr "Impossible d'ouvrir le r=C3=A9f=C3=A9rentiel %s :"
+msgstr "Impossible d'ouvrir le d=C3=A9p=C3=B4t %s :"
=20
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
@@ -1143,11 +1144,11 @@ msgstr "Branche locale"
=20
 #: lib/choose_rev.tcl:79
 msgid "Tracking Branch"
-msgstr "Suivi de branche"
+msgstr "Branche de suivi"
=20
 #: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
 msgid "Tag"
-msgstr "Marque"
+msgstr "Marque (tag)"
=20
 #: lib/choose_rev.tcl:317
 #, tcl-format
@@ -1164,7 +1165,7 @@ msgstr "L'expression de r=C3=A9vision est vide."
=20
 #: lib/choose_rev.tcl:531
 msgid "Updated"
-msgstr "Misa =C3=A0 jour"
+msgstr "=C3=80 jour (updated)"
=20
 #: lib/choose_rev.tcl:559
 msgid "URL"
@@ -1218,9 +1219,9 @@ msgid ""
 "The rescan will be automatically started now.\n"
 msgstr ""
 "L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du "
-"r=C3=A9f=C3=A9rentiel.\n"
+"d=C3=A9p=C3=B4t.\n"
 "\n"
-"Un autre programme Git a modifi=C3=A9 ce r=C3=A9f=C3=A9rentiel depuis=
 la derni=C3=A8re "
+"Un autre programme Git a modifi=C3=A9 ce d=C3=A9p=C3=B4t depuis la de=
rni=C3=A8re "
 "synchronisation. Une resynshronisation doit =C3=AAtre effectu=C3=A9e =
avant de pouvoir "
 "cr=C3=A9er un nouveau commit.\n"
 "\n"
@@ -1258,7 +1259,7 @@ msgid ""
 msgstr ""
 "Pas de modification =C3=A0 commiter.\n"
 "\n"
-"Vous devez pr=C3=A9-commiter au moins 1 fichier avant de pouvoir comm=
iter.\n"
+"Vous devez indexer au moins 1 fichier avant de pouvoir commiter.\n"
=20
 #: lib/commit.tcl:183
 msgid ""
@@ -1285,19 +1286,19 @@ msgstr "attention : Tcl ne supporte pas l'encod=
age '%s'."
=20
 #: lib/commit.tcl:221
 msgid "Calling pre-commit hook..."
-msgstr "Appel du programme externe d'avant commit..."
+msgstr "Appel du programme externe d'avant commit (pre-commit)..."
=20
 #: lib/commit.tcl:236
 msgid "Commit declined by pre-commit hook."
-msgstr "Commit refus=C3=A9 par le programme externe d'avant commit."
+msgstr "Commit refus=C3=A9 par le programme externe d'avant commit (pr=
e-commit)."
=20
 #: lib/commit.tcl:259
 msgid "Calling commit-msg hook..."
-msgstr "Appel du programme externe de message de commit..."
+msgstr "Appel du programme externe de message de commit (commit-msg)..=
=2E"
=20
 #: lib/commit.tcl:274
 msgid "Commit declined by commit-msg hook."
-msgstr "Commit refus=C3=A9 par le programme externe de message de comm=
it."
+msgstr "Commit refus=C3=A9 par le programme externe de message de comm=
it (commit-msg)."
=20
 #: lib/commit.tcl:287
 msgid "Committing changes..."
@@ -1406,7 +1407,7 @@ msgid ""
 "\n"
 "Compress the database now?"
 msgstr ""
-"Ce r=C3=A9f=C3=A9rentiel comprend actuellement environ %i objets ayan=
t leur fichier "
+"Ce d=C3=A9p=C3=B4t comprend actuellement environ %i objets ayant leur=
 fichier "
 "particulier.\n"
 "\n"
 "Pour conserver une performance optimale, il est fortement recommand=C3=
=A9 de "
@@ -1459,7 +1460,7 @@ msgstr "Erreur lors du chargement du fichier :"
=20
 #: lib/diff.tcl:122
 msgid "Git Repository (subproject)"
-msgstr "R=C3=A9f=C3=A9rentiel Git (sous projet)"
+msgstr "D=C3=A9p=C3=B4t Git (sous projet)"
=20
 #: lib/diff.tcl:134
 msgid "* Binary file (not showing content)."
@@ -1471,11 +1472,11 @@ msgstr "Erreur lors du chargement des diff=C3=A9=
rences :"
=20
 #: lib/diff.tcl:303
 msgid "Failed to unstage selected hunk."
-msgstr "La suppression dans le pr=C3=A9-commit de la section s=C3=A9le=
ctionn=C3=A9e a =C3=A9chou=C3=A9e."
+msgstr "=C3=89chec lors de la d=C3=A9sindexation de la section."
=20
 #: lib/diff.tcl:310
 msgid "Failed to stage selected hunk."
-msgstr "Le pr=C3=A9-commit de la section s=C3=A9lectionn=C3=A9e a =C3=A9=
chou=C3=A9."
+msgstr "=C3=89chec lors de l'indexation de la section."
=20
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
@@ -1491,17 +1492,17 @@ msgstr "Vous devez corriger les erreurs suivant=
es avant de pouvoir commiter."
=20
 #: lib/index.tcl:6
 msgid "Unable to unlock the index."
-msgstr "Impossible de d=C3=A9v=C3=A9rouiller le pr=C3=A9-commit."
+msgstr "Impossible de d=C3=A9v=C3=A9rouiller l'index."
=20
 #: lib/index.tcl:15
 msgid "Index Error"
-msgstr "Erreur de pr=C3=A9-commit"
+msgstr "Erreur de l'index"
=20
 #: lib/index.tcl:21
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
-msgstr "Le pr=C3=A9-commit a =C3=A9chou=C3=A9. Une resynchronisation v=
a =C3=AAtre lanc=C3=A9e automatiquement."
+msgstr "=C3=89chec de la mise =C3=A0 jour de l'index. Une resynchronis=
ation va =C3=AAtre lanc=C3=A9e automatiquement."
=20
 #: lib/index.tcl:27
 msgid "Continue"
@@ -1509,12 +1510,12 @@ msgstr "Continuer"
=20
 #: lib/index.tcl:31
 msgid "Unlock Index"
-msgstr "D=C3=A9v=C3=A9rouiller le pr=C3=A9-commit"
+msgstr "D=C3=A9verouiller l'index"
=20
 #: lib/index.tcl:282
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "Supprimer %s du commit"
+msgstr "D=C3=A9sindexation de: %s"
=20
 #: lib/index.tcl:313
 msgid "Ready to commit."
@@ -1523,23 +1524,23 @@ msgstr "Pr=C3=AAt =C3=A0 =C3=AAtre commit=C3=A9=
=2E"
 #: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
-msgstr "Ajouter %s"
+msgstr "Ajout de %s"
=20
 #: lib/index.tcl:381
 #, tcl-format
 msgid "Revert changes in file %s?"
-msgstr "Inverser les modifications dans le fichier %s ? "
+msgstr "Annuler les modifications dans le fichier %s ? "
=20
 #: lib/index.tcl:383
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "Inverser les modifications dans ces %i fichiers ?"
+msgstr "Annuler les modifications dans ces %i fichiers ?"
=20
 #: lib/index.tcl:391
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Toutes les modifications non pr=C3=A9-commit=C3=A9es seront d=C3=A9fi=
nitivement perdues "
-"lors de l'inversion."
+"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues "
+"par l'annulation."
=20
 #: lib/index.tcl:394
 msgid "Do Nothing"
@@ -1551,7 +1552,7 @@ msgid ""
 "\n"
 "You must finish amending this commit before starting any type of merg=
e.\n"
 msgstr ""
-"Impossible de fucionner pendant une correction.\n"
+"Impossible de fusionner pendant une correction.\n"
 "\n"
 "Vous devez finir de corriger ce commit avant de lancer une quelconque=
 "
 "fusion.\n"
@@ -1566,9 +1567,9 @@ msgid ""
 "The rescan will be automatically started now.\n"
 msgstr ""
 "L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du "
-"r=C3=A9f=C3=A9rentiel.\n"
+"d=C3=A9p=C3=B4t.\n"
 "\n"
-"Un autre programme Git a modifi=C3=A9 ce r=C3=A9f=C3=A9rentiel depuis=
 la derni=C3=A8re "
+"Un autre programme Git a modifi=C3=A9 ce d=C3=A9p=C3=B4t depuis la de=
rni=C3=A8re "
 "synchronisation. Une resynchronisation doit =C3=AAtre effectu=C3=A9e =
avant de pouvoir "
 "fusionner de nouveau.\n"
 "\n"
@@ -1588,8 +1589,8 @@ msgstr ""
 "\n"
 "Le fichier %s a des conflicts de fusion.\n"
 "\n"
-"Vous devez les r=C3=A9soudre, puis pr=C3=A9-commiter le fichier, et e=
nfin commiter "
-"pour terminer la fusion courante. Seulement=C3=A0 ce moment l=C3=A0, =
il sera possible "
+"Vous devez les r=C3=A9soudre, puis indexer le fichier, et enfin commi=
ter "
+"pour terminer la fusion courante. Seulement =C3=A0 ce moment l=C3=A0 =
sera-t-il possible "
 "d'effectuer une nouvelle fusion.\n"
=20
 #: lib/merge.tcl:54
@@ -1704,11 +1705,11 @@ msgstr "Sauvegarder"
 #: lib/option.tcl:109
 #, tcl-format
 msgid "%s Repository"
-msgstr "R=C3=A9f=C3=A9rentiel de %s"
+msgstr "D=C3=A9p=C3=B4t: %s"
=20
 #: lib/option.tcl:110
 msgid "Global (All Repositories)"
-msgstr "Globales (tous les r=C3=A9f=C3=A9rentiels)"
+msgstr "Globales (tous les d=C3=A9p=C3=B4ts)"
=20
 #: lib/option.tcl:116
 msgid "User Name"
@@ -1736,7 +1737,7 @@ msgstr "Faire confiance aux dates de modification=
 de fichiers "
=20
 #: lib/option.tcl:124
 msgid "Prune Tracking Branches During Fetch"
-msgstr "Nettoyer les branches de suivi pendant la r=C3=A9cup=C3=A9rati=
on"
+msgstr "Purger les branches de suivi pendant la r=C3=A9cup=C3=A9ration=
"
=20
 #: lib/option.tcl:125
 msgid "Match Tracking Branches"
@@ -1760,7 +1761,7 @@ msgstr "Dictionnaire d'orthographe :"
=20
 #: lib/option.tcl:216
 msgid "Change Font"
-msgstr "Modifier les fontes"
+msgstr "Modifier les polices"
=20
 #: lib/option.tcl:220
 #, tcl-format
@@ -1785,7 +1786,7 @@ msgstr "Supprimer branche distante"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
-msgstr "R=C3=A9f=C3=A9rentiel"
+msgstr "D=C3=A9p=C3=B4t source"
=20
 #: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
 msgid "Remote:"
@@ -1856,7 +1857,7 @@ msgstr "Supprimer les branches de %s"
=20
 #: lib/remote_branch_delete.tcl:286
 msgid "No repository selected."
-msgstr "Aucun r=C3=A9f=C3=A9rentiel n'est s=C3=A9lectionn=C3=A9."
+msgstr "Aucun d=C3=A9p=C3=B4t n'est s=C3=A9lectionn=C3=A9."
=20
 #: lib/remote_branch_delete.tcl:291
 #, tcl-format
@@ -1865,7 +1866,7 @@ msgstr "Synchronisation de %s..."
=20
 #: lib/remote.tcl:165
 msgid "Prune from"
-msgstr "Nettoyer de"
+msgstr "Purger de"
=20
 #: lib/remote.tcl:170
 msgid "Fetch from"
@@ -1914,7 +1915,7 @@ msgstr "Aucune suggestion"
=20
 #: lib/spellcheck.tcl:381
 msgid "Unexpected EOF from spell checker"
-msgstr "Fin de fichier innatendue envoy=C3=A9e par le v=C3=A9rificateu=
r d'orthographe"
+msgstr "EOF inattendue envoy=C3=A9e par le v=C3=A9rificateur d'orthogr=
aphe"
=20
 #: lib/spellcheck.tcl:385
 msgid "Spell Checker Failed"
@@ -1938,7 +1939,7 @@ msgstr "R=C3=A9cup=C3=A9ration des derni=C3=A8res=
 modifications de %s"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "nettoyer =C3=A0 distance %s"
+msgstr "purger =C3=A0 distance %s"
=20
 #: lib/transport.tcl:19
 #, tcl-format
@@ -1970,7 +1971,7 @@ msgstr "Branches source"
=20
 #: lib/transport.tcl:120
 msgid "Destination Repository"
-msgstr "R=C3=A9f=C3=A9rentiel de destination"
+msgstr "D=C3=A9p=C3=B4t de destination"
=20
 #: lib/transport.tcl:158
 msgid "Transfer Options"
@@ -1988,5 +1989,5 @@ msgstr "Utiliser des petits paquets (pour les con=
nexions lentes)"
=20
 #: lib/transport.tcl:168
 msgid "Include tags"
-msgstr "Inclure les marques"
+msgstr "Inclure les marques (tags)"
=20
--=20
1.5.4.3
