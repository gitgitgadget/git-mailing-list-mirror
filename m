From: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
Subject: [PATCH] git-gui: update all remaining translations to French.
Date: Mon, 11 Aug 2008 17:19:17 -0400
Message-ID: <1218489557-10169-2-git-send-email-alexandre.bourget@savoirfairelinux.com>
References: <vpqr68vuzoo.fsf@bauges.imag.fr>
 <1218489557-10169-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 23:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeoL-0005FV-LY
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 23:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757763AbYHKVTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 17:19:15 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757663AbYHKVTP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 17:19:15 -0400
Received: from mail.savoirfairelinux.net ([69.28.212.163]:48709 "EHLO
	open-xchange.savoirfairelinux.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754445AbYHKVTG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 17:19:06 -0400
Received: from localhost (unknown [127.0.0.1])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 30DA146166E;
	Mon, 11 Aug 2008 21:19:05 +0000 (UTC)
Received: from open-xchange.savoirfairelinux.net ([127.0.0.1])
	by localhost (open-xchange.savoirfairelinux.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHxbkoWoWhTO; Mon, 11 Aug 2008 17:18:50 -0400 (EDT)
Received: from xenon.inside.savoirfairelinux.net (mtl.savoirfairelinux.net [199.243.85.90])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 911EC4618E2;
	Mon, 11 Aug 2008 17:18:47 -0400 (EDT)
Received: from localhost.localdomain (dyn221.inside.savoirfairelinux.net [192.168.1.221])
	by xenon.inside.savoirfairelinux.net (Postfix) with ESMTP id EA4A8F68F3;
	Mon, 11 Aug 2008 17:18:46 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1218489557-10169-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92003>

Simply..

Signed-off-by: Alexandre Bourget <alexandre.bourget@savoirfairelinux.co=
m>
---
 git-gui/po/fr.po |  553 +++++++++++++++++++++++++++++-----------------=
--------
 1 files changed, 299 insertions(+), 254 deletions(-)

diff --git a/git-gui/po/fr.po b/git-gui/po/fr.po
index 128cd69..26b866f 100644
--- a/git-gui/po/fr.po
+++ b/git-gui/po/fr.po
@@ -9,8 +9,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: fr\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-08-11 16:28-0400\n"
+"POT-Creation-Date: 2008-08-02 14:45-0700\n"
+"PO-Revision-Date: 2008-08-11 17:12-0400\n"
 "Last-Translator: Alexandre Bourget <alexandre.bourget@savoirfairelinu=
x.com>\n"
 "Language-Team: Fran=C3=A7ais <fr@li.org>\n"
 "MIME-Version: 1.0\n"
@@ -19,33 +19,33 @@ msgstr ""
 "X-Generator: KBabel 1.11.4\n"
 "Plural-Forms:  nplurals=3D2; plural=3D(n > 1);\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:688 git-gui.sh:702 git-gui.sh:715 git-gui.=
sh:798
+#: git-gui.sh:817
 msgid "git-gui: fatal error"
 msgstr "git-gui: erreur fatale"
=20
-#: git-gui.sh:593
+#: git-gui.sh:644
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Police invalide sp=C3=A9cifi=C3=A9e dans %s :"
=20
-#: git-gui.sh:620
+#: git-gui.sh:674
 msgid "Main Font"
 msgstr "Police principale"
=20
-#: git-gui.sh:621
+#: git-gui.sh:675
 msgid "Diff/Console Font"
 msgstr "Police diff/console"
=20
-#: git-gui.sh:635
+#: git-gui.sh:689
 msgid "Cannot find git in PATH."
 msgstr "Impossible de trouver git dans PATH."
=20
-#: git-gui.sh:662
+#: git-gui.sh:716
 msgid "Cannot parse Git version string:"
 msgstr "Impossible de parser la version de Git :"
=20
-#: git-gui.sh:680
+#: git-gui.sh:734
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -64,378 +64,381 @@ msgstr ""
 "\n"
 "Peut'on consid=C3=A9rer que '%s' est en version 1.5.0 ?\n"
=20
-#: git-gui.sh:918
+#: git-gui.sh:972
 msgid "Git directory not found:"
 msgstr "Impossible de trouver le r=C3=A9pertoire git :"
=20
-#: git-gui.sh:925
+#: git-gui.sh:979
 msgid "Cannot move to top of working directory:"
 msgstr "Impossible d'aller =C3=A0 la racine du r=C3=A9pertoire de trav=
ail :"
=20
-#: git-gui.sh:932
+#: git-gui.sh:986
 msgid "Cannot use funny .git directory:"
 msgstr "Impossible d'utiliser le r=C3=A9pertoire .git:"
=20
-#: git-gui.sh:937
+#: git-gui.sh:991
 msgid "No working directory"
 msgstr "Aucun r=C3=A9pertoire de travail"
=20
-#: git-gui.sh:1084 lib/checkout_op.tcl:283
+#: git-gui.sh:1138 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "Rafraichissement du status des fichiers..."
=20
-#: git-gui.sh:1149
+#: git-gui.sh:1194
 msgid "Scanning for modified files ..."
 msgstr "Recherche de fichiers modifi=C3=A9s..."
=20
-#: git-gui.sh:1324 lib/browser.tcl:246
+#: git-gui.sh:1369 lib/browser.tcl:246
 msgid "Ready."
 msgstr "Pr=C3=AAt."
=20
-#: git-gui.sh:1590
+#: git-gui.sh:1635
 msgid "Unmodified"
 msgstr "Non modifi=C3=A9"
=20
-#: git-gui.sh:1592
+#: git-gui.sh:1637
 msgid "Modified, not staged"
 msgstr "Modifi=C3=A9, pas index=C3=A9"
=20
-#: git-gui.sh:1593 git-gui.sh:1598
+#: git-gui.sh:1638 git-gui.sh:1643
 msgid "Staged for commit"
 msgstr "Index=C3=A9"
=20
-#: git-gui.sh:1594 git-gui.sh:1599
+#: git-gui.sh:1639 git-gui.sh:1644
 msgid "Portions staged for commit"
 msgstr "Portions index=C3=A9es"
=20
-#: git-gui.sh:1595 git-gui.sh:1600
+#: git-gui.sh:1640 git-gui.sh:1645
 msgid "Staged for commit, missing"
 msgstr "Index=C3=A9s, manquant"
=20
-#: git-gui.sh:1597
+#: git-gui.sh:1642
 msgid "Untracked, not staged"
 msgstr "Non versionn=C3=A9, non index=C3=A9"
=20
-#: git-gui.sh:1602
+#: git-gui.sh:1647
 msgid "Missing"
 msgstr "Manquant"
=20
-#: git-gui.sh:1603
+#: git-gui.sh:1648
 msgid "Staged for removal"
 msgstr "Index=C3=A9 pour suppression"
=20
-#: git-gui.sh:1604
+#: git-gui.sh:1649
 msgid "Staged for removal, still present"
 msgstr "Index=C3=A9 pour suppression, toujours pr=C3=A9sent"
=20
-#: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
+#: git-gui.sh:1651 git-gui.sh:1652 git-gui.sh:1653 git-gui.sh:1654
 msgid "Requires merge resolution"
 msgstr "N=C3=A9cessite la r=C3=A9solution d'une fusion"
=20
-#: git-gui.sh:1644
+#: git-gui.sh:1689
 msgid "Starting gitk... please wait..."
 msgstr "Lancement de gitk... un instant..."
=20
-#: git-gui.sh:1653
-#, tcl-format
-msgid ""
-"Unable to start gitk:\n"
-"\n"
-"%s does not exist"
-msgstr ""
-"Impossible de lancer gitk :\n"
-"\n"
-"%s inexistant"
+#: git-gui.sh:1698
+msgid "Couldn't find gitk in PATH"
+msgstr "Impossible de trouver gitk dans PATH."
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36
+#: git-gui.sh:1948 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "D=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:1861
+#: git-gui.sh:1949
 msgid "Edit"
 msgstr "Edition"
=20
-#: git-gui.sh:1863 lib/choose_rev.tcl:561
+#: git-gui.sh:1951 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "Branche"
=20
-#: git-gui.sh:1866 lib/choose_rev.tcl:548
+#: git-gui.sh:1954 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "Commit"
=20
-#: git-gui.sh:1869 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:1957 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
 msgid "Merge"
 msgstr "Fusionner"
=20
-#: git-gui.sh:1870 lib/choose_rev.tcl:557
+#: git-gui.sh:1958 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "D=C3=A9p=C3=B4t distant"
=20
-#: git-gui.sh:1879
+#: git-gui.sh:1967
 msgid "Browse Current Branch's Files"
 msgstr "Naviguer dans la branche courante"
=20
-#: git-gui.sh:1883
+#: git-gui.sh:1971
 msgid "Browse Branch Files..."
 msgstr "Naviguer dans la branche..."
=20
-#: git-gui.sh:1888
+#: git-gui.sh:1976
 msgid "Visualize Current Branch's History"
 msgstr "Visualiser historique branche courante"
=20
-#: git-gui.sh:1892
+#: git-gui.sh:1980
 msgid "Visualize All Branch History"
 msgstr "Voir l'historique de toutes les branches"
=20
-#: git-gui.sh:1899
+#: git-gui.sh:1987
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Naviguer l'arborescence de %s"
=20
-#: git-gui.sh:1901
+#: git-gui.sh:1989
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Voir l'historique de la branche: %s"
=20
-#: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1994 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "Statistiques du d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:1909 lib/database.tcl:34
+#: git-gui.sh:1997 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "Comprimer le d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:1912
+#: git-gui.sh:2000
 msgid "Verify Database"
 msgstr "V=C3=A9rifier le d=C3=A9p=C3=B4t"
=20
-#: git-gui.sh:1919 git-gui.sh:1923 git-gui.sh:1927 lib/shortcut.tcl:7
+#: git-gui.sh:2007 git-gui.sh:2011 git-gui.sh:2015 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "Cr=C3=A9er ic=C3=B4ne sur bureau"
=20
-#: git-gui.sh:1932 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2023 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
 msgid "Quit"
 msgstr "Quitter"
=20
-#: git-gui.sh:1939
+#: git-gui.sh:2031
 msgid "Undo"
 msgstr "D=C3=A9faire"
=20
-#: git-gui.sh:1942
+#: git-gui.sh:2034
 msgid "Redo"
 msgstr "Refaire"
=20
-#: git-gui.sh:1946 git-gui.sh:2443
+#: git-gui.sh:2038 git-gui.sh:2545
 msgid "Cut"
 msgstr "Couper"
=20
-#: git-gui.sh:1949 git-gui.sh:2446 git-gui.sh:2520 git-gui.sh:2614
+#: git-gui.sh:2041 git-gui.sh:2548 git-gui.sh:2622 git-gui.sh:2715
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Copier"
=20
-#: git-gui.sh:1952 git-gui.sh:2449
+#: git-gui.sh:2044 git-gui.sh:2551
 msgid "Paste"
 msgstr "Coller"
=20
-#: git-gui.sh:1955 git-gui.sh:2452 lib/branch_delete.tcl:26
+#: git-gui.sh:2047 git-gui.sh:2554 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "Supprimer"
=20
-#: git-gui.sh:1959 git-gui.sh:2456 git-gui.sh:2618 lib/console.tcl:71
+#: git-gui.sh:2051 git-gui.sh:2558 git-gui.sh:2719 lib/console.tcl:71
 msgid "Select All"
 msgstr "Tout s=C3=A9lectionner"
=20
-#: git-gui.sh:1968
+#: git-gui.sh:2060
 msgid "Create..."
 msgstr "Cr=C3=A9er..."
=20
-#: git-gui.sh:1974
+#: git-gui.sh:2066
 msgid "Checkout..."
 msgstr "Charger (checkout)..."
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2072
 msgid "Rename..."
 msgstr "Renommer..."
=20
-#: git-gui.sh:1985 git-gui.sh:2085
+#: git-gui.sh:2077 git-gui.sh:2187
 msgid "Delete..."
 msgstr "Supprimer..."
=20
-#: git-gui.sh:1990
+#: git-gui.sh:2082
 msgid "Reset..."
 msgstr "R=C3=A9initialiser..."
=20
-#: git-gui.sh:2002 git-gui.sh:2389
+#: git-gui.sh:2094 git-gui.sh:2491
 msgid "New Commit"
 msgstr "Nouveau commit"
=20
-#: git-gui.sh:2010 git-gui.sh:2396
+#: git-gui.sh:2102 git-gui.sh:2498
 msgid "Amend Last Commit"
 msgstr "Corriger dernier commit"
=20
-#: git-gui.sh:2019 git-gui.sh:2356 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2111 git-gui.sh:2458 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Recharger modifs."
=20
-#: git-gui.sh:2025
+#: git-gui.sh:2117
 msgid "Stage To Commit"
 msgstr "Indexer"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2123
 msgid "Stage Changed Files To Commit"
 msgstr "Indexer toutes modifications"
=20
-#: git-gui.sh:2037
+#: git-gui.sh:2129
 msgid "Unstage From Commit"
 msgstr "D=C3=A9sindexer"
=20
-#: git-gui.sh:2042 lib/index.tcl:395
+#: git-gui.sh:2134 lib/index.tcl:395
 msgid "Revert Changes"
 msgstr "Annuler les modifications (revert)"
=20
-#: git-gui.sh:2049 git-gui.sh:2368 git-gui.sh:2467
+#: git-gui.sh:2141 git-gui.sh:2702
+msgid "Show Less Context"
+msgstr "Montrer moins de contexte"
+
+#: git-gui.sh:2145 git-gui.sh:2706
+msgid "Show More Context"
+msgstr "Montrer plus de contexte"
+
+#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
 msgid "Sign Off"
 msgstr "Signer"
=20
-#: git-gui.sh:2053 git-gui.sh:2372
+#: git-gui.sh:2155 git-gui.sh:2474
 msgid "Commit@@verb"
 msgstr "Commiter"
=20
-#: git-gui.sh:2064
+#: git-gui.sh:2166
 msgid "Local Merge..."
 msgstr "Fusion locale..."
=20
-#: git-gui.sh:2069
+#: git-gui.sh:2171
 msgid "Abort Merge..."
 msgstr "Abandonner fusion..."
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2183
 msgid "Push..."
 msgstr "Pousser..."
=20
-#: git-gui.sh:2092 lib/choose_repository.tcl:41
-msgid "Apple"
-msgstr "Pomme"
-
-#: git-gui.sh:2095 git-gui.sh:2117 lib/about.tcl:14
+#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
 #, tcl-format
 msgid "About %s"
 msgstr "=C3=80 propos de %s"
=20
-#: git-gui.sh:2099
+#: git-gui.sh:2201
 msgid "Preferences..."
 msgstr "Pr=C3=A9f=C3=A9rences..."
=20
-#: git-gui.sh:2107 git-gui.sh:2639
+#: git-gui.sh:2209 git-gui.sh:2740
 msgid "Options..."
 msgstr "Options..."
=20
-#: git-gui.sh:2113 lib/choose_repository.tcl:47
+#: git-gui.sh:2215 lib/choose_repository.tcl:47
 msgid "Help"
 msgstr "Aide"
=20
-#: git-gui.sh:2154
+#: git-gui.sh:2256
 msgid "Online Documentation"
 msgstr "Documentation en ligne"
=20
-#: git-gui.sh:2238
+#: git-gui.sh:2340
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr "erreur fatale : pas d'infos sur le chemin %s : Fichier ou r=C3=
=A9pertoire inexistant"
+msgstr ""
+"erreur fatale : pas d'infos sur le chemin %s : Fichier ou r=C3=A9pert=
oire "
+"inexistant"
=20
-#: git-gui.sh:2271
+#: git-gui.sh:2373
 msgid "Current Branch:"
 msgstr "Branche courante :"
=20
-#: git-gui.sh:2292
+#: git-gui.sh:2394
 msgid "Staged Changes (Will Commit)"
 msgstr "Modifs. index=C3=A9es (pour commit)"
=20
-#: git-gui.sh:2312
+#: git-gui.sh:2414
 msgid "Unstaged Changes"
 msgstr "Modifs. non index=C3=A9es"
=20
-#: git-gui.sh:2362
+#: git-gui.sh:2464
 msgid "Stage Changed"
 msgstr "Indexer modifs."
=20
-#: git-gui.sh:2378 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2480 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "Pousser"
=20
-#: git-gui.sh:2408
+#: git-gui.sh:2510
 msgid "Initial Commit Message:"
 msgstr "Message de commit initial :"
=20
-#: git-gui.sh:2409
+#: git-gui.sh:2511
 msgid "Amended Commit Message:"
 msgstr "Message de commit corrig=C3=A9 :"
=20
-#: git-gui.sh:2410
+#: git-gui.sh:2512
 msgid "Amended Initial Commit Message:"
 msgstr "Message de commit initial corrig=C3=A9 :"
=20
-#: git-gui.sh:2411
+#: git-gui.sh:2513
 msgid "Amended Merge Commit Message:"
 msgstr "Message de commit de fusion corrig=C3=A9 :"
=20
-#: git-gui.sh:2412
+#: git-gui.sh:2514
 msgid "Merge Commit Message:"
 msgstr "Message de commit de fusion :"
=20
-#: git-gui.sh:2413
+#: git-gui.sh:2515
 msgid "Commit Message:"
 msgstr "Message de commit :"
=20
-#: git-gui.sh:2459 git-gui.sh:2622 lib/console.tcl:73
+#: git-gui.sh:2561 git-gui.sh:2723 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Copier tout"
=20
-#: git-gui.sh:2483 lib/blame.tcl:107
+#: git-gui.sh:2585 lib/blame.tcl:100
 msgid "File:"
 msgstr "Fichier :"
=20
-#: git-gui.sh:2589
+#: git-gui.sh:2691
 msgid "Apply/Reverse Hunk"
 msgstr "Appliquer/Inverser section"
=20
-#: git-gui.sh:2595
-msgid "Show Less Context"
-msgstr "Montrer moins de contexte"
-
-#: git-gui.sh:2602
-msgid "Show More Context"
-msgstr "Montrer plus de contexte"
+#: git-gui.sh:2696
+msgid "Apply/Reverse Line"
+msgstr "Appliquer/Inverser la ligne"
=20
-#: git-gui.sh:2610
+#: git-gui.sh:2711
 msgid "Refresh"
 msgstr "Rafraichir"
=20
-#: git-gui.sh:2631
+#: git-gui.sh:2732
 msgid "Decrease Font Size"
 msgstr "Diminuer la police"
=20
-#: git-gui.sh:2635
+#: git-gui.sh:2736
 msgid "Increase Font Size"
 msgstr "Agrandir la police"
=20
-#: git-gui.sh:2646
+#: git-gui.sh:2747
 msgid "Unstage Hunk From Commit"
 msgstr "D=C3=A9sindexer la section"
=20
-#: git-gui.sh:2648
+#: git-gui.sh:2748
+msgid "Unstage Line From Commit"
+msgstr "D=C3=A9sindexer la ligne"
+
+#: git-gui.sh:2750
 msgid "Stage Hunk For Commit"
 msgstr "Indexer la section"
=20
-#: git-gui.sh:2667
+#: git-gui.sh:2751
+msgid "Stage Line For Commit"
+msgstr "Indexer la ligne"
+
+#: git-gui.sh:2771
 msgid "Initializing..."
 msgstr "Initialisation..."
=20
-#: git-gui.sh:2762
+#: git-gui.sh:2876
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -452,7 +455,7 @@ msgstr ""
 "sous-processus de Git lanc=C3=A9s par %s\n"
 "\n"
=20
-#: git-gui.sh:2792
+#: git-gui.sh:2906
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -462,7 +465,7 @@ msgstr ""
 "Ceci est du =C3=A0 un probl=C3=A8me connu avec\n"
 "le binaire Tcl distribu=C3=A9 par Cygwin."
=20
-#: git-gui.sh:2797
+#: git-gui.sh:2911
 #, tcl-format
 msgid ""
 "\n"
@@ -483,64 +486,80 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - une interface graphique utilisateur pour Git"
=20
-#: lib/blame.tcl:77
+#: lib/blame.tcl:70
 msgid "File Viewer"
 msgstr "Visionneur de fichier"
=20
-#: lib/blame.tcl:81
+#: lib/blame.tcl:74
 msgid "Commit:"
 msgstr "Commit :"
=20
-#: lib/blame.tcl:264
+#: lib/blame.tcl:257
 msgid "Copy Commit"
 msgstr "Copier commit"
=20
-#: lib/blame.tcl:384
+#: lib/blame.tcl:260
+msgid "Do Full Copy Detection"
+msgstr "Lancer la d=C3=A9tection approfondie des copies"
+
+#: lib/blame.tcl:388
 #, tcl-format
 msgid "Reading %s..."
 msgstr "Lecture de %s..."
=20
-#: lib/blame.tcl:488
+#: lib/blame.tcl:492
 msgid "Loading copy/move tracking annotations..."
 msgstr "Chargement des annotations de suivi des copies/d=C3=A9placemen=
ts..."
=20
-#: lib/blame.tcl:508
+#: lib/blame.tcl:512
 msgid "lines annotated"
 msgstr "lignes annot=C3=A9es"
=20
-#: lib/blame.tcl:689
+#: lib/blame.tcl:704
 msgid "Loading original location annotations..."
 msgstr "Chargement des annotations d'emplacement original"
=20
-#: lib/blame.tcl:692
+#: lib/blame.tcl:707
 msgid "Annotation complete."
 msgstr "Annotation termin=C3=A9e."
=20
-#: lib/blame.tcl:746
+#: lib/blame.tcl:737
+msgid "Busy"
+msgstr "Occup=C3=A9"
+
+#: lib/blame.tcl:738
+msgid "Annotation process is already running."
+msgstr "Annotation en cours d'ex=C3=A9cution."
+
+#: lib/blame.tcl:777
+msgid "Running thorough copy detection..."
+msgstr "Recherche de copie approfondie en cours..."
+
+#: lib/blame.tcl:827
 msgid "Loading annotation..."
 msgstr "Chargement des annotations..."
=20
-#: lib/blame.tcl:802
+#: lib/blame.tcl:883
 msgid "Author:"
 msgstr "Auteur :"
=20
-#: lib/blame.tcl:806
+#: lib/blame.tcl:887
 msgid "Committer:"
 msgstr "Commiteur :"
=20
-#: lib/blame.tcl:811
+#: lib/blame.tcl:892
 msgid "Original File:"
 msgstr "Fichier original :"
=20
-#: lib/blame.tcl:925
+#: lib/blame.tcl:1006
 msgid "Originally By:"
 msgstr "A l'origine par :"
=20
-#: lib/blame.tcl:931
+#: lib/blame.tcl:1012
 msgid "In File:"
 msgstr "Dans le fichier :"
=20
-#: lib/blame.tcl:936
+#: lib/blame.tcl:1017
 msgid "Copied Or Moved Here By:"
 msgstr "Copi=C3=A9 ou d=C3=A9plac=C3=A9 ici par :"
=20
@@ -554,7 +573,7 @@ msgstr "Charger (checkout)"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:522 lib/choose_font.tcl:43 lib/merge.tcl:171
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:171
 #: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
 msgid "Cancel"
 msgstr "Annuler"
@@ -563,7 +582,7 @@ msgstr "Annuler"
 msgid "Revision"
 msgstr "R=C3=A9vision"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
242
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
244
 msgid "Options"
 msgstr "Options"
=20
@@ -615,7 +634,7 @@ msgstr "Non"
 msgid "Fast Forward Only"
 msgstr "Mise-=C3=A0-jour rectiligne seulement (fast-forward)"
=20
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
 msgid "Reset"
 msgstr "R=C3=A9initialiser"
=20
@@ -655,7 +674,7 @@ msgstr "Branches locales"
=20
 #: lib/branch_delete.tcl:52
 msgid "Delete Only If Merged Into"
-msgstr "Supprimer ssi fusion dedans"
+msgstr "Supprimer seulement si fusionn=C3=A9e dans:"
=20
 #: lib/branch_delete.tcl:54
 msgid "Always (Do not perform merge test.)"
@@ -705,7 +724,7 @@ msgstr "Nouveau nom :"
 msgid "Please select a branch to rename."
 msgstr "Merci de s=C3=A9lectionner une branche =C3=A0 renommer."
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "La branche '%s' existe d=C3=A9j=C3=A0."
@@ -737,31 +756,36 @@ msgid "Browse Branch Files"
 msgstr "Naviguer dans les fichiers de le branche"
=20
 #: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:474 lib/choose_repository.tcl:484
-#: lib/choose_repository.tcl:987
+#: lib/choose_repository.tcl:472 lib/choose_repository.tcl:482
+#: lib/choose_repository.tcl:985
 msgid "Browse"
 msgstr "Naviguer"
=20
-#: lib/checkout_op.tcl:79
+#: lib/checkout_op.tcl:84
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "R=C3=A9cup=C3=A9ration de %s =C3=A0 partir de %s"
=20
-#: lib/checkout_op.tcl:127
+#: lib/checkout_op.tcl:132
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "erreur fatale : Impossible de r=C3=A9soudre %s"
=20
-#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
 msgid "Close"
 msgstr "Fermer"
=20
-#: lib/checkout_op.tcl:169
+#: lib/checkout_op.tcl:174
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "La branche '%s' n'existe pas."
=20
-#: lib/checkout_op.tcl:206
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "=C3=89chec de la configuration simplifi=C3=A9e de git-pull pou=
r '%s'."
+
+#: lib/checkout_op.tcl:228
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -774,21 +798,21 @@ msgstr ""
 "Impossible de faire une avance rapide (fast forward) vers %s.\n"
 "Une fusion est n=C3=A9cessaire."
=20
-#: lib/checkout_op.tcl:220
+#: lib/checkout_op.tcl:242
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "La strat=C3=A9gie de fusion '%s' n'est pas support=C3=A9e."
=20
-#: lib/checkout_op.tcl:239
+#: lib/checkout_op.tcl:261
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "La mise =C3=A0 jour de '%s' a =C3=A9chou=C3=A9e."
=20
-#: lib/checkout_op.tcl:251
+#: lib/checkout_op.tcl:273
 msgid "Staging area (index) is already locked."
 msgstr "L'index (staging area) est d=C3=A9j=C3=A0 v=C3=A9rouill=C3=A9"
=20
-#: lib/checkout_op.tcl:266
+#: lib/checkout_op.tcl:288
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -797,36 +821,39 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du d=C3=A9p=C3=B4t\n"
+"L'=C3=A9tat lors de la derni=C3=A8re synchronisation ne correspond pl=
us =C3=A0 l'=C3=A9tat du "
+"d=C3=A9p=C3=B4t\n"
 "\n"
-"Un autre programme Git a modifi=C3=A9 ce d=C3=A9p=C3=B4t depuis la de=
rni=C3=A8re synchronisation. Une resynchronisation doit =C3=AAtre effec=
tu=C3=A9e avant de pouvoir modifier la branche courante.\n"
+"Un autre programme Git a modifi=C3=A9 ce d=C3=A9p=C3=B4t depuis la de=
rni=C3=A8re "
+"synchronisation. Une resynchronisation doit =C3=AAtre effectu=C3=A9e =
avant de pouvoir "
+"modifier la branche courante.\n"
 "\n"
 "Cela va =C3=AAtre fait tout de suite automatiquement.\n"
=20
-#: lib/checkout_op.tcl:322
+#: lib/checkout_op.tcl:344
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "Mise =C3=A0 jour du r=C3=A9pertoire courant avec '%s'..."
=20
-#: lib/checkout_op.tcl:323
+#: lib/checkout_op.tcl:345
 msgid "files checked out"
 msgstr "fichiers charg=C3=A9s"
=20
-#: lib/checkout_op.tcl:353
+#: lib/checkout_op.tcl:375
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "Chargement de '%s' abandonn=C3=A9 (il est n=C3=A9cessaire de f=
usionner des fichiers)."
=20
-#: lib/checkout_op.tcl:354
+#: lib/checkout_op.tcl:376
 msgid "File level merge required."
 msgstr "Il est n=C3=A9cessaire de fusionner des fichiers."
=20
-#: lib/checkout_op.tcl:358
+#: lib/checkout_op.tcl:380
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Le r=C3=A9pertoire de travail reste sur la branche '%s'."
=20
-#: lib/checkout_op.tcl:429
+#: lib/checkout_op.tcl:451
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -838,30 +865,30 @@ msgstr ""
 "Si vous vouliez =C3=AAtre sur une branche, cr=C3=A9ez en une maintena=
nt en partant de "
 "'Cet emprunt d=C3=A9tach=C3=A9'."
=20
-#: lib/checkout_op.tcl:446 lib/checkout_op.tcl:450
+#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "'%s' charg=C3=A9."
=20
-#: lib/checkout_op.tcl:478
+#: lib/checkout_op.tcl:500
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "R=C3=A9initialiser '%s' =C3=A0 '%s' va faire perdre les commit=
s suivants :"
=20
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:522
 msgid "Recovering lost commits may not be easy."
 msgstr "R=C3=A9cup=C3=A9rer les commits perdus ne sera peut =C3=AAtre =
pas facile."
=20
-#: lib/checkout_op.tcl:505
+#: lib/checkout_op.tcl:527
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "R=C3=A9initialiser '%s' ?"
=20
-#: lib/checkout_op.tcl:510 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:163
 msgid "Visualize"
 msgstr "Visualiser"
=20
-#: lib/checkout_op.tcl:578
+#: lib/checkout_op.tcl:600
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -915,7 +942,7 @@ msgstr "Cr=C3=A9er nouveau d=C3=A9p=C3=B4t"
 msgid "New..."
 msgstr "Nouveau..."
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:458
 msgid "Clone Existing Repository"
 msgstr "Cloner d=C3=A9p=C3=B4t existant"
=20
@@ -923,7 +950,7 @@ msgstr "Cloner d=C3=A9p=C3=B4t existant"
 msgid "Clone..."
 msgstr "Cloner..."
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:976
+#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:974
 msgid "Open Existing Repository"
 msgstr "Ouvrir d=C3=A9p=C3=B4t existant"
=20
@@ -945,187 +972,187 @@ msgstr "Ouvrir d=C3=A9p=C3=B4t r=C3=A9cent :"
 msgid "Failed to create repository %s:"
 msgstr "La cr=C3=A9ation du d=C3=A9p=C3=B4t %s a =C3=A9chou=C3=A9e :"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:478
+#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:476
 msgid "Directory:"
 msgstr "R=C3=A9pertoire :"
=20
-#: lib/choose_repository.tcl:412 lib/choose_repository.tcl:537
-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:410 lib/choose_repository.tcl:535
+#: lib/choose_repository.tcl:1007
 msgid "Git Repository"
 msgstr "D=C3=A9p=C3=B4t Git"
=20
-#: lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:435
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "Le r=C3=A9pertoire %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:441
+#: lib/choose_repository.tcl:439
 #, tcl-format
 msgid "File %s already exists."
 msgstr "Le fichier %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:455
+#: lib/choose_repository.tcl:453
 msgid "Clone"
 msgstr "Cloner"
=20
-#: lib/choose_repository.tcl:468
+#: lib/choose_repository.tcl:466
 msgid "URL:"
 msgstr "URL :"
=20
-#: lib/choose_repository.tcl:489
+#: lib/choose_repository.tcl:487
 msgid "Clone Type:"
 msgstr "Type de clonage :"
=20
-#: lib/choose_repository.tcl:495
+#: lib/choose_repository.tcl:493
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "Standard (rapide, semi-redondant, liens durs)"
=20
-#: lib/choose_repository.tcl:501
+#: lib/choose_repository.tcl:499
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
=20
-#: lib/choose_repository.tcl:507
+#: lib/choose_repository.tcl:505
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "Partag=C3=A9 (le plus rapide, non recommand=C3=A9, pas de sauv=
egarde)"
=20
-#: lib/choose_repository.tcl:543 lib/choose_repository.tcl:590
-#: lib/choose_repository.tcl:736 lib/choose_repository.tcl:806
-#: lib/choose_repository.tcl:1017 lib/choose_repository.tcl:1025
+#: lib/choose_repository.tcl:541 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:734 lib/choose_repository.tcl:804
+#: lib/choose_repository.tcl:1013 lib/choose_repository.tcl:1021
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "'%s' n'est pas un d=C3=A9p=C3=B4t Git."
=20
-#: lib/choose_repository.tcl:579
+#: lib/choose_repository.tcl:577
 msgid "Standard only available for local repository."
 msgstr "Standard n'est disponible que pour un d=C3=A9p=C3=B4t local."
