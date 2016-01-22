From: Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 2/2] gitk: fr.po: Sync translations with git
Date: Fri, 22 Jan 2016 23:34:42 +0100
Message-ID: <1453502082-14849-2-git-send-email-jn.avila@free.fr>
References: <1453502082-14849-1-git-send-email-jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean-Noel Avila <jn.avila@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 23:35:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkIl-0003Us-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbcAVWf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2016 17:35:28 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:32931 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbcAVWf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:35:26 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 27A192D36F
	for <git@vger.kernel.org>; Fri, 22 Jan 2016 23:35:21 +0100 (CET)
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
	by smtp1-g21.free.fr (Postfix) with ESMTP id CB9D8940130;
	Fri, 22 Jan 2016 23:33:53 +0100 (CET)
X-Mailer: git-send-email 2.7.0.rc3
In-Reply-To: <1453502082-14849-1-git-send-email-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284600>

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 po/fr.po | 96 +++++++++++++++++++++++++++++++-------------------------=
--------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index 2e55c89..c44f994 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2016-01-22 22:04+0100\n"
-"PO-Revision-Date: 2016-01-22 23:05+0100\n"
+"PO-Revision-Date: 2016-01-22 23:28+0100\n"
 "Last-Translator: Jean-No=C3=ABl Avila <jn.avila@free.fr>\n"
 "Language-Team: git@vger.kernel.org\n"
 "Language: \n"
@@ -95,27 +95,27 @@ msgstr "Mise =C3=A0 jour"
=20
 #: gitk:2084
 msgid "&Reload"
-msgstr "Recharger"
+msgstr "&Recharger"
=20
 #: gitk:2085
 msgid "Reread re&ferences"
-msgstr "Relire les r=C3=A9f=C3=A9rences"
+msgstr "Relire les r=C3=A9&f=C3=A9rences"
=20
 #: gitk:2086
 msgid "&List references"
-msgstr "Lister les r=C3=A9f=C3=A9rences"
+msgstr "&Lister les r=C3=A9f=C3=A9rences"
=20
 #: gitk:2088
 msgid "Start git &gui"
-msgstr "D=C3=A9marrer git gui"
+msgstr "D=C3=A9marrer git &gui"
=20
 #: gitk:2090
 msgid "&Quit"
-msgstr "Quitter"
+msgstr "&Quitter"
=20
 #: gitk:2082
 msgid "&File"
-msgstr "Fichier"
+msgstr "&Fichier"
=20
 #: gitk:2094
 msgid "&Preferences"
@@ -123,15 +123,15 @@ msgstr "Pr=C3=A9f=C3=A9rences"
=20
 #: gitk:2093
 msgid "&Edit"
-msgstr "=C3=89diter"
+msgstr "&=C3=89diter"
=20
 #: gitk:2098
 msgid "&New view..."
-msgstr "Nouvelle vue..."
+msgstr "&Nouvelle vue..."
=20
 #: gitk:2099
 msgid "&Edit view..."
-msgstr "=C3=89diter la vue..."
+msgstr "&=C3=89diter la vue..."
=20
 #: gitk:2100
 msgid "&Delete view"
@@ -143,7 +143,7 @@ msgstr "Tous les fichiers"
=20
 #: gitk:2097
 msgid "&View"
-msgstr "Vue"
+msgstr "&Vue"
=20
 #: gitk:2107 gitk:2117
 msgid "&About gitk"
@@ -208,7 +208,7 @@ msgstr "Tous les champs"
=20
 #: gitk:2332 gitk:4890 gitk:4923 gitk:6805
 msgid "Headline"
-msgstr "Surligner"
+msgstr "Titre"
=20
 #: gitk:2333 gitk:4890 gitk:6805 gitk:6935 gitk:7408
 msgid "Comments"
@@ -221,7 +221,7 @@ msgstr "Auteur"
=20
 #: gitk:2333 gitk:4890 gitk:6805 gitk:7345
 msgid "Committer"
-msgstr "Auteur du commit"
+msgstr "Validateur"
=20
 #: gitk:2367
 msgid "Search"
@@ -261,11 +261,11 @@ msgstr "Arbre"
=20
 #: gitk:2635 gitk:2656
 msgid "Diff this -> selected"
-msgstr "Diff entre ceci et la s=C3=A9lection"
+msgstr "Diff ceci -> la s=C3=A9lection"
=20
 #: gitk:2636 gitk:2657
 msgid "Diff selected -> this"
-msgstr "Diff entre s=C3=A9lection et ceci"
+msgstr "Diff s=C3=A9lection -> ceci"
=20
 #: gitk:2637 gitk:2658
 msgid "Make patch"
@@ -273,7 +273,7 @@ msgstr "Cr=C3=A9er patch"
=20
 #: gitk:2638 gitk:9273
 msgid "Create tag"
