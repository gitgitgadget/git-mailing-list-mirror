From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Further changes to it.po
Date: Thu, 9 Aug 2007 00:35:16 +0200
Message-ID: <20070809003516.257fa371@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: barra_cuda@katamail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 00:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIu5G-0005DE-P3
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbXHHWct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbXHHWct
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:32:49 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:28170 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbXHHWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:32:47 -0400
Received: by hu-out-0506.google.com with SMTP id 19so225983hue
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 15:32:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=iPSwryQbxCH0wXF9nWn0/1LHUIJBXcevb6yYgDxKufmCuNpwaZCSgW39tRagMWzepAd8oDI1pEB+YNzbIhMrbjpY9zA7zdaHxCE+v+q3K0SgzdL3eGBdASas+B0bzGa0fM5X0jr2H7jmaZD4TsC2yOJF5Prd/jy4gNX1XEjpejE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mqCZjXi7uOrfrxUjRkyuKZUeEILl0Aa+vtq7KaTfLVrDG+hJqHIagTjm/yhyNjDSbi14hwRpQ7pO8jx0Zkie+CfGl13UYubDIo2Lmym/pbgRWLNddDi19jge7gOFAkApdznROllAUrnoZLr6MZcyXFZ6NAN/5DNmP4aZ07Pz9+8=
Received: by 10.66.250.9 with SMTP id x9mr1829386ugh.1186612365486;
        Wed, 08 Aug 2007 15:32:45 -0700 (PDT)
Received: from paolo-desktop ( [87.2.69.200])
        by mx.google.com with ESMTPS id 34sm1038652uga.2007.08.08.15.32.42
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Aug 2007 15:32:43 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55383>

Thanks to Michele Ballabio and tp@lists.linux.it

Patch already pushed to the mob branch.


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |   85 ++++++++++++++++++++++++++++++++----------------------=
--------
 1 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/po/it.po b/po/it.po
index e87263e..42f6829 100644
--- a/po/it.po
+++ b/po/it.po
@@ -2,26 +2,28 @@
 # Copyright (C) 2007 Shawn Pearce
 # This file is distributed under the same license as the git-gui packa=
ge.
 # Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, 2007
-#, fuzzy
+# Michele Ballabio <barra_cuda@katamail.com>, 2007.
+#=20
+#=20
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-07-31 19:24+0200\n"
-"PO-Revision-Date: 2007-08-01 19:10+0200\n"
-"Last-Translator: Michele Ballabio <barra_cuda@katamail.com>\n"
-"Language-Team: Italian\n"
+"PO-Revision-Date: 2007-08-09 00:27+0200\n"
+"Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
+"Language-Team: Italian <tp@lists.linux.it>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
-"Content-Transfer-Encoding: 8bit\n"
+"Content-Transfer-Encoding: 8bit"
=20
 #: git-gui.sh:531
 msgid "Cannot find git in PATH."
-msgstr "Non posso trovare git nel PATH"
+msgstr "Impossibile trovare git nel PATH"
=20
 #: git-gui.sh:550
 msgid "Cannot parse Git version string:"
-msgstr "Non posso estrarre la stringa di versione di git:"
+msgstr "Impossibile determinare la versione di Git:"
=20
 #: git-gui.sh:567
 #, tcl-format
@@ -52,11 +54,11 @@ msgstr "Non trovo la directory di git: "
=20
 #: git-gui.sh:703
 msgid "Cannot use funny .git directory:"
-msgstr "Non posso usare una .git directory strana:"
+msgstr "Impossibile usare una .git directory strana:"
=20
 #: git-gui.sh:708
 msgid "No working directory"
-msgstr "Non working directory"
+msgstr "Nessuna directory di lavoro"
=20
 #: git-gui.sh:854
 msgid "Refreshing file status..."
@@ -80,7 +82,7 @@ msgstr "Modificato, non pronto per il commit"
=20
 #: git-gui.sh:1325 git-gui.sh:1330
 msgid "Staged for commit"
-msgstr "Pronto al commit"
+msgstr "Pronto per il commit"
=20
 #: git-gui.sh:1326 git-gui.sh:1331
 msgid "Portions staged for commit"
@@ -92,7 +94,7 @@ msgstr "Pronto per il commit, mancante"
=20
 #: git-gui.sh:1329
 msgid "Untracked, not staged"
-msgstr "Non seguito, non pronto al commit"
+msgstr "Non tracciato, non pronto per il commit"
=20
 #: git-gui.sh:1334
 msgid "Missing"
@@ -100,7 +102,7 @@ msgstr "Mancante"
=20
 #: git-gui.sh:1335
 msgid "Staged for removal"
-msgstr "Pronto alla rimozione"
+msgstr "Pronto per la rimozione"
=20
 #: git-gui.sh:1336
 msgid "Staged for removal, still present"