=20
-#: lib/choose_repository.tcl:583
+#: lib/choose_repository.tcl:581
 msgid "Shared only available for local repository."
 msgstr "Partag=C3=A9 n'est disponible que pour un d=C3=A9p=C3=B4t loca=
l."
=20
-#: lib/choose_repository.tcl:604
+#: lib/choose_repository.tcl:602
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "L'emplacement %s existe d=C3=A9j=C3=A0."
=20
-#: lib/choose_repository.tcl:615
+#: lib/choose_repository.tcl:613
 msgid "Failed to configure origin"
 msgstr "La configuration de l'origine a =C3=A9chou=C3=A9e."
=20
-#: lib/choose_repository.tcl:627
+#: lib/choose_repository.tcl:625
 msgid "Counting objects"
 msgstr "D=C3=A9compte des objets"
=20
-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:626
 msgid "buckets"
 msgstr "paniers"
=20
-#: lib/choose_repository.tcl:652
+#: lib/choose_repository.tcl:650
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "Impossible de copier 'objects/info/alternates' : %s"
=20
-#: lib/choose_repository.tcl:688
+#: lib/choose_repository.tcl:686
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "Il n'y a rien =C3=A0 cloner depuis %s."
=20
-#: lib/choose_repository.tcl:690 lib/choose_repository.tcl:904
-#: lib/choose_repository.tcl:916
+#: lib/choose_repository.tcl:688 lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:914
 msgid "The 'master' branch has not been initialized."
 msgstr "La branche 'master' n'a pas =C3=A9t=C3=A9 initialis=C3=A9e."
