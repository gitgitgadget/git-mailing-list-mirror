From: Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 1/2] gitk: fr.po: Update translation (311t)
Date: Fri, 22 Jan 2016 23:34:41 +0100
Message-ID: <1453502082-14849-1-git-send-email-jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean-Noel Avila <jn.avila@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 23:43:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkQW-00079R-8o
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbcAVWn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2016 17:43:28 -0500
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:48320 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbcAVWn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:43:27 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 8AE95D1EF8D
	for <git@vger.kernel.org>; Fri, 22 Jan 2016 23:35:11 +0100 (CET)
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A4BCE94014B;
	Fri, 22 Jan 2016 23:33:42 +0100 (CET)
X-Mailer: git-send-email 2.7.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284605>

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 po/fr.po | 761 +++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 373 insertions(+), 388 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index 80f72fb..2e55c89 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -3,14 +3,14 @@
 # This file is distributed under the same license as the gitk package.
 # Translators:
 # Emmanuel Trillaud <etrillaud@gmail.com>
-#
+# Jean-No=C3=ABl Avila <jn.avila@free.fr>
 msgid ""
 msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2009-11-19 22:13+0100\n"
-"Last-Translator: Emmanuel Trillaud <etrillaud@gmail.com>\n"
+"POT-Creation-Date: 2016-01-22 22:04+0100\n"
+"PO-Revision-Date: 2016-01-22 23:05+0100\n"
+"Last-Translator: Jean-No=C3=ABl Avila <jn.avila@free.fr>\n"
 "Language-Team: git@vger.kernel.org\n"
 "Language: \n"
 "MIME-Version: 1.0\n"
@@ -23,13 +23,13 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Impossible de r=C3=A9cup=C3=A9rer la liste des fichiers non fu=
sionn=C3=A9s :"
=20
-#: gitk:212 gitk:2381
+#: gitk:212 gitk:2399
 msgid "Color words"
-msgstr ""
+msgstr "Colorier les mots diff=C3=A9rents"
=20
-#: gitk:217 gitk:2381 gitk:8220 gitk:8253
+#: gitk:217 gitk:2399 gitk:8239 gitk:8272
 msgid "Markup words"
-msgstr ""
+msgstr "Marquer les mots diff=C3=A9rents"
=20
 #: gitk:324
 msgid "Error parsing revisions:"
@@ -47,13 +47,10 @@ msgstr ""
=20
 # FIXME : am=C3=A9liorer la traduction de 'file limite'
 #: gitk:396
-#, fuzzy
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
-msgstr ""
-"Aucun fichier s=C3=A9lectionn=C3=A9 : --merge pr=C3=A9cis=C3=A9 mais =
aucun fichier non fusionn=C3=A9 "
-"n'est dans la limite des fichiers."
+msgstr "Aucun fichier s=C3=A9lectionn=C3=A9 : --merge pr=C3=A9cis=C3=A9=
 mais aucun fichier non fusionn=C3=A9 n'est dans la limite des fichiers=
=2E"
=20
 #: gitk:418 gitk:566
 msgid "Error executing git log:"
@@ -63,15 +60,15 @@ msgstr "Erreur =C3=A0 l'ex=C3=A9cution de git log :=
"
 msgid "Reading"
 msgstr "Lecture en cours"
=20
-#: gitk:496 gitk:4525
+#: gitk:496 gitk:4544
 msgid "Reading commits..."
 msgstr "Lecture des commits..."
=20
-#: gitk:499 gitk:1637 gitk:4528
+#: gitk:499 gitk:1637 gitk:4547
 msgid "No commits selected"
 msgstr "Aucun commit s=C3=A9lectionn=C3=A9"
=20
-#: gitk:1445 gitk:4045 gitk:12432
+#: gitk:1445 gitk:4064 gitk:12469
 msgid "Command line"
 msgstr "Ligne de commande"
=20
@@ -83,290 +80,294 @@ msgstr "Impossible de lire la sortie de git log :=
"
 msgid "No commit information available"
 msgstr "Aucune information disponible sur le commit"
=20
-#: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
+#: gitk:1903 gitk:1932 gitk:4334 gitk:9702 gitk:11274 gitk:11554
 msgid "OK"
 msgstr "OK"
=20
-#: gitk:1934 gitk:4317 gitk:9196 gitk:9275 gitk:9391 gitk:9440 gitk:96=
71
-#: gitk:11242 gitk:11522
+#: gitk:1934 gitk:4336 gitk:9215 gitk:9294 gitk:9424 gitk:9473 gitk:97=
04
+#: gitk:11275 gitk:11555
 msgid "Cancel"
 msgstr "Annuler"
=20
-#: gitk:2069
+#: gitk:2083
 msgid "&Update"
 msgstr "Mise =C3=A0 jour"
=20
-#: gitk:2070
+#: gitk:2084
 msgid "&Reload"
 msgstr "Recharger"
=20
-#: gitk:2071
+#: gitk:2085
 msgid "Reread re&ferences"
 msgstr "Relire les r=C3=A9f=C3=A9rences"
=20
-#: gitk:2072
+#: gitk:2086
 msgid "&List references"
 msgstr "Lister les r=C3=A9f=C3=A9rences"
=20
-#: gitk:2074
+#: gitk:2088
 msgid "Start git &gui"
 msgstr "D=C3=A9marrer git gui"
=20
-#: gitk:2076
+#: gitk:2090
 msgid "&Quit"
 msgstr "Quitter"
=20
-#: gitk:2068
+#: gitk:2082
 msgid "&File"
 msgstr "Fichier"
=20
-#: gitk:2080
+#: gitk:2094
 msgid "&Preferences"
 msgstr "Pr=C3=A9f=C3=A9rences"
=20
-#: gitk:2079
+#: gitk:2093
 msgid "&Edit"
 msgstr "=C3=89diter"
=20
-#: gitk:2084
+#: gitk:2098
 msgid "&New view..."
 msgstr "Nouvelle vue..."
=20
-#: gitk:2085
+#: gitk:2099
 msgid "&Edit view..."
 msgstr "=C3=89diter la vue..."
=20
-#: gitk:2086
+#: gitk:2100
 msgid "&Delete view"
 msgstr "Supprimer la vue"
=20
-#: gitk:2088 gitk:4043
+#: gitk:2102
 msgid "&All files"
 msgstr "Tous les fichiers"
=20
-#: gitk:2083 gitk:4067
+#: gitk:2097
 msgid "&View"
 msgstr "Vue"
=20
-#: gitk:2093 gitk:2103 gitk:3012
+#: gitk:2107 gitk:2117
 msgid "&About gitk"
 msgstr "=C3=80 propos de gitk"