@@ -128,15 +130,15 @@ msgstr ""
 #: git-gui.sh:1609
 #, tcl-format
 msgid "Invalid font specified in gui.%s:"
-msgstr "Carattere non valido specificato nella gui.%s:"
+msgstr "Caratteri non valido specificato nella gui.%s:"
=20
 #: git-gui.sh:1634
 msgid "Main Font"
-msgstr "Carattere principale"
+msgstr "Caratteri principali"
=20
 #: git-gui.sh:1635
 msgid "Diff/Console Font"
-msgstr "Carattere per confronti e terminale"
+msgstr "Caratteri per confronti e terminale"
=20
 #: git-gui.sh:1649
 msgid "Repository"
@@ -156,11 +158,11 @@ msgstr "Commit"
=20
 #: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
-msgstr "Fondi (Merge)"
+msgstr "Fusione (Merge)"
=20
 #: git-gui.sh:1659
 msgid "Fetch"
-msgstr "Recupera (Fetch)"
+msgstr "Preleva (Fetch)"
=20
 #: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.=
tcl:172
 msgid "Push"
@@ -273,7 +275,7 @@ msgstr "Correggi l'ultimo commit"
=20
 #: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
-msgstr "Analizza di nuovo"
+msgstr "Analizza nuovamente"
=20
 #: git-gui.sh:1815
 msgid "Stage To Commit"
@@ -326,7 +328,7 @@ msgstr "Aiuto"
=20
 #: git-gui.sh:1938
 msgid "Online Documentation"
-msgstr "Documentazione online"
+msgstr "Documentazione sul web"
=20
 #: git-gui.sh:2054
 msgid "Current Branch:"
@@ -386,11 +388,11 @@ msgstr "Applica/Inverti sezione"
=20
 #: git-gui.sh:2391
 msgid "Decrease Font Size"
-msgstr "Diminuisci dimensione carattere"
+msgstr "Diminuisci dimensione caratteri"
=20
 #: git-gui.sh:2395
 msgid "Increase Font Size"
-msgstr "Aumenta dimensione carattere"
+msgstr "Aumenta dimensione caratteri"
=20
 #: git-gui.sh:2400
 msgid "Show Less Context"
@@ -455,7 +457,7 @@ msgstr "Opzioni"
=20
 #: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Recupera ramo in 'tracking'"
+msgstr "Preleva ramo in 'tracking'"
=20
 #: lib/branch_checkout.tcl:44
 msgid "Detach From Local Branch"
@@ -511,7 +513,7 @@ msgstr "Checkout dopo la creazione"
=20
 #: lib/branch_create.tcl:131
 msgid "Please select a tracking branch."
-msgstr "Scegli un ramo in 'tracking'"
+msgstr "Scegliere un ramo in 'tracking'"
=20
 #: lib/branch_create.tcl:140
 #, tcl-format
@@ -520,7 +522,7 @@ msgstr "Il ramo in 'tracking' %s non =C3=A8 un ramo=
 nell'archivio remoto."
=20
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
-msgstr "Devi dare un nome al ramo."
+msgstr "Inserire un nome per il ramo."
=20
 #: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
 #, tcl-format
@@ -558,7 +560,7 @@ msgid ""
 "\n"
 " Delete the selected branches?"
 msgstr ""
-"Recuperare rami cancellati pu=C3=B2 essere complicato. \n"
+"Prelevare rami cancellati pu=C3=B2 essere complicato. \n"
 "\n"
 " Eliminare i rami selezionati?"
=20
@@ -589,7 +591,7 @@ msgstr "Nuovo Nome:"
=20
 #: lib/branch_rename.tcl:75
 msgid "Please select a branch to rename."
-msgstr "Scegli un ramo da rinominare."
+msgstr "Scegliere un ramo da rinominare."
=20
 #: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
 #, tcl-format
@@ -646,7 +648,7 @@ msgid ""
 msgstr "Il ramo '%s' esiste gi=C3=A0.\n"
 "\n"
 "Non pu=C3=B2 effettuare un 'fast-forward' a %s.\n"
-"E' richiesta una fusione."
+"E' necessaria una fusione."
=20
 #: lib/checkout_op.tcl:220
 #, tcl-format
@@ -660,7 +662,7 @@ msgstr "Aggiornamento di '%s' fallito."
=20
 #: lib/checkout_op.tcl:251
 msgid "Staging area (index) is already locked."
-msgstr "L'area di preparazione al commit (indice) =C3=A8 gi=C3=A0 bloc=
cata."
+msgstr "L'area di preparazione per il commit (indice) =C3=A8 gi=C3=A0 =
bloccata."
=20
 #: lib/checkout_op.tcl:266
 msgid ""