=20
-#: lib/choose_repository.tcl:703
+#: lib/choose_repository.tcl:701
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "Les liens durs ne sont pas support=C3=A9s. Une copie sera effe=
ctu=C3=A9e =C3=A0 la place."
=20
-#: lib/choose_repository.tcl:715
+#: lib/choose_repository.tcl:713
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "Clonage depuis %s"
=20
-#: lib/choose_repository.tcl:746
+#: lib/choose_repository.tcl:744
 msgid "Copying objects"
 msgstr "Copie des objets"
=20
-#: lib/choose_repository.tcl:747
+#: lib/choose_repository.tcl:745
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:771
+#: lib/choose_repository.tcl:769
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "Impossible de copier l'objet : %s"
=20
-#: lib/choose_repository.tcl:781
+#: lib/choose_repository.tcl:779
 msgid "Linking objects"
 msgstr "Liaison des objets"
=20
-#: lib/choose_repository.tcl:782
+#: lib/choose_repository.tcl:780
 msgid "objects"
 msgstr "objets"
=20
-#: lib/choose_repository.tcl:790
+#: lib/choose_repository.tcl:788
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "Impossible cr=C3=A9er un lien dur pour l'objet : %s"
=20
-#: lib/choose_repository.tcl:845
+#: lib/choose_repository.tcl:843
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "Impossible de r=C3=A9cup=C3=A9rer les branches et objets. Voir la sor=
tie console pour "
 "plus de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:856
