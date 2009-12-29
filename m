From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [RESEND PATCH] french translation of gitk
Date: Tue, 29 Dec 2009 23:39:39 +0100
Message-ID: <20091229223758.GB12965@vidovic>
References: <20091202112403.52abcd75@eleanor> <c558c59b3fe779e8577fe06233d3da5d2711127f.1259795550.git.ni.s@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Emmanuel Trillaud <etrillaud@gmail.com>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Guy Brand <gb@unistra.fr>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 23:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPkjL-00044N-Pp
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 23:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZL2Wju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 17:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZL2Wjt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 17:39:49 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:61181 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZL2Wjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 17:39:47 -0500
Received: by ewy19 with SMTP id 19so3186450ewy.21
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1rrjlVJ0pKkXoGKghJB1+1OWQiSjtEMnp4C98LrIZQY=;
        b=e3ZgLUad8XfCUSWrfx+zivFM3oU58lggLTbugGp+wFr4CuGifiGbTjoW8kbPWID894
         vcZqw0Aq2b7ya/2f7eWg+dYxUbi7dMvAzxjhqtoNfzbbU2SXzu8TTzfxeznQHkhDAu+9
         YRALdP/33gVbVhYdUvVljBmgAkY6CARFoi83Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NMSj5dhL9qYJmcbYdGh5ZNdImrYb/M/GBOwBARaBzz28Y3uwq0ivAG5MRWYP2eMtNK
         h9FvLtxdclJTVJV5PDg1sZsRLpxBVKtinVZefTzLdbj9GMw8QxHNulx0YSv+awa7t7kY
         mdOiDmF3Tw/UxlivDGyGo5n0KQy8CF5iBmFeY=
Received: by 10.213.43.67 with SMTP id v3mr6464158ebe.4.1262126385463;
        Tue, 29 Dec 2009 14:39:45 -0800 (PST)
Received: from @ (83-154-173-109.rev.libertysurf.net [83.154.173.109])
        by mx.google.com with ESMTPS id 16sm9157272ewy.6.2009.12.29.14.39.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 14:39:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c558c59b3fe779e8577fe06233d3da5d2711127f.1259795550.git.ni.s@laposte.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135842>

Hi,

I may be wrong but I think this patch wasn't merged and I didn't see an=
y
comment on it.

Could you please merge this patch?


-- >8 --
Subject: [PATCH] gitk: french translation
=46rom: Emmanuel Trillaud <etrillaud@gmail.com>

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
Signed-off-by: Thomas Moulard <thomas.moulard@gmail.com>
Signed-off-by: Guy Brand <gb@unistra.fr>
Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

 po/fr.po | 1254 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 1254 insertions(+), 0 deletions(-)
 create mode 100644 po/fr.po

