From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH 2/2] git-gui: some French translation enhancements
Date: Fri, 20 Mar 2009 01:54:02 +0100
Message-ID: <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net>
References: <20090318205410.GA900@zoy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Hocevar <sam@zoy.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkT1d-0005RT-Uv
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbZCTAy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:54:27 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbZCTAyZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:54:25 -0400
Received: from out6.laposte.net ([193.251.214.123]:8361 "EHLO out5.laposte.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754511AbZCTAyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:54:23 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8417.laposte.net (SMTP Server) with ESMTP id 8CCDDE000086;
	Fri, 20 Mar 2009 01:54:19 +0100 (CET)
Received: from localhost (91-165-141-36.rev.libertysurf.net [91.165.141.36])
	by mwinf8417.laposte.net (SMTP Server) with ESMTP id 24AB7E000085;
	Fri, 20 Mar 2009 01:54:19 +0100 (CET)
X-ME-UUID: 20090320005419150.24AB7E000085@mwinf8417.laposte.net
X-Mailer: git-send-email 1.6.2.169.g92418
In-Reply-To: <20090318205410.GA900@zoy.org>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net>
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrvdelucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113880>



Signed-off-by: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
---
 po/fr.po |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index eb5f68e..2f96054 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -316,11 +316,11 @@ msgstr "Indexer toutes modifications"
=20
 #: git-gui.sh:2479
 msgid "Unstage From Commit"
-msgstr "D=C3=A9sindexer"
+msgstr "Retirer de l'index"
=20
 #: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
-msgstr "R=C3=A9voquer les modifications"
+msgstr "Inverser les modifications (revert)"
=20
 #: git-gui.sh:2491 git-gui.sh:3069
 msgid "Show Less Context"
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
@@ -1705,7 +1705,7 @@ msgstr "D=C3=A9verrouiller l'index"
 #: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "D=C3=A9sindexation de : %s"
+msgstr "Enl=C3=A8ve %s de l'index"
=20
 #: lib/index.tcl:326
 msgid "Ready to commit."
@@ -1719,18 +1719,17 @@ msgstr "Ajout de %s"
 #: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
-msgstr "R=C3=A9voquer les modifications dans le fichier %s ? "
+msgstr "Inverser les modifications dans le fichier %s ? "
=20
 #: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "R=C3=A9voquer les modifications dans ces %i fichiers ?"
+msgstr "Inverser les modifications dans ces %i fichiers ?"
=20
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
@@ -1738,12 +1737,12 @@ msgstr "Ne rien faire"
=20
 #: lib/index.tcl:427
 msgid "Reverting selected files"
-msgstr "R=C3=A9vocation en cours des fichiers selectionn=C3=A9s"
+msgstr "Inversion en cours des fichiers selectionn=C3=A9s"
=20
 #: lib/index.tcl:431
 #, tcl-format
 msgid "Reverting %s"
-msgstr "R=C3=A9vocation en cours de %s"
+msgstr "Inversion en cours de %s"
=20
 #: lib/merge.tcl:13
 msgid ""
--=20
1.6.2.169.g92418