+#: lib/choose_repository.tcl:854
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
-"Impossible de r=C3=A9cup=C3=A9rer les marques (tags). Voir la sortie =
console pour plus de "
-"d=C3=A9tails."
+"Impossible de r=C3=A9cup=C3=A9rer les marques (tags). Voir la sortie =
console pour plus "
+"de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:880
+#: lib/choose_repository.tcl:878
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "Impossible de d=C3=A9terminer HEAD. Voir la sortie console pou=
r plus de d=C3=A9tails."
=20
-#: lib/choose_repository.tcl:889
+#: lib/choose_repository.tcl:887
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "Impossible de nettoyer %s"
=20
-#: lib/choose_repository.tcl:895
+#: lib/choose_repository.tcl:893
 msgid "Clone failed."
 msgstr "Le clonage a =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:900
 msgid "No default branch obtained."
 msgstr "Aucune branche par d=C3=A9faut n'a =C3=A9t=C3=A9 obtenue."
=20
-#: lib/choose_repository.tcl:913
+#: lib/choose_repository.tcl:911
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "Impossible de r=C3=A9soudre %s comme commit."
=20
-#: lib/choose_repository.tcl:925
+#: lib/choose_repository.tcl:923
 msgid "Creating working directory"
 msgstr "Cr=C3=A9ation du r=C3=A9pertoire de travail"