=20
-#: gitk:2094 gitk:2108
+#: gitk:2108 gitk:2122
 msgid "&Key bindings"
 msgstr "Raccourcis clavier"
=20
-#: gitk:2092 gitk:2107
+#: gitk:2106 gitk:2121
 msgid "&Help"
 msgstr "Aide"
=20
-#: gitk:2185 gitk:8652
+#: gitk:2199 gitk:8671
 msgid "SHA1 ID:"
 msgstr "Id SHA1 :"
=20
-#: gitk:2229
+#: gitk:2243
 msgid "Row"
 msgstr "Colonne"
=20
-#: gitk:2267
+#: gitk:2281
 msgid "Find"
 msgstr "Recherche"
=20
-#: gitk:2295
+#: gitk:2309
 msgid "commit"
 msgstr "commit"
=20
-#: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:68=
27
-#: gitk:6912
+#: gitk:2313 gitk:2315 gitk:4706 gitk:4729 gitk:4753 gitk:6774 gitk:68=
46
+#: gitk:6931
 msgid "containing:"
 msgstr "contient :"
=20
-#: gitk:2302 gitk:3526 gitk:3531 gitk:4763
+#: gitk:2316 gitk:3545 gitk:3550 gitk:4782
 msgid "touching paths:"
 msgstr "chemins modifi=C3=A9s :"
=20
-#: gitk:2303 gitk:4777
+#: gitk:2317 gitk:4796
 msgid "adding/removing string:"
 msgstr "ajoute/supprime la cha=C3=AEne :"
=20
-#: gitk:2304 gitk:4779
+#: gitk:2318 gitk:4798
 msgid "changing lines matching:"
-msgstr ""
+msgstr "modifie les lignes v=C3=A9rifiant=C2=A0:"
=20
-#: gitk:2313 gitk:2315 gitk:4766
+#: gitk:2327 gitk:2329 gitk:4785
 msgid "Exact"
 msgstr "Exact"
=20
-#: gitk:2315 gitk:4854 gitk:6723
+#: gitk:2329 gitk:4873 gitk:6742
 msgid "IgnCase"
 msgstr "Ignorer la casse"
=20
-#: gitk:2315 gitk:4736 gitk:4852 gitk:6719
+#: gitk:2329 gitk:4755 gitk:4871 gitk:6738
 msgid "Regexp"
 msgstr "Expression r=C3=A9guli=C3=A8re"
=20
-#: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:69=
16
+#: gitk:2331 gitk:2332 gitk:4893 gitk:4923 gitk:4930 gitk:6867 gitk:69=
35
 msgid "All fields"
 msgstr "Tous les champs"
=20
-#: gitk:2318 gitk:4871 gitk:4904 gitk:6786
+#: gitk:2332 gitk:4890 gitk:4923 gitk:6805
 msgid "Headline"
 msgstr "Surligner"
=20
-#: gitk:2319 gitk:4871 gitk:6786 gitk:6916 gitk:7389
+#: gitk:2333 gitk:4890 gitk:6805 gitk:6935 gitk:7408
 msgid "Comments"
 msgstr "Commentaires"
=20
-#: gitk:2319 gitk:4871 gitk:4876 gitk:4911 gitk:6786 gitk:7324 gitk:88=
30
-#: gitk:8845
+#: gitk:2333 gitk:4890 gitk:4895 gitk:4930 gitk:6805 gitk:7343 gitk:88=
49
+#: gitk:8864
 msgid "Author"
 msgstr "Auteur"
=20
-#: gitk:2319 gitk:4871 gitk:6786 gitk:7326
+#: gitk:2333 gitk:4890 gitk:6805 gitk:7345
 msgid "Committer"
 msgstr "Auteur du commit"
=20
-#: gitk:2350
+#: gitk:2367
 msgid "Search"
 msgstr "Rechercher"
=20
-#: gitk:2358
+#: gitk:2375
 msgid "Diff"
 msgstr "Diff"
=20
-#: gitk:2360
+#: gitk:2377
 msgid "Old version"
 msgstr "Ancienne version"
=20
-#: gitk:2362
+#: gitk:2379
 msgid "New version"
 msgstr "Nouvelle version"
=20
-#: gitk:2364
+#: gitk:2382
 msgid "Lines of context"
 msgstr "Lignes de contexte"
=20
-#: gitk:2374
+#: gitk:2392
 msgid "Ignore space change"
 msgstr "Ignorer les modifications d'espace"
=20
-#: gitk:2378 gitk:2380 gitk:7959 gitk:8206
+#: gitk:2396 gitk:2398 gitk:7978 gitk:8225
 msgid "Line diff"
-msgstr ""
+msgstr "diff=C3=A9rence par ligne"
=20
-#: gitk:2445
+#: gitk:2463
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:2447
+#: gitk:2465
 msgid "Tree"
 msgstr "Arbre"
=20
-#: gitk:2617 gitk:2637
+#: gitk:2635 gitk:2656
 msgid "Diff this -> selected"
 msgstr "Diff entre ceci et la s=C3=A9lection"
=20
-#: gitk:2618 gitk:2638
+#: gitk:2636 gitk:2657
 msgid "Diff selected -> this"
 msgstr "Diff entre s=C3=A9lection et ceci"
=20
-#: gitk:2619 gitk:2639
+#: gitk:2637 gitk:2658
 msgid "Make patch"
 msgstr "Cr=C3=A9er patch"
=20
-#: gitk:2620 gitk:9254
+#: gitk:2638 gitk:9273
 msgid "Create tag"
 msgstr "Cr=C3=A9er tag"
=20
-#: gitk:2621 gitk:9371
+#: gitk:2639
+msgid "Copy commit summary"
+msgstr "Copi=C3=A9 le r=C3=A9sum=C3=A9 du commit"
+
+#: gitk:2640 gitk:9404
 msgid "Write commit to file"
 msgstr "=C3=89crire le commit dans un fichier"
=20
-#: gitk:2622 gitk:9428
+#: gitk:2641 gitk:9461
 msgid "Create new branch"
 msgstr "Cr=C3=A9er une nouvelle branche"
=20
-#: gitk:2623
+#: gitk:2642
 msgid "Cherry-pick this commit"
 msgstr "Cueillir (cherry-pick) ce commit"
=20
-#: gitk:2624
+#: gitk:2643
 msgid "Reset HEAD branch to here"
 msgstr "R=C3=A9initialiser la branche HEAD vers cet =C3=A9tat"
=20
-#: gitk:2625
+#: gitk:2644
 msgid "Mark this commit"
 msgstr "Marquer ce commit"
=20
-#: gitk:2626
+#: gitk:2645
 msgid "Return to mark"
 msgstr "Retourner =C3=A0 la marque"
