From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH] git-gui: update french translation
Date: Tue, 2 Feb 2010 13:18:00 +0100
Message-ID: <20100202131800.63200600@eleanor>
References: <20100201151647.GB8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 13:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcHg9-00019H-9x
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 13:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab0BBMQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 07:16:14 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:63265 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab0BBMQJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 07:16:09 -0500
Received: by bwz23 with SMTP id 23so459450bwz.21
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Wf2iubahVthp3k0OruwALZff9+vxap2utpMBVIq5rjY=;
        b=G+uayE0Enk6je3SSc9/5L+r6uH2rPfQaPpHVJ15rX0vO/TX1YfXXXJyDP4pW7VpIWi
         ja53GDz70VQaVvAHy9FjrVIDKy5zdrd2Q9gLnI2cMUtRjF1UXVxkqoNqzDEqN27hNniY
         cSiME4GddUFMP3A5cK5WVSpSuPpHBnhoMsOQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=eBEYiMiLGfA85+o/R93SmtUThoQDw7gtw6FgXvBJQpeoKmwFsgux2sgibqi0ZsD632
         CnWC1IHO6NmIitANCoxVIXqcxD94umotZa5dPX56YpH1KJ4fV6hrAMsE970s5NRLs1TF
         HqmvTgnKCnzZiI5b490fWhhGkIXyFndHommWM=
Received: by 10.204.151.216 with SMTP id d24mr2128002bkw.1.1265112967521;
        Tue, 02 Feb 2010 04:16:07 -0800 (PST)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 15sm2604406bwz.0.2010.02.02.04.16.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 04:16:07 -0800 (PST)
In-Reply-To: <20100201151647.GB8916@spearce.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138714>


Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 po/fr.po |  686 +++++++++++++++++++++++++++++++++---------------------=
--------
 1 files changed, 366 insertions(+), 320 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index a944ace..8170696 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -9,8 +9,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: fr\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-11-16 13:56-0800\n"
-"PO-Revision-Date: 2008-11-20 10:20+0100\n"
+"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"PO-Revision-Date: 2010-02-02 12:59+0100\n"
 "Last-Translator: Emmanuel Trillaud <etrillaud@gmail.com>\n"
 "Language-Team: French\n"
 "MIME-Version: 1.0\n"
@@ -19,33 +19,33 @@ msgstr ""
 "X-Generator: KBabel 1.11.4\n"
 "Plural-Forms:  nplurals=3D2; plural=3D(n > 1);\n"
=20
-#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
-#: git-gui.sh:866
+#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.=
sh:903
+#: git-gui.sh:922
 msgid "git-gui: fatal error"
 msgstr "git-gui: erreur fatale"
=20
-#: git-gui.sh:689
+#: git-gui.sh:743
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Police invalide sp=C3=A9cifi=C3=A9e dans %s :"
=20
-#: git-gui.sh:723
+#: git-gui.sh:779
 msgid "Main Font"
 msgstr "Police principale"
=20
-#: git-gui.sh:724
+#: git-gui.sh:780
 msgid "Diff/Console Font"
 msgstr "Police diff/console"
=20
-#: git-gui.sh:738
+#: git-gui.sh:794
 msgid "Cannot find git in PATH."
 msgstr "Impossible de trouver git dans PATH."
=20
-#: git-gui.sh:765
+#: git-gui.sh:821
 msgid "Cannot parse Git version string:"
 msgstr "Impossible de parser la version de Git :"
=20
-#: git-gui.sh:783
+#: git-gui.sh:839
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -64,446 +64,475 @@ msgstr ""
 "\n"
 "Peut-on consid=C3=A9rer que '%s' est en version 1.5.0 ?\n"
=20
-#: git-gui.sh:1062
+#: git-gui.sh:1128
 msgid "Git directory not found:"
 msgstr "Impossible de trouver le r=C3=A9pertoire git :"
=20
-#: git-gui.sh:1069
+#: git-gui.sh:1146
 msgid "Cannot move to top of working directory:"
 msgstr "Impossible d'aller =C3=A0 la racine du r=C3=A9pertoire de trav=
ail :"
=20
-#: git-gui.sh:1076
-msgid "Cannot use funny .git directory:"
-msgstr "Impossible d'utiliser le r=C3=A9pertoire .git:"
+#: git-gui.sh:1154
+msgid "Cannot use bare repository:"
+msgstr "Impossible d'utiliser un d=C3=A9p=C3=B4t nu (bare) :"
=20
-#: git-gui.sh:1081
+#: git-gui.sh:1162
 msgid "No working directory"
 msgstr "Aucun r=C3=A9pertoire de travail"
=20
-#: git-gui.sh:1247 lib/checkout_op.tcl:305
+#: git-gui.sh:1334 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Rafra=C3=AEchissement du statut des fichiers..."
=20
-#: git-gui.sh:1303
+#: git-gui.sh:1390
 msgid "Scanning for modified files ..."
 msgstr "Recherche de fichiers modifi=C3=A9s..."
=20
-#: git-gui.sh:1367
+#: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
 msgstr "Lancement de l'action de pr=C3=A9paration du message de commit=
=2E.."
=20
-#: git-gui.sh:1384
+#: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr "Commit refus=C3=A9 par l'action de pr=C3=A9paration du message=
 de commit."
=20
-#: git-gui.sh:1542 lib/browser.tcl:246
+#: git-gui.sh:1629 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Pr=C3=AAt."
=20
-#: git-gui.sh:1819
+#: git-gui.sh:1787
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "Affiche seulement %s fichiers sur %s."
+
+#: git-gui.sh:1913
 msgid "Unmodified"
 msgstr "Non modifi=C3=A9"
=20
-#: git-gui.sh:1821
+#: git-gui.sh:1915
 msgid "Modified, not staged"
 msgstr "Modifi=C3=A9, pas index=C3=A9"
=20
-#: git-gui.sh:1822 git-gui.sh:1830
+#: git-gui.sh:1916 git-gui.sh:1924
 msgid "Staged for commit"
 msgstr "Index=C3=A9"
=20
-#: git-gui.sh:1823 git-gui.sh:1831
+#: git-gui.sh:1917 git-gui.sh:1925
 msgid "Portions staged for commit"
 msgstr "Portions index=C3=A9es"
=20
-#: git-gui.sh:1824 git-gui.sh:1832
+#: git-gui.sh:1918 git-gui.sh:1926
 msgid "Staged for commit, missing"
 msgstr "Index=C3=A9s, manquant"
=20
-#: git-gui.sh:1826
+#: git-gui.sh:1920
 msgid "File type changed, not staged"
 msgstr "Le type de fichier a chang=C3=A9, non index=C3=A9"
=20
-#: git-gui.sh:1827
+#: git-gui.sh:1921
 msgid "File type changed, staged"
 msgstr "Le type de fichier a chang=C3=A9, index=C3=A9"
