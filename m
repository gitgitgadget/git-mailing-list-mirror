From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH v2 2/2] git-gui: impove some French translations
Date: Sat, 21 Mar 2009 15:47:06 +0100
Message-ID: <1d6ecc17e1e0e9524aebfb38b7cd1d8a8fc375a7.1237646585.git.nicolas.s-dev@laposte.net>
References: <20090321102748.GC12971@vidovic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: alexandre.bourget@savoirfairelinux.com, mh@glandium.org,
	sam@zoy.org, chriscool@tuxfamily.org, nico@cam.org,
	git@vger.kernel.org, Nicolas Sebrecht <nicolas.s-dev@laposte.net>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Mar 21 15:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll2VX-0001gT-Rv
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 15:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbZCUOrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 10:47:37 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbZCUOrf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 10:47:35 -0400
Received: from out4.laposte.net ([193.251.214.121]:18114 "EHLO
	out3.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754868AbZCUOrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 10:47:33 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8317.laposte.net (SMTP Server) with ESMTP id 98861E000088;
	Sat, 21 Mar 2009 15:47:24 +0100 (CET)
Received: from localhost (91-164-138-157.rev.libertysurf.net [91.164.138.157])
	by mwinf8317.laposte.net (SMTP Server) with ESMTP id 233C7E000083;
	Sat, 21 Mar 2009 15:47:23 +0100 (CET)
X-ME-UUID: 20090321144724144.233C7E000083@mwinf8317.laposte.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114040>



Signed-off-by: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
---
 po/fr.po |   47 ++++++++++++++++++++++-------------------------
 1 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index eb5f68e..15f326f 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -106,7 +106,7 @@ msgstr "Non modifi=C3=A9"
=20
 #: git-gui.sh:1821
 msgid "Modified, not staged"
-msgstr "Modifi=C3=A9, pas index=C3=A9"
+msgstr "Modifi=C3=A9, non index=C3=A9"
=20
 #: git-gui.sh:1822 git-gui.sh:1830
 msgid "Staged for commit"
@@ -171,7 +171,7 @@ msgstr "Branche"
=20
 #: git-gui.sh:2286 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
-msgstr "Commit"
+msgstr "Commit@@noun"
=20
 #: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
@@ -195,7 +195,7 @@ msgstr "Naviguer dans la branche courante"
=20
 #: git-gui.sh:2311
 msgid "Browse Branch Files..."
-msgstr "Naviguer dans la branche..."
+msgstr "Naviguer dans une branche..."
=20
 #: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
@@ -304,7 +304,7 @@ msgstr "Corriger dernier commit"
=20
 #: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
-msgstr "Recharger modifs."
+msgstr "Recharger les modifications"
=20
 #: git-gui.sh:2467
 msgid "Stage To Commit"
@@ -312,11 +312,11 @@ msgstr "Indexer"
=20
 #: git-gui.sh:2473
 msgid "Stage Changed Files To Commit"
-msgstr "Indexer toutes modifications"
+msgstr "Indexer toutes les modifications"
=20
 #: git-gui.sh:2479
 msgid "Unstage From Commit"
-msgstr "D=C3=A9sindexer"
+msgstr "Enlever de l'index"
=20
 #: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
@@ -397,15 +397,15 @@ msgstr "Branche courante :"
=20
 #: git-gui.sh:2761
 msgid "Staged Changes (Will Commit)"
-msgstr "Modifs. index=C3=A9es (pour commit)"
+msgstr "Modifications index=C3=A9es (=C3=A0 commiter)"
=20
 #: git-gui.sh:2781
 msgid "Unstaged Changes"
-msgstr "Modifs. non index=C3=A9es"
+msgstr "Modifications non index=C3=A9es"
=20
 #: git-gui.sh:2831
 msgid "Stage Changed"
-msgstr "Indexer modifs."
+msgstr "Indexer les modifications"
=20
 #: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
@@ -485,11 +485,11 @@ msgstr "Revenir =C3=A0 la version de base"
=20
 #: git-gui.sh:3169
 msgid "Unstage Hunk From Commit"
-msgstr "D=C3=A9sindexer la section"
+msgstr "Enlever la section de l'index"
=20
 #: git-gui.sh:3170
 msgid "Unstage Line From Commit"
-msgstr "D=C3=A9sindexer la ligne"
+msgstr "Enlever la ligne de l'index"
=20
 #: git-gui.sh:3172
 msgid "Stage Hunk For Commit"
@@ -711,7 +711,7 @@ msgstr "Nom :"
=20
 #: lib/branch_create.tcl:58
 msgid "Match Tracking Branch Name"
-msgstr "Trouver nom de branche de suivi"
+msgstr "Correspond au nom de la branche de suivi"
=20
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
@@ -1109,7 +1109,7 @@ msgstr "Standard (rapide, semi-redondant, liens d=
urs)"
=20
 #: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