=20
-#: lib/choose_repository.tcl:926 lib/index.tcl:65 lib/index.tcl:127
+#: lib/choose_repository.tcl:924 lib/index.tcl:65 lib/index.tcl:127
 #: lib/index.tcl:193
 msgid "files"
 msgstr "fichiers"
=20
-#: lib/choose_repository.tcl:955
+#: lib/choose_repository.tcl:953
 msgid "Initial file checkout failed."
 msgstr "Chargement initial du fichier =C3=A9chou=C3=A9."
=20
-#: lib/choose_repository.tcl:971
+#: lib/choose_repository.tcl:969
 msgid "Open"
 msgstr "Ouvrir"
=20
-#: lib/choose_repository.tcl:981
+#: lib/choose_repository.tcl:979
 msgid "Repository:"
 msgstr "D=C3=A9p=C3=B4t :"
=20
-#: lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "Impossible d'ouvrir le d=C3=A9p=C3=B4t %s :"
@@ -1165,7 +1192,7 @@ msgstr "L'expression de r=C3=A9vision est vide."
=20
 #: lib/choose_rev.tcl:531
 msgid "Updated"
-msgstr "=C3=80 jour (updated)"
+msgstr "Mise-=C3=A0-jour:"
=20
 #: lib/choose_rev.tcl:559
 msgid "URL"