=20
-#: git-gui.sh:1829
+#: git-gui.sh:1923
 msgid "Untracked, not staged"
 msgstr "Non versionn=C3=A9, non index=C3=A9"
=20
-#: git-gui.sh:1834
+#: git-gui.sh:1928
 msgid "Missing"
 msgstr "Manquant"
=20
-#: git-gui.sh:1835
+#: git-gui.sh:1929
 msgid "Staged for removal"
 msgstr "Index=C3=A9 pour suppression"
=20
-#: git-gui.sh:1836
+#: git-gui.sh:1930
 msgid "Staged for removal, still present"
 msgstr "Index=C3=A9 pour suppression, toujours pr=C3=A9sent"
=20
-#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
-#: git-gui.sh:1842 git-gui.sh:1843
+#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
+#: git-gui.sh:1936 git-gui.sh:1937
 msgid "Requires merge resolution"
 msgstr "N=C3=A9cessite la r=C3=A9solution d'une fusion"
=20
-#: git-gui.sh:1878
+#: git-gui.sh:1972
 msgid "Starting gitk... please wait..."
 msgstr "Lancement de gitk... un instant..."
=20
-#: git-gui.sh:1887
+#: git-gui.sh:1984
 msgid "Couldn't find gitk in PATH"
 msgstr "Impossible de trouver gitk dans PATH."
=20
-#: git-gui.sh:2280 lib/choose_repository.tcl:36
+#: git-gui.sh:2043
+msgid "Couldn't find git gui in PATH"
+msgstr "Impossible de trouver git gui dans PATH"
+
+#: git-gui.sh:2455 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "D=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:2281
+#: git-gui.sh:2456
 msgid "Edit"
 msgstr "=C3=89dition"
=20
-#: git-gui.sh:2283 lib/choose_rev.tcl:561
+#: git-gui.sh:2458 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "Branche"
=20
-#: git-gui.sh:2286 lib/choose_rev.tcl:548
+#: git-gui.sh:2461 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "Commit"
=20
-#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "Fusionner"
=20
-#: git-gui.sh:2290 lib/choose_rev.tcl:557
+#: git-gui.sh:2465 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "D=C3=A9p=C3=B4t distant"
=20
-#: git-gui.sh:2293
+#: git-gui.sh:2468
 msgid "Tools"
 msgstr "Outils"
=20
-#: git-gui.sh:2302
+#: git-gui.sh:2477
 msgid "Explore Working Copy"
 msgstr "Explorer la copie de travail"
=20
-#: git-gui.sh:2307
+#: git-gui.sh:2483
 msgid "Browse Current Branch's Files"
 msgstr "Naviguer dans la branche courante"
=20
-#: git-gui.sh:2311
+#: git-gui.sh:2487
 msgid "Browse Branch Files..."
 msgstr "Naviguer dans la branche..."
=20
-#: git-gui.sh:2316
+#: git-gui.sh:2492
 msgid "Visualize Current Branch's History"
 msgstr "Visualiser l'historique de la branche courante"
=20
-#: git-gui.sh:2320
+#: git-gui.sh:2496
 msgid "Visualize All Branch History"
 msgstr "Voir l'historique de toutes les branches"
=20
-#: git-gui.sh:2327
+#: git-gui.sh:2503
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Parcourir l'arborescence de %s"
=20
-#: git-gui.sh:2329
+#: git-gui.sh:2505
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Voir l'historique de la branche : %s"
=20
-#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Statistiques du d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:2337 lib/database.tcl:34
+#: git-gui.sh:2513 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Comprimer le d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:2340
+#: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "V=C3=A9rifier le d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
-#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
+#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "Cr=C3=A9er une ic=C3=B4ne sur le bureau"
=20
-#: git-gui.sh:2363 lib/choose_repository.tcl:183
lib/choose_repository.tcl:191 +#: git-gui.sh:2539
lib/choose_repository.tcl:183 lib/choose_repository.tcl:191 msgid "Quit=
"
 msgstr "Quitter"
=20
-#: git-gui.sh:2371
+#: git-gui.sh:2547
 msgid "Undo"
 msgstr "D=C3=A9faire"
=20
-#: git-gui.sh:2374
+#: git-gui.sh:2550
 msgid "Redo"
 msgstr "Refaire"
=20
-#: git-gui.sh:2378 git-gui.sh:2923
+#: git-gui.sh:2554 git-gui.sh:3109
 msgid "Cut"
 msgstr "Couper"
=20
-#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
+#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Copier"
=20
-#: git-gui.sh:2384 git-gui.sh:2929
+#: git-gui.sh:2560 git-gui.sh:3115
 msgid "Paste"
 msgstr "Coller"
=20
-#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
+#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "Supprimer"
=20
-#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
+#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
 msgid "Select All"
 msgstr "Tout s=C3=A9lectionner"
=20
-#: git-gui.sh:2400
+#: git-gui.sh:2576
 msgid "Create..."
 msgstr "Cr=C3=A9er..."
=20
-#: git-gui.sh:2406
+#: git-gui.sh:2582
 msgid "Checkout..."
 msgstr "Charger (checkout)..."
=20
-#: git-gui.sh:2412
+#: git-gui.sh:2588
 msgid "Rename..."
 msgstr "Renommer..."
=20
-#: git-gui.sh:2417
+#: git-gui.sh:2593
 msgid "Delete..."
 msgstr "Supprimer..."
=20
-#: git-gui.sh:2422
+#: git-gui.sh:2598
 msgid "Reset..."
 msgstr "R=C3=A9initialiser..."
=20
-#: git-gui.sh:2432
+#: git-gui.sh:2608
 msgid "Done"
 msgstr "Effectu=C3=A9"
=20
-#: git-gui.sh:2434
+#: git-gui.sh:2610
 msgid "Commit@@verb"
 msgstr "Commiter@@verb"
=20
-#: git-gui.sh:2443 git-gui.sh:2864
+#: git-gui.sh:2619 git-gui.sh:3050
 msgid "New Commit"
 msgstr "Nouveau commit"
=20
-#: git-gui.sh:2451 git-gui.sh:2871
+#: git-gui.sh:2627 git-gui.sh:3057
 msgid "Amend Last Commit"
 msgstr "Corriger dernier commit"
=20
-#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Recharger modifs."
=20
-#: git-gui.sh:2467
+#: git-gui.sh:2643
 msgid "Stage To Commit"
 msgstr "Indexer"
=20
-#: git-gui.sh:2473
+#: git-gui.sh:2649
 msgid "Stage Changed Files To Commit"
 msgstr "Indexer toutes modifications"
=20
-#: git-gui.sh:2479
+#: git-gui.sh:2655
 msgid "Unstage From Commit"
 msgstr "D=C3=A9sindexer"