+msgstr "Copie compl=C3=A8te (plus lent, sauvegarde redondante)"
=20
 #: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
@@ -1284,7 +1284,7 @@ msgstr "R=C3=A9vision invalide : %s"
=20
 #: lib/choose_rev.tcl:338
 msgid "No revision selected."
-msgstr "Pas de r=C3=A9vision selectionn=C3=A9e."
+msgstr "Pas de r=C3=A9vision s=C3=A9lectionn=C3=A9e."
=20
 #: lib/choose_rev.tcl:346
 msgid "Revision expression is empty."
@@ -1534,12 +1534,10 @@ msgid ""
 "\n"
 "Compress the database now?"
 msgstr ""
-"Ce d=C3=A9p=C3=B4t comprend actuellement environ %i objets ayant leur=
 fichier "
-"particulier.\n"
+"Ce d=C3=A9p=C3=B4t comprend actuellement environ %i objets inutilis=C3=
=A9s.\n"
 "\n"
 "Pour conserver une performance optimale, il est fortement recommand=C3=
=A9 de "
-"comprimer la base quand plus de %i objets ayant leur fichier particul=
ier "
-"existent.\n"
+"comprimer la base quand plus de %i objets inutilis=C3=A9s existent.\n=
"
 "\n"
 "Comprimer la base maintenant ?"
=20
@@ -1705,7 +1703,7 @@ msgstr "D=C3=A9verrouiller l'index"
 #: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "D=C3=A9sindexation de : %s"
+msgstr "Enl=C3=A8ve %s de l'index"
=20
 #: lib/index.tcl:326
 msgid "Ready to commit."
@@ -1729,8 +1727,7 @@ msgstr "R=C3=A9voquer les modifications dans ces =
%i fichiers ?"
 #: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues par "
-"la r=C3=A9vocation."
+"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues."
=20
 #: lib/index.tcl:409
 msgid "Do Nothing"
@@ -1738,7 +1735,7 @@ msgstr "Ne rien faire"
=20
 #: lib/index.tcl:427
 msgid "Reverting selected files"
-msgstr "R=C3=A9vocation en cours des fichiers selectionn=C3=A9s"
+msgstr "R=C3=A9vocation en cours des fichiers s=C3=A9lectionn=C3=A9s"
=20
 #: lib/index.tcl:431
 #, tcl-format
@@ -1918,7 +1915,7 @@ msgstr ""
 "\n"
 "%s sera =C3=A9cras=C3=A9.\n"
 "\n"
-"Cette op=C3=A9ration ne peut =C3=AAtre invers=C3=A9e qu'en relan=C3=A7=
ant la fusion."
+"Cette op=C3=A9ration ne peut =C3=AAtre annul=C3=A9e qu'en relan=C3=A7=
ant la fusion."
=20
 #: lib/mergetool.tcl:45
 #, tcl-format
@@ -2245,7 +2242,7 @@ msgid ""
 "necessary commits.  Try fetching from %s first."
 msgstr ""
 "Un ou plusieurs des tests de fusion ont =C3=A9chou=C3=A9 parce que vo=
us n'avez pas "
-"r=C3=A9cup=C3=A9r=C3=A9 les commits n=C3=A9cessaires. Essayez de r=C3=
=A9cup=C3=A9r=C3=A9 =C3=A0 partir de %s d'abord."
+"r=C3=A9cup=C3=A9r=C3=A9 les commits n=C3=A9cessaires. Essayez de r=C3=
=A9cup=C3=A9rer =C3=A0 partir de %s d'abord."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -2462,7 +2459,7 @@ msgstr "Ne pas montrer la fen=C3=AAtre de sortie =
des commandes"
=20
 #: lib/tools_dlg.tcl:97
 msgid "Run only if a diff is selected ($FILENAME not empty)"
-msgstr "Lancer seulement si un diff est selectionn=C3=A9 ($FILENAME no=
n vide)"
+msgstr "Lancer seulement si un diff est s=C3=A9lectionn=C3=A9 ($FILENA=
ME non vide)"
=20
 #: lib/tools_dlg.tcl:121
 msgid "Please supply a name for the tool."
--=20
1.6.2.169.g92418