=20
-#: gitk:2627
+#: gitk:2646
 msgid "Find descendant of this and mark"
 msgstr "Chercher le descendant de ceci et le marquer"
=20
-#: gitk:2628
+#: gitk:2647
 msgid "Compare with marked commit"
 msgstr "Comparer avec le commit marqu=C3=A9"
=20
-#: gitk:2629 gitk:2640
-#, fuzzy
+#: gitk:2648 gitk:2659
 msgid "Diff this -> marked commit"
-msgstr "Diff entre ceci et la s=C3=A9lection"
+msgstr "Diff ceci -> s=C3=A9lection"
=20
-#: gitk:2630 gitk:2641
-#, fuzzy
+#: gitk:2649 gitk:2660
 msgid "Diff marked commit -> this"
-msgstr "Diff entre s=C3=A9lection et ceci"
+msgstr "Diff entre s=C3=A9lection -> ceci"
=20
-#: gitk:2631
-#, fuzzy
+#: gitk:2650
 msgid "Revert this commit"
-msgstr "Marquer ce commit"
+msgstr "D=C3=A9faire ce commit"
=20
-#: gitk:2647
+#: gitk:2666
 msgid "Check out this branch"
 msgstr "R=C3=A9cup=C3=A9rer cette branche"
=20
-#: gitk:2648
+#: gitk:2667
 msgid "Remove this branch"
 msgstr "Supprimer cette branche"
=20
-#: gitk:2649
+#: gitk:2668
 msgid "Copy branch name"
-msgstr ""
+msgstr "Copier la nom de la branche"
=20
-#: gitk:2656
+#: gitk:2675
 msgid "Highlight this too"
 msgstr "Surligner =C3=A9galement ceci"
=20
-#: gitk:2657
+#: gitk:2676
 msgid "Highlight this only"
 msgstr "Surligner seulement ceci"
=20
-#: gitk:2658
+#: gitk:2677
 msgid "External diff"
 msgstr "Diff externe"
=20
-#: gitk:2659
+#: gitk:2678
 msgid "Blame parent commit"
 msgstr "Bl=C3=A2mer le commit parent"
=20
-#: gitk:2660
+#: gitk:2679
 msgid "Copy path"
-msgstr ""
+msgstr "Copier le chemin"
=20
-#: gitk:2667
+#: gitk:2686
 msgid "Show origin of this line"
 msgstr "Montrer l'origine de cette ligne"
=20
-#: gitk:2668
+#: gitk:2687
 msgid "Run git gui blame on this line"
 msgstr "Ex=C3=A9cuter git gui blame sur cette ligne"
=20
-#: gitk:3014
-#, fuzzy
+#: gitk:3031
+msgid "About gitk"
+msgstr "=C3=80 propos de gitk"
+
+#: gitk:3033
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -378,327 +379,329 @@ msgstr ""
 "\n"
 "Gitk - visualisateur de commit pour git\n"
 "\n"
-"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
+"Copyright \\u00a9 2005-2014 Paul Mackerras\n"
 "\n"
-"Utilisation et redistribution soumises aux termes de la GNU General P=
ublic "
-"License"
+"Utilisation et redistribution soumises aux termes de la GNU General P=
ublic License"
=20
-#: gitk:3022 gitk:3089 gitk:9857
+#: gitk:3041 gitk:3108 gitk:9890
 msgid "Close"
 msgstr "Fermer"
=20
-#: gitk:3043
+#: gitk:3062
 msgid "Gitk key bindings"
 msgstr "Raccourcis clavier de Gitk"
=20
-#: gitk:3046
+#: gitk:3065
 msgid "Gitk key bindings:"
 msgstr "Raccourcis clavier de Gitk :"
=20
-#: gitk:3048
+#: gitk:3067
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tQuitter"
=20
-#: gitk:3049
-#, fuzzy, tcl-format
+#: gitk:3068
+#, tcl-format
 msgid "<%s-W>\t\tClose window"
-msgstr "<%s-F>\t\tRechercher"
+msgstr "<%s-W>\t\tFermer la fen=C3=AAtre"
=20
-#: gitk:3050
+#: gitk:3069
 msgid "<Home>\t\tMove to first commit"
 msgstr "<D=C3=A9but>\t\tAller au premier commit"
=20
-#: gitk:3051
+#: gitk:3070
 msgid "<End>\t\tMove to last commit"
 msgstr "<Fin>\t\tAller au dernier commit"
=20
-#: gitk:3052
-#, fuzzy
+#: gitk:3071
 msgid "<Up>, p, k\tMove up one commit"
-msgstr "<Haut>, p, i\t Aller au commit suivant"
+msgstr "<Haut>, p, k\t Aller au commit pr=C3=A9c=C3=A9dent"
=20
-#: gitk:3053
-#, fuzzy
+#: gitk:3072
 msgid "<Down>, n, j\tMove down one commit"
-msgstr "<Bas>, n, k\t Aller au commit pr=C3=A9c=C3=A9dent"
+msgstr "<Bas>, n, j\t Aller au commit suivant"
=20
-#: gitk:3054
-#, fuzzy
+#: gitk:3073
 msgid "<Left>, z, h\tGo back in history list"
-msgstr "<Gauche>, z, j\tReculer dans l'historique"
+msgstr "<Gauche>, z, h\tReculer dans l'historique"
=20
-#: gitk:3055
+#: gitk:3074
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Droite>, x, l\tAvancer dans l'historique"
=20
-#: gitk:3056
+#: gitk:3075
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
-msgstr ""
+msgstr "<%s-n>\tAller sur le n-i=C3=A8me parent du commit dans l'histo=
rique"
=20
-#: gitk:3057
+#: gitk:3076
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tMonter d'une page dans la liste des commits"
=20
-#: gitk:3058
+#: gitk:3077
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tDescendre d'une page dans la liste des commits"
=20
-#: gitk:3059
+#: gitk:3078
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-D=C3=A9but>\tAller en haut de la liste des commits"
=20
-#: gitk:3060
+#: gitk:3079
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tAller en bas de la liste des commits"
=20
-#: gitk:3061
+#: gitk:3080
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tMonter d'une ligne dans la liste des commits"
=20
-#: gitk:3062
+#: gitk:3081
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tDescendre d'une ligne dans la liste des commits"
=20
-#: gitk:3063
+#: gitk:3082
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tMonter d'une page dans la liste des commits"
=20
-#: gitk:3064
+#: gitk:3083
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tDescendre d'une page dans la liste des commits"
=20
-#: gitk:3065
+#: gitk:3084
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr ""
 "<Shift-Up>\tRecherche en arri=C3=A8re (vers l'avant, commits les plus=
 anciens)"
