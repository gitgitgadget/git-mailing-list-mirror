From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH] git-gui: French translation improvements
Date: Fri, 27 Mar 2009 20:11:40 +0100
Message-ID: <ae74fa8c7846e3f4e6d6d75cc4177b6e6afe6824.1238180731.git.nicolas.s-dev@laposte.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 20:13:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnHV4-0000e6-Hm
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 20:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbZC0TML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 15:12:11 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbZC0TMJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 15:12:09 -0400
Received: from out2.laposte.net ([193.251.214.119]:2898 "EHLO out1.laposte.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753430AbZC0TMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 15:12:08 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8217.laposte.net (SMTP Server) with ESMTP id EE52BE000089;
	Fri, 27 Mar 2009 20:11:59 +0100 (CET)
Received: from localhost (91-164-147-87.rev.libertysurf.net [91.164.147.87])
	by mwinf8217.laposte.net (SMTP Server) with ESMTP id 877C4E000086;
	Fri, 27 Mar 2009 20:11:59 +0100 (CET)
X-ME-UUID: 20090327191159555.877C4E000086@mwinf8217.laposte.net
X-Mailer: git-send-email 1.6.2.1.389.geed1
X-me-spamlevel: not-spam
X-me-spamrating: 36.000000
X-me-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeeiucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114921>



Signed-off-by: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
---
 po/fr.po |   47 +++++++++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index a944ace..c02272e 100644
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
@@ -780,6 +780,16 @@ msgstr "Toujours (Ne pas faire de test de fusion.)=
"
 msgid "The following branches are not completely merged into %s:"
 msgstr "Les branches suivantes ne sont pas compl=C3=A8tement fusionn=C3=
=A9es dans %s :"
=20
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9es.=
\n"
+"\n"
+"Supprimer les branches s=C3=A9lectionn=C3=A9es ?"
+
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -1099,7 +1109,7 @@ msgstr "Standard (rapide, semi-redondant, liens d=
urs)"
=20
 #: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
+msgstr "Copie compl=C3=A8te (plus lent, sauvegarde redondante)"
=20
 #: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
@@ -1524,12 +1534,10 @@ msgid ""
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
@@ -1695,7 +1703,7 @@ msgstr "D=C3=A9verrouiller l'index"
 #: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "D=C3=A9sindexation de : %s"
+msgstr "Enl=C3=A8ve %s de l'index"
=20
 #: lib/index.tcl:326
 msgid "Ready to commit."
@@ -1719,8 +1727,7 @@ msgstr "Annuler les modifications dans ces %i fic=
hiers ?"
 #: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues par "
-"l'annulation."
+"Toutes les modifications non-index=C3=A9es seront d=C3=A9finitivement=
 perdues."
=20
 #: lib/index.tcl:409
 msgid "Do Nothing"
@@ -1728,7 +1735,7 @@ msgstr "Ne rien faire"
=20
 #: lib/index.tcl:427
 msgid "Reverting selected files"
-msgstr "Annuler modifications dans fichiers selectionn=C3=A9s"
+msgstr "R=C3=A9vocation en cours des fichiers s=C3=A9lectionn=C3=A9s"
=20
 #: lib/index.tcl:431
 #, tcl-format
--=20
1.6.2.1.389.geed1