=20
-#: git-gui.sh:2484 lib/index.tcl:410
+#: git-gui.sh:2661 lib/index.tcl:412
 msgid "Revert Changes"
 msgstr "Annuler les modifications"
=20
-#: git-gui.sh:2491 git-gui.sh:3069
+#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
 msgid "Show Less Context"
 msgstr "Montrer moins de contexte"
=20
-#: git-gui.sh:2495 git-gui.sh:3073
+#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
 msgid "Show More Context"
 msgstr "Montrer plus de contexte"
=20
-#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
+#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
 msgid "Sign Off"
 msgstr "Signer"
=20
-#: git-gui.sh:2518
+#: git-gui.sh:2696
 msgid "Local Merge..."
 msgstr "Fusion locale..."
=20
-#: git-gui.sh:2523
+#: git-gui.sh:2701
 msgid "Abort Merge..."
 msgstr "Abandonner fusion..."
=20
-#: git-gui.sh:2535 git-gui.sh:2575
+#: git-gui.sh:2713 git-gui.sh:2741
 msgid "Add..."
 msgstr "Ajouter..."
=20
-#: git-gui.sh:2539
+#: git-gui.sh:2717
 msgid "Push..."
 msgstr "Pousser..."
=20
-#: git-gui.sh:2543
+#: git-gui.sh:2721
 msgid "Delete Branch..."
 msgstr "Supprimer branche..."
=20
-#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
-#, tcl-format
-msgid "About %s"
-msgstr "=C3=80 propos de %s"
-
-#: git-gui.sh:2557
-msgid "Preferences..."
-msgstr "Pr=C3=A9f=C3=A9rences..."
-
-#: git-gui.sh:2565 git-gui.sh:3115
+#: git-gui.sh:2731 git-gui.sh:3292
 msgid "Options..."
 msgstr "Options..."
=20
-#: git-gui.sh:2576
+#: git-gui.sh:2742
 msgid "Remove..."
 msgstr "Supprimer..."
=20
-#: git-gui.sh:2585 lib/choose_repository.tcl:50
+#: git-gui.sh:2751 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "Aide"
=20
-#: git-gui.sh:2611
+#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "=C3=80 propos de %s"
+
+#: git-gui.sh:2783
 msgid "Online Documentation"
 msgstr "Documentation en ligne"
=20
-#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
 msgid "Show SSH Key"
 msgstr "Montrer la cl=C3=A9 SSH"
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2893
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "erreur fatale : pas d'infos sur le chemin %s : Fichier ou r=C3=A9pert=
oire "
 "inexistant"
=20
-#: git-gui.sh:2740
+#: git-gui.sh:2926
 msgid "Current Branch:"
 msgstr "Branche courante :"
=20
-#: git-gui.sh:2761
+#: git-gui.sh:2947
 msgid "Staged Changes (Will Commit)"
 msgstr "Modifs. index=C3=A9es (pour commit)"
=20
-#: git-gui.sh:2781
+#: git-gui.sh:2967
 msgid "Unstaged Changes"
 msgstr "Modifs. non index=C3=A9es"
=20
-#: git-gui.sh:2831
+#: git-gui.sh:3017
 msgid "Stage Changed"
 msgstr "Indexer modifs."
=20
-#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "Pousser"
=20
-#: git-gui.sh:2885
+#: git-gui.sh:3071
 msgid "Initial Commit Message:"
 msgstr "Message de commit initial :"
=20
-#: git-gui.sh:2886
+#: git-gui.sh:3072
 msgid "Amended Commit Message:"
 msgstr "Message de commit corrig=C3=A9 :"
=20
-#: git-gui.sh:2887
+#: git-gui.sh:3073
 msgid "Amended Initial Commit Message:"
 msgstr "Message de commit initial corrig=C3=A9 :"
=20
-#: git-gui.sh:2888
+#: git-gui.sh:3074
 msgid "Amended Merge Commit Message:"
 msgstr "Message de commit de fusion corrig=C3=A9 :"
=20
-#: git-gui.sh:2889
+#: git-gui.sh:3075
 msgid "Merge Commit Message:"
 msgstr "Message de commit de fusion :"
=20
-#: git-gui.sh:2890
+#: git-gui.sh:3076
 msgid "Commit Message:"
 msgstr "Message de commit :"
=20
-#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
+#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Copier tout"
=20
-#: git-gui.sh:2963 lib/blame.tcl:104
+#: git-gui.sh:3149 lib/blame.tcl:104
 msgid "File:"
 msgstr "Fichier :"
=20
-#: git-gui.sh:3078
+#: git-gui.sh:3255
 msgid "Refresh"
 msgstr "Rafra=C3=AEchir"
=20
-#: git-gui.sh:3099
+#: git-gui.sh:3276
 msgid "Decrease Font Size"
 msgstr "Diminuer la police"
=20
-#: git-gui.sh:3103
+#: git-gui.sh:3280
 msgid "Increase Font Size"
 msgstr "Agrandir la police"
=20
-#: git-gui.sh:3111 lib/blame.tcl:281
+#: git-gui.sh:3288 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "Codage des caract=C3=A8res"
=20
-#: git-gui.sh:3122
+#: git-gui.sh:3299
 msgid "Apply/Reverse Hunk"
 msgstr "Appliquer/Inverser section"
=20
-#: git-gui.sh:3127
+#: git-gui.sh:3304
 msgid "Apply/Reverse Line"
 msgstr "Appliquer/Inverser la ligne"
=20
-#: git-gui.sh:3137
+#: git-gui.sh:3323
 msgid "Run Merge Tool"
 msgstr "Lancer l'outil de fusion"
=20
-#: git-gui.sh:3142
+#: git-gui.sh:3328
 msgid "Use Remote Version"
 msgstr "Utiliser la version distante"
=20
-#: git-gui.sh:3146
+#: git-gui.sh:3332
 msgid "Use Local Version"
 msgstr "Utiliser la version locale"
=20
-#: git-gui.sh:3150
+#: git-gui.sh:3336
 msgid "Revert To Base"
 msgstr "Revenir =C3=A0 la version de base"
=20
-#: git-gui.sh:3169
+#: git-gui.sh:3354
+msgid "Visualize These Changes In The Submodule"
+msgstr "Voir les changments dans le sous-module"
+
+#: git-gui.sh:3358
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "Voir l'historique de la branche courante du sous-module"
+
+#: git-gui.sh:3362
+msgid "Visualize All Branch History In The Submodule"
+msgstr "Voir l'historique de toutes les branches du sous-module"
+
+#: git-gui.sh:3367
+msgid "Start git gui In The Submodule"
+msgstr "D=C3=A9marrer git gui dans le sous-module"
+
+#: git-gui.sh:3389
 msgid "Unstage Hunk From Commit"
 msgstr "D=C3=A9sindexer la section"