-msgstr "Cr=C3=A9er tag"
+msgstr "Cr=C3=A9er =C3=A9tiquette"
=20
 #: gitk:2639
 msgid "Copy commit summary"
@@ -643,7 +643,7 @@ msgstr "R=C3=A9f=C3=A9rences (liste d'=C3=A9l=C3=A9=
ments s=C3=A9par=C3=A9s par des espaces) :"
=20
 #: gitk:4095
 msgid "Branches & tags:"
-msgstr "Branches & tags :"
+msgstr "Branches & =C3=A9tiquettes :"
=20
 #: gitk:4096
 msgid "All refs"
@@ -655,7 +655,7 @@ msgstr "Toutes les branches (locales)"
=20
 #: gitk:4098
 msgid "All tags"
-msgstr "Tous les tags"
+msgstr "Toutes les =C3=A9tiquettes"
=20
 #: gitk:4099
 msgid "All remote-tracking branches"
@@ -671,7 +671,7 @@ msgstr "Auteur :"
=20
 #: gitk:4102
 msgid "Committer:"
-msgstr "Commiteur :"
+msgstr "Validateur :"
=20
 #: gitk:4103
 msgid "Commit Message:"
@@ -711,7 +711,7 @@ msgstr ""
=20
 #: gitk:4111
 msgid "Since:"
-msgstr "De :"
+msgstr "Depuis :"
=20
 #: gitk:4112
 msgid "Until:"
@@ -737,7 +737,6 @@ msgstr "Options diverses :"
 msgid "Strictly sort by date"
 msgstr "Trier par date"
=20
-# FIXME : traduction de "branch sides"
 #: gitk:4118
 msgid "Mark branch sides"
 msgstr "Indiquer les c=C3=B4t=C3=A9s des branches"
@@ -804,11 +803,11 @@ msgstr "Pas un anc=C3=AAtre"
=20
 #: gitk:5343
 msgid "Local changes checked in to index but not committed"
-msgstr "Modifications locales enregistr=C3=A9es dans l'index mais non =
commit=C3=A9es"
+msgstr "Modifications locales enregistr=C3=A9es dans l'index mais non =
valid=C3=A9es"
=20
 #: gitk:5379
 msgid "Local uncommitted changes, not checked in to index"
-msgstr "Modifications locales non enregistr=C3=A9es dans l'index et no=
n commit=C3=A9es"
+msgstr "Modifications locales non enregistr=C3=A9es dans l'index et no=
n valid=C3=A9es"
=20
 #: gitk:7153
 msgid "and many more"
@@ -820,7 +819,7 @@ msgstr "nombreux"
=20
 #: gitk:7347
 msgid "Tags:"
-msgstr "Tags :"
+msgstr "=C3=89tiquettes :"
=20
 #: gitk:7364 gitk:7370 gitk:8844
 msgid "Parent"
@@ -854,17 +853,17 @@ msgstr "Aller =C3=A0 :"
 #: gitk:8690
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
-msgstr "Id SHA1 court %s est ambigu"
+msgstr "L'id SHA1 court %s est ambigu"
=20
 #: gitk:8697
 #, tcl-format
 msgid "Revision %s is not known"
-msgstr "Id SHA1 %s est inconnu"
+msgstr "La r=C3=A9vision %s est inconnu"
=20
 #: gitk:8707
 #, tcl-format
 msgid "SHA1 id %s is not known"
-msgstr "Id SHA1 %s est inconnu"
+msgstr "L'id SHA1 %s est inconnu"
=20
 #: gitk:8709
 #, tcl-format
@@ -987,15 +986,15 @@ msgstr "ID :"
=20
 #: gitk:9284
 msgid "Tag name:"
-msgstr "Nom du Tag :"
+msgstr "Nom de l'=C3=A9tiquette :"
=20
 #: gitk:9287
 msgid "Tag message is optional"
-msgstr "Le message du tag est optionnel"
+msgstr "Le message d'=C3=A9tiquette est optionnel"
=20
 #: gitk:9289
 msgid "Tag message:"
-msgstr "Message du Tag :"
+msgstr "Message d'=C3=A9tiquette :"
=20
 #: gitk:9293 gitk:9472
 msgid "Create"
@@ -1003,16 +1002,16 @@ msgstr "Cr=C3=A9er"
=20
 #: gitk:9311
 msgid "No tag name specified"
-msgstr "Aucun nom de tag sp=C3=A9cifi=C3=A9"
+msgstr "Aucun nom d'=C3=A9tiquette sp=C3=A9cifi=C3=A9"
=20
 #: gitk:9315
 #, tcl-format
 msgid "Tag \"%s\" already exists"
-msgstr "Le tag \"%s\" existe d=C3=A9j=C3=A0"
+msgstr "L'=C3=A9tiquette \"%s\" existe d=C3=A9j=C3=A0"
=20
 #: gitk:9325
 msgid "Error creating tag:"