@@ -691,7 +693,7 @@ msgstr "E' richiesta una fusione a livello file."
 #: lib/checkout_op.tcl:358
 #, tcl-format
 msgid "Staying on branch '%s'."
-msgstr "Resto sul ramo '%s'."
+msgstr "Si rimarr=C3=A0 sul ramo '%s'."
=20
 #: lib/checkout_op.tcl:429
 msgid ""
@@ -700,9 +702,9 @@ msgid ""
 "If you wanted to be on a branch, create one now starting from 'This D=
etached "
 "Checkout'."
 msgstr ""
-"Non sei pi=C3=B9 su un ramo locale.\n"
+"Non si =C3=A8 pi=C3=B9 su un ramo locale\n"
 "\n"
-"Se volevi rimanere su un ramo, creane uno ora a partire da 'Questo ch=
eckout "
+"Se si vuole rimanere su un ramo, crearne uno ora a partire da 'Questo=
 checkout "
 "staccato'."
=20
 #: lib/checkout_op.tcl:478
@@ -712,7 +714,7 @@ msgstr "Ripristinare '%s' a '%s' comporter=C3=A0 la=
 perdita dei seguenti commit:"
=20
 #: lib/checkout_op.tcl:500
 msgid "Recovering lost commits may not be easy."
-msgstr "Recuperare commit perduti potrebbe non essere semplice."
+msgstr "Prelevare i commit perduti potrebbe non essere semplice."
=20
 #: lib/checkout_op.tcl:505
 #, tcl-format
@@ -735,7 +737,7 @@ msgid ""
 msgstr ""
 "Preparazione ramo corrente fallita.\n"
 "\n"
-"Questa directory di lavoro =C3=A8 stata convertita solo parzialmente.=
 I tuoi file "
+"Questa directory di lavoro =C3=A8 stata convertita solo parzialmente.=
 I file "
 "sono stati aggiornati correttamente, ma l'aggiornamento di un file di=
 Git ha "
 "prodotto degli errori.\n"
 "\n"
@@ -796,7 +798,7 @@ msgid ""
 msgstr ""
 "Non =C3=A8 possibile effettuare una correzione durante una fusione.\n=
"
 "\n"
-"In questo momento stai effettuando una fusione che non =C3=A8 stata d=
el tutto "
+"In questo momento si sta effettuando una fusione che non =C3=A8 stata=
 del tutto "
 "completata. Non puoi correggere il commit precedente a meno che prima=
 tu non "
 "interrompa l'operazione di fusione in corso.\n"
=20
@@ -1117,7 +1119,7 @@ msgstr "Fusione fallita. Bisogna risolvere i conf=
litti."
 #: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
-msgstr "Fondi in %s"
+msgstr "Fusione in %s"
=20
 #: lib/merge.tcl:177
 msgid "Revision To Merge"
@@ -1177,7 +1179,7 @@ msgstr "Interruzione completata. Pronto."
=20
 #: lib/option.tcl:77
 msgid "git-gui - a graphical user interface for Git."
-msgstr "git-gui - una interfaccia grafica per Git."
+msgstr "git-gui - un'interfaccia grafica per Git."
=20
 #: lib/option.tcl:164
 msgid "Restore Defaults"
@@ -1254,7 +1256,7 @@ msgstr "Remoto:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
 msgid "Arbitrary URL:"
-msgstr ""
+msgstr "URL arbitrario:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1283,11 +1285,11 @@ msgid ""
 "necessary commits.  Try fetching from %s first."
 msgstr ""
 "Una o pi=C3=B9 verifiche di fusione sono fallite perch=C3=A9 mancano =
i commit "
-"necessari. Prova prima a recuperarli da %s."
+"necessari. Prova prima a prelevarli da %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
-msgstr "Scegli uno o pi=C3=B9 rami da cancellare."
+msgstr "Scegliere uno o pi=C3=B9 rami da cancellare."
=20
 #: lib/remote_branch_delete.tcl:216
 msgid ""
@@ -1295,7 +1297,7 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"Recuperare rami cancellati =C3=A8 difficile.\n"
+"Prelevare rami cancellati =C3=A8 difficile.\n"
 "\n"
 "Cancellare i rami selezionati?"
=20
@@ -1316,7 +1318,7 @@ msgstr "Analisi in corso %s..."
 #: lib/remote.tcl:162
 #, tcl-format
 msgid "Fetch from %s..."
-msgstr "Recupera da %s..."
+msgstr "Preleva da %s..."
=20
 #: lib/remote.tcl:172
 #, tcl-format
@@ -1384,3 +1386,4 @@ msgstr "Utilizza 'thin pack' (per connessioni len=
te)"
 #: lib/transport.tcl:159
 msgid "Include tags"
 msgstr "Includi etichette"
+
--=20
1.5.3.rc4.29.g74276