=20
-#: git-gui.sh:3170
+#: git-gui.sh:3391
+msgid "Unstage Lines From Commit"
+msgstr "D=C3=A9sindexer la ligne du commit"
+
+#: git-gui.sh:3393
 msgid "Unstage Line From Commit"
 msgstr "D=C3=A9sindexer la ligne"
=20
-#: git-gui.sh:3172
+#: git-gui.sh:3396
 msgid "Stage Hunk For Commit"
 msgstr "Indexer la section"
=20
-#: git-gui.sh:3173
+#: git-gui.sh:3398
+msgid "Stage Lines For Commit"
+msgstr "Indexer les lignes"
+
+#: git-gui.sh:3400
 msgid "Stage Line For Commit"
 msgstr "Indexer la ligne"
=20
-#: git-gui.sh:3196
+#: git-gui.sh:3424
 msgid "Initializing..."
 msgstr "Initialisation..."
=20
-#: git-gui.sh:3301
+#: git-gui.sh:3541
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -520,7 +549,7 @@ msgstr ""
 "sous-processus de Git lanc=C3=A9s par %s\n"
 "\n"
=20
-#: git-gui.sh:3331
+#: git-gui.sh:3570
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -530,7 +559,7 @@ msgstr ""
 "Ceci est d=C3=BB =C3=A0 un probl=C3=A8me connu avec\n"
 "le binaire Tcl distribu=C3=A9 par Cygwin."
=20
-#: git-gui.sh:3336
+#: git-gui.sh:3575
 #, tcl-format
 msgid ""
 "\n"
@@ -616,43 +645,43 @@ msgstr "Recherche de copie approfondie en cours..=
=2E"
 msgid "Loading annotation..."
 msgstr "Chargement des annotations..."
=20
-#: lib/blame.tcl:964
+#: lib/blame.tcl:963
 msgid "Author:"
 msgstr "Auteur :"
=20
-#: lib/blame.tcl:968
+#: lib/blame.tcl:967
 msgid "Committer:"
 msgstr "Commiteur :"
=20
-#: lib/blame.tcl:973
+#: lib/blame.tcl:972
 msgid "Original File:"
 msgstr "Fichier original :"
=20
-#: lib/blame.tcl:1021
+#: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
 msgstr "Impossible de trouver le commit HEAD :"
=20
-#: lib/blame.tcl:1076
+#: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
 msgstr "Impossible de trouver le commit parent :"
=20
-#: lib/blame.tcl:1091
+#: lib/blame.tcl:1090
 msgid "Unable to display parent"
 msgstr "Impossible d'afficher le parent"
=20
-#: lib/blame.tcl:1092 lib/diff.tcl:297
+#: lib/blame.tcl:1091 lib/diff.tcl:320
 msgid "Error loading diff:"
 msgstr "Erreur lors du chargement des diff=C3=A9rences :"
=20
-#: lib/blame.tcl:1232
+#: lib/blame.tcl:1231
 msgid "Originally By:"
 msgstr "=C3=80 l'origine par :"
=20
-#: lib/blame.tcl:1238
+#: lib/blame.tcl:1237
 msgid "In File:"
 msgstr "Dans le fichier :"
=20
-#: lib/blame.tcl:1243
+#: lib/blame.tcl:1242
 msgid "Copied Or Moved Here By:"
 msgstr "Copi=C3=A9 ou d=C3=A9plac=C3=A9 ici par :"
=20
@@ -666,10 +695,10 @@ msgstr "Charger (checkout)"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
 #: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
 #: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:97
+#: lib/transport.tcl:108
 msgid "Cancel"
 msgstr "Annuler"
=20
@@ -697,7 +726,7 @@ msgstr "Cr=C3=A9er une branche"
 msgid "Create New Branch"
 msgstr "Cr=C3=A9er une nouvelle branche"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
 msgid "Create"
 msgstr "Cr=C3=A9er"
=20
@@ -729,7 +758,7 @@ msgstr "Non"
 msgid "Fast Forward Only"
 msgstr "Mise =C3=A0 jour rectiligne seulement (fast-forward)"
=20
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
 msgid "Reset"
 msgstr "R=C3=A9initialiser"
=20
@@ -771,15 +800,25 @@ msgstr "Branches locales"
 msgid "Delete Only If Merged Into"
 msgstr "Supprimer seulement si fusionn=C3=A9e dans :"
=20
-#: lib/branch_delete.tcl:54
-msgid "Always (Do not perform merge test.)"
-msgstr "Toujours (Ne pas faire de test de fusion.)"
+#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Toujours (ne pas v=C3=A9rifier les fusions)"
=20
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
 msgstr "Les branches suivantes ne sont pas compl=C3=A8tement fusionn=C3=
=A9es dans %s :"
=20
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9es.=
\n"
+"\n"
+"Supprimer les branches s=C3=A9lectionn=C3=A9es ?"
+
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -809,7 +848,7 @@ msgstr "Nouveau nom :"
 msgid "Please select a branch to rename."
 msgstr "Merci de s=C3=A9lectionner une branche =C3=A0 renommer."
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "La branche '%s' existe d=C3=A9j=C3=A0."
@@ -840,38 +879,38 @@ msgstr "[Jusqu'au parent]"
 msgid "Browse Branch Files"
 msgstr "Naviguer dans les fichiers de le branche"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:394
-#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
-#: lib/choose_repository.tcl:995
+#: lib/browser.tcl:278 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
+#: lib/choose_repository.tcl:1028
 msgid "Browse"
 msgstr "Naviguer"
=20
-#: lib/checkout_op.tcl:84
+#: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "R=C3=A9cup=C3=A9ration de %s =C3=A0 partir de %s"
=20
-#: lib/checkout_op.tcl:132
+#: lib/checkout_op.tcl:133
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "erreur fatale : Impossible de r=C3=A9soudre %s"
=20
-#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
 #: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "Fermer"
=20
-#: lib/checkout_op.tcl:174
+#: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "La branche '%s' n'existe pas."
=20
-#: lib/checkout_op.tcl:193
+#: lib/checkout_op.tcl:194
 #, tcl-format
 msgid "Failed to configure simplified git-pull for '%s'."
 msgstr "=C3=89chec de la configuration simplifi=C3=A9e de git-pull pou=
r '%s'."
=20
-#: lib/checkout_op.tcl:228
+#: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -884,21 +923,21 @@ msgstr ""
 "Impossible de faire une avance rapide (fast forward) vers %s.\n"
 "Une fusion est n=C3=A9cessaire."
=20
-#: lib/checkout_op.tcl:242
+#: lib/checkout_op.tcl:243
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "La strat=C3=A9gie de fusion '%s' n'est pas support=C3=A9e."
=20
-#: lib/checkout_op.tcl:261
+#: lib/checkout_op.tcl:262
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "La mise =C3=A0 jour de '%s' a =C3=A9chou=C3=A9."
=20
-#: lib/checkout_op.tcl:273
+#: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
 msgstr "L'index (staging area) est d=C3=A9j=C3=A0 verrouill=C3=A9."