=20
-#: gitk:3066
+#: gitk:3085
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr ""
 "<Shift-Down>\tRecherche en avant (vers l'arri=C3=A8re, commit les plu=
s r=C3=A9cents)"
=20
-#: gitk:3067
+#: gitk:3086
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Supprimer>, b\tMonter d'une page dans la vue des diff"
=20
-#: gitk:3068
+#: gitk:3087
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tMonter d'une page dans la vue des diff"
=20
-#: gitk:3069
+#: gitk:3088
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Espace>\t\tDescendre d'une page dans la vue des diff"
=20
-#: gitk:3070
+#: gitk:3089
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tMonter de 18 lignes dans la vue des diff"
=20
-#: gitk:3071
+#: gitk:3090
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tDescendre de 18 lignes dans la vue des diff"
=20
-#: gitk:3072
+#: gitk:3091
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tRechercher"
=20
-#: gitk:3073
+#: gitk:3092
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tAller au r=C3=A9sultat de recherche suivant"
=20
-#: gitk:3074
+#: gitk:3093
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t\tAller au r=C3=A9sultat de recherche suivant"
=20
-#: gitk:3075
-#, fuzzy
+#: gitk:3094
 msgid "g\t\tGo to commit"
-msgstr "<Fin>\t\tAller au dernier commit"
+msgstr "g\t\tAller au commit"
=20
-#: gitk:3076
+#: gitk:3095
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tFocus sur la zone de recherche"
=20
-#: gitk:3077
+#: gitk:3096
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tAller au r=C3=A9sultat de recherche pr=C3=A9c=C3=A9dent"
=20
-#: gitk:3078
+#: gitk:3097
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tAller au prochain fichier dans la vue des diff"
=20
-#: gitk:3079
+#: gitk:3098
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tAller au r=C3=A9sultat suivant dans la vue des diff"
=20
-#: gitk:3080
+#: gitk:3099
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tAller au r=C3=A9sultat pr=C3=A9c=C3=A9dent dans la v=
ue des diff"
=20
-#: gitk:3081
+#: gitk:3100
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tAugmenter la taille de la police"
=20
-#: gitk:3082
+#: gitk:3101
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tAugmenter la taille de la police"
=20
-#: gitk:3083
+#: gitk:3102
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tDiminuer la taille de la police"
=20
-#: gitk:3084
+#: gitk:3103
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tDiminuer la taille de la police"
=20
-#: gitk:3085
+#: gitk:3104
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tMise =C3=A0 jour"
=20
-#: gitk:3550 gitk:3559
+#: gitk:3569 gitk:3578
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Erreur lors de la cr=C3=A9ation du r=C3=A9pertoire temporaire =
%s :"
=20
-#: gitk:3572
+#: gitk:3591
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Erreur en obtenant \"%s\" de %s:"
=20
-#: gitk:3635
+#: gitk:3654
 msgid "command failed:"
 msgstr "=C3=A9chec de la commande :"
=20
-#: gitk:3784
+#: gitk:3803
 msgid "No such commit"
 msgstr "Commit inexistant"
=20
-#: gitk:3798
+#: gitk:3817
 msgid "git gui blame: command failed:"
 msgstr "git gui blame : =C3=A9chec de la commande :"
=20
-#: gitk:3829
+#: gitk:3848
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Impossible de lire le head de la fusion : %s"
=20
-#: gitk:3837
+#: gitk:3856
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Erreur =C3=A0 la lecture de l'index : %s"
=20
-#: gitk:3862
+#: gitk:3881
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "Impossible de d=C3=A9marrer git blame : %s"
=20
-#: gitk:3865 gitk:6754
+#: gitk:3884 gitk:6773
 msgid "Searching"
 msgstr "Recherche en cours"
=20
-#: gitk:3897
+#: gitk:3916
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Erreur =C3=A0 l'ex=C3=A9cution de git blame : %s"
=20
-#: gitk:3925
+#: gitk:3944
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "Cette ligne est issue du commit %s, qui n'est pas dans cette v=
ue"
=20
-#: gitk:3939
+#: gitk:3958
 msgid "External diff viewer failed:"
-msgstr "=C3=89chec de l'outil externe de visualisation des diff"
+msgstr "=C3=89chec de l'outil externe de visualisation des diff=C2=A0:=
"
+
+#: gitk:4062
+msgid "All files"
+msgstr "Tous les fichiers"
=20
-#: gitk:4070
+#: gitk:4086
+msgid "View"
+msgstr "Vue"
+
+#: gitk:4089
 msgid "Gitk view definition"
 msgstr "D=C3=A9finition des vues de Gitk"
=20
-#: gitk:4074
+#: gitk:4093
 msgid "Remember this view"
 msgstr "Se souvenir de cette vue"
=20
-#: gitk:4075
+#: gitk:4094
 msgid "References (space separated list):"
 msgstr "R=C3=A9f=C3=A9rences (liste d'=C3=A9l=C3=A9ments s=C3=A9par=C3=
=A9s par des espaces) :"
=20
-#: gitk:4076
+#: gitk:4095
 msgid "Branches & tags:"
 msgstr "Branches & tags :"
=20
-#: gitk:4077
+#: gitk:4096
 msgid "All refs"
 msgstr "Toutes les r=C3=A9f=C3=A9rences"
=20
-#: gitk:4078
+#: gitk:4097
 msgid "All (local) branches"
 msgstr "Toutes les branches (locales)"
=20
-#: gitk:4079
+#: gitk:4098
 msgid "All tags"
 msgstr "Tous les tags"
=20
-#: gitk:4080
+#: gitk:4099
 msgid "All remote-tracking branches"
 msgstr "Toutes les branches de suivi =C3=A0 distance"
=20
-#: gitk:4081
+#: gitk:4100
 msgid "Commit Info (regular expressions):"
 msgstr "Info sur les commits (expressions r=C3=A9guli=C3=A8res) :"
=20
-#: gitk:4082
+#: gitk:4101
 msgid "Author:"
 msgstr "Auteur :"
=20
-#: gitk:4083
+#: gitk:4102
 msgid "Committer:"
 msgstr "Commiteur :"
=20
-#: gitk:4084
+#: gitk:4103
 msgid "Commit Message:"
 msgstr "Message de commit :"
=20
-#: gitk:4085
+#: gitk:4104
 msgid "Matches all Commit Info criteria"
 msgstr "Correspond =C3=A0 tous les crit=C3=A8res d'Info sur les commit=
s"
=20
-#: gitk:4086
-#, fuzzy
+#: gitk:4105
 msgid "Matches no Commit Info criteria"
-msgstr "Correspond =C3=A0 tous les crit=C3=A8res d'Info sur les commit=
s"
+msgstr "Ne correspond =C3=A0 aucun des crit=C3=A8res d'Info sur les co=
mmits"
=20
-#: gitk:4087
+#: gitk:4106
 msgid "Changes to Files:"
 msgstr "Changements des fichiers :"