-msgstr "Erreur =C3=A0 la cr=C3=A9ation du tag :"
+msgstr "Erreur =C3=A0 la cr=C3=A9ation de l'=C3=A9tiquette :"
=20
 #: gitk:9415
 msgid "Command:"
@@ -1048,7 +1047,7 @@ msgstr ""
=20
 #: gitk:9568
 msgid "Cherry-picking"
-msgstr "Cueillir (Cherry-picking)"
+msgstr "Picorer (Cherry-picking)"
=20
 #: gitk:9577
 #, tcl-format
@@ -1056,23 +1055,20 @@ msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
 "Please commit, reset or stash your changes and try again."
 msgstr ""
-"La cueillette (cherry-pick) a =C3=A9chou=C3=A9e =C3=A0 cause de modif=
ications locales du "
-"fichier '%s'.\n"
-"Veuillez commiter, r=C3=A9initialiser ou stasher vos changements et e=
ssayer de "
-"nouveau."
+"Le picorage (cherry-pick) a =C3=A9chou=C3=A9e =C3=A0 cause de modific=
ations locales du fichier '%s'.\n"
+"Veuillez commiter, r=C3=A9initialiser ou stasher vos changements et e=
ssayer de nouveau."
=20
 #: gitk:9583
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
 msgstr ""
-"La cueillette (cherry-pick) a =C3=A9chou=C3=A9e =C3=A0 cause d'un con=
flit lors d'une "
-"fusion.\n"
+"Le picorage (cherry-pick) a =C3=A9chou=C3=A9e =C3=A0 cause d'un confl=
it lors d'une fusion.\n"
 "Souhaitez-vous ex=C3=A9cuter git citool pour le r=C3=A9soudre ?"
=20
 #: gitk:9599 gitk:9657
 msgid "No changes committed"
-msgstr "Aucun changement commit=C3=A9"
+msgstr "Aucune modification valid=C3=A9e"
=20
 #: gitk:9626
 #, tcl-format
@@ -1127,7 +1123,7 @@ msgid ""
 "(discard ALL local changes)"
 msgstr ""
 "Dure : R=C3=A9initialise le r=C3=A9pertoire de travail et l'index\n"
-"(abandonne TOUS les changements locaux)"
+"(abandonne TOUTES les modifications locale)"
=20
 #: gitk:9716
 msgid "Resetting"
@@ -1140,7 +1136,7 @@ msgstr "Extraction"
=20
 #: gitk:9829
 msgid "Cannot delete the currently checked-out branch"
-msgstr "Impossible de supprimer la branche en cours"
+msgstr "Impossible de supprimer la branche extraite"
=20
 #: gitk:9835
 #, tcl-format
@@ -1154,7 +1150,7 @@ msgstr ""
 #: gitk:9866
 #, tcl-format
 msgid "Tags and heads: %s"
-msgstr "Tags et heads : %s"
+msgstr "=C3=89tiquettes et heads : %s"
=20
 #: gitk:9883
 msgid "Filter"
@@ -1171,7 +1167,7 @@ msgstr ""
=20
 #: gitk:11156
 msgid "Tag"
-msgstr "Tag"
+msgstr "=C3=89tiquette"
=20
 #: gitk:11160
 msgid "Id"
@@ -1205,7 +1201,7 @@ msgstr "Largeur maximum du graphe (% du panneau)"
=20
 #: gitk:11391
 msgid "Show local changes"
-msgstr "Montrer les changements locaux"
+msgstr "Montrer les modifications locales"
=20
 #: gitk:11394
 msgid "Auto-select SHA1 (length)"
@@ -1229,7 +1225,7 @@ msgstr "Afficher les tags les plus proches"
=20
 #: gitk:11410
 msgid "Maximum # tags/heads to show"
-msgstr "Nombre maximum de tags/heads =C3=A0 afficher"
+msgstr "Nombre maximum d'=C3=A9tiquettes/heads =C3=A0 afficher"
=20
 #: gitk:11413
 msgid "Limit diffs to listed paths"
@@ -1317,15 +1313,15 @@ msgstr "diff : ent=C3=AAte du hunk"
=20
 #: gitk:11477
 msgid "Marked line bg"
-msgstr "Arri=C3=A8re-plan de la ligne marqu=C3=A9e"
+msgstr "Fond de la ligne marqu=C3=A9e"
=20
 #: gitk:11479
 msgid "marked line background"
-msgstr "Arri=C3=A8re-plan de la ligne marqu=C3=A9e"
+msgstr "Fond de la ligne marqu=C3=A9e"
=20
 #: gitk:11483
 msgid "Select bg"
-msgstr "S=C3=A9lectionner l'arri=C3=A8re-plan"
+msgstr "S=C3=A9lectionner le fond"
=20
 #: gitk:11492
 msgid "Fonts: press to choose"
--=20
2.7.0.rc3
