From: Cyril Brulebois <kibi@debian.org>
Subject: [PATCH] gitk: Add basic French translation
Date: Thu, 19 Jun 2008 07:08:03 +0200
Message-ID: <1213852083-31418-2-git-send-email-kibi@debian.org>
References: <1213852083-31418-1-git-send-email-kibi@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Cyril Brulebois <kibi@debian.org>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Jun 19 07:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Cbz-0001lI-9O
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 07:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYFSFWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 01:22:14 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYFSFWO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 01:22:14 -0400
Received: from dedibox.ebzao.info ([88.191.19.23]:58132 "EHLO
	dedibox.ebzao.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYFSFWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 01:22:10 -0400
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2008 01:22:09 EDT
Received: from localhost (localhost [127.0.0.1])
	by dedibox.ebzao.info (Postfix) with ESMTP id E7B416A5E;
	Thu, 19 Jun 2008 07:10:06 +0200 (CEST)
Received: from dedibox.ebzao.info ([127.0.0.1])
	by localhost (dedibox.ebzao.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WPOjOJ0rR8t; Thu, 19 Jun 2008 07:10:06 +0200 (CEST)
Received: from evy.ikibiki.org (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by dedibox.ebzao.info (Postfix) with ESMTPS id 6947716ED;
	Thu, 19 Jun 2008 07:10:06 +0200 (CEST)
Received: by evy.ikibiki.org (Postfix, from userid 1000)
	id 7CE03C80B4; Thu, 19 Jun 2008 07:08:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1213852083-31418-1-git-send-email-kibi@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85448>

Signed-off-by: Cyril Brulebois <kibi@debian.org>
---
 po/fr.po |  904 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 904 insertions(+), 0 deletions(-)
 create mode 100644 po/fr.po

diff --git a/po/fr.po b/po/fr.po
new file mode 100644
index 0000000..d37b2eb
--- /dev/null
+++ b/po/fr.po
@@ -0,0 +1,904 @@
+# Translation of gitk
+# This file is distributed under the same license as the gitk package.
+# Copyright =C2=A9 2008 Cyril Brulebois <kibi@debian.org>
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk\n"
+"PO-Revision-Date: 2008-06-19 05:39+0200\n"
+"Last-Translator: Cyril Brulebois <kibi@debian.org>\n"
+"Language-Team: French\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: gitk:102
+msgid "Couldn't get list of unmerged files:"
+msgstr "Impossible d'obtenir la liste des fichiers non fusionn=C3=A9s=C2=
=A0:"
+
+#: gitk:329
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr "Aucun fichier s=C3=A9lectionn=C3=A9=C2=A0: --merge sp=C3=A9cif=
i=C3=A9 mais aucun fichier n=C3=A9cessitant de fusion."
+
+#: gitk:332
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"Aucun fichier s=C3=A9lectionn=C3=A9=C2=A0: --merge sp=C3=A9cifi=C3=A9=
 mais aucun fichier"
+"n=C3=A9cessitant de fusion dans l'ensemble de fichiers sp=C3=A9cifi=C3=
=A9."
+
+#: gitk:354
+msgid "Error executing git log:"
+msgstr ""
+"Erreur pendant l'ex=C3=A9cution de git log=C2=A0:"
+
+#: gitk:369
+msgid "Reading"
+msgstr "Lecture en cours"
+
+#: gitk:400 gitk:3356
+msgid "Reading commits..."
+msgstr "Lecture des commits=E2=80=A6"
+
+#: gitk:403 gitk:1480 gitk:3359
+msgid "No commits selected"
+msgstr "Aucun commit s=C3=A9lectionn=C3=A9"
+
+#: gitk:1358
+msgid "Can't parse git log output:"
+msgstr "Impossible d'analyser la sortie de git log=C2=A0:"
+
+#: gitk:1557
+msgid "No commit information available"
+msgstr "Aucune information de commit disponible"
+
+#: gitk:1654 gitk:1676 gitk:3150 gitk:7620 gitk:9149 gitk:9317
+msgid "OK"
+msgstr "OK"
+
+#: gitk:1678 gitk:3151 gitk:7296 gitk:7367 gitk:7470 gitk:7516 gitk:76=
22
+#: gitk:9150 gitk:9318
+msgid "Cancel"
+msgstr "Annuler"
+
+#: gitk:1716
+msgid "File"
+msgstr "Fichier"
+
+#: gitk:1718
+msgid "Update"
+msgstr "Mise =C3=A0 jour"
+
+#: gitk:1719
+msgid "Reload"
+msgstr "Recharger"
+
+#: gitk:1720
+msgid "Reread references"
+msgstr "Relire les r=C3=A9f=C3=A9rences"
+
+#: gitk:1721
+msgid "List references"
+msgstr "Lister les r=C3=A9f=C3=A9rences"
+
+#: gitk:1722
+msgid "Quit"
+msgstr "Quitter"
+
+#: gitk:1724
+msgid "Edit"
+msgstr "=C3=89diter"
+
+#: gitk:1725
+msgid "Preferences"
+msgstr "Pr=C3=A9f=C3=A9rences"
+
+#: gitk:1728 gitk:3087
+msgid "View"
+msgstr "Visualiser"
+
+#: gitk:1729
+msgid "New view..."
+msgstr "Nouvelle vue=E2=80=A6"
+
+#: gitk:1730 gitk:3298 gitk:9932
+msgid "Edit view..."
+msgstr "=C3=89diter la vue=E2=80=A6"
+
+#: gitk:1732 gitk:3299 gitk:9933
+msgid "Delete view"
+msgstr "Supprimer la vue"
+
+#: gitk:1734
+msgid "All files"
+msgstr "Tous les fichiers"
+
+#: gitk:1738
+msgid "Help"
+msgstr "Aide"
+
+#: gitk:1739 gitk:2399
+msgid "About gitk"
+msgstr "=C3=80 propos de gitk"
+
+#: gitk:1740
+msgid "Key bindings"
+msgstr "Raccourcis clavier"
+
+#: gitk:1797
+msgid "SHA1 ID: "
+msgstr "ID SHA1=C2=A0:"
+
+#: gitk:1828
+msgid "Row"
+msgstr "Ligne"
+
+#: gitk:1859
+msgid "Find"
+msgstr "Chercher"
+
+#: gitk:1860
+msgid "next"
+msgstr "suivant"
+
+#: gitk:1861
+msgid "prev"
+msgstr "pr=C3=A9c=C3=A9dent"
+
+#: gitk:1862
+msgid "commit"
+msgstr "commit"
+
+#: gitk:1865 gitk:1867 gitk:3511 gitk:3534 gitk:3558 gitk:5441 gitk:55=
12
+msgid "containing:"
+msgstr "contenant=C2=A0:"
+
+#: gitk:1868 gitk:2866 gitk:2871 gitk:3586
+msgid "touching paths:"
+msgstr "modifiant les chemins=C2=A0:"
+
+#: gitk:1869 gitk:3591
+msgid "adding/removing string:"
+msgstr "ajoutant/supprimant la cha=C3=AEne=C2=A0:"
+
+#: gitk:1878 gitk:1880
+msgid "Exact"
+msgstr "Exacte"
+
+#: gitk:1880 gitk:3667 gitk:5409
+msgid "IgnCase"
+msgstr "IgnCasse"
+
+#: gitk:1880 gitk:3560 gitk:3665 gitk:5405
+msgid "Regexp"
+msgstr "Regexp"
+
+#: gitk:1882 gitk:1883 gitk:3686 gitk:3716 gitk:3723 gitk:5532 gitk:55=
99
+msgid "All fields"
+msgstr "Tous les champs"
+
+#: gitk:1883 gitk:3684 gitk:3716 gitk:5471
+msgid "Headline"
+msgstr "R=C3=A9sum=C3=A9"
+
+#: gitk:1884 gitk:3684 gitk:5471 gitk:5599 gitk:6000
+msgid "Comments"
+msgstr "Commentaires"
+
+#: gitk:1884 gitk:3684 gitk:3688 gitk:3723 gitk:5471 gitk:5936 gitk:71=
42
+#: gitk:7157
+msgid "Author"
+msgstr "Auteur"
+
+#: gitk:1884 gitk:3684 gitk:5471 gitk:5938
+msgid "Committer"
+msgstr "Committer"
+
+#: gitk:1913
+msgid "Search"
+msgstr "Chercher"
+
+#: gitk:1920
+msgid "Diff"
+msgstr "Diff"
+
+#: gitk:1922
+msgid "Old version"
+msgstr "Ancienne version"
+
+#: gitk:1924
+msgid "New version"
+msgstr "Nouvelle version"
+
+#: gitk:1926
+msgid "Lines of context"
+msgstr "Lignes de contexte"
+
+#: gitk:1936
+msgid "Ignore space change"
+msgstr "Ignorer les modifications d'espace"
+
+#: gitk:1994
+msgid "Patch"
+msgstr "Patch"
+
+#: gitk:1996
+msgid "Tree"
+msgstr "Arbre"
+
+#: gitk:2121 gitk:2136 gitk:7211
+msgid "Diff this -> selected"
+msgstr ""
+
+#: gitk:2123 gitk:2138 gitk:7212
+msgid "Diff selected -> this"
+msgstr ""
+
+#: gitk:2125 gitk:2140 gitk:7213
+msgid "Make patch"
+msgstr "Cr=C3=A9er patch"
+
+#: gitk:2126 gitk:7351
+msgid "Create tag"
+msgstr "Cr=C3=A9er tag"
+
+#: gitk:2127 gitk:7450
+msgid "Write commit to file"
+msgstr ""
+
+#: gitk:2128 gitk:7504
+msgid "Create new branch"
+msgstr "Cr=C3=A9er une nouvelle branch"
+
+#: gitk:2129
+msgid "Cherry-pick this commit"
+msgstr "Cueillir ce commit"
+
+#: gitk:2131
+msgid "Reset HEAD branch to here"
+msgstr "R=C3=A9initialiser la branche HEAD ici"
+
+#: gitk:2147
+msgid "Check out this branch"
+msgstr ""
+
+#: gitk:2149
+msgid "Remove this branch"
+msgstr "Supprimer cette branche"
+
+#: gitk:2155
+msgid "Highlight this too"
+msgstr "Mettre ceci en valeur aussi"
+
+#: gitk:2157
+msgid "Highlight this only"
+msgstr "Mettre ceci en valeur seulement"
+
+#: gitk:2159
+msgid "External diff"
+msgstr "Diff externe"
+
+#: gitk:2400
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - un visualiseur de commits pour git\n"
+"\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Utilisation et redistribution sous les termes de la Licence Publique =
G=C3=A9n=C3=A9rale GNU (=C2=AB=C2=A0GNU General Public License=C2=A0=C2=
=BB)."
+
+#: gitk:2408 gitk:2469 gitk:7799
+msgid "Close"
+msgstr "Fermer"
+
+#: gitk:2427
+msgid "Gitk key bindings"
+msgstr "Raccourcis clavier gitk"
+
+#: gitk:2429
+msgid "Gitk key bindings:"
+msgstr "Raccourcis clavier gitk=C2=A0:"
+
+#: gitk:2431
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tQuitter"
+
+#: gitk:2432
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Home>\t\tAller au premier commit"
+
+#: gitk:2433
+msgid "<End>\t\tMove to last commit"
+msgstr "<End>\t\tAller au dernier commit"
+
+#: gitk:2434
+msgid "<Up>, p, i\tMove up one commit"
+msgstr "<Up>, p, i\tAller au commit pr=C3=A9c=C3=A9dent"
+
+#: gitk:2435
+msgid "<Down>, n, k\tMove down one commit"
+msgstr "<Down>, n, k\tAller au commit suivant"
+
+#: gitk:2436
+msgid "<Left>, z, j\tGo back in history list"
+msgstr "<Left>, z, j\tReculer dans l'historique"
+
+#: gitk:2437
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Right>, x, l\tAvancer dans l'historique"
+
+#: gitk:2438
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr ""
+
+#: gitk:2439
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr ""
+
+#: gitk:2440
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr ""
+
+#: gitk:2441
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr ""
+
+#: gitk:2442
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr ""
+
+#: gitk:2443
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr ""
+
+#: gitk:2444
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr ""
+
+#: gitk:2445
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr ""
+
+#: gitk:2446
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr ""
+
+#: gitk:2447
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr ""
+
+#: gitk:2448
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr ""
+
+#: gitk:2449
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr ""
+
+#: gitk:2450
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr ""
+
+#: gitk:2451
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr ""
+
+#: gitk:2452
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr ""
+
+#: gitk:2453
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr ""
+
+#: gitk:2454
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr ""
+
+#: gitk:2455
+msgid "<Return>\tMove to next find hit"
+msgstr ""
+
+#: gitk:2456
+msgid "/\t\tMove to next find hit, or redo find"
+msgstr ""
+
+#: gitk:2457
+msgid "?\t\tMove to previous find hit"
+msgstr ""
+
+#: gitk:2458
+msgid "f\t\tScroll diff view to next file"
+msgstr ""
+
+#: gitk:2459
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr ""
+
+#: gitk:2460
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr ""
+
+#: gitk:2461
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr ""
+
+#: gitk:2462
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr ""
+
+#: gitk:2463
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr ""
+
+#: gitk:2464
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr ""
+
+#: gitk:2465
+msgid "<F5>\t\tUpdate"
+msgstr ""
+
+#: gitk:3091
+msgid "Gitk view definition"
+msgstr ""
+
+#: gitk:3116
+msgid "Name"
+msgstr "Nom"
+
+#: gitk:3119
+msgid "Remember this view"
+msgstr "Se souvenir de cette vue"
+
+#: gitk:3123
+msgid "Commits to include (arguments to git log):"
+msgstr "Commits =C3=A0 inclure (param=C3=A8tres pour git log)=C2=A0:"
+
+#: gitk:3130
+msgid "Command to generate more commits to include:"
+msgstr ""
+
+#: gitk:3137
+msgid "Enter files and directories to include, one per line:"
+msgstr ""
+
+#: gitk:3184
+msgid "Error in commit selection arguments:"
+msgstr ""
+
+#: gitk:3238 gitk:3290 gitk:3736 gitk:3750 gitk:4951 gitk:9896 gitk:98=
97
+msgid "None"
+msgstr "Aucun"
+
+#: gitk:3684 gitk:5471 gitk:7144 gitk:7159
+msgid "Date"
+msgstr "Date"
+
+#: gitk:3684 gitk:5471
+msgid "CDate"
+msgstr "CDate"
+
+#: gitk:3833 gitk:3838
+msgid "Descendant"
+msgstr "Descendant"
+
+#: gitk:3834
+msgid "Not descendant"
+msgstr "Non descendant"
+
+#: gitk:3841 gitk:3846
+msgid "Ancestor"
+msgstr "Anc=C3=AAtre"
+
+#: gitk:3842
+msgid "Not ancestor"
+msgstr "Non anc=C3=AAtre"
+
+#: gitk:4078
+msgid "Local changes checked in to index but not committed"
+msgstr "Modifications locales enregistr=C3=A9es dans l'index mais non =
committ=C3=A9es"
+
+#: gitk:4111
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "Modifications locales ni committ=C3=A9es ni enregistr=C3=A9es =
dans l'index"
+
+#: gitk:5440
+msgid "Searching"
+msgstr "Recherche en cours"
+
+#: gitk:5940
+msgid "Tags:"
+msgstr "Tags=C2=A0:"
+
+#: gitk:5957 gitk:5963 gitk:7137
+msgid "Parent"
+msgstr "Parent"
+
+#: gitk:5968
+msgid "Child"
+msgstr "Enfant"
+
+#: gitk:5977
+msgid "Branch"
+msgstr "Branche"
+
+#: gitk:5980
+msgid "Follows"
+msgstr "Suit"
+
+#: gitk:5983
+msgid "Precedes"
+msgstr "Pr=C3=A9c=C3=A8de"
+
+#: gitk:6267
+msgid "Error getting merge diffs:"
+msgstr ""
+
+#: gitk:6970
+msgid "Goto:"
+msgstr "Aller =C3=A0=C2=A0:"
+
+#: gitk:6972
+msgid "SHA1 ID:"
+msgstr "ID SHA1=C2=A0:"
+
+#: gitk:6991
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "L'ID SHA1 court %s est ambigu"
+
+#: gitk:7003
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "L'ID SHA1 %s est inconnu"
+
+#: gitk:7005
+#, tcl-format
+msgid "Tag/Head %s is not known"
+msgstr "Tag/Head %s est inconnu"
+
+#: gitk:7147
+msgid "Children"
+msgstr "Enfants"
+
+#: gitk:7204
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "R=C3=A9initialiser la branche %s ici"
+
+#: gitk:7206
+msgid "Detached head: can't reset"
+msgstr "Head d=C3=A9tach=C3=A9e=C2=A0: impossible de r=C3=A9initialise=
r"
+
+#: gitk:7238
+msgid "Top"
+msgstr ""
+
+#: gitk:7239
+msgid "From"
+msgstr "De"
+
+#: gitk:7244
+msgid "To"
+msgstr "=C3=80"
+
+#: gitk:7267
+msgid "Generate patch"
+msgstr "G=C3=A9n=C3=A9er patch"
+
+#: gitk:7269
+msgid "From:"
+msgstr "De=C2=A0:"
+
+#: gitk:7278
+msgid "To:"
+msgstr "=C3=80=C2=A0:"
+
+#: gitk:7287
+#, fuzzy
+msgid "Reverse"
+msgstr "Invers=C3=A9"
+
+#: gitk:7289 gitk:7464
+msgid "Output file:"
+msgstr "Fichier de sortie=C2=A0:"
+
+#: gitk:7295
+msgid "Generate"
+msgstr "G=C3=A9n=C3=A9rer"
+
+#: gitk:7331
+msgid "Error creating patch:"
+msgstr "Erreur =C3=A0 la cr=C3=A9ation du patch=C2=A0:"
+
+#: gitk:7353 gitk:7452 gitk:7506
+msgid "ID:"
+msgstr "ID=C2=A0:"
+
+#: gitk:7362
+msgid "Tag name:"
+msgstr "Nom du tag=C2=A0:"
+
+#: gitk:7366 gitk:7515
+msgid "Create"
+msgstr "Cr=C3=A9er"
+
+#: gitk:7381
+msgid "No tag name specified"
+msgstr "Aucun nom de tag sp=C3=A9cifi=C3=A9"
+
+#: gitk:7385
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "Tag =C2=AB=C2=A0%s=C2=A0=C2=BB d=C3=A9j=C3=A0 existant"
+
+#: gitk:7391
+msgid "Error creating tag:"
+msgstr "Erreur =C3=A0 la cr=C3=A9ation du tag=C2=A0:"
+
+#: gitk:7461
+msgid "Command:"
+msgstr "Commande=C2=A0:"
+
+#: gitk:7469
+msgid "Write"
+msgstr "=C3=89crire"
+
+#: gitk:7485
+msgid "Error writing commit:"
+msgstr "Erreur =C3=A0 la cr=C3=A9ation du commit=C2=A0:"
+
+#: gitk:7511
+msgid "Name:"
+msgstr "Nom=C2=A0:"
+
+#: gitk:7530
+msgid "Please specify a name for the new branch"
+msgstr "Veuillez sp=C3=A9cifier un nom pour la nouvelle branche"
+
+#: gitk:7559
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr "Commit %s d=C3=A9j=C3=A0 inclu dans la branche %s =E2=80=94 l'=
appliquer =C3=A0 nouveau=C2=A0?"
+
+#: gitk:7564
+msgid "Cherry-picking"
+msgstr "Cueillette (=C2=AB=C2=A0cherry-picking=C2=A0=C2=BB)"
+
+#: gitk:7576
+msgid "No changes committed"
+msgstr "Aucun changement committ=C3=A9"
+
+#: gitk:7601
+msgid "Confirm reset"
+msgstr "Confirmer la r=C3=A9initialisation"
+
+#: gitk:7603
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "R=C3=A9initialiser la branche %s =C3=A0 %s=C2=A0?"
+
+#: gitk:7607
+msgid "Reset type:"
+msgstr "Type de r=C3=A9initialisation=C2=A0:"
+
+#: gitk:7611
+msgid "Soft: Leave working tree and index untouched"
+msgstr ""
+
+#: gitk:7614
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr ""
+
+#: gitk:7617
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+
+#: gitk:7633
+msgid "Resetting"
+msgstr "R=C3=A9initialisation en cours"
+
+#: gitk:7690
+msgid "Checking out"
+msgstr ""
+
+#: gitk:7741
+msgid "Cannot delete the currently checked-out branch"
+msgstr ""
+
+#: gitk:7747
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+
+#: gitk:7778
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Tags et heads=C2=A0: %s"
+
+#: gitk:7792
+msgid "Filter"
+msgstr ""
+
+#: gitk:8086
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+
+#: gitk:9072
+msgid "Tag"
+msgstr "Tag"
+
+#: gitk:9072
+msgid "Id"
+msgstr "ID"
+
+#: gitk:9118
+msgid "Gitk font chooser"
+msgstr "S=C3=A9lection de police gitk"
+
+#: gitk:9135
+msgid "B"
+msgstr "B"
+
+#: gitk:9138
+msgid "I"
+msgstr "I"
+
+#: gitk:9231
+msgid "Gitk preferences"
+msgstr "Pr=C3=A9f=C3=A9rences gitk"
+
+#: gitk:9232
+msgid "Commit list display options"
+msgstr ""
+
+#: gitk:9235
+msgid "Maximum graph width (lines)"
+msgstr "Largeur maximale du graphe (lignes)"
+
+#: gitk:9239
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "Largeur maximale du graphe (% du panneau)"
+
+#: gitk:9244
+msgid "Show local changes"
+msgstr "Montrer les modifications locales"
+
+#: gitk:9249
+msgid "Auto-select SHA1"
+msgstr "S=C3=A9lection de SHA1 automatique"
+
+#: gitk:9254
+msgid "Diff display options"
+msgstr "Options d'affichage de diff"
+
+#: gitk:9256
+msgid "Tab spacing"
+msgstr "Espacement des tabulations"
+
+#: gitk:9260
+msgid "Display nearby tags"
+msgstr "Afficher les tags proches"
+
+#: gitk:9265
+msgid "Limit diffs to listed paths"
+msgstr "Limiter les diffs aux chemins sp=C3=A9cifi=C3=A9s"
+
+#: gitk:9272
+msgid "External diff tool"
+msgstr "Outil diff externe"
+
+#: gitk:9274
+msgid "Choose..."
+msgstr "S=C3=A9lectionner=E2=80=A6"
+
+#: gitk:9279
+msgid "Colors: press to choose"
+msgstr "Couleurs=C2=A0: cliquer pour choisir"
+
+#: gitk:9282
+msgid "Background"
+msgstr "Arri=C3=A8re-plan"
+
+#: gitk:9286
+msgid "Foreground"
+msgstr "Avant-plan"
+
+#: gitk:9290
+msgid "Diff: old lines"
+msgstr "Diff=C2=A0: anciennes lignes"
+
+#: gitk:9295
+msgid "Diff: new lines"
+msgstr "Diff=C2=A0: nouvelles lignes"
+
+#: gitk:9300
+#, fuzzy
+msgid "Diff: hunk header"
+msgstr "Diff=C2=A0: ent=C3=AAte de hunk"
+
+#: gitk:9306
+msgid "Select bg"
+msgstr "S=C3=A9lectionner arri=C3=A8re-plan"
+
+#: gitk:9310
+msgid "Fonts: press to choose"
+msgstr "Polices=C2=A0: cliquer pour choisir"
+
+#: gitk:9312
+msgid "Main font"
+msgstr "Police principale"
+
+#: gitk:9313
+msgid "Diff display font"
+msgstr "Police d'affichage de diff"
+
+#: gitk:9314
+msgid "User interface font"
+msgstr "Police de l'interface utilisateur"
+
+#: gitk:9339
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk=C2=A0: s=C3=A9lectionner la couleur pour %s"
+
+#: gitk:9720
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+"D=C3=A9sol=C3=A9, gitk ne peut fonctionner avec cette version de Tcl/=
Tk.\n"
+" Gitk n=C3=A9cessite au moins Tcl/Tk 8.4."
+
+#: gitk:9812
+msgid "Cannot find a git repository here."
+msgstr "Impossible de trouver un d=C3=A9p=C3=B4t git ici."
+
+#: gitk:9816
+#, tcl-format
+msgid "Cannot find the git directory \"%s\"."
+msgstr "Impossible de trouver le r=C3=A9pertoire git =C2=AB=C2=A0%s=C2=
=A0=C2=BB."
+
+#: gitk:9853
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "Param=C3=A8tre =C2=AB=C2=A0%s=C2=A0=C2=BB ambigu=C2=A0: =C3=A0=
 la fois une r=C3=A9vision et un nom de fichier"
+
+#: gitk:9865
+msgid "Bad arguments to gitk:"
+msgstr "Mauvais param=C3=A8tres pour gitk=C2=A0:"
+
+#: gitk:9925
+msgid "Command line"
+msgstr "Ligne de commande"
--=20
1.5.5.4