=20
-#: gitk:4088
+#: gitk:4107
 msgid "Fixed String"
 msgstr "Cha=C3=AEne Fig=C3=A9e"
=20
-#: gitk:4089
+#: gitk:4108
 msgid "Regular Expression"
 msgstr "Expression R=C3=A9guli=C3=A8re"
=20
-#: gitk:4090
+#: gitk:4109
 msgid "Search string:"
 msgstr "Recherche de la cha=C3=AEne :"
=20
-#: gitk:4091
+#: gitk:4110
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
 "15:27:38\"):"
@@ -706,204 +709,202 @@ msgstr ""
 "Dates des commits (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March =
17, "
 "2009 15:27:38\") :"
=20
-#: gitk:4092
+#: gitk:4111
 msgid "Since:"
 msgstr "De :"
=20
-#: gitk:4093
+#: gitk:4112
 msgid "Until:"
 msgstr "Jusqu'au :"
=20
-#: gitk:4094
+#: gitk:4113
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr "Limiter et/ou sauter un certain nombre (entier positif) de r=C3=
=A9visions :"
=20
-#: gitk:4095
+#: gitk:4114
 msgid "Number to show:"
 msgstr "Nombre =C3=A0 afficher :"
=20
-#: gitk:4096
+#: gitk:4115
 msgid "Number to skip:"
 msgstr "Nombre =C3=A0 sauter :"
=20
-#: gitk:4097
+#: gitk:4116
 msgid "Miscellaneous options:"
 msgstr "Options diverses :"
=20
-#: gitk:4098
+#: gitk:4117
 msgid "Strictly sort by date"
 msgstr "Trier par date"
=20
 # FIXME : traduction de "branch sides"
-#: gitk:4099
-#, fuzzy
+#: gitk:4118
 msgid "Mark branch sides"
-msgstr "Marquer les extr=C3=A9mit=C3=A9s des branches"
+msgstr "Indiquer les c=C3=B4t=C3=A9s des branches"
=20
-#: gitk:4100
+#: gitk:4119
 msgid "Limit to first parent"
 msgstr "Limiter au premier anc=C3=AAtre"
=20
-#: gitk:4101
+#: gitk:4120
 msgid "Simple history"
 msgstr "Historique simple"
=20
-#: gitk:4102
+#: gitk:4121
 msgid "Additional arguments to git log:"
 msgstr "Arguments suppl=C3=A9mentaires de git log :"
=20
-#: gitk:4103
+#: gitk:4122
 msgid "Enter files and directories to include, one per line:"
 msgstr "Saisir les fichiers et r=C3=A9pertoires =C3=A0 inclure, un par=
 ligne :"
=20
-#: gitk:4104
+#: gitk:4123
 msgid "Command to generate more commits to include:"
 msgstr "Commande pour g=C3=A9n=C3=A9rer plus de commits =C3=A0 inclure=
 :"
=20
-#: gitk:4228
+#: gitk:4247
 msgid "Gitk: edit view"
 msgstr "Gitk : =C3=A9diter la vue"
=20
-#: gitk:4236
+#: gitk:4255
 msgid "-- criteria for selecting revisions"
 msgstr "-- crit=C3=A8re pour la s=C3=A9lection des r=C3=A9visions"
=20
-#: gitk:4241
-#, fuzzy
+#: gitk:4260
 msgid "View Name"
-msgstr "Nom de la vue :"
+msgstr "Nom de la vue"
=20
-#: gitk:4316
+#: gitk:4335
 msgid "Apply (F5)"
 msgstr "Appliquer (F5)"
=20
-#: gitk:4354
+#: gitk:4373
 msgid "Error in commit selection arguments:"
 msgstr "Erreur dans les arguments de s=C3=A9lection des commits :"
=20
-#: gitk:4409 gitk:4462 gitk:4924 gitk:4938 gitk:6208 gitk:12373 gitk:1=
2374
+#: gitk:4428 gitk:4481 gitk:4943 gitk:4957 gitk:6227 gitk:12410 gitk:1=
2411
 msgid "None"
 msgstr "Aucun"
=20
-#: gitk:5021 gitk:5026
+#: gitk:5040 gitk:5045
 msgid "Descendant"
 msgstr "Descendant"
=20
-#: gitk:5022
+#: gitk:5041
 msgid "Not descendant"
 msgstr "Pas un descendant"
=20
-#: gitk:5029 gitk:5034
+#: gitk:5048 gitk:5053
 msgid "Ancestor"
 msgstr "Anc=C3=AAtre"
=20
-#: gitk:5030
+#: gitk:5049
 msgid "Not ancestor"
 msgstr "Pas un anc=C3=AAtre"
=20
-#: gitk:5324
+#: gitk:5343
 msgid "Local changes checked in to index but not committed"
 msgstr "Modifications locales enregistr=C3=A9es dans l'index mais non =
commit=C3=A9es"
=20
-#: gitk:5360
+#: gitk:5379
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Modifications locales non enregistr=C3=A9es dans l'index et no=
n commit=C3=A9es"
=20
-#: gitk:7134
+#: gitk:7153
 msgid "and many more"
-msgstr ""
+msgstr "et beaucoup plus"
=20
-#: gitk:7137
+#: gitk:7156
 msgid "many"
 msgstr "nombreux"
=20
-#: gitk:7328
+#: gitk:7347
 msgid "Tags:"
 msgstr "Tags :"
=20
-#: gitk:7345 gitk:7351 gitk:8825
+#: gitk:7364 gitk:7370 gitk:8844
 msgid "Parent"
 msgstr "Parent"
=20
-#: gitk:7356
+#: gitk:7375
 msgid "Child"
 msgstr "Enfant"
=20
-#: gitk:7365
+#: gitk:7384
 msgid "Branch"
 msgstr "Branche"
=20
-#: gitk:7368
+#: gitk:7387
 msgid "Follows"
 msgstr "Suit"
=20
-#: gitk:7371
+#: gitk:7390
 msgid "Precedes"
 msgstr "Pr=C3=A9c=C3=A8de"
=20
-#: gitk:7966
+#: gitk:7985
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Erreur lors de la r=C3=A9cup=C3=A9ration des diff : %s"
=20
-#: gitk:8650
+#: gitk:8669
 msgid "Goto:"
 msgstr "Aller =C3=A0 :"