=20
-#: lib/checkout_op.tcl:288
+#: lib/checkout_op.tcl:289
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -916,30 +955,31 @@ msgstr ""
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement.\n"
=20
-#: lib/checkout_op.tcl:344
+#: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "Mise =C3=A0 jour du r=C3=A9pertoire courant avec '%s'..."
=20
-#: lib/checkout_op.tcl:345
+#: lib/checkout_op.tcl:346
 msgid "files checked out"
 msgstr "fichiers charg=C3=A9s"
=20
-#: lib/checkout_op.tcl:375
+#: lib/checkout_op.tcl:376
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr "Chargement de '%s' abandonn=C3=A9 (il est n=C3=A9cessaire de f=
usionner des
fichiers)." +msgstr ""
+"Chargement de '%s' abandonn=C3=A9 (il est n=C3=A9cessaire de fusionne=
r des fichiers)."
=20
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 msgid "File level merge required."
 msgstr "Il est n=C3=A9cessaire de fusionner des fichiers."
=20
-#: lib/checkout_op.tcl:380
+#: lib/checkout_op.tcl:381
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Le r=C3=A9pertoire de travail reste sur la branche '%s'."
=20
-#: lib/checkout_op.tcl:451
+#: lib/checkout_op.tcl:452
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -951,30 +991,30 @@ msgstr ""
 "Si vous vouliez =C3=AAtre sur une branche, cr=C3=A9ez-en une maintena=
nt en partant de
" "'Cet emprunt d=C3=A9tach=C3=A9'."
=20
-#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
+#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "'%s' charg=C3=A9."
=20
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:535
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "R=C3=A9initialiser '%s' =C3=A0 '%s' va faire perdre les commit=
s suivants :"
=20
-#: lib/checkout_op.tcl:522
+#: lib/checkout_op.tcl:557
 msgid "Recovering lost commits may not be easy."
 msgstr "R=C3=A9cup=C3=A9rer les commits perdus ne sera peut =C3=AAtre =
pas facile."
=20
-#: lib/checkout_op.tcl:527
+#: lib/checkout_op.tcl:562
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "R=C3=A9initialiser '%s' ?"
=20
-#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "Visualiser"
=20
-#: lib/checkout_op.tcl:600
+#: lib/checkout_op.tcl:635
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1020,7 +1060,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
 msgid "Create New Repository"
 msgstr "Cr=C3=A9er nouveau d=C3=A9p=C3=B4t"
=20
@@ -1028,7 +1068,7 @@ msgstr "Cr=C3=A9er nouveau d=C3=A9p=C3=B4t"
 msgid "New..."
 msgstr "Nouveau..."
=20
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
 msgid "Clone Existing Repository"
 msgstr "Cloner un d=C3=A9p=C3=B4t existant"
=20
@@ -1036,7 +1076,7 @@ msgstr "Cloner un d=C3=A9p=C3=B4t existant"
 msgid "Clone..."
 msgstr "Cloner..."
=20
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
 msgid "Open Existing Repository"
 msgstr "Ouvrir un d=C3=A9p=C3=B4t existant"
=20
@@ -1052,197 +1092,199 @@ msgstr "D=C3=A9p=C3=B4ts r=C3=A9cemment utili=
s=C3=A9s"
 msgid "Open Recent Repository:"
 msgstr "Ouvrir un d=C3=A9p=C3=B4t r=C3=A9cent :"
=20
-#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
-#: lib/choose_repository.tcl:316
+#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
+#: lib/choose_repository.tcl:320
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "La cr=C3=A9ation du d=C3=A9p=C3=B4t %s a =C3=A9chou=C3=A9 :"
=20
-#: lib/choose_repository.tcl:387
+#: lib/choose_repository.tcl:391
 msgid "Directory:"
 msgstr "R=C3=A9pertoire :"
=20
-#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
-#: lib/choose_repository.tcl:1017
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
+#: lib/choose_repository.tcl:1052
 msgid "Git Repository"
 msgstr "D=C3=A9p=C3=B4t Git"
=20
-#: lib/choose_repository.tcl:442
+#: lib/choose_repository.tcl:448
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Le r=C3=A9pertoire %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:446
+#: lib/choose_repository.tcl:452
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Le fichier %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:466
 msgid "Clone"
 msgstr "Cloner"
=20
-#: lib/choose_repository.tcl:473
+#: lib/choose_repository.tcl:479
 msgid "Source Location:"
 msgstr "Emplacement source :"
=20
-#: lib/choose_repository.tcl:484
+#: lib/choose_repository.tcl:490
 msgid "Target Directory:"
 msgstr "R=C3=A9pertoire cible :"
=20
-#: lib/choose_repository.tcl:496
+#: lib/choose_repository.tcl:502
 msgid "Clone Type:"
 msgstr "Type de clonage :"
=20
-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:508
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (rapide, semi-redondant, liens durs)"
=20
-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
=20
-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:520
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Partag=C3=A9 (le plus rapide, non recommand=C3=A9, pas de sauv=
egarde)"
=20
-#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
-#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
-#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
+#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
+#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "'%s' n'est pas un d=C3=A9p=C3=B4t Git."
=20
-#: lib/choose_repository.tcl:586
+#: lib/choose_repository.tcl:592
 msgid "Standard only available for local repository."
 msgstr "Standard n'est disponible que pour un d=C3=A9p=C3=B4t local."
=20
-#: lib/choose_repository.tcl:590
+#: lib/choose_repository.tcl:596
 msgid "Shared only available for local repository."
 msgstr "Partag=C3=A9 n'est disponible que pour un d=C3=A9p=C3=B4t loca=
l."
=20
-#: lib/choose_repository.tcl:611
+#: lib/choose_repository.tcl:617
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "L'emplacement %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:622
+#: lib/choose_repository.tcl:628
 msgid "Failed to configure origin"
 msgstr "La configuration de l'origine a =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:634
+#: lib/choose_repository.tcl:640
 msgid "Counting objects"
 msgstr "D=C3=A9compte des objets"
=20
-#: lib/choose_repository.tcl:635
+#: lib/choose_repository.tcl:641
 msgid "buckets"
 msgstr "paniers"
=20
-#: lib/choose_repository.tcl:659
+#: lib/choose_repository.tcl:665
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Impossible de copier 'objects/info/alternates' : %s"
=20
-#: lib/choose_repository.tcl:695
+#: lib/choose_repository.tcl:701
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Il n'y a rien =C3=A0 cloner depuis %s."
=20
-#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
-#: lib/choose_repository.tcl:923
+#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
+#: lib/choose_repository.tcl:929
 msgid "The 'master' branch has not been initialized."
 msgstr "La branche 'master' n'a pas =C3=A9t=C3=A9 initialis=C3=A9e."