@@ -1421,7 +1448,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Date invalide de Git : %s"
=20
-#: lib/diff.tcl:42
+#: lib/diff.tcl:44
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1444,40 +1471,48 @@ msgstr ""
 "Une resynchronisation va =C3=AAtre lanc=C3=A9e automatiquement pour t=
rouver d'autres "
 "fichiers qui pourraient se trouver dans le m=C3=AAme =C3=A9tat."
=20
-#: lib/diff.tcl:81
+#: lib/diff.tcl:83
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "Chargement des diff=C3=A9rences de %s..."
=20
-#: lib/diff.tcl:114 lib/diff.tcl:184
+#: lib/diff.tcl:116 lib/diff.tcl:190
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "Impossible d'afficher %s"
=20
-#: lib/diff.tcl:115
+#: lib/diff.tcl:117
 msgid "Error loading file:"
 msgstr "Erreur lors du chargement du fichier :"
=20
-#: lib/diff.tcl:122
+#: lib/diff.tcl:124
 msgid "Git Repository (subproject)"
 msgstr "D=C3=A9p=C3=B4t Git (sous projet)"
=20
-#: lib/diff.tcl:134
+#: lib/diff.tcl:136
 msgid "* Binary file (not showing content)."
 msgstr "* Fichier binaire (pas d'apper=C3=A7u du contenu)."
