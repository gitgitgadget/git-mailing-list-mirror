From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Initial  Italian translation of git-gui.pot
Date: Sun, 22 Jul 2007 12:42:36 +0200
Message-ID: <20070722124236.47baacb1@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 12:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICYtg-0003iZ-79
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 12:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463AbXGVKml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 06:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757261AbXGVKml
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 06:42:41 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:57646 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbXGVKmk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 06:42:40 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1020736hue
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 03:42:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fnHDq3OZviiE8Jw83UHiJT/edsoZWkadSgNeS3iGdfb2KBCseLCw1WqeeGVsHVVhfkMwOPWEabPqLhi83gV3QtIm8M0UX8WIFj8aBnirsRajAXVHVMODMQ2D0TI46s/cEpkrzVsR0IxqIGGlrONaZVUiW8P1rAq6X+144Hfoby4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WrJWa54xwIWpjChgy7ZarkHpduHoHjsXSRqPbGKavJDWSS677RU/2akHXy6MRzvgFKpL3MYj2YEbQ2wF+PdOEtrnxqLPH4BOQThrq83j3Xvo3blGLdi7pYhyVvnpA09bdUSECZ+JGQk9W7xK7uUco7n0HJRibbeS4/cMHJ4zNFU=
Received: by 10.86.74.15 with SMTP id w15mr1644456fga.1185100958078;
        Sun, 22 Jul 2007 03:42:38 -0700 (PDT)
Received: from paolo-desktop ( [82.48.1.34])
        by mx.google.com with ESMTPS id h7sm10576651nfh.2007.07.22.03.42.36
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 03:42:37 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53247>

Initial Italian translation

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |  118 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/po/it.po b/po/it.po
index e8b8cdb..780519e 100644
--- a/po/it.po
+++ b/po/it.po
@@ -8,25 +8,25 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-07-21 20:31+0100\n"
-"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
-"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"POT-Creation-Date: 2007-07-22 12:10+0100\n"
+"PO-Revision-Date: 2007-07-22 12:10+0100\n"
+"Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
 "MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=3DCHARSET\n"
+"Content-Type: text/plain; charset=3Dutf8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
 #: git-gui.sh:1669
 msgid "Repository"
-msgstr ""
+msgstr "Archivio"
=20
 #: git-gui.sh:1670
 msgid "Edit"
-msgstr ""
+msgstr "Modifica"
=20
 #: git-gui.sh:1672
 msgid "Branch"
-msgstr ""
+msgstr "Ramo"
=20
 #: git-gui.sh:1675 git-gui.sh:1853 git-gui.sh:2192
 msgid "Commit"
@@ -34,79 +34,79 @@ msgstr ""
=20
 #: git-gui.sh:1678
 msgid "Merge"
-msgstr ""
+msgstr "Incorpora"
=20
 #: git-gui.sh:1679
 msgid "Fetch"
-msgstr ""
+msgstr "Prendi"
=20
 #: git-gui.sh:1680 git-gui.sh:2198
 msgid "Push"
-msgstr ""
+msgstr "Propaga"
=20
 #: git-gui.sh:1689
 msgid "Browse Current Branch's Files"
-msgstr ""
+msgstr "Naviga nei file del ramo corrente"
=20
 #: git-gui.sh:1698
 msgid "Visualize Current Branch's History"
-msgstr ""
+msgstr "Visualizza la storia del ramo corrente"
=20
 #: git-gui.sh:1702
 msgid "Visualize All Branch History"
-msgstr ""
+msgstr "Visualizza la storia di tutti i rami"
=20
 #: git-gui.sh:1707
 msgid "Database Statistics"
-msgstr ""
+msgstr "Statistiche del database"
=20
 #: git-gui.sh:1710
 msgid "Compress Database"
-msgstr ""
+msgstr "Comprimi il database"
=20
 #: git-gui.sh:1713
 msgid "Verify Database"
-msgstr ""
+msgstr "Verifica il database"
=20
 #: git-gui.sh:1720 git-gui.sh:1724 git-gui.sh:1728
 msgid "Create Desktop Icon"
-msgstr ""
+msgstr "Crea icona desktop"
=20
 #: git-gui.sh:1733
 msgid "Quit"
-msgstr ""
+msgstr "Esci"
=20
 #: git-gui.sh:1740
 msgid "Undo"
-msgstr ""
+msgstr "Annulla"
=20
 #: git-gui.sh:1743
 msgid "Redo"
-msgstr ""
+msgstr "Rifai"
=20
 #: git-gui.sh:1747 git-gui.sh:2262
 msgid "Cut"
-msgstr ""
+msgstr "Taglia"
=20
 #: git-gui.sh:1750 git-gui.sh:2265 git-gui.sh:2336 git-gui.sh:2408
 msgid "Copy"
-msgstr ""
+msgstr "Copia"
=20
 #: git-gui.sh:1753 git-gui.sh:2268
 msgid "Paste"
-msgstr ""
+msgstr "Incolla"
=20
 #: git-gui.sh:1756 git-gui.sh:2271
 msgid "Delete"
-msgstr ""
+msgstr "Cancella"
=20
 #: git-gui.sh:1760 git-gui.sh:2275 git-gui.sh:2412
 msgid "Select All"
-msgstr ""
+msgstr "Seleziona tutto"
=20
 #: git-gui.sh:1769
 msgid "Create..."
-msgstr ""
+msgstr "Crea..."
=20
 #: git-gui.sh:1775
 msgid "Checkout..."