=20
-#: lib/choose_repository.tcl:710
+#: lib/choose_repository.tcl:716
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "Les liens durs ne sont pas support=C3=A9s. Une copie sera effe=
ctu=C3=A9e =C3=A0 la
place." +msgstr ""
+"Les liens durs ne sont pas support=C3=A9s. Une copie sera effectu=C3=A9=
e =C3=A0 la place."
=20
-#: lib/choose_repository.tcl:722
+#: lib/choose_repository.tcl:728
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Clonage depuis %s"
=20
-#: lib/choose_repository.tcl:753
+#: lib/choose_repository.tcl:759
 msgid "Copying objects"
 msgstr "Copie des objets"
=20
-#: lib/choose_repository.tcl:754
+#: lib/choose_repository.tcl:760
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:778
+#: lib/choose_repository.tcl:784
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Impossible de copier l'objet : %s"
=20
-#: lib/choose_repository.tcl:788
+#: lib/choose_repository.tcl:794
 msgid "Linking objects"
 msgstr "Liaison des objets"
=20
-#: lib/choose_repository.tcl:789
+#: lib/choose_repository.tcl:795
 msgid "objects"
 msgstr "objets"
=20
-#: lib/choose_repository.tcl:797
+#: lib/choose_repository.tcl:803
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Impossible cr=C3=A9er un lien dur pour l'objet : %s"
=20
-#: lib/choose_repository.tcl:852
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "Impossible de r=C3=A9cup=C3=A9rer les branches et objets. Voir la sor=
tie console pour
" "plus de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:863
+#: lib/choose_repository.tcl:869
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 "Impossible de r=C3=A9cup=C3=A9rer les marques (tags). Voir la sortie =
console pour
plus " "de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:887
+#: lib/choose_repository.tcl:893
 msgid "Cannot determine HEAD.  See console output for details."
-msgstr "Impossible de d=C3=A9terminer HEAD. Voir la sortie console pou=
r plus de
d=C3=A9tails." +msgstr ""
+"Impossible de d=C3=A9terminer HEAD. Voir la sortie console pour plus =
de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:896
+#: lib/choose_repository.tcl:902
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Impossible de nettoyer %s"
=20
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:908
 msgid "Clone failed."
 msgstr "Le clonage a =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:909
+#: lib/choose_repository.tcl:915
 msgid "No default branch obtained."
 msgstr "Aucune branche par d=C3=A9faut n'a =C3=A9t=C3=A9 obtenue."
=20
-#: lib/choose_repository.tcl:920
+#: lib/choose_repository.tcl:926
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "Impossible de r=C3=A9soudre %s comme commit."
=20
-#: lib/choose_repository.tcl:932
+#: lib/choose_repository.tcl:938
 msgid "Creating working directory"
 msgstr "Cr=C3=A9ation du r=C3=A9pertoire de travail"
=20
-#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
-#: lib/index.tcl:196
+#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
+#: lib/index.tcl:198
 msgid "files"
 msgstr "fichiers"
=20
-#: lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:968
 msgid "Initial file checkout failed."
 msgstr "Le chargement initial du fichier a =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:978
+#: lib/choose_repository.tcl:1011
 msgid "Open"
 msgstr "Ouvrir"
=20
-#: lib/choose_repository.tcl:988
+#: lib/choose_repository.tcl:1021
 msgid "Repository:"
 msgstr "D=C3=A9p=C3=B4t :"
=20
-#: lib/choose_repository.tcl:1037
+#: lib/choose_repository.tcl:1072
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Impossible d'ouvrir le d=C3=A9p=C3=B4t %s :"
@@ -1314,19 +1356,24 @@ msgstr ""
 "termin=C3=A9e. Vous ne pouvez pas corriger le commit pr=C3=A9c=C3=A9d=
ent sauf si vous "
 "abandonnez la fusion courante.\n"
=20
-#: lib/commit.tcl:49
+#: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
 msgstr "Erreur lors du chargement des donn=C3=A9es de commit pour corr=
ection :"
=20
-#: lib/commit.tcl:76
+#: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
 msgstr "Impossible d'obtenir votre identit=C3=A9 :"
=20
-#: lib/commit.tcl:81
+#: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "GIT_COMMITTER_IDENT invalide :"
=20
-#: lib/commit.tcl:133
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "attention : Tcl ne supporte pas le codage '%s'."
+
+#: lib/commit.tcl:149
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1344,7 +1391,7 @@ msgstr ""
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement.\n"
=20
-#: lib/commit.tcl:156
+#: lib/commit.tcl:172
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1357,7 +1404,7 @@ msgstr ""
 "Le fichier %s a des conflicts de fusion. Vous devez les r=C3=A9soudre=
 et pr=C3=A9-"
 "commiter le fichier avant de pouvoir commiter.\n"
=20
-#: lib/commit.tcl:164
+#: lib/commit.tcl:180
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1368,7 +1415,7 @@ msgstr ""
 "\n"
 "Le fichier %s ne peut pas =C3=AAtre commit=C3=A9 par ce programme.\n"
=20
-#: lib/commit.tcl:172
+#: lib/commit.tcl:188
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1378,7 +1425,7 @@ msgstr ""
 "\n"
 "Vous devez indexer au moins 1 fichier avant de pouvoir commiter.\n"
=20
-#: lib/commit.tcl:187
+#: lib/commit.tcl:203
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1396,45 +1443,40 @@ msgstr ""
 "- Deuxi=C3=A8me ligne : rien.\n"
 "- Lignes suivantes : D=C3=A9crire pourquoi ces modifications sont bon=
nes.\n"
=20
-#: lib/commit.tcl:211
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "attention : Tcl ne supporte pas le codage '%s'."
-
-#: lib/commit.tcl:227
+#: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
 msgstr "Lancement de l'action d'avant-commit..."
=20
-#: lib/commit.tcl:242
+#: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
 msgstr "Commit refus=C3=A9 par l'action d'avant-commit."
=20
-#: lib/commit.tcl:265
+#: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
 msgstr "Lancement de l'action \"message de commit\"..."
=20
-#: lib/commit.tcl:280
+#: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
 msgstr "Commit refus=C3=A9 par l'action \"message de commit\"."
=20
-#: lib/commit.tcl:293
+#: lib/commit.tcl:300
 msgid "Committing changes..."
 msgstr "Commit des modifications..."
=20
-#: lib/commit.tcl:309
+#: lib/commit.tcl:316
 msgid "write-tree failed:"
 msgstr "write-tree a =C3=A9chou=C3=A9 :"
=20
-#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
+#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
 msgid "Commit failed."
 msgstr "Le commit a =C3=A9chou=C3=A9."
