From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Further changes to it.po
Date: Tue, 24 Jul 2007 22:38:54 +0200
Message-ID: <20070724223854.35715c77@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Jul 24 22:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDR8x-0004Ut-6R
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbXGXUh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764523AbXGXUh6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:37:58 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:4108 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764586AbXGXUhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 16:37:55 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3280923mue
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 13:37:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=k8FNegc01qRhTbOJVX+JUYGlyYPQtXosL64sJz9HeRLlu96QYvOybh8KlUQDm022pN7fe3H3/BkT7WsTTcGAegcNZ9oqOmSbppXn6m3vFQg0Y6uPmTYaFu9lkA0Fed5DooxyXNecLfFfR6CHGLnRNNOeWM4r20o6bQXG8GLkwBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mBRXYMAFvcAAZ/rXWEUvbyyF+1LPGquU756UC4RdFhtS26atynjqXdwe1EazHPCzBCjj05EN2Zrsj29Wr77TyZiUGQ8CJIhJEuGyW9USIxhGbuv1tyB3y+Z1KXYFktXIucHOmPDayLjIeo5zLt8BAiHlfr34aP9et3qgF0BpcQY=
Received: by 10.82.112.3 with SMTP id k3mr3630133buc.1185309473180;
        Tue, 24 Jul 2007 13:37:53 -0700 (PDT)
Received: from paolo-desktop ( [82.52.6.121])
        by mx.google.com with ESMTPS id k5sm8221954nfh.2007.07.24.13.37.50
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 13:37:51 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53639>

Ciao Johannes,

With the following patch applied it.po should be in a final state.
I don't expect to apply big changes to the file.

Please apply :-)


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/po/it.po b/po/it.po
index 5fa6596..170dd02 100644
--- a/po/it.po
+++ b/po/it.po
@@ -5,7 +5,7 @@
 #, fuzzy
 msgid ""
 msgstr ""
-"Project-Id-Version: PACKAGE VERSION\n"
+"Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-07-22 12:10+0100\n"
 "PO-Revision-Date: 2007-07-22 12:10+0100\n"
@@ -33,27 +33,27 @@ msgstr ""
 
 #: git-gui.sh:1678
 msgid "Merge"
-msgstr "Incorpora"
+msgstr "Fondi (Merge)"
 
 #: git-gui.sh:1679
 msgid "Fetch"
-msgstr "Prendi"
+msgstr "Prendi (Fetch)"
 
 #: git-gui.sh:1680 git-gui.sh:2198
 msgid "Push"
-msgstr "Propaga"
+msgstr "Propaga (Push)"
 
 #: git-gui.sh:1689
 msgid "Browse Current Branch's Files"
-msgstr "Naviga nei file del ramo corrente"
+msgstr "Esplora i file del ramo corrente"
 
 #: git-gui.sh:1698
 msgid "Visualize Current Branch's History"
-msgstr "Visualizza la storia del ramo corrente"
+msgstr "Visualizza la cronologia del ramo corrente"
 
 #: git-gui.sh:1702
 msgid "Visualize All Branch History"
-msgstr "Visualizza la storia di tutti i rami"
+msgstr "Visualizza lo storico di tutti i rami"
 
 #: git-gui.sh:1707
 msgid "Database Statistics"
@@ -81,7 +81,7 @@ msgstr "Annulla"
 
 #: git-gui.sh:1743
 msgid "Redo"
-msgstr "Rifai"
+msgstr "Ripeti"
 
 #: git-gui.sh:1747 git-gui.sh:2262
 msgid "Cut"
@@ -121,27 +121,27 @@ msgstr "Cancella"
 
 #: git-gui.sh:1791
 msgid "Reset..."
-msgstr "Reimposta..."
+msgstr "Ripristina..."
 
 #: git-gui.sh:1803 git-gui.sh:2209
 msgid "New Commit"
-msgstr "Nuovo Commit"
+msgstr "Nuovo commit"
 
 #: git-gui.sh:1811 git-gui.sh:2216
 msgid "Amend Last Commit"
-msgstr "Annulla l'ultimo Commit"
+msgstr "Correggi l'ultimo commit"
 
 #: git-gui.sh:1820 git-gui.sh:2176
 msgid "Rescan"
-msgstr "Analizza"
+msgstr "Rianalizza"
 
 #: git-gui.sh:1826
 msgid "Add To Commit"
-msgstr "Aggiungi al Commit"
+msgstr "Aggiungi al commit"
 
 #: git-gui.sh:1831
 msgid "Add Existing To Commit"
-msgstr "Aggiungi esistente a Commit"
+msgstr "Aggiungi esistente al commit"
 
 #: git-gui.sh:1837
 msgid "Unstage From Commit"
@@ -174,7 +174,7 @@ msgstr ""
 #: git-gui.sh:1894 git-gui.sh:1941
 #, tcl-format
 msgid "About %s"
-msgstr "A proposito %s"
+msgstr "Informazioni su %s"
 
 #: git-gui.sh:1896 git-gui.sh:1902 git-gui.sh:2454
 msgid "Options..."
@@ -218,11 +218,11 @@ msgstr "Annulla messaggio iniziale del commit:"
 
 #: git-gui.sh:2231
 msgid "Amended Merge Commit Message:"
-msgstr "Annulla messaggio di incorporamento:"
+msgstr "Annulla messaggio di commit:"
 
 #: git-gui.sh:2232
 msgid "Merge Commit Message:"
-msgstr "Messaggio di incorporamento"
+msgstr "Fondi messaggio di commit"
 
 #: git-gui.sh:2233
 msgid "Commit Message:"
@@ -234,7 +234,7 @@ msgstr "Copia tutto"
 
 #: git-gui.sh:2404
 msgid "Refresh"
-msgstr "Aggiorna"
+msgstr "Rinfresca"
 
 #: git-gui.sh:2425
 msgid "Apply/Reverse Hunk"
@@ -242,11 +242,11 @@ msgstr "Applica/Inverti sezione"
 
 #: git-gui.sh:2431
 msgid "Decrease Font Size"
-msgstr "Diminuisci dimensione font"
+msgstr "Diminuisci dimensione carattere"
 
 #: git-gui.sh:2435
 msgid "Increase Font Size"
-msgstr "Aumenta dimensione font"
+msgstr "Aumenta dimensione carettere"
 
 #: git-gui.sh:2440
 msgid "Show Less Context"
-- 
1.5.3.rc2.29.gc4640f