=20
-#: gitk:8671
+#: gitk:8690
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Id SHA1 court %s est ambigu"
=20
-#: gitk:8678
+#: gitk:8697
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Id SHA1 %s est inconnu"
=20
-#: gitk:8688
+#: gitk:8707
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "Id SHA1 %s est inconnu"
=20
-#: gitk:8690
+#: gitk:8709
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "La r=C3=A9vision %s n'est pas dans la vue courante"
=20
-#: gitk:8832 gitk:8847
+#: gitk:8851 gitk:8866
 msgid "Date"
 msgstr "Date"
=20
-#: gitk:8835
+#: gitk:8854
 msgid "Children"
 msgstr "Enfants"
=20
-#: gitk:8898
+#: gitk:8917
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "R=C3=A9initialiser la branche %s vers cet =C3=A9tat"
=20
-#: gitk:8900
+#: gitk:8919
 msgid "Detached head: can't reset"
 msgstr "Head d=C3=A9tach=C3=A9 : impossible de r=C3=A9initialiser"
=20
-#: gitk:9005 gitk:9011
+#: gitk:9024 gitk:9030
 msgid "Skipping merge commit "
 msgstr "=C3=89viter le commit de la fusion "
=20
-#: gitk:9020 gitk:9025
+#: gitk:9039 gitk:9044
 msgid "Error getting patch ID for "
 msgstr "Erreur =C3=A0 l'obtention de l'ID du patch pour "
=20
-#: gitk:9021 gitk:9026
+#: gitk:9040 gitk:9045
 msgid " - stopping\n"
 msgstr " - arr=C3=AAt en cours\n"
=20
-#: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
+#: gitk:9050 gitk:9053 gitk:9061 gitk:9075 gitk:9084
 msgid "Commit "
 msgstr "Commit "
=20
-#: gitk:9035
+#: gitk:9054
 msgid ""
 " is the same patch as\n"
 "       "
@@ -911,7 +912,7 @@ msgstr ""
 "est le m=C3=AAme patch que \n"
 "       "
=20
-#: gitk:9043
+#: gitk:9062
 msgid ""
 " differs from\n"
 "       "
@@ -919,138 +920,137 @@ msgstr ""
 " diff=C3=A8re de\n"
 "       "
=20
-#: gitk:9045
+#: gitk:9064
 msgid ""
 "Diff of commits:\n"
 "\n"
-msgstr ""
+msgstr "Diff des commits=C2=A0:\n\n"
=20
-#: gitk:9057 gitk:9066
+#: gitk:9076 gitk:9085
 #, tcl-format
 msgid " has %s children - stopping\n"
-msgstr "a %s enfants - arr=C3=AAt en cours\n"
+msgstr " a %s enfants - arr=C3=AAt en cours\n"
=20
-#: gitk:9085
-#, fuzzy, tcl-format
+#: gitk:9104
+#, tcl-format
 msgid "Error writing commit to file: %s"
-msgstr "Erreur =C3=A0 l'ecriture du commit :"
+msgstr "Erreur =C3=A0 l'=C3=A9criture du commit dans le fichier : %s"
=20
-#: gitk:9091
-#, fuzzy, tcl-format
+#: gitk:9110
+#, tcl-format
 msgid "Error diffing commits: %s"
-msgstr "Erreur =C3=A0 l'ecriture du commit :"
+msgstr "Erreur =C3=A0 la diff=C3=A9rence des commits : %s"
=20
-#: gitk:9137
+#: gitk:9156
 msgid "Top"
 msgstr "Haut"
=20
-#: gitk:9138
+#: gitk:9157
 msgid "From"
 msgstr "De"
=20
-#: gitk:9143
+#: gitk:9162
 msgid "To"
 msgstr "=C3=80"
=20
-#: gitk:9167
+#: gitk:9186
 msgid "Generate patch"
 msgstr "G=C3=A9n=C3=A9rer le patch"
=20
-#: gitk:9169
+#: gitk:9188
 msgid "From:"
 msgstr "De :"
=20
-#: gitk:9178
+#: gitk:9197
 msgid "To:"
 msgstr "=C3=80 :"
=20
-#: gitk:9187
+#: gitk:9206
 msgid "Reverse"
 msgstr "Inverser"
=20
-#: gitk:9189 gitk:9385
+#: gitk:9208 gitk:9418
 msgid "Output file:"
 msgstr "Fichier de sortie :"
=20
-#: gitk:9195
+#: gitk:9214
 msgid "Generate"
 msgstr "G=C3=A9n=C3=A9rer"
=20
-#: gitk:9233
+#: gitk:9252
 msgid "Error creating patch:"
 msgstr "Erreur =C3=A0 la cr=C3=A9ation du patch :"
=20
-#: gitk:9256 gitk:9373 gitk:9430
+#: gitk:9275 gitk:9406 gitk:9463
 msgid "ID:"
 msgstr "ID :"
=20
-#: gitk:9265
+#: gitk:9284
 msgid "Tag name:"
 msgstr "Nom du Tag :"
=20
-#: gitk:9268
+#: gitk:9287
 msgid "Tag message is optional"
-msgstr ""
+msgstr "Le message du tag est optionnel"
=20
-#: gitk:9270
-#, fuzzy
+#: gitk:9289
 msgid "Tag message:"
-msgstr "Nom du Tag :"
+msgstr "Message du Tag :"
=20
-#: gitk:9274 gitk:9439
+#: gitk:9293 gitk:9472
 msgid "Create"
 msgstr "Cr=C3=A9er"
=20
-#: gitk:9292
+#: gitk:9311
 msgid "No tag name specified"
 msgstr "Aucun nom de tag sp=C3=A9cifi=C3=A9"
=20
-#: gitk:9296
+#: gitk:9315
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Le tag \"%s\" existe d=C3=A9j=C3=A0"
=20
-#: gitk:9306
+#: gitk:9325
 msgid "Error creating tag:"
 msgstr "Erreur =C3=A0 la cr=C3=A9ation du tag :"
=20
-#: gitk:9382
+#: gitk:9415
 msgid "Command:"
 msgstr "Commande :"
=20
-#: gitk:9390
+#: gitk:9423
 msgid "Write"
 msgstr "=C3=89crire"
=20
-#: gitk:9408
+#: gitk:9441
 msgid "Error writing commit:"
 msgstr "Erreur =C3=A0 l'ecriture du commit :"
=20
-#: gitk:9435
+#: gitk:9468
 msgid "Name:"
 msgstr "Nom :"
=20
-#: gitk:9458
+#: gitk:9491
 msgid "Please specify a name for the new branch"
 msgstr "Veuillez sp=C3=A9cifier un nom pour la nouvelle branche"
=20
-#: gitk:9463
+#: gitk:9496
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "La branche '%s' existe d=C3=A9j=C3=A0. =C3=89craser?"
=20
-#: gitk:9530
+#: gitk:9563
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "Le Commit %s est d=C3=A9j=C3=A0 inclus dans la branche %s -- le r=C3=A9=
-appliquer malgr=C3=A9 "
 "tout?"