=20
-#: lib/commit.tcl:327
+#: lib/commit.tcl:334
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "Le commit %s semble =C3=AAtre corrompu"
=20
-#: lib/commit.tcl:332
+#: lib/commit.tcl:339
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1449,19 +1491,19 @@ msgstr ""
 "\n"
 "Une resynchronisation va =C3=AAtre lanc=C3=A9e tout de suite automati=
quement.\n"
=20
-#: lib/commit.tcl:339
+#: lib/commit.tcl:346
 msgid "No changes to commit."
 msgstr "Pas de modifications =C3=A0 commiter."
=20
-#: lib/commit.tcl:353
+#: lib/commit.tcl:360
 msgid "commit-tree failed:"
 msgstr "commit-tree a =C3=A9chou=C3=A9 :"
=20
-#: lib/commit.tcl:373
+#: lib/commit.tcl:381
 msgid "update-ref failed:"
 msgstr "update-ref a =C3=A9chou=C3=A9 :"
=20
-#: lib/commit.tcl:461
+#: lib/commit.tcl:469
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "Commit %s cr=C3=A9=C3=A9 : %s"
@@ -1514,13 +1556,13 @@ msgstr "Compression de la base des objets"
 msgid "Verifying the object database with fsck-objects"
 msgstr "V=C3=A9rification de la base des objets avec fsck-objects"
=20
-#: lib/database.tcl:108
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
 "To maintain optimal performance it is strongly recommended that you
compress " -"the database when more than %i loose objects exist.\n"
+"the database.\n"
 "\n"
 "Compress the database now?"
 msgstr ""
@@ -1528,8 +1570,7 @@ msgstr ""
 "particulier.\n"
 "\n"
 "Pour conserver une performance optimale, il est fortement recommand=C3=
=A9 de "
-"comprimer la base quand plus de %i objets ayant leur fichier particul=
ier "
-"existent.\n"
+"comprimer la base de donn=C3=A9e.\n"
 "\n"
 "Comprimer la base maintenant ?"
=20
@@ -1538,7 +1579,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Date invalide de Git : %s"
=20
-#: lib/diff.tcl:59
+#: lib/diff.tcl:64
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1561,12 +1602,12 @@ msgstr ""
 "Une resynchronisation va =C3=AAtre lanc=C3=A9e automatiquement pour t=
rouver d'autres "
 "fichiers qui pourraient se trouver dans le m=C3=AAme =C3=A9tat."
=20
-#: lib/diff.tcl:99
+#: lib/diff.tcl:104
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "Chargement des diff=C3=A9rences de %s..."
=20
-#: lib/diff.tcl:120
+#: lib/diff.tcl:125
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
@@ -1574,7 +1615,7 @@ msgstr ""
 "LOCAL : supprim=C3=A9\n"
 "DISTANT :\n"
=20
-#: lib/diff.tcl:125
+#: lib/diff.tcl:130
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
@@ -1582,32 +1623,32 @@ msgstr ""
 "DISTANT : supprim=C3=A9\n"
 "LOCAL :\n"
=20
-#: lib/diff.tcl:132
+#: lib/diff.tcl:137
 msgid "LOCAL:\n"
 msgstr "LOCAL :\n"
=20
-#: lib/diff.tcl:135
+#: lib/diff.tcl:140
 msgid "REMOTE:\n"
 msgstr "DISTANT :\n"
=20
-#: lib/diff.tcl:197 lib/diff.tcl:296
+#: lib/diff.tcl:202 lib/diff.tcl:319
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Impossible d'afficher %s"
=20
-#: lib/diff.tcl:198
+#: lib/diff.tcl:203
 msgid "Error loading file:"
 msgstr "Erreur lors du chargement du fichier :"
=20
-#: lib/diff.tcl:205
+#: lib/diff.tcl:210
 msgid "Git Repository (subproject)"
 msgstr "D=C3=A9p=C3=B4t Git (sous projet)"
=20
-#: lib/diff.tcl:217
+#: lib/diff.tcl:222
 msgid "* Binary file (not showing content)."
 msgstr "* Fichier binaire (pas d'apper=C3=A7u du contenu)."
=20
-#: lib/diff.tcl:222
+#: lib/diff.tcl:227
 #, tcl-format
 msgid ""
 "* Untracked file is %d bytes.\n"
@@ -1616,7 +1657,7 @@ msgstr ""
 "* Le fichier non suivi fait %d octets.\n"
 "* Seuls les %d premiers octets sont montr=C3=A9s.\n"
=20
-#: lib/diff.tcl:228
+#: lib/diff.tcl:233
 #, tcl-format
 msgid ""
 "\n"
@@ -1627,19 +1668,19 @@ msgstr ""
 "* Fichier suivi raccourcis ici de %s.\n"
 "* Pour voir le fichier entier, utilisez un =C3=A9diteur externe.\n"
=20
-#: lib/diff.tcl:436
+#: lib/diff.tcl:482
 msgid "Failed to unstage selected hunk."
 msgstr "=C3=89chec lors de la d=C3=A9sindexation de la section s=C3=A9=
lectionn=C3=A9e."
=20
-#: lib/diff.tcl:443
+#: lib/diff.tcl:489
 msgid "Failed to stage selected hunk."
 msgstr "=C3=89chec lors de l'indexation de la section."
=20
-#: lib/diff.tcl:509
+#: lib/diff.tcl:568
 msgid "Failed to unstage selected line."
 msgstr "=C3=89chec lors de la d=C3=A9sindexation de la ligne s=C3=A9le=
ctionn=C3=A9e."
=20
-#: lib/diff.tcl:517
+#: lib/diff.tcl:576
 msgid "Failed to stage selected line."
 msgstr "=C3=89chec lors de l'indexation de la ligne."
=20
@@ -1676,7 +1717,7 @@ msgstr "Impossible de d=C3=A9verrouiller l'index.=
"
 msgid "Index Error"
 msgstr "Erreur de l'index"
=20
-#: lib/index.tcl:21
+#: lib/index.tcl:17
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
@@ -1684,7 +1725,7 @@ msgstr ""
 "=C3=89chec de la mise =C3=A0 jour de l'index. Une resynchronisation v=
a =C3=AAtre lanc=C3=A9e "
 "automatiquement."
=20
-#: lib/index.tcl:27
+#: lib/index.tcl:28
 msgid "Continue"
 msgstr "Continuer"
=20
@@ -1692,45 +1733,45 @@ msgstr "Continuer"
 msgid "Unlock Index"
 msgstr "D=C3=A9verrouiller l'index"
=20
-#: lib/index.tcl:287
+#: lib/index.tcl:289
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "D=C3=A9sindexation de : %s"
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:328
 msgid "Ready to commit."
 msgstr "Pr=C3=AAt =C3=A0 =C3=AAtre commit=C3=A9."
=20
-#: lib/index.tcl:339
+#: lib/index.tcl:341
 #, tcl-format
 msgid "Adding %s"
 msgstr "Ajout de %s"