=20
-#: lib/diff.tcl:185
+#: lib/diff.tcl:191
 msgid "Error loading diff:"
 msgstr "Erreur lors du chargement des diff=C3=A9rences :"
=20
-#: lib/diff.tcl:303
+#: lib/diff.tcl:313
 msgid "Failed to unstage selected hunk."
 msgstr "=C3=89chec lors de la d=C3=A9sindexation de la section s=C3=A9=
lectionn=C3=A9e."
=20
-#: lib/diff.tcl:310
+#: lib/diff.tcl:320
 msgid "Failed to stage selected hunk."
 msgstr "=C3=89chec lors de l'indexation de la section."
=20
+#: lib/diff.tcl:386
+msgid "Failed to unstage selected line."
+msgstr "=C3=89chec lors de la d=C3=A9sindexation de la ligne s=C3=A9le=
ctionn=C3=A9e."
+
+#: lib/diff.tcl:394
+msgid "Failed to stage selected line."
+msgstr "=C3=89chec lors de l'indexation de la ligne."
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "erreur"
@@ -1502,7 +1537,9 @@ msgstr "Erreur de l'index"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically starte=
d to "
 "resynchronize git-gui."
-msgstr "=C3=89chec de la mise =C3=A0 jour de l'index. Une resynchronis=
ation va =C3=AAtre lanc=C3=A9e automatiquement."
+msgstr ""
+"=C3=89chec de la mise =C3=A0 jour de l'index. Une resynchronisation v=
a =C3=AAtre lanc=C3=A9e "
+"automatiquement."
=20
 #: lib/index.tcl:27
 msgid "Continue"