=20
-#: gitk:9535
+#: gitk:9568
 msgid "Cherry-picking"
 msgstr "Cueillir (Cherry-picking)"
=20
-#: gitk:9544
+#: gitk:9577
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1061,7 +1061,7 @@ msgstr ""
 "Veuillez commiter, r=C3=A9initialiser ou stasher vos changements et e=
ssayer de "
 "nouveau."
=20
-#: gitk:9550
+#: gitk:9583
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1070,67 +1070,58 @@ msgstr ""
 "fusion.\n"
 "Souhaitez-vous ex=C3=A9cuter git citool pour le r=C3=A9soudre ?"
=20
-#: gitk:9566 gitk:9624
+#: gitk:9599 gitk:9657
 msgid "No changes committed"
 msgstr "Aucun changement commit=C3=A9"
=20
-#: gitk:9593
-#, fuzzy, tcl-format
+#: gitk:9626
+#, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr ""
-"Le Commit %s est d=C3=A9j=C3=A0 inclus dans la branche %s -- le r=C3=A9=
-appliquer malgr=C3=A9 "
-"tout?"
+msgstr "Le Commit %s n'est pas inclus dans la branche %s -- le d=C3=A9=
faire malgr=C3=A9 tout?"
=20
-#: gitk:9598
-#, fuzzy
+#: gitk:9631
 msgid "Reverting"
-msgstr "R=C3=A9initialisation"
+msgstr "Commit d=C3=A9fait"
=20
-#: gitk:9606
-#, fuzzy, tcl-format
+#: gitk:9639
+#, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Plea=
se "
 "commit, reset or stash  your changes and try again."
-msgstr ""
-"La cueillette (cherry-pick) a =C3=A9chou=C3=A9e =C3=A0 cause de modif=
ications locales du "
-"fichier '%s'.\n"
-"Veuillez commiter, r=C3=A9initialiser ou stasher vos changements et e=
ssayer de "
-"nouveau."
+msgstr "=C3=89chec en tentant de d=C3=A9faire le commit =C3=A0 cause d=
e modifications locales des fichiers=C2=A0: %s. Veuillez valider, r=C3=A9=
initialiser ou remiser vos modifications et essayer de nouveau."
=20
-#: gitk:9610
-#, fuzzy
+#: gitk:9643
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
 msgstr ""
-"La cueillette (cherry-pick) a =C3=A9chou=C3=A9e =C3=A0 cause d'un con=
flit lors d'une "
-"fusion.\n"
+"=C3=89chec en tentant de d=C3=A9faire =C3=A0 cause d'un conflit de fu=
sion.\n"
 "Souhaitez-vous ex=C3=A9cuter git citool pour le r=C3=A9soudre ?"
=20
-#: gitk:9653
+#: gitk:9686
 msgid "Confirm reset"
 msgstr "Confirmer la r=C3=A9initialisation"
=20
-#: gitk:9655
+#: gitk:9688
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "R=C3=A9initialiser la branche %s =C3=A0 %s?"
=20
-#: gitk:9657
+#: gitk:9690
 msgid "Reset type:"
 msgstr "Type de r=C3=A9initialisation :"
=20
-#: gitk:9660
+#: gitk:9693
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Douce : Laisse le r=C3=A9pertoire de travail et l'index intact=
s"
=20
-#: gitk:9663
+#: gitk:9696
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
 "Hybride : Laisse le r=C3=A9pertoire de travail dans son =C3=A9tat cou=
rant, "
 "r=C3=A9initialise l'index"
=20
-#: gitk:9666
+#: gitk:9699
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1138,21 +1129,20 @@ msgstr ""
 "Dure : R=C3=A9initialise le r=C3=A9pertoire de travail et l'index\n"
 "(abandonne TOUS les changements locaux)"
=20
-#: gitk:9683
+#: gitk:9716
 msgid "Resetting"
 msgstr "R=C3=A9initialisation"
=20
 # Fixme: R=C3=A9cup=C3=A9ration est-il vraiment une mauvaise traductio=
n?
-#: gitk:9743
-#, fuzzy
+#: gitk:9776
 msgid "Checking out"
-msgstr "R=C3=A9cup=C3=A9ration"
+msgstr "Extraction"
=20
-#: gitk:9796
+#: gitk:9829
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Impossible de supprimer la branche en cours"
=20
-#: gitk:9802
+#: gitk:9835
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1161,16 +1151,16 @@ msgstr ""
 "Les commits de la branche %s ne sont dans aucune autre branche.\n"
 "Voulez-vous vraiment supprimer cette branche %s ?"
=20
-#: gitk:9833
+#: gitk:9866
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Tags et heads : %s"
=20
-#: gitk:9850
+#: gitk:9883
 msgid "Filter"
 msgstr "Filtrer"
=20
-#: gitk:10146
+#: gitk:10179
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -1179,207 +1169,202 @@ msgstr ""
 "informations sur les branches et les tags pr=C3=A9c=C3=A9dents/suivan=
ts seront "
 "incompl=C3=A8tes."
=20
-#: gitk:11123
+#: gitk:11156
 msgid "Tag"
 msgstr "Tag"
=20
-#: gitk:11127
+#: gitk:11160
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:11210
+#: gitk:11243
 msgid "Gitk font chooser"
 msgstr "S=C3=A9lecteur de police de Gitk"
=20
-#: gitk:11227
+#: gitk:11260
 msgid "B"
 msgstr "B"
=20
-#: gitk:11230
+#: gitk:11263
 msgid "I"
 msgstr "I"
=20
-#: gitk:11348
+#: gitk:11381
 msgid "Commit list display options"
 msgstr "Options d'affichage de la liste des commits"
=20
-#: gitk:11351
+#: gitk:11384
 msgid "Maximum graph width (lines)"
 msgstr "Longueur maximum du graphe (lignes)"
=20
 # FIXME : Traduction standard de "pane"?
-#: gitk:11355
-#, fuzzy, no-tcl-format
+#: gitk:11388
+#, no-tcl-format
 msgid "Maximum graph width (% of pane)"
-msgstr "Longueur maximum du graphe (% du panneau)"
+msgstr "Largeur maximum du graphe (% du panneau)"
=20
-#: gitk:11358
+#: gitk:11391
 msgid "Show local changes"
 msgstr "Montrer les changements locaux"
=20
-#: gitk:11361
-#, fuzzy
+#: gitk:11394
 msgid "Auto-select SHA1 (length)"
-msgstr "S=C3=A9lection auto. du SHA1"
+msgstr "S=C3=A9lection auto. du SHA1 (longueur)"
=20
-#: gitk:11365
+#: gitk:11398
 msgid "Hide remote refs"
 msgstr "Cacher les refs distantes"