=20
-#: lib/index.tcl:396
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "Annuler les modifications dans le fichier %s ? "
=20
-#: lib/index.tcl:398
+#: lib/index.tcl:400
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "Annuler les modifications dans ces %i fichiers ?"
=20
-#: lib/index.tcl:406
+#: lib/index.tcl:408
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues par "
 "l'annulation."
=20
-#: lib/index.tcl:409
+#: lib/index.tcl:411
 msgid "Do Nothing"
 msgstr "Ne rien faire"
=20
-#: lib/index.tcl:427
+#: lib/index.tcl:429
 msgid "Reverting selected files"
 msgstr "Annuler modifications dans fichiers selectionn=C3=A9s"
=20
-#: lib/index.tcl:431
+#: lib/index.tcl:433
 #, tcl-format
 msgid "Reverting %s"
 msgstr "Annulation des modifications dans %s"
@@ -1913,7 +1954,8 @@ msgstr ""
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr "Le fichier %s semble avoir des conflits non r=C3=A9solus, inde=
xer quand
m=C3=AAme ?" +msgstr ""
+"Le fichier %s semble avoir des conflits non r=C3=A9solus, indexer qua=
nd m=C3=AAme ?"
=20
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1922,7 +1964,9 @@ msgstr "Ajouter une r=C3=A9solution pour %s"
=20
 #: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr "Impossible de r=C3=A9soudre la suppression ou de relier des co=
nflits en
utilisant un outil" +msgstr ""
+"Impossible de r=C3=A9soudre la suppression ou de relier des conflits =
en
utilisant " +"un outil"
=20
 #: lib/mergetool.tcl:146
 msgid "Conflict file does not exist"
@@ -2171,7 +2215,8 @@ msgstr "R=C3=A9cup=C3=A9ration de %s"
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "Pas de m=C3=A9thode connue pour initialiser le d=C3=A9p=C3=B4t=
 =C3=A0 l'emplacement
'%s'."=20
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
 #, tcl-format
 msgid "push %s"
 msgstr "pousser %s"
@@ -2189,11 +2234,11 @@ msgstr "Supprimer une branche =C3=A0 distance"
 msgid "From Repository"
 msgstr "D=C3=A9p=C3=B4t source"
=20
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "Branche distante :"
=20
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
 msgid "Arbitrary Location:"
 msgstr "Emplacement arbitraire :"
=20
@@ -2209,10 +2254,6 @@ msgstr "Supprimer seulement si"
 msgid "Merged Into:"
 msgstr "Fusionn=C3=A9 dans :"
=20
-#: lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr "Toujours (ne pas v=C3=A9rifier les fusions)"
-
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
 msgstr "Une branche est n=C3=A9cessaire pour 'Fusionn=C3=A9 dans'."
@@ -2235,32 +2276,23 @@ msgid ""
 "necessary commits.  Try fetching from %s first."
 msgstr ""
 "Un ou plusieurs des tests de fusion ont =C3=A9chou=C3=A9 parce que vo=
us n'avez pas "
-"r=C3=A9cup=C3=A9r=C3=A9 les commits n=C3=A9cessaires. Essayez de r=C3=
=A9cup=C3=A9rer =C3=A0 partir de %s
d'abord." +"r=C3=A9cup=C3=A9r=C3=A9 les commits n=C3=A9cessaires. Essay=
ez de r=C3=A9cup=C3=A9rer =C3=A0 partir
de %s " +"d'abord."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
 msgstr "Merci de s=C3=A9lectionner une ou plusieurs branches =C3=A0 su=
pprimer."
=20
-#: lib/remote_branch_delete.tcl:216
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr ""
-"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9es.=
\n"
-"\n"
-"Supprimer les branches s=C3=A9lectionn=C3=A9es ?"
-
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "Suppression des branches de %s"
=20
-#: lib/remote_branch_delete.tcl:286
+#: lib/remote_branch_delete.tcl:292
 msgid "No repository selected."
 msgstr "Aucun d=C3=A9p=C3=B4t n'est s=C3=A9lectionn=C3=A9."
=20
-#: lib/remote_branch_delete.tcl:291
+#: lib/remote_branch_delete.tcl:297
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "Synchronisation de %s..."
@@ -2281,11 +2313,11 @@ msgstr "Pr=C3=A9c=C3=A9dent"
 msgid "Case-Sensitive"
 msgstr "Sensible =C3=A0 la casse"
=20
-#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
 msgstr "Impossible d'=C3=A9crire le raccourci :"
=20
-#: lib/shortcut.tcl:136
+#: lib/shortcut.tcl:137
 msgid "Cannot write icon:"
 msgstr "Impossible d'=C3=A9crire l'ic=C3=B4ne :"
=20
@@ -2440,7 +2472,8 @@ msgstr "Montrer une bo=C3=AEte de dialogue avant =
le
lancement"=20
 #: lib/tools_dlg.tcl:80
 msgid "Ask the user to select a revision (sets $REVISION)"
-msgstr "Demander =C3=A0 l'utilisateur de s=C3=A9lectionner une r=C3=A9=
vision (change
$REVISION)" +msgstr ""
+"Demander =C3=A0 l'utilisateur de s=C3=A9lectionner une r=C3=A9vision =
(change $REVISION)"
=20
 #: lib/tools_dlg.tcl:85
 msgid "Ask the user for additional arguments (sets $ARGS)"
@@ -2521,38 +2554,51 @@ msgstr "Nettoyer les branches de suivi supprim=C3=
=A9es de
%s" msgid "Pushing changes to %s"
 msgstr "Les modifications sont pouss=C3=A9es vers %s"
=20
-#: lib/transport.tcl:72
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Dupliquer dans %s"
+
+#: lib/transport.tcl:82
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "Pousse %s %s vers %s"
=20
-#: lib/transport.tcl:89
+#: lib/transport.tcl:100
 msgid "Push Branches"
 msgstr "Pousser branches"
=20
-#: lib/transport.tcl:103
+#: lib/transport.tcl:114
 msgid "Source Branches"
 msgstr "Branches source"
=20
-#: lib/transport.tcl:120
+#: lib/transport.tcl:131
 msgid "Destination Repository"
 msgstr "D=C3=A9p=C3=B4t de destination"
=20
-#: lib/transport.tcl:158
+#: lib/transport.tcl:169
 msgid "Transfer Options"
 msgstr "Options de transfert"
=20
-#: lib/transport.tcl:160
+#: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""
 "Forcer l'=C3=A9crasement d'une branche existante (peut supprimer des =
"
 "modifications)"
=20
-#: lib/transport.tcl:164
+#: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
 msgstr "Utiliser des petits paquets (pour les connexions lentes)"
=20
-#: lib/transport.tcl:168
+#: lib/transport.tcl:179
 msgid "Include tags"
 msgstr "Inclure les marques (tags)"