@@ -114,35 +114,35 @@ msgstr ""
=20
 #: git-gui.sh:1781
 msgid "Rename..."
-msgstr ""
+msgstr "Rinomina"
=20
 #: git-gui.sh:1786 git-gui.sh:1884
 msgid "Delete..."
-msgstr ""
+msgstr "Cancella"
=20
 #: git-gui.sh:1791
 msgid "Reset..."
-msgstr ""
+msgstr "Resetta..."
=20
 #: git-gui.sh:1803 git-gui.sh:2209
 msgid "New Commit"
-msgstr ""
+msgstr "Nuovo Commit"
=20
 #: git-gui.sh:1811 git-gui.sh:2216
 msgid "Amend Last Commit"
-msgstr ""
+msgstr "Annulla l'ultimo Commit"
=20
 #: git-gui.sh:1820 git-gui.sh:2176
 msgid "Rescan"
-msgstr ""
+msgstr "Analizza"
=20
 #: git-gui.sh:1826
 msgid "Add To Commit"
-msgstr ""
+msgstr "Aggiungi al Commit"
=20
 #: git-gui.sh:1831
 msgid "Add Existing To Commit"
-msgstr ""
+msgstr "Aggiungi esistente a Commit"
=20
 #: git-gui.sh:1837
 msgid "Unstage From Commit"
@@ -150,7 +150,7 @@ msgstr ""
=20
 #: git-gui.sh:1842
 msgid "Revert Changes"
-msgstr ""
+msgstr "Annulla modifiche"
=20
 #: git-gui.sh:1849 git-gui.sh:2188 git-gui.sh:2286
 msgid "Sign Off"
@@ -158,15 +158,15 @@ msgstr ""
=20
 #: git-gui.sh:1864
 msgid "Local Merge..."
-msgstr ""
+msgstr "Incorporazione locale"
=20
 #: git-gui.sh:1869
 msgid "Abort Merge..."
-msgstr ""
+msgstr "Annulla incorporazione"
=20
 #: git-gui.sh:1881
 msgid "Push..."
-msgstr ""
+msgstr "Propaga..."
=20
 #: git-gui.sh:1891
 msgid "Apple"
@@ -175,84 +175,84 @@ msgstr ""
 #: git-gui.sh:1894 git-gui.sh:1941
 #, tcl-format
 msgid "About %s"
-msgstr ""
+msgstr "A proposito %s"
=20
 #: git-gui.sh:1896 git-gui.sh:1902 git-gui.sh:2454
 msgid "Options..."
-msgstr ""
+msgstr "Opzioni..."
=20
 #: git-gui.sh:1937
 msgid "Help"
-msgstr ""
+msgstr "Aiuto"
=20
 #: git-gui.sh:1978
 msgid "Online Documentation"
-msgstr ""
+msgstr "Documentazione Online"
=20
 #: git-gui.sh:2094
 msgid "Current Branch:"
-msgstr ""
+msgstr "Ramo corrente:"
=20
 #: git-gui.sh:2115
 msgid "Staged Changes (Will Be Committed)"
-msgstr ""
+msgstr "Modifiche preparate (Saranno committate)"
=20
 #: git-gui.sh:2135
 msgid "Unstaged Changes (Will Not Be Committed)"
-msgstr ""
+msgstr "Modifiche non preparate (Non saranno committate)"
=20
 #: git-gui.sh:2182
 msgid "Add Existing"
-msgstr ""
+msgstr "Aggiungi esistente"
=20
 #: git-gui.sh:2228
 msgid "Initial Commit Message:"
-msgstr ""
+msgstr "Messaggio iniziale del Commit"
=20
 #: git-gui.sh:2229
 msgid "Amended Commit Message:"
-msgstr ""
+msgstr "Annulla messaggio del Commit"
=20
 #: git-gui.sh:2230
 msgid "Amended Initial Commit Message:"
-msgstr ""
+msgstr "Annulla messaggio iniziale del Commit"
=20
 #: git-gui.sh:2231
 msgid "Amended Merge Commit Message:"
-msgstr ""
+msgstr "Annulla messaggio di incorporamento"
=20
 #: git-gui.sh:2232
 msgid "Merge Commit Message:"
-msgstr ""
+msgstr "Messaggio di incorporamento"
=20
 #: git-gui.sh:2233
 msgid "Commit Message:"
-msgstr ""
+msgstr "Messaggio di Commit"
=20
 #: git-gui.sh:2278 git-gui.sh:2416
 msgid "Copy All"
-msgstr ""
+msgstr "Copia tutto"
=20
 #: git-gui.sh:2404
 msgid "Refresh"
-msgstr ""
+msgstr "Rinfresca"
=20
 #: git-gui.sh:2425
 msgid "Apply/Reverse Hunk"
-msgstr ""
+msgstr "Applica/Inverti Hunk"
=20
 #: git-gui.sh:2431
 msgid "Decrease Font Size"
-msgstr ""
+msgstr "Diminuisci dimensione Font"
=20
 #: git-gui.sh:2435
 msgid "Increase Font Size"
-msgstr ""
+msgstr "Aumenta dimensione Font"
=20
 #: git-gui.sh:2440
 msgid "Show Less Context"
-msgstr ""
+msgstr "Mostra meno contenuto"
=20
 #: git-gui.sh:2447
 msgid "Show More Context"
-msgstr ""
+msgstr "Mostra pi=F9 contenuto"
--=20
1.5.3.rc2.29.gc4640f