=20
-#: gitk:11369
+#: gitk:11402
 msgid "Diff display options"
 msgstr "Options d'affichage des diff"
=20
-#: gitk:11371
+#: gitk:11404
 msgid "Tab spacing"
 msgstr "Taille des tabulations"
=20
-#: gitk:11374
-#, fuzzy
+#: gitk:11407
 msgid "Display nearby tags/heads"
 msgstr "Afficher les tags les plus proches"
=20
-#: gitk:11377
+#: gitk:11410
 msgid "Maximum # tags/heads to show"
-msgstr ""
+msgstr "Nombre maximum de tags/heads =C3=A0 afficher"
=20
-#: gitk:11380
+#: gitk:11413
 msgid "Limit diffs to listed paths"
 msgstr "Limiter les diff=C3=A9rences aux chemins list=C3=A9s"
=20
-#: gitk:11383
+#: gitk:11416
 msgid "Support per-file encodings"
 msgstr "Support pour un encodage des caract=C3=A8res par fichier"
=20
-#: gitk:11389 gitk:11536
+#: gitk:11422 gitk:11569
 msgid "External diff tool"
 msgstr "Outil diff externe"
=20
-#: gitk:11390
+#: gitk:11423
 msgid "Choose..."
 msgstr "Choisir..."
=20
-#: gitk:11395
-#, fuzzy
+#: gitk:11428
 msgid "General options"
-msgstr "G=C3=A9n=C3=A9rer le patch"
+msgstr "Options g=C3=A9n=C3=A9rales"
=20
-#: gitk:11398
+#: gitk:11431
 msgid "Use themed widgets"
-msgstr ""
+msgstr "Utiliser des widgets en th=C3=A8me"
=20
-#: gitk:11400
+#: gitk:11433
 msgid "(change requires restart)"
-msgstr ""
+msgstr "(la modification n=C3=A9cessite un red=C3=A9marrage)"
=20
-#: gitk:11402
+#: gitk:11435
 msgid "(currently unavailable)"
-msgstr ""
+msgstr "(non disponible actuellement)"
=20
-#: gitk:11413
+#: gitk:11446
 msgid "Colors: press to choose"
 msgstr "Couleurs : cliquer pour choisir"
=20
-#: gitk:11416
+#: gitk:11449
 msgid "Interface"
-msgstr ""
+msgstr "Interface"
=20
-#: gitk:11417
-#, fuzzy
+#: gitk:11450
 msgid "interface"
-msgstr "Police de l'interface utilisateur"
+msgstr "interface"
=20
-#: gitk:11420
+#: gitk:11453
 msgid "Background"
 msgstr "Arri=C3=A8re-plan"
=20
-#: gitk:11421 gitk:11451
+#: gitk:11454 gitk:11484
 msgid "background"
 msgstr "arri=C3=A8re-plan"
=20
-#: gitk:11424
+#: gitk:11457
 msgid "Foreground"
 msgstr "Premier plan"
=20
-#: gitk:11425
+#: gitk:11458
 msgid "foreground"
 msgstr "premier plan"
=20
-#: gitk:11428
+#: gitk:11461
 msgid "Diff: old lines"
 msgstr "Diff : anciennes lignes"
=20
-#: gitk:11429
+#: gitk:11462
 msgid "diff old lines"
 msgstr "diff anciennes lignes"
=20
-#: gitk:11433
+#: gitk:11466
 msgid "Diff: new lines"
 msgstr "Diff : nouvelles lignes"
=20
-#: gitk:11434
+#: gitk:11467
 msgid "diff new lines"
 msgstr "diff nouvelles lignes"
=20
-#: gitk:11438
+#: gitk:11471
 msgid "Diff: hunk header"
 msgstr "Diff : ent=C3=AAte du hunk"
=20
-#: gitk:11440
+#: gitk:11473
 msgid "diff hunk header"
 msgstr "diff : ent=C3=AAte du hunk"
=20
-#: gitk:11444
+#: gitk:11477
 msgid "Marked line bg"
 msgstr "Arri=C3=A8re-plan de la ligne marqu=C3=A9e"
=20
-#: gitk:11446
+#: gitk:11479
 msgid "marked line background"
 msgstr "Arri=C3=A8re-plan de la ligne marqu=C3=A9e"
=20
-#: gitk:11450
+#: gitk:11483
 msgid "Select bg"
 msgstr "S=C3=A9lectionner l'arri=C3=A8re-plan"
=20
-#: gitk:11459
+#: gitk:11492
 msgid "Fonts: press to choose"
 msgstr "Polices : cliquer pour choisir"
=20
-#: gitk:11461
+#: gitk:11494
 msgid "Main font"
 msgstr "Police principale"
=20
-#: gitk:11462
+#: gitk:11495
 msgid "Diff display font"
 msgstr "Police d'affichage des diff"
=20
-#: gitk:11463
+#: gitk:11496
 msgid "User interface font"
 msgstr "Police de l'interface utilisateur"
=20
-#: gitk:11485
+#: gitk:11518
 msgid "Gitk preferences"
 msgstr "Pr=C3=A9f=C3=A9rences de Gitk"
=20
-#: gitk:11494
-#, fuzzy
+#: gitk:11527
 msgid "General"
-msgstr "G=C3=A9n=C3=A9rer"
+msgstr "G=C3=A9n=C3=A9ral"
=20
-#: gitk:11495
+#: gitk:11528
 msgid "Colors"
-msgstr ""
+msgstr "Couleurs"
=20
-#: gitk:11496
+#: gitk:11529
 msgid "Fonts"
-msgstr ""
+msgstr "Polices"
=20
-#: gitk:11546
+#: gitk:11579
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk : choisir la couleur de %s"
=20
-#: gitk:12059
+#: gitk:12092
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1387,16 +1372,16 @@ msgstr ""
 "D=C3=A9sol=C3=A9, gitk ne peut =C3=AAtre ex=C3=A9cut=C3=A9 avec cette=
 version de Tcl/Tk.\n"
 " Gitk requiert Tcl/Tk version 8.4 ou sup=C3=A9rieur."
=20
-#: gitk:12269
+#: gitk:12302
 msgid "Cannot find a git repository here."
 msgstr "Impossible de trouver un d=C3=A9p=C3=B4t git ici."
=20
-#: gitk:12316
+#: gitk:12349
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Argument '%s' ambigu : =C3=A0 la fois une r=C3=A9vision et un =
nom de fichier"
=20
-#: gitk:12328
+#: gitk:12361
 msgid "Bad arguments to gitk:"
 msgstr "Arguments invalides pour gitk :"
=20
--=20
2.7.0.rc3
