From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] More cleanup and grammatical fixes to it.po
Date: Mon, 23 Jul 2007 00:06:28 +0200
Message-ID: <20070723000628.5bb2538e@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Jul 23 00:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjYd-0007q3-7s
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758634AbXGVWFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 18:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762678AbXGVWFd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:05:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:42384 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbXGVWFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 18:05:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1033648ugf
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:05:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JvMrhiaHJZHoLFSgpVpi1cU3lwSdR0sHegKxZUI8H1dgOkQIX8Ox18/MEP4h8LJfac4foPf4tTA5B8Cr0jUIJmXhfy4vSXdW5E7uHvCPM9pDdeBw2OAzdzRkGelu6MzEFFx8VHFNFhlqbyl/Zmo9mhaaSYayLUY9Z2mGNyLm/BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Neez5X9ILXGoahXXBoY/YA+oukyysDbujWzPUbJgl46B1EwER5o1KxnthFBWAP82PmFtV2YOBttaI4G7+CnCsl7TVnzWIJE53AT6KIubf6p8+9IIoV6xupD4gHlENrXucm2ebH/ujL8NzBo/gKEWaj+xuJfiO5NjCg2XH1DMqTk=
Received: by 10.67.28.9 with SMTP id f9mr3717125ugj.1185141930531;
        Sun, 22 Jul 2007 15:05:30 -0700 (PDT)
Received: from paolo-desktop ( [82.56.2.238])
        by mx.google.com with ESMTPS id d27sm5955751nfh.2007.07.22.15.05.28
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 15:05:29 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53335>

Thanks to Daniele Forsi from the Italian translation project for the su=
ggestions.
The translation is now in line with other already translated applicatio=
n.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/po/it.po b/po/it.po
index 80365b4..9899a78 100644
--- a/po/it.po
+++ b/po/it.po
@@ -97,7 +97,7 @@ msgstr "Incolla"
=20
 #: git-gui.sh:1756 git-gui.sh:2271
 msgid "Delete"
-msgstr "Cancella"
+msgstr "Elimina"
=20
 #: git-gui.sh:1760 git-gui.sh:2275 git-gui.sh:2412
 msgid "Select All"
@@ -121,7 +121,7 @@ msgstr "Cancella"
=20
 #: git-gui.sh:1791
 msgid "Reset..."
-msgstr "Resetta..."
+msgstr "Reimposta..."
=20
 #: git-gui.sh:1803 git-gui.sh:2209
 msgid "New Commit"
@@ -161,7 +161,7 @@ msgstr "Incorporazione locale"
=20
 #: git-gui.sh:1869
 msgid "Abort Merge..."
-msgstr "Annulla incorporazione"
+msgstr "Interrompi incorporazione"
=20
 #: git-gui.sh:1881
 msgid "Push..."
@@ -186,11 +186,11 @@ msgstr "Aiuto"
=20
 #: git-gui.sh:1978
 msgid "Online Documentation"
-msgstr "Documentazione Online"
+msgstr "Documentazione in linea"
=20
 #: git-gui.sh:2094
 msgid "Current Branch:"
-msgstr "Ramo corrente:"
+msgstr "Ramo attuale:"
=20
 #: git-gui.sh:2115
 msgid "Staged Changes (Will Be Committed)"
@@ -206,19 +206,19 @@ msgstr "Aggiungi esistente"
=20
 #: git-gui.sh:2228
 msgid "Initial Commit Message:"
-msgstr "Messaggio iniziale del Commit"
+msgstr "Messaggio iniziale del commit:"
=20
 #: git-gui.sh:2229
 msgid "Amended Commit Message:"
-msgstr "Annulla messaggio del Commit"
+msgstr "Annulla messaggio del commit:"
=20
 #: git-gui.sh:2230
 msgid "Amended Initial Commit Message:"
-msgstr "Annulla messaggio iniziale del Commit"
+msgstr "Annulla messaggio iniziale del commit:"
=20
 #: git-gui.sh:2231
 msgid "Amended Merge Commit Message:"
-msgstr "Annulla messaggio di incorporamento"
+msgstr "Annulla messaggio di incorporamento:"
=20
 #: git-gui.sh:2232
 msgid "Merge Commit Message:"
@@ -226,7 +226,7 @@ msgstr "Messaggio di incorporamento"
=20
 #: git-gui.sh:2233
 msgid "Commit Message:"
-msgstr "Messaggio di Commit"
+msgstr "Messaggio di commit:"
=20
 #: git-gui.sh:2278 git-gui.sh:2416
 msgid "Copy All"
@@ -234,24 +234,24 @@ msgstr "Copia tutto"
=20
 #: git-gui.sh:2404
 msgid "Refresh"
-msgstr "Rinfresca"
+msgstr "Aggiorna"
=20
 #: git-gui.sh:2425
 msgid "Apply/Reverse Hunk"
-msgstr "Applica/Inverti Hunk"
+msgstr "Applica/Inverti sezione"
=20
 #: git-gui.sh:2431
 msgid "Decrease Font Size"
-msgstr "Diminuisci dimensione Font"
+msgstr "Diminuisci dimensione font"
=20
 #: git-gui.sh:2435
 msgid "Increase Font Size"
-msgstr "Aumenta dimensione Font"
+msgstr "Aumenta dimensione font"
=20
 #: git-gui.sh:2440
 msgid "Show Less Context"
-msgstr "Mostra meno contenuto"
+msgstr "Mostra meno contesto"
=20
 #: git-gui.sh:2447
 msgid "Show More Context"
-msgstr "Mostra pi=F9 contenuto"
+msgstr "Mostra pi=F9 contesto"
--=20
1.5.3.rc2.29.gc4640f