@@ -1539,8 +1576,8 @@ msgstr "Annuler les modifications dans ces %i fic=
hiers ?"
 #: lib/index.tcl:391
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues "
-"par l'annulation."
+"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues par "
+"l'annulation."
=20
 #: lib/index.tcl:394
 msgid "Do Nothing"
@@ -1589,8 +1626,8 @@ msgstr ""
 "\n"
 "Le fichier %s a des conflicts de fusion.\n"
 "\n"
-"Vous devez les r=C3=A9soudre, puis indexer le fichier, et enfin commi=
ter "
-"pour terminer la fusion courante. Seulement =C3=A0 ce moment l=C3=A0 =
sera-t-il possible "
+"Vous devez les r=C3=A9soudre, puis indexer le fichier, et enfin commi=
ter pour "
+"terminer la fusion courante. Seulement =C3=A0 ce moment l=C3=A0 sera-=
t-il possible "
 "d'effectuer une nouvelle fusion.\n"
=20
 #: lib/merge.tcl:54
@@ -1686,11 +1723,11 @@ msgstr "Abandon"
 msgid "files reset"
 msgstr "fichiers r=C3=A9initialis=C3=A9s"
=20
-#: lib/merge.tcl:265
+#: lib/merge.tcl:266
 msgid "Abort failed."
 msgstr "L'abandon a =C3=A9chou=C3=A9."
=20
-#: lib/merge.tcl:267
+#: lib/merge.tcl:268
 msgid "Abort completed.  Ready."
 msgstr "Abandon temin=C3=A9. Pr=C3=AAt."
=20
@@ -1744,42 +1781,62 @@ msgid "Match Tracking Branches"
 msgstr "Faire correspondre les branches de suivi"
=20
 #: lib/option.tcl:126
+msgid "Blame Copy Only On Changed Files"
+msgstr "Annoter les copies seulement sur fichiers modifi=C3=A9s"
+
+#: lib/option.tcl:127
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Minimum de carat=C3=A8res pour annoter une copie"
+
+#: lib/option.tcl:128
 msgid "Number of Diff Context Lines"
 msgstr "Nombre de lignes de contexte dans les diffs"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:129
 msgid "Commit Message Text Width"
 msgstr "Largeur du texte de message de commit"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:130
 msgid "New Branch Name Template"
 msgstr "Nouveau mod=C3=A8le de nom de branche"
=20
-#: lib/option.tcl:192
+#: lib/option.tcl:194
 msgid "Spelling Dictionary:"
 msgstr "Dictionnaire d'orthographe :"
=20
-#: lib/option.tcl:216
+#: lib/option.tcl:218
 msgid "Change Font"
 msgstr "Modifier les polices"
=20
-#: lib/option.tcl:220
+#: lib/option.tcl:222
 #, tcl-format
 msgid "Choose %s"
 msgstr "Choisir %s"
=20
-#: lib/option.tcl:226
+#: lib/option.tcl:228
 msgid "pt."
 msgstr "pt."
=20
-#: lib/option.tcl:240
+#: lib/option.tcl:242
 msgid "Preferences"
 msgstr "Pr=C3=A9f=C3=A9rences"
=20
-#: lib/option.tcl:275
+#: lib/option.tcl:277
 msgid "Failed to completely save options:"
 msgstr "La sauvegarde compl=C3=A8te des options a =C3=A9chou=C3=A9e :"
=20
+#: lib/remote.tcl:165
+msgid "Prune from"
+msgstr "Purger de"
+
+#: lib/remote.tcl:170
+msgid "Fetch from"
+msgstr "R=C3=A9cup=C3=A9rer de"
+
+#: lib/remote.tcl:213
+msgid "Push to"
+msgstr "Pousser vers"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
 msgstr "Supprimer branche distante"
@@ -1864,18 +1921,6 @@ msgstr "Aucun d=C3=A9p=C3=B4t n'est s=C3=A9lecti=
onn=C3=A9."
 msgid "Scanning %s..."
 msgstr "Synchronisation de %s..."
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "Purger de"
-
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "R=C3=A9cup=C3=A9rer de"
-
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "Pousser vers"
-
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
 msgstr "Impossible d'=C3=A9crire le raccourcis :"
@@ -1909,15 +1954,15 @@ msgstr "La v=C3=A9rification d'orthographe a =C3=
=A9chou=C3=A9e silentieusement au d=C3=A9marrage
 msgid "Unrecognized spell checker"
 msgstr "V=C3=A9rificateur d'orthographe non reconnu"
=20
-#: lib/spellcheck.tcl:180
+#: lib/spellcheck.tcl:186
 msgid "No Suggestions"
 msgstr "Aucune suggestion"
=20
-#: lib/spellcheck.tcl:381
+#: lib/spellcheck.tcl:387
 msgid "Unexpected EOF from spell checker"
 msgstr "EOF inattendue envoy=C3=A9e par le v=C3=A9rificateur d'orthogr=
aphe"
=20
-#: lib/spellcheck.tcl:385
+#: lib/spellcheck.tcl:391
 msgid "Spell Checker Failed"
 msgstr "Le v=C3=A9rificateur d'orthographe a =C3=A9chou=C3=A9"
=20
--=20
1.5.4.3