diff --git a/po/fr.po b/po/fr.po
new file mode 100644
index 0000000..99d198e
--- /dev/null
+++ b/po/fr.po
@@ -0,0 +1,1254 @@
+# French translation of the gitk package
+# Copyright (C) 2005-2008 Paul Mackerras.  All rights reserved.
+# This file is distributed under the same license as the gitk package.
+# Translators:
+# Emmanuel Trillaud <etrillaud@gmail.com>
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2009-10-05 15:16+0200\n"
+"PO-Revision-Date: 2009-11-19 22:13+0100\n"
+"Last-Translator: Emmanuel Trillaud <etrillaud@gmail.com>\n"
+"Language-Team: git@vger.kernel.org\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Poedit-Language: French\n"
+"X-Poedit-Country: FRANCE\n"
+
+#: gitk:113
+msgid "Couldn't get list of unmerged files:"
+msgstr "Impossible de r=E9cup=E9rer la liste des fichiers non fusionn=E9=
s :"
+
+#: gitk:269
+msgid "Error parsing revisions:"
+msgstr "Erreur lors du parcours des r=E9visions :"
+
+#: gitk:324
+msgid "Error executing --argscmd command:"
+msgstr "Erreur =E0 l'ex=E9cution de la commande --argscmd :"
+
+#: gitk:337
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"Aucun fichier s=E9lectionn=E9 : --merge pr=E9cis=E9, mais tous lesfic=
hiers sont "
+"fusionn=E9s."
+
+# FIXME : am=E9liorer la traduction de 'file limite'
+#: gitk:340
+#, fuzzy
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"Aucun fichier s=E9lectionn=E9 : --merge pr=E9cis=E9 mais aucun fichie=
r non fusionn=E9 "
+"n'est dans la limite des fichiers."
+
+#: gitk:362 gitk:509
+msgid "Error executing git log:"
+msgstr "Erreur =E0 l'ex=E9cution de git log :"
+
+#: gitk:380 gitk:525
+msgid "Reading"
+msgstr "Lecture en cours"
+
+#: gitk:440 gitk:4123
+msgid "Reading commits..."
+msgstr "Lecture des commits..."
+
+#: gitk:443 gitk:1561 gitk:4126
+msgid "No commits selected"
+msgstr "Aucun commit s=E9lectionn=E9"
+
+#: gitk:1437
+msgid "Can't parse git log output:"
+msgstr "Impossible de lire la sortie de git log :"
+
+#: gitk:1657
+msgid "No commit information available"
+msgstr "Aucune information disponible sur le commit"
+
+#: gitk:1793 gitk:1817 gitk:3916 gitk:8786 gitk:10322 gitk:10498
+msgid "OK"
+msgstr "OK"
+
+#: gitk:1819 gitk:3918 gitk:8383 gitk:8457 gitk:8567 gitk:8616 gitk:87=
88
+#: gitk:10323 gitk:10499
+msgid "Cancel"
+msgstr "Annuler"
+
+#: gitk:1919
+msgid "Update"
+msgstr "Mise =E0 jour"
+
+#: gitk:1920
+msgid "Reload"
+msgstr "Recharger"
+
+#: gitk:1921
+msgid "Reread references"
+msgstr "Relire les r=E9f=E9rences"
+
+#: gitk:1922
+msgid "List references"
+msgstr "Lister les r=E9f=E9rences"
+
+#: gitk:1924
+msgid "Start git gui"
+msgstr "D=E9marrer git gui"
+
+#: gitk:1926
+msgid "Quit"
+msgstr "Quitter"
+
+#: gitk:1918
+msgid "File"
+msgstr "Fichier"
+
+#: gitk:1930
+msgid "Preferences"
+msgstr "Pr=E9f=E9rences"
+
+#: gitk:1929
+msgid "Edit"
+msgstr "=C9diter"
+
+#: gitk:1934
+msgid "New view..."
+msgstr "Nouvelle vue..."
+
+#: gitk:1935
+msgid "Edit view..."
+msgstr "=C9diter la vue..."
+
+#: gitk:1936
+msgid "Delete view"
+msgstr "Supprimer la vue"
+
+#: gitk:1938
+msgid "All files"
+msgstr "Tous les fichiers"
+
+#: gitk:1933 gitk:3670
+msgid "View"
+msgstr "Vue"
+
+#: gitk:1943 gitk:1953 gitk:2654
+msgid "About gitk"
+msgstr "=C0 propos de gitk"
+
+#: gitk:1944 gitk:1958
+msgid "Key bindings"
+msgstr "Raccourcis clavier"
+
+#: gitk:1942 gitk:1957
+msgid "Help"
+msgstr "Aide"
+
+#: gitk:2018
+msgid "SHA1 ID: "
+msgstr "ID SHA1 :"
+
+#: gitk:2049
+msgid "Row"
+msgstr "Colonne"
+
+#: gitk:2080
+msgid "Find"
+msgstr "Recherche"
+
+#: gitk:2081
+msgid "next"
+msgstr "suivant"
+
+#: gitk:2082
+msgid "prev"
+msgstr "pr=E9c=E9dent"
+
+#: gitk:2083
+msgid "commit"
+msgstr "commit"
+
+#: gitk:2086 gitk:2088 gitk:4284 gitk:4307 gitk:4331 gitk:6272 gitk:63=
44
+#: gitk:6428
+msgid "containing:"
+msgstr "contient :"
+
+#: gitk:2089 gitk:3162 gitk:3167 gitk:4359
+msgid "touching paths:"
+msgstr "chemins modifi=E9s :"
+
+#: gitk:2090 gitk:4364
+msgid "adding/removing string:"
+msgstr "ajoute/supprime la cha=EEne :"
+
+#: gitk:2099 gitk:2101
+msgid "Exact"
+msgstr "Exact"
+
+#: gitk:2101 gitk:4439 gitk:6240
+msgid "IgnCase"
+msgstr "Ignorer la casse"
+
+#: gitk:2101 gitk:4333 gitk:4437 gitk:6236
+msgid "Regexp"
+msgstr "Expression r=E9guli=E8re"
+
+#: gitk:2103 gitk:2104 gitk:4458 gitk:4488 gitk:4495 gitk:6364 gitk:64=
32
+msgid "All fields"
+msgstr "Tous les champs"
+
+#: gitk:2104 gitk:4456 gitk:4488 gitk:6303
+msgid "Headline"
+msgstr "Surligner"
+
+#: gitk:2105 gitk:4456 gitk:6303 gitk:6432 gitk:6866
+msgid "Comments"
+msgstr "Commentaires"
+
+#: gitk:2105 gitk:4456 gitk:4460 gitk:4495 gitk:6303 gitk:6801 gitk:80=
63
+#: gitk:8078
+msgid "Author"
+msgstr "Auteur"
+
+#: gitk:2105 gitk:4456 gitk:6303 gitk:6803
+msgid "Committer"
+msgstr "Auteur du commit"
+
+#: gitk:2134
+msgid "Search"
+msgstr "Rechercher"
+
+#: gitk:2141
+msgid "Diff"
+msgstr "Diff"
+
+#: gitk:2143
+msgid "Old version"
+msgstr "Ancienne version"
+
+#: gitk:2145
+msgid "New version"
+msgstr "Nouvelle version"
+
+#: gitk:2147
+msgid "Lines of context"
+msgstr "Lignes de contexte"
+
+#: gitk:2157
+msgid "Ignore space change"
+msgstr "Ignorer les modifications d'espace"
+
+#: gitk:2215
+msgid "Patch"
+msgstr "Patch"
+
+#: gitk:2217
+msgid "Tree"
+msgstr "Arbre"
+
+#: gitk:2361 gitk:2378
+msgid "Diff this -> selected"
+msgstr "Diff entre ceci et la s=E9lection"
+
+#: gitk:2362 gitk:2379
+msgid "Diff selected -> this"
+msgstr "Diff entre s=E9lection et ceci"
+
+#: gitk:2363 gitk:2380
+msgid "Make patch"
+msgstr "Cr=E9er patch"
+
+#: gitk:2364 gitk:8441
+msgid "Create tag"
+msgstr "Cr=E9er tag"
+
+#: gitk:2365 gitk:8547
+msgid "Write commit to file"
+msgstr "=C9crire le commit dans un fichier"
+
+#: gitk:2366 gitk:8604
+msgid "Create new branch"
+msgstr "Cr=E9er une nouvelle branche"
+
+#: gitk:2367
+msgid "Cherry-pick this commit"
+msgstr "Cueillir (cherry-pick) ce commit"
+
+#: gitk:2368
+msgid "Reset HEAD branch to here"
+msgstr "R=E9initialiser la branche HEAD vers cet =E9tat"
+
+#: gitk:2369
+msgid "Mark this commit"
+msgstr "Marquer ce commit"
+
+#: gitk:2370
+msgid "Return to mark"
+msgstr "Retourner =E0 la marque"
+
+#: gitk:2371
+msgid "Find descendant of this and mark"
+msgstr "Chercher le descendant de ceci et le marquer"
+
+#: gitk:2372
+msgid "Compare with marked commit"
+msgstr "Comparer avec le commit marqu=E9"
+
+#: gitk:2386
+msgid "Check out this branch"
+msgstr "R=E9cup=E9rer cette branche"
+
+#: gitk:2387
+msgid "Remove this branch"
+msgstr "Supprimer cette branche"
+
+#: gitk:2394
+msgid "Highlight this too"
+msgstr "Surligner =E9galement ceci"
+
+#: gitk:2395
+msgid "Highlight this only"
+msgstr "Surligner seulement ceci"
+
+#: gitk:2396
+msgid "External diff"
+msgstr "Diff externe"
+
+#: gitk:2397
+msgid "Blame parent commit"
+msgstr "Bl=E2mer le commit parent"
+
+#: gitk:2404
+msgid "Show origin of this line"
+msgstr "Montrer l'origine de cette ligne"
+
+#: gitk:2405
+msgid "Run git gui blame on this line"
+msgstr "Ex=E9cuter git gui blame sur cette ligne"
+
+#: gitk:2656
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - visualisateur de commit pour git\n"
+"\n"
+"Copyright =A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Utilisation et redistribution soumises aux termes de la GNU General P=
ublic "
+"License"
+
+#: gitk:2664 gitk:2726 gitk:8969
+msgid "Close"
+msgstr "Fermer"
+
+#: gitk:2683
+msgid "Gitk key bindings"
+msgstr "Raccourcis clavier de Gitk"
+
+#: gitk:2686
+msgid "Gitk key bindings:"
+msgstr "Raccourcis clavier de Gitk :"
+
+#: gitk:2688
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tQuitter"
+
+#: gitk:2689
+msgid "<Home>\t\tMove to first commit"
+msgstr "<D=E9but>\t\tAller au premier commit"
+
+#: gitk:2690
+msgid "<End>\t\tMove to last commit"
+msgstr "<Fin>\t\tAller au dernier commit"
+
+#: gitk:2691
+msgid "<Up>, p, i\tMove up one commit"
+msgstr "<Haut>, p, i\t Aller au commit suivant"
+
+#: gitk:2692
+msgid "<Down>, n, k\tMove down one commit"
+msgstr "<Bas>, n, k\t Aller au commit pr=E9c=E9dent"
+
+#: gitk:2693
+msgid "<Left>, z, j\tGo back in history list"
+msgstr "<Gauche>, z, j\tReculer dans l'historique"
+
+#: gitk:2694
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Droite>, x, l\tAvancer dans l'historique"
+
+#: gitk:2695
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<PageUp>\tMonter d'une page dans la liste des commits"
+
+#: gitk:2696
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<PageDown>\tDescendre d'une page dans la liste des commits"
+
+#: gitk:2697
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-D=E9but>\tAller en haut de la liste des commits"
+
+#: gitk:2698
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-End>\tAller en bas de la liste des commits"
+
+#: gitk:2699
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Up>\tMonter d'une ligne dans la liste des commits"
+
+#: gitk:2700
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Down>\tDescendre d'une ligne dans la liste des commits"
+
+#: gitk:2701
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-PageUp>\tMonter d'une page dans la liste des commits"
+
+#: gitk:2702
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-PageDown>\tDescendre d'une page dans la liste des commits"
+
+#: gitk:2703
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr ""
+"<Shift-Up>\tRecherche en arri=E8re (vers l'avant, commits les plus an=
ciens)"
+
+#: gitk:2704
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr ""
+"<Shift-Down>\tRecherche en avant (vers l'arri=E8re, commit les plus r=
=E9cents)"
+
+#: gitk:2705
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Supprimer>, b\tMonter d'une page dans la vue des diff"
+
+#: gitk:2706
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Backspace>\tMonter d'une page dans la vue des diff"
+
+#: gitk:2707
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Espace>\t\tDescendre d'une page dans la vue des diff"
+
+#: gitk:2708
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\tMonter de 18 lignes dans la vue des diff"
+
+#: gitk:2709
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\tDescendre de 18 lignes dans la vue des diff"
+
+#: gitk:2710
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tRechercher"
+
+#: gitk:2711
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tAller au r=E9sultat de recherche suivant"
+
+#: gitk:2712
+msgid "<Return>\tMove to next find hit"
+msgstr "<Return>\t\tAller au r=E9sultat de recherche suivant"
+
+#: gitk:2713
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tFocus sur la zone de recherche"
+
+#: gitk:2714
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tAller au r=E9sultat de recherche pr=E9c=E9dent"
+
+#: gitk:2715
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tAller au prochain fichier dans la vue des diff"
+
+#: gitk:2716
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tAller au r=E9sultat suivant dans la vue des diff"
+
+#: gitk:2717
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tAller au r=E9sultat pr=E9c=E9dent dans la vue des di=
ff"
+
+#: gitk:2718
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\tAugmenter la taille de la police"
+
+#: gitk:2719
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-plus>\tAugmenter la taille de la police"
+
+#: gitk:2720
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\tDiminuer la taille de la police"
+
+#: gitk:2721
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-minus>\tDiminuer la taille de la police"
+
+#: gitk:2722
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tMise =E0 jour"
+
+#: gitk:3177
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Erreur en obtenant \"%s\" de %s:"
+
+#: gitk:3234 gitk:3243
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Erreur lors de la cr=E9ation du r=E9pertoire temporaire %s :"
+
+#: gitk:3255
+msgid "command failed:"
+msgstr "=E9chec de la commande :"
+
+#: gitk:3401
+msgid "No such commit"
+msgstr "Commit inexistant"
+
+#: gitk:3415
+msgid "git gui blame: command failed:"
+msgstr "git gui blame : =E9chec de la commande :"
+
+#: gitk:3446
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "Impossible de lire le head de la fusion : %s"
+
+#: gitk:3454
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Erreur =E0 la lecture de l'index : %s"
+
+#: gitk:3479
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "Impossible de d=E9marrer git blame : %s"
+
+#: gitk:3482 gitk:6271
+msgid "Searching"
+msgstr "Recherche en cours"
+
+#: gitk:3514
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Erreur =E0 l'ex=E9cution de git blame : %s"
+
+#: gitk:3542
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr "Cette ligne est issue du commit %s, qui n'est pas dans cette v=
ue"
+
+#: gitk:3556
+msgid "External diff viewer failed:"
+msgstr "=C9chec de l'outil externe de visualisation des diff"
+
+#: gitk:3674
+msgid "Gitk view definition"
+msgstr "D=E9finition des vues de Gitk"
+
+#: gitk:3678
+msgid "Remember this view"
+msgstr "Se souvenir de cette vue"
+
+#: gitk:3679
+msgid "References (space separated list):"
+msgstr "R=E9f=E9rences (liste d'=E9l=E9ments s=E9par=E9s par des espac=
es) :"
+
+#: gitk:3680
+msgid "Branches & tags:"
+msgstr "Branches & tags :"
+
+#: gitk:3681
+msgid "All refs"
+msgstr "Toutes les r=E9f=E9rences"
+
+#: gitk:3682
+msgid "All (local) branches"
+msgstr "Toutes les branches (locales)"
+
+#: gitk:3683
+msgid "All tags"
+msgstr "Tous les tags"
+
+#: gitk:3684
+msgid "All remote-tracking branches"
+msgstr "Toutes les branches de suivi =E0 distance"
+
+#: gitk:3685
+msgid "Commit Info (regular expressions):"
+msgstr "Info sur les commits (expressions r=E9guli=E8res) :"
+
+#: gitk:3686
+msgid "Author:"
+msgstr "Auteur :"
+
+#: gitk:3687
+msgid "Committer:"
+msgstr "Commiteur :"
+
+#: gitk:3688
+msgid "Commit Message:"
+msgstr "Message de commit :"
+
+#: gitk:3689
+msgid "Matches all Commit Info criteria"
+msgstr "Correspond =E0 tous les crit=E8res d'Info sur les commits"
+
+#: gitk:3690
+msgid "Changes to Files:"
+msgstr "Changements des fichiers :"
+
+#: gitk:3691
+msgid "Fixed String"
+msgstr "Cha=EEne Fig=E9e"
+
+#: gitk:3692
+msgid "Regular Expression"
+msgstr "Expression R=E9guli=E8re"
+
+#: gitk:3693
+msgid "Search string:"
+msgstr "Recherche de la cha=EEne :"
+
+#: gitk:3694
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Dates des commits (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March =
17, "
+"2009 15:27:38\") :"
+
+#: gitk:3695
+msgid "Since:"
+msgstr "De :"
+
+#: gitk:3696
+msgid "Until:"
+msgstr "Jusqu'au :"
+
+#: gitk:3697
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Limiter et/ou sauter un certain nombre (entier positif) de r=E9=
visions :"
+
+#: gitk:3698
+msgid "Number to show:"
+msgstr "Nombre =E0 afficher :"
+
+#: gitk:3699
+msgid "Number to skip:"
+msgstr "Nombre =E0 sauter :"
+
+#: gitk:3700
+msgid "Miscellaneous options:"
+msgstr "Options diverses :"
+
+#: gitk:3701
+msgid "Strictly sort by date"
+msgstr "Trier par date"
+
+# FIXME : traduction de "branch sides"
+#: gitk:3702
+#, fuzzy
+msgid "Mark branch sides"
+msgstr "Marquer les extr=E9mit=E9s des branches"
+
+#: gitk:3703
+msgid "Limit to first parent"
+msgstr "Limiter au premier anc=EAtre"
+
+#: gitk:3704
+msgid "Simple history"
+msgstr "Historique simple"
+
+#: gitk:3705
+msgid "Additional arguments to git log:"
+msgstr "Arguments suppl=E9mentaires de git log :"
+
+#: gitk:3706
+msgid "Enter files and directories to include, one per line:"
+msgstr "Saisir les fichiers et r=E9pertoires =E0 inclure, un par ligne=
 :"
+
+#: gitk:3707
+msgid "Command to generate more commits to include:"
+msgstr "Commande pour g=E9n=E9rer plus de commits =E0 inclure :"
+
+#: gitk:3829
+msgid "Gitk: edit view"
+msgstr "Gitk : =E9diter la vue"
+
+#: gitk:3837
+msgid "-- criteria for selecting revisions"
+msgstr "-- crit=E8re pour la s=E9lection des r=E9visions"
+
+#: gitk:3842
+msgid "View Name:"
+msgstr "Nom de la vue :"
+
+#: gitk:3917
+msgid "Apply (F5)"
+msgstr "Appliquer (F5)"
+
+#: gitk:3955
+msgid "Error in commit selection arguments:"
+msgstr "Erreur dans les arguments de s=E9lection des commits :"
+
+#: gitk:4008 gitk:4060 gitk:4508 gitk:4522 gitk:5783 gitk:11196 gitk:1=
1197
+msgid "None"
+msgstr "Aucun"
+
+#: gitk:4456 gitk:6303 gitk:8065 gitk:8080
+msgid "Date"
+msgstr "Date"
+
+#: gitk:4456 gitk:6303
+msgid "CDate"
+msgstr "CDate"
+
+#: gitk:4605 gitk:4610
+msgid "Descendant"
+msgstr "Descendant"
+
+#: gitk:4606
+msgid "Not descendant"
+msgstr "Pas un descendant"
+
+#: gitk:4613 gitk:4618
+msgid "Ancestor"
+msgstr "Anc=EAtre"
+
+#: gitk:4614
+msgid "Not ancestor"
+msgstr "Pas un anc=EAtre"
+
+#: gitk:4904
+msgid "Local changes checked in to index but not committed"
+msgstr "Modifications locales enregistr=E9es dans l'index mais non com=
mit=E9es"
+
+#: gitk:4940
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "Modifications locales non enregistr=E9es dans l'index et non c=
ommit=E9es"
+
+#: gitk:6621
+msgid "many"
+msgstr "nombreux"
+
+#: gitk:6805
+msgid "Tags:"
+msgstr "Tags :"
+
+#: gitk:6822 gitk:6828 gitk:8058
+msgid "Parent"
+msgstr "Parent"
+
+#: gitk:6833
+msgid "Child"
+msgstr "Enfant"
+
+#: gitk:6842
+msgid "Branch"
+msgstr "Branche"
+
+#: gitk:6845
+msgid "Follows"
+msgstr "Suit"
+
+#: gitk:6848
+msgid "Precedes"
+msgstr "Pr=E9c=E8de"
+
+#: gitk:7346
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Erreur lors de la r=E9cup=E9ration des diff : %s"
+
+#: gitk:7886
+msgid "Goto:"
+msgstr "Aller =E0 :"
+
+#: gitk:7888
+msgid "SHA1 ID:"
+msgstr "Id SHA1 :"
+
+#: gitk:7907
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "Id SHA1 court %s est ambigu"
+
+#: gitk:7914
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "Id SHA1 %s est inconnu"
+
+#: gitk:7924
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "Id SHA1 %s est inconnu"
+
+#: gitk:7926
+#, tcl-format
+msgid "Revision %s is not in the current view"
+msgstr "La r=E9vision %s n'est pas dans la vue courante"
+
+#: gitk:8068
+msgid "Children"
+msgstr "Enfants"
+
+#: gitk:8125
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "R=E9initialiser la branche %s vers cet =E9tat"
+
+#: gitk:8127
+msgid "Detached head: can't reset"
+msgstr "Head d=E9tach=E9 : impossible de r=E9initialiser"
+
+#: gitk:8236 gitk:8242
+msgid "Skipping merge commit "
+msgstr "=C9viter le commit de la fusion "
+
+#: gitk:8251 gitk:8256
+msgid "Error getting patch ID for "
+msgstr "Erreur =E0 l'obtention de l'ID du patch pour "
+
+#: gitk:8252 gitk:8257
+msgid " - stopping\n"
+msgstr " - arr=EAt en cours\n"
+
+#: gitk:8262 gitk:8265 gitk:8273 gitk:8283 gitk:8292
+msgid "Commit "
+msgstr "Commit "
+
+#: gitk:8266
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+"est le m=EAme patch que \n"
+"       "
+
+#: gitk:8274
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" diff=E8re de\n"
+"       "
+
+#: gitk:8276
+msgid "- stopping\n"
+msgstr "- arr=EAt en cours\n"
+
+#: gitk:8284 gitk:8293
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr "a %s enfants - arr=EAt en cours\n"
+
+#: gitk:8324
+msgid "Top"
+msgstr "Haut"
+
+#: gitk:8325
+msgid "From"
+msgstr "De"
+
+#: gitk:8330
+msgid "To"
+msgstr "=C0"
+
+#: gitk:8354
+msgid "Generate patch"
+msgstr "G=E9n=E9rer le patch"
+
+#: gitk:8356
+msgid "From:"
+msgstr "De :"
+
+#: gitk:8365
+msgid "To:"
+msgstr "=C0 :"
+
+#: gitk:8374
+msgid "Reverse"
+msgstr "Inverser"
+
+#: gitk:8376 gitk:8561
+msgid "Output file:"
+msgstr "Fichier de sortie :"
+
+#: gitk:8382
+msgid "Generate"
+msgstr "G=E9n=E9rer"
+
+#: gitk:8420
+msgid "Error creating patch:"
+msgstr "Erreur =E0 la cr=E9ation du patch :"
+
+#: gitk:8443 gitk:8549 gitk:8606
+msgid "ID:"
+msgstr "ID :"
+
+#: gitk:8452
+msgid "Tag name:"
+msgstr "Nom du Tag :"
+
+#: gitk:8456 gitk:8615
+msgid "Create"
+msgstr "Cr=E9er"
+
+#: gitk:8473
+msgid "No tag name specified"
+msgstr "Aucun nom de tag sp=E9cifi=E9"
+
+#: gitk:8477
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "Le tag \"%s\" existe d=E9j=E0"
+
+#: gitk:8483
+msgid "Error creating tag:"
+msgstr "Erreur =E0 la cr=E9ation du tag :"
+
+#: gitk:8558
+msgid "Command:"
+msgstr "Commande :"
+
+#: gitk:8566
+msgid "Write"
+msgstr "=C9crire"
+
+#: gitk:8584
+msgid "Error writing commit:"
+msgstr "Erreur =E0 l'ecriture du commit :"
+
+#: gitk:8611
+msgid "Name:"
+msgstr "Nom :"
+
+#: gitk:8634
+msgid "Please specify a name for the new branch"
+msgstr "Veuillez sp=E9cifier un nom pour la nouvelle branche"
+
+#: gitk:8639
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "La branche '%s' existe d=E9j=E0. =C9craser?"
+
+#: gitk:8705
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr ""
+"Le Commit %s est d=E9j=E0 inclus dans la branche %s -- le r=E9-appliq=
uer malgr=E9 "
+"tout?"
+
+#: gitk:8710
+msgid "Cherry-picking"
+msgstr "Cueillir (Cherry-picking)"
+
+#: gitk:8719
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"La cueillette (cherry-pick) a =E9chou=E9e =E0 cause de modifications =
locales du "
+"fichier '%s'.\n"
+"Veuillez commiter, r=E9initialiser ou stasher vos changements et essa=
yer de "
+"nouveau."
+
+#: gitk:8725
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"La cueillette (cherry-pick) a =E9chou=E9e =E0 cause d'un conflit lors=
 d'une "
+"fusion.\n"
+"Souhaitez-vous ex=E9cuter git citool pour le r=E9soudre ?"
+
+#: gitk:8741
+msgid "No changes committed"
+msgstr "Aucun changement commit=E9"
+
+#: gitk:8767
+msgid "Confirm reset"
+msgstr "Confirmer la r=E9initialisation"
+
+#: gitk:8769
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "R=E9initialiser la branche %s =E0 %s?"
+
+#: gitk:8773
+msgid "Reset type:"
+msgstr "Type de r=E9initialisation :"
+
+#: gitk:8777
+msgid "Soft: Leave working tree and index untouched"
+msgstr "Douce : Laisse le r=E9pertoire de travail et l'index intacts"
+
+#: gitk:8780
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr ""
+"Hybride : Laisse le r=E9pertoire de travail dans son =E9tat courant, =
"
+"r=E9initialise l'index"
+
+#: gitk:8783
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Dure : R=E9initialise le r=E9pertoire de travail et l'index\n"
+"(abandonne TOUS les changements locaux)"
+
+#: gitk:8800
+msgid "Resetting"
+msgstr "R=E9initialisation"
+
+# Fixme: R=E9cup=E9ration est-il vraiment une mauvaise traduction?
+#: gitk:8857
+#, fuzzy
+msgid "Checking out"
+msgstr "R=E9cup=E9ration"
+
+#: gitk:8910
+msgid "Cannot delete the currently checked-out branch"
+msgstr "Impossible de supprimer la branche en cours"
+
+#: gitk:8916
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"Les commits de la branche %s ne sont dans aucune autre branche.\n"
+"Voulez-vous vraiment supprimer cette branche %s ?"
+
+#: gitk:8947
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Tags et heads : %s"
+
+#: gitk:8962
+msgid "Filter"
+msgstr "Filtrer"
+
+#: gitk:9257
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"Erreur =E0 la lecture des informations sur la topologie des commits, =
les "
+"informations sur les branches et les tags pr=E9c=E9dents/suivants ser=
ont "
+"incompl=E8tes."
+
+#: gitk:10243
+msgid "Tag"
+msgstr "Tag"
+
+#: gitk:10243
+msgid "Id"
+msgstr "Id"
+
+#: gitk:10291
+msgid "Gitk font chooser"
+msgstr "S=E9lecteur de police de Gitk"
+
+#: gitk:10308
+msgid "B"
+msgstr "B"
+
+#: gitk:10311
+msgid "I"
+msgstr "I"
+
+#: gitk:10407
+msgid "Gitk preferences"
+msgstr "Pr=E9f=E9rences de Gitk"
+
+#: gitk:10409
+msgid "Commit list display options"
+msgstr "Options d'affichage de la liste des commits"
+
+#: gitk:10412
+msgid "Maximum graph width (lines)"
+msgstr "Longueur maximum du graphe (lignes)"
+
+# FIXME : Traduction standard de "pane"?
+#: gitk:10416
+#, fuzzy, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "Longueur maximum du graphe (% du panneau)"
+
+#: gitk:10420
+msgid "Show local changes"
+msgstr "Montrer les changements locaux"
+
+#: gitk:10423
+msgid "Auto-select SHA1"
+msgstr "S=E9lection auto. du SHA1"
+
+#: gitk:10427
+msgid "Diff display options"
+msgstr "Options d'affichage des diff"
+
+#: gitk:10429
+msgid "Tab spacing"
+msgstr "Taille des tabulations"
+
+#: gitk:10432
+msgid "Display nearby tags"
+msgstr "Afficher les tags les plus proches"
+
+#: gitk:10435
+msgid "Hide remote refs"
+msgstr "Cacher les refs distantes"
+
+#: gitk:10438
+msgid "Limit diffs to listed paths"
+msgstr "Limiter les diff=E9rences aux chemins list=E9s"
+
+#: gitk:10441
+msgid "Support per-file encodings"
+msgstr "Support pour un encodage des caract=E8res par fichier"
+
+#: gitk:10447 gitk:10512
+msgid "External diff tool"
+msgstr "Outil diff externe"
+
+#: gitk:10449
+msgid "Choose..."
+msgstr "Choisir..."
+
+#: gitk:10454
+msgid "Colors: press to choose"
+msgstr "Couleurs : cliquer pour choisir"
+
+#: gitk:10457
+msgid "Background"
+msgstr "Arri=E8re-plan"
+
+#: gitk:10458 gitk:10488
+msgid "background"
+msgstr "arri=E8re-plan"
+
+#: gitk:10461
+msgid "Foreground"
+msgstr "Premier plan"
+
+#: gitk:10462
+msgid "foreground"
+msgstr "premier plan"
+
+#: gitk:10465
+msgid "Diff: old lines"
+msgstr "Diff : anciennes lignes"
+
+#: gitk:10466
+msgid "diff old lines"
+msgstr "diff anciennes lignes"
+
+#: gitk:10470
+msgid "Diff: new lines"
+msgstr "Diff : nouvelles lignes"
+
+#: gitk:10471
+msgid "diff new lines"
+msgstr "diff nouvelles lignes"
+
+#: gitk:10475
+msgid "Diff: hunk header"
+msgstr "Diff : ent=EAte du hunk"
+
+#: gitk:10477
+msgid "diff hunk header"
+msgstr "diff : ent=EAte du hunk"
+
+#: gitk:10481
+msgid "Marked line bg"
+msgstr "Arri=E8re-plan de la ligne marqu=E9e"
+
+#: gitk:10483
+msgid "marked line background"
+msgstr "Arri=E8re-plan de la ligne marqu=E9e"
+
+#: gitk:10487
+msgid "Select bg"
+msgstr "S=E9lectionner l'arri=E8re-plan"
+
+#: gitk:10491
+msgid "Fonts: press to choose"
+msgstr "Polices : cliquer pour choisir"
+
+#: gitk:10493
+msgid "Main font"
+msgstr "Police principale"
+
+#: gitk:10494
+msgid "Diff display font"
+msgstr "Police d'affichage des diff"
+
+#: gitk:10495
+msgid "User interface font"
+msgstr "Police de l'interface utilisateur"
+
+#: gitk:10522
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk : choisir la couleur de %s"
+
+#: gitk:10973
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+"D=E9sol=E9, gitk ne peut =EAtre ex=E9cut=E9 avec cette version de Tcl=
/Tk.\n"
+" Gitk requiert Tcl/Tk version 8.4 ou sup=E9rieur."
+
+#: gitk:11101
+msgid "Cannot find a git repository here."
+msgstr "Impossible de trouver un d=E9p=F4t git ici."
+
+#: gitk:11105
+#, tcl-format
+msgid "Cannot find the git directory \"%s\"."
+msgstr "Impossible de trouver le r=E9pertoire git \"%s\"."
+
+#: gitk:11152
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "Argument '%s' ambigu : =E0 la fois une r=E9vision et un nom de=
 fichier"
+
+#: gitk:11164
+msgid "Bad arguments to gitk:"
+msgstr "Arguments invalides pour gitk :"
+
+#: gitk:11249
+msgid "Command line"
+msgstr "Ligne de commande"
--=20
Nicolas Sebrecht
