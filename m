From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 11/15] Italian translation of git-gui
Date: Sun, 2 Sep 2007 17:35:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021735400.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-155218187-1188750950=:28586"
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsRC-0005q8-Vb
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbXIBQge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933153AbXIBQgd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:36:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:52075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933229AbXIBQgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:36:32 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:36:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 02 Sep 2007 18:36:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xPxY4kLXxk7v+5wf0Y6S2WzVJyl0MVVYs6Q0Iwe
	kURkLOHlD9KZeO
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57359>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-155218187-1188750950=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

[jes: includes patches from Michele Ballabio]

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/it.po | 1393 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1393 insertions(+), 0 deletions(-)
 create mode 100644 po/it.po

diff --git a/po/it.po b/po/it.po
new file mode 100644
index 0000000..17a5c21
--- /dev/null
+++ b/po/it.po
@@ -0,0 +1,1393 @@
+# Translation of git-gui to Italian
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui package.
+# Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, 2007
+# Michele Ballabio <barra_cuda@katamail.com>, 2007.
+# 
+# 
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-08-11 17:28+0200\n"
+"PO-Revision-Date: 2007-08-09 00:27+0200\n"
+"Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
+"Language-Team: Italian <tp@lists.linux.it>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit"
+
+#: git-gui.sh:531
+msgid "Cannot find git in PATH."
+msgstr "Impossibile trovare git nel PATH"
+
+#: git-gui.sh:550
+msgid "Cannot parse Git version string:"
+msgstr "Impossibile determinare la versione di Git:"
+
+#: git-gui.sh:567
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+"La versione di GIT non può essere determinata.\n"
+"\n"
+"%s sostiene che la versione è '%s'.\n"
+"\n"
+"%s richiede almeno Git 1.5.0 o superiore.\n"
+"\n"
+"Assumere che '%s' sia alla versione 1.5.0?\n"
+
+#: git-gui.sh:689
+msgid "Cannot find the git directory:"
+msgstr "Non posso trovare la directory di git:"
+
+#: git-gui.sh:697
+msgid "Git directory not found:"
+msgstr "Non trovo la directory di git: "
+
+#: git-gui.sh:703
+msgid "Cannot use funny .git directory:"
+msgstr "Impossibile usare una .git directory strana:"
+
+#: git-gui.sh:708
+msgid "No working directory"
+msgstr "Nessuna directory di lavoro"
+
+#: git-gui.sh:854
+msgid "Refreshing file status..."
+msgstr "Controllo dello stato dei file in corso..."
+
+#: git-gui.sh:891
+msgid "Scanning for modified files ..."
+msgstr "Ricerca di file modificati in corso..."
+
+#: git-gui.sh:1057 lib/browser.tcl:247
+msgid "Ready."
+msgstr "Pronto."
+
+#: git-gui.sh:1322
+msgid "Unmodified"
+msgstr "Non modificato"
+
+#: git-gui.sh:1324
+msgid "Modified, not staged"
+msgstr "Modificato, non pronto per il commit"
+
+#: git-gui.sh:1325 git-gui.sh:1330
+msgid "Staged for commit"
+msgstr "Pronto per il commit"
+
+#: git-gui.sh:1326 git-gui.sh:1331
+msgid "Portions staged for commit"
+msgstr "Parti pronte per il commit"
+
+#: git-gui.sh:1327 git-gui.sh:1332
+msgid "Staged for commit, missing"
+msgstr "Pronto per il commit, mancante"
+
+#: git-gui.sh:1329
+msgid "Untracked, not staged"
+msgstr "Non tracciato, non pronto per il commit"
+
+#: git-gui.sh:1334
+msgid "Missing"
+msgstr "Mancante"
+
+#: git-gui.sh:1335
+msgid "Staged for removal"
+msgstr "Pronto per la rimozione"
+
+#: git-gui.sh:1336
+msgid "Staged for removal, still present"
+msgstr "Pronto alla rimozione, ancora presente"
+
+#: git-gui.sh:1338 git-gui.sh:1339 git-gui.sh:1340 git-gui.sh:1341
+msgid "Requires merge resolution"
+msgstr "Richiede risoluzione dei conflitti"
+
+#: git-gui.sh:1383
+msgid "Starting gitk... please wait..."
+msgstr "Avvio di gitk... attendere..."
+
+#: git-gui.sh:1392
+#, tcl-format
+msgid ""
+"Unable to start gitk:\n"
+"\n"
+"%s does not exist"
+msgstr ""
+"Impossibile avviare gitk:\n"
+"\n"
+"%s non esiste"
+
+#: git-gui.sh:1609
+#, tcl-format
+msgid "Invalid font specified in gui.%s:"
+msgstr "Caratteri non validi specificati nella gui.%s:"
+
+#: git-gui.sh:1634
+msgid "Main Font"
+msgstr "Caratteri principali"
+
+#: git-gui.sh:1635
+msgid "Diff/Console Font"
+msgstr "Caratteri per confronti e terminale"
+
+#: git-gui.sh:1649
+msgid "Repository"
+msgstr "Archivio"
+
+#: git-gui.sh:1650
+msgid "Edit"
+msgstr "Modifica"
+
+#: git-gui.sh:1652
+msgid "Branch"
+msgstr "Ramo"
+
+#: git-gui.sh:1655 git-gui.sh:1842 git-gui.sh:2152
+msgid "Commit"
+msgstr "Commit"
+
+#: git-gui.sh:1658 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+msgid "Merge"
+msgstr "Fusione (Merge)"
+
+#: git-gui.sh:1659
+msgid "Fetch"
+msgstr "Preleva (Fetch)"
+
+#: git-gui.sh:1660 git-gui.sh:2158 lib/transport.tcl:88 lib/transport.tcl:172
+msgid "Push"
+msgstr "Propaga (Push)"
+
+#: git-gui.sh:1669
+msgid "Browse Current Branch's Files"
+msgstr "Esplora i file del ramo corrente"
+
+#: git-gui.sh:1673
+msgid "Browse Branch Files..."
+msgstr "Esplora i file del ramo..."
+
+#: git-gui.sh:1678
+msgid "Visualize Current Branch's History"
+msgstr "Visualizza la cronologia del ramo corrente"
+
+#: git-gui.sh:1682
+msgid "Visualize All Branch History"
+msgstr "Visualizza la cronologia di tutti i rami"
+
+#: git-gui.sh:1689
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Esplora i file di %s"
+
+#: git-gui.sh:1691
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Visualizza la cronologia di %s"
+
+#: git-gui.sh:1696 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Statistiche del database"
+
+#: git-gui.sh:1699 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Comprimi il database"
+
+#: git-gui.sh:1702
+msgid "Verify Database"
+msgstr "Verifica il database"
+
+#: git-gui.sh:1709 git-gui.sh:1713 git-gui.sh:1717 lib/shortcut.tcl:9
+#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+msgid "Create Desktop Icon"
+msgstr "Crea icona desktop"
+
+#: git-gui.sh:1722
+msgid "Quit"
+msgstr "Esci"
+
+#: git-gui.sh:1729
+msgid "Undo"
+msgstr "Annulla"
+
+#: git-gui.sh:1732
+msgid "Redo"
+msgstr "Ripeti"
+
+#: git-gui.sh:1736 git-gui.sh:2222
+msgid "Cut"
+msgstr "Taglia"
+
+#: git-gui.sh:1739 git-gui.sh:2225 git-gui.sh:2296 git-gui.sh:2368
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Copia"
+
+#: git-gui.sh:1742 git-gui.sh:2228
+msgid "Paste"
+msgstr "Incolla"
+
+#: git-gui.sh:1745 git-gui.sh:2231 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Elimina"
+
+#: git-gui.sh:1749 git-gui.sh:2235 git-gui.sh:2372 lib/console.tcl:71
+msgid "Select All"
+msgstr "Seleziona tutto"
+
+#: git-gui.sh:1758
+msgid "Create..."
+msgstr "Crea..."
+
+#: git-gui.sh:1764
+msgid "Checkout..."
+msgstr "Checkout..."
+
+#: git-gui.sh:1770
+msgid "Rename..."
+msgstr "Rinomina"
+
+#: git-gui.sh:1775 git-gui.sh:1873
+msgid "Delete..."
+msgstr "Elimina..."
+
+#: git-gui.sh:1780
+msgid "Reset..."
+msgstr "Ripristina..."
+
+#: git-gui.sh:1792 git-gui.sh:2169
+msgid "New Commit"
+msgstr "Nuovo commit"
+
+#: git-gui.sh:1800 git-gui.sh:2176
+msgid "Amend Last Commit"
+msgstr "Correggi l'ultimo commit"
+
+#: git-gui.sh:1809 git-gui.sh:2136 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "Analizza nuovamente"
+
+#: git-gui.sh:1815
+msgid "Stage To Commit"
+msgstr "Prepara per il commit"
+
+#: git-gui.sh:1820
+msgid "Stage Changed Files To Commit"
+msgstr "Prepara per il commit i file modificati"
+
+#: git-gui.sh:1826
+msgid "Unstage From Commit"
+msgstr "Non pronto per il commit"
+
+#: git-gui.sh:1831 lib/index.tcl:376
+msgid "Revert Changes"
+msgstr "Annulla modifiche"
+
+#: git-gui.sh:1838 git-gui.sh:2148 git-gui.sh:2246
+msgid "Sign Off"
+msgstr "Sign Off"
+
+#: git-gui.sh:1853
+msgid "Local Merge..."
+msgstr "Fusione locale"
+
+#: git-gui.sh:1858
+msgid "Abort Merge..."
+msgstr "Interrompi fusione"
+
+#: git-gui.sh:1870
+msgid "Push..."
+msgstr "Propaga..."
+
+#: git-gui.sh:1880
+msgid "Apple"
+msgstr "Apple"
+
+#: git-gui.sh:1883 git-gui.sh:1901 lib/option.tcl:65
+#, tcl-format
+msgid "About %s"
+msgstr "Informazioni su %s"
+
+#: git-gui.sh:1885 git-gui.sh:1891 git-gui.sh:2414
+msgid "Options..."
+msgstr "Opzioni..."
+
+#: git-gui.sh:1897
+msgid "Help"
+msgstr "Aiuto"
+
+#: git-gui.sh:1938
+msgid "Online Documentation"
+msgstr "Documentazione sul web"
+
+#: git-gui.sh:2054
+msgid "Current Branch:"
+msgstr "Ramo attuale:"
+
+#: git-gui.sh:2075
+msgid "Staged Changes (Will Be Committed)"
+msgstr "Modifiche preparate (ne verrà effettuato il commit)"
+
+#: git-gui.sh:2095
+msgid "Unstaged Changes (Will Not Be Committed)"
+msgstr "Modifiche non preparate (non ne verrà effettuato il commit)"
+
+#: git-gui.sh:2142
+msgid "Stage Changed"
+msgstr "Prepara modificati"
+
+#: git-gui.sh:2188
+msgid "Initial Commit Message:"
+msgstr "Messaggio di commit iniziale:"
+
+#: git-gui.sh:2189
+msgid "Amended Commit Message:"
+msgstr "Messaggio di commit corretto:"
+
+#: git-gui.sh:2190
+msgid "Amended Initial Commit Message:"
+msgstr "Messaggio iniziale di commit corretto:"
+
+#: git-gui.sh:2191
+msgid "Amended Merge Commit Message:"
+msgstr "Messaggio di fusione corretto:"
+
+#: git-gui.sh:2192
+msgid "Merge Commit Message:"
+msgstr "Messaggio di fusione:"
+
+#: git-gui.sh:2193
+msgid "Commit Message:"
+msgstr "Messaggio di commit:"
+
+#: git-gui.sh:2238 git-gui.sh:2376 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Copia tutto"
+
+#: git-gui.sh:2262 lib/blame.tcl:104
+msgid "File:"
+msgstr "File:"
+
+#: git-gui.sh:2364
+msgid "Refresh"
+msgstr "Rinfresca"
+
+#: git-gui.sh:2385
+msgid "Apply/Reverse Hunk"
+msgstr "Applica/Inverti sezione"
+
+#: git-gui.sh:2391
+msgid "Decrease Font Size"
+msgstr "Diminuisci dimensione caratteri"
+
+#: git-gui.sh:2395
+msgid "Increase Font Size"
+msgstr "Aumenta dimensione caratteri"
+
+#: git-gui.sh:2400
+msgid "Show Less Context"
+msgstr "Mostra meno contesto"
+
+#: git-gui.sh:2407
+msgid "Show More Context"
+msgstr "Mostra più contesto"
+
+#: git-gui.sh:2422
+msgid "Unstage Hunk From Commit"
+msgstr "Sezione non pronta per il commit"
+
+#: git-gui.sh:2426 git-gui.sh:2430
+msgid "Stage Hunk For Commit"
+msgstr "Prepara sezione per il commit"
+
+#: git-gui.sh:2440
+msgid "Initializing..."
+msgstr "Inizializzazione..."
+
+#: lib/blame.tcl:77
+msgid "File Viewer"
+msgstr "Mostra file"
+
+#: lib/blame.tcl:81
+msgid "Commit:"
+msgstr "Commit:"
+
+#: lib/blame.tcl:249
+msgid "Copy Commit"
+msgstr "Copia commit"
+
+#: lib/blame.tcl:369
+#, tcl-format
+msgid "Reading %s..."
+msgstr "Lettura di %s..."
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Checkout ramo"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Checkout"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:283
+#: lib/checkout_op.tcl:522 lib/merge.tcl:172 lib/option.tcl:172
+#: lib/remote_branch_delete.tcl:42 lib/transport.tcl:92
+msgid "Cancel"
+msgstr "Annulla"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:288
+msgid "Revision"
+msgstr "Revisione"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:159
+#: lib/option.tcl:274
+msgid "Options"
+msgstr "Opzioni"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Preleva ramo in 'tracking'"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Stacca da ramo locale"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Crea ramo"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Crea nuovo ramo"
+
+#: lib/branch_create.tcl:31
+msgid "Create"
+msgstr "Crea"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Nome del ramo"
+
+#: lib/branch_create.tcl:43
+msgid "Name:"
+msgstr "Nome:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Appaia nome del ramo in 'tracking'"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Revisione iniziale"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Aggiorna ramo esistente:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "No"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Solo fast forward"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+msgid "Reset"
+msgstr "Ripristina"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Checkout dopo la creazione"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Scegliere un ramo in 'tracking'"
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Il ramo in 'tracking' %s non è un ramo nell'archivio remoto."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Inserire un nome per il ramo."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' non è utilizzabile come nome di ramo."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Elimina ramo"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Elimina ramo locale"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Rami locali"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "Cancella solo se fuso con un altro ramo"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr "Sempre (Non effettuare controlli durante la fusione)."
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "I rami seguenti non sono stati fusi completamente in %s:"
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"Prelevare rami cancellati può essere complicato. \n"
+"\n"
+" Eliminare i rami selezionati?"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Cancellazione rami fallita:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Rinomina ramo"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Rinomina"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Ramo:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Nuovo Nome:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Scegliere un ramo da rinominare."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Il ramo '%s' esiste già"
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Cambiamento nome '%s' fallito."
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Avvio in corso..."
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "File browser"
+
+#: lib/browser.tcl:127 lib/browser.tcl:144
+#, tcl-format
+msgid "Loading %s..."
+msgstr "Caricamento %s..."
+
+#: lib/browser.tcl:188
+msgid "[Up To Parent]"
+msgstr "[Directory superiore]"
+
+#: lib/browser.tcl:268 lib/browser.tcl:274
+msgid "Browse Branch Files"
+msgstr "Esplora i file del ramo"
+
+#: lib/browser.tcl:279
+msgid "Browse"
+msgstr "Sfoglia"
+
+#: lib/checkout_op.tcl:79
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Recupero %s da %s"
+
+#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+msgid "Close"
+msgstr "Chiudi"
+
+#: lib/checkout_op.tcl:169
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Il ramo '%s' non esiste."
+
+#: lib/checkout_op.tcl:206
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr "Il ramo '%s' esiste già.\n"
+"\n"
+"Non può effettuare un 'fast-forward' a %s.\n"
+"E' necessaria una fusione."
+
+#: lib/checkout_op.tcl:220
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "La strategia di fusione '%s' non è supportata."
+
+#: lib/checkout_op.tcl:239
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Aggiornamento di '%s' fallito."
+
+#: lib/checkout_op.tcl:251
+msgid "Staging area (index) is already locked."
+msgstr "L'area di preparazione per il commit (indice) è già bloccata."
+
+#: lib/checkout_op.tcl:266
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"L'ultimo stato analizzato non corrisponde allo stato del repository.\n"
+"\n"
+"Un altro programma Git ha modificato questo repository dall'ultima analisi. "
+"Bisogna effettuare una nuova analisi prima di poter cambiare il ramo "
+"corrente.\n"
+"\n"
+"La nuova analisi comincerà ora.\n"
+
+#: lib/checkout_op.tcl:353
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "Checkout di '%s' fallito (richiesta una fusione a livello file)."
+
+#: lib/checkout_op.tcl:354
+msgid "File level merge required."
+msgstr "E' richiesta una fusione a livello file."
+
+#: lib/checkout_op.tcl:358
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Si rimarrà sul ramo '%s'."
+
+#: lib/checkout_op.tcl:429
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"Non si è più su un ramo locale\n"
+"\n"
+"Se si vuole rimanere su un ramo, crearne uno ora a partire da 'Questo checkout "
+"staccato'."
+
+#: lib/checkout_op.tcl:478
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "Ripristinare '%s' a '%s' comporterà la perdita dei seguenti commit:"
+
+#: lib/checkout_op.tcl:500
+msgid "Recovering lost commits may not be easy."
+msgstr "Prelevare i commit perduti potrebbe non essere semplice."
+
+#: lib/checkout_op.tcl:505
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "Ripristinare '%s'?"
+
+#: lib/checkout_op.tcl:510 lib/merge.tcl:164
+msgid "Visualize"
+msgstr "Visualizza"
+
+#: lib/checkout_op.tcl:578
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Preparazione ramo corrente fallita.\n"
+"\n"
+"Questa directory di lavoro è stata convertita solo parzialmente. I file "
+"sono stati aggiornati correttamente, ma l'aggiornamento di un file di Git ha "
+"prodotto degli errori.\n"
+"\n"
+"Questo non sarebbe dovuto succedere.  %s ora terminerà senza altre azioni."
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr "Questo checkout staccato"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Espressione di revisione:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "Ramo locale"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "Ramo in 'tracking'"
+
+#: lib/choose_rev.tcl:84
+msgid "Tag"
+msgstr "Etichetta"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Revisione non valida: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "Nessuna revisione selezionata."
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "L'espressione di revisione è vuota."
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Non c'è niente da correggere.\n"
+"\n"
+"Stai per creare il commit iniziale. Non esiste un commit precedente da "
+"correggere.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Non è possibile effettuare una correzione durante una fusione.\n"
+"\n"
+"In questo momento si sta effettuando una fusione che non è stata del tutto "
+"completata. Non puoi correggere il commit precedente a meno che prima tu non "
+"interrompa l'operazione di fusione in corso.\n"
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr "Errore durante il caricamento dei dati da correggere:"
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr "Impossibile ottenere la tua identità:"
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "GIT_COMMITTER_IDENT non valida:"
+
+#: lib/commit.tcl:133
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"L'ultimo stato analizzato non corrisponde allo stato del repository.\n"
+"\n"
+"Un altro programma Git ha modificato questo repository dall'ultima analisi. "
+"Bisogna effettuare una nuova analisi prima di poter creare un nuovo commit.\n"
+"\n"
+"La nuova analisi comincerà ora.\n"
+
+#: lib/commit.tcl:154
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Non è possibile effettuare il commit di file non sottoposti a fusione.\n"
+"\n"
+"Il file %s presenta dei conflitti. Devi risolverli e preparare il file "
+"per il commit prima di effettuare questa azione.\n"
+
+#: lib/commit.tcl:162
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Stato di file %s sconosciuto.\n"
+"\n"
+"Non si può effettuare il commit del file %s con questo programma.\n"
+
+#: lib/commit.tcl:170
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Nessuna modifica per la quale effettuare il commit.\n"
+"\n"
+"Devi preparare per il commit almeno 1 file prima di effettuare questa operazione.\n"
+
+#: lib/commit.tcl:183
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentance what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Bisogna fornire un messaggio di commit.\n"
+"\n"
+"Un buon messaggio di commit ha il seguente formato:\n"
+"\n"
+"- Prima linea: descrivi in una frase ciò che hai fatto.\n"
+"- Seconda linea: vuota.\n"
+"- Terza linea: spiga a cosa serve la tua modifica.\n"
+
+#: lib/commit.tcl:257
+msgid "write-tree failed:"
+msgstr "write-tree fallito:"
+
+#: lib/commit.tcl:279
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Nessuna modifica pronta per il commit.\n"
+"\n"
+"Questo commit non modifica alcun file e non effettua alcuna fusione.\n"
+"\n"
+"Si procederà subito ad una nuova analisi.\n"
+
+#: lib/commit.tcl:286
+msgid "No changes to commit."
+msgstr "Nessuna modifica pronta per il commit."
+
+#: lib/commit.tcl:317
+msgid "commit-tree failed:"
+msgstr "commit-tree fallito:"
+
+#: lib/commit.tcl:339
+msgid "update-ref failed:"
+msgstr "update-ref fallito:"
+
+#: lib/commit.tcl:430
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Creato commit %s: %s"
+
+#: lib/console.tcl:55
+msgid "Working... please wait..."
+msgstr "Elaborazione in corso... attendere..."
+
+#: lib/console.tcl:184
+msgid "Success"
+msgstr "Successo"
+
+#: lib/console.tcl:194
+msgid "Error: Command Failed"
+msgstr "Errore: comando fallito"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "Numero di oggetti slegati"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "Spazio su disco utilizzato da oggetti slegati"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "Numero di oggetti impacchettati"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "Numero di pacchetti"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "Spazio su disco utilizzato da oggetti impacchettati"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "Oggetti impacchettati che attendono la potatura"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "File inutili"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Compressione del database in corso"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Verifica dell'archivio con fsck-objects in corso"
+
+#: lib/diff.tcl:42
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Non sono state trovate differenze.\n"
+"\n"
+"%s non ha modifiche.\n"
+"\n"
+"La data di modifica di questo file è stata cambiata da un'altra "
+"applicazione, ma il contenuto del file è rimasto invariato.\n"
+"\n"
+"Si procederà automaticamente ad una nuova analisi per trovare altri file che "
+"potrebbero avere lo stesso stato."
+
+#: lib/diff.tcl:97
+msgid "Error loading file:"
+msgstr "Errore nel caricamento del file:"
+
+#: lib/diff.tcl:162
+msgid "Error loading diff:"
+msgstr "Errore nel caricamento delle differenze:"
+
+#: lib/diff.tcl:278
+msgid "Failed to unstage selected hunk."
+msgstr "La sezione scelta è ancora pronta per il commit."
+
+#: lib/diff.tcl:285
+msgid "Failed to stage selected hunk."
+msgstr "La sezione scelta non è ancora pronta per il commit."
+
+#: lib/error.tcl:12 lib/error.tcl:102
+msgid "error"
+msgstr "errore"
+
+#: lib/error.tcl:28
+msgid "warning"
+msgstr "avviso"
+
+#: lib/error.tcl:81
+msgid "You must correct the above errors before committing."
+msgstr "Bisogna correggere gli errori suddetti prima di effettuare un commit."
+
+#: lib/index.tcl:364
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Annullare le modifiche nel file %s?"
+
+#: lib/index.tcl:366
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Annullare le modifiche in questi %i file?"
+
+#: lib/index.tcl:372
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr "Tutte le modifiche non preparate per il commit saranno perse per sempre."
+
+#: lib/index.tcl:375
+msgid "Do Nothing"
+msgstr "Non fare niente"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Non posso effettuare fusioni durante una correzione.\n"
+"\n"
+"Bisogna finire di correggere questo commit prima di iniziare una qualunque "
+"fusione.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"L'ultimo stato analizzato non corrisponde allo stato del repository.\n"
+"\n"
+"Un altro programma Git ha modificato questo repository dall'ultima analisi."
+"Bisogna effettuare una nuova analisi prima di poter effettuare una fusione.\n"
+"\n"
+"La nuova analisi comincerà ora.\n"
+
+#: lib/merge.tcl:44
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Sei nel mezzo di una fusione con conflitti.\n"
+"\n"
+"Il file %s ha dei conflitti.\n"
+"\n"
+"Bisogna risolvere i conflitti, preparare il file per il commit ed infine "
+"effettuare un commit "
+"per completare la fusione corrente. Solo a questo punto potrai iniziare "
+"un'altra fusione.\n"
+
+#: lib/merge.tcl:54
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Sei nel mezzo di una modifica.\n"
+"\n"
+"Il file %s è stato modificato.\n"
+"\n"
+"Bisogna completare il commit corrente prima di iniziare una fusione. In "
+"questo modo sarà più facile interrompere una fusione non riuscita, nel caso "
+"ce ne fosse bisogno.\n"
+
+#: lib/merge.tcl:106
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s di %s"
+
+#: lib/merge.tcl:119
+#, tcl-format
+msgid "Merging %s and %s"
+msgstr "Fusione di %s e %s in corso"
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "Fusione completata con successo."
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Fusione fallita. Bisogna risolvere i conflitti."
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Fusione in %s"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "Revisione da fondere"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Interruzione impossibile durante una correzione.\n"
+"\n"
+"Bisogna finire di correggere questo commit.\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Interrompere fusione?\n"
+"\n"
+"L'interruzione della fusione corrente causerà la perdita di *TUTTE* le "
+"modifiche non ancora presenti nei commit.\n"
+"\n"
+"Continuare con l'interruzione della fusione corrente?"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Annullare le modifiche?\n"
+"\n"
+"L'annullamento delle modifiche causerà la perdita di *TUTTE* le "
+"modifiche non ancora presenti nei commit.\n"
+"\n"
+"Continuare con l'annullamento delle modifiche correnti?"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "Interruzione in corso"
+
+#: lib/merge.tcl:266
+msgid "Abort failed."
+msgstr "Interruzione fallita."
+
+#: lib/merge.tcl:268
+msgid "Abort completed.  Ready."
+msgstr "Interruzione completata. Pronto."
+
+#: lib/option.tcl:77
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - un'interfaccia grafica per Git."
+
+#: lib/option.tcl:164
+msgid "Restore Defaults"
+msgstr "Ripristina predefiniti"
+
+#: lib/option.tcl:168
+msgid "Save"
+msgstr "Salva"
+
+#: lib/option.tcl:178
+#, tcl-format
+msgid "%s Repository"
+msgstr "%s archivio"
+
+#: lib/option.tcl:179
+msgid "Global (All Repositories)"
+msgstr "Globale (Tutti i repository)"
+
+#: lib/option.tcl:185
+msgid "User Name"
+msgstr "Nome utente"
+
+#: lib/option.tcl:186
+msgid "Email Address"
+msgstr "Indirizzo Email"
+
+#: lib/option.tcl:188
+msgid "Summarize Merge Commits"
+msgstr "Riepilogo nei commit di fusione"
+
+#: lib/option.tcl:189
+msgid "Merge Verbosity"
+msgstr "Verbosità della fusione"
+
+#: lib/option.tcl:190
+msgid "Show Diffstat After Merge"
+msgstr "Mostra statistiche delle differenze dopo la fusione"
+
+#: lib/option.tcl:192
+msgid "Trust File Modification Timestamps"
+msgstr "Fidati delle date di modifica dei file"
+
+#: lib/option.tcl:193
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Effettua potatura dei rami in 'tracking' durante il recupero"
+
+#: lib/option.tcl:194
+msgid "Match Tracking Branches"
+msgstr "Appaia rami in 'tracking'"
+
+#: lib/option.tcl:195
+msgid "Number of Diff Context Lines"
+msgstr "Numero di linee di contesto nelle differenze"
+
+#: lib/option.tcl:196
+msgid "New Branch Name Template"
+msgstr "Modello per il nome di un nuovo ramo"
+
+#: lib/option.tcl:305
+msgid "Failed to completely save options:"
+msgstr "Fallimento nel salvataggio completo delle opzioni:"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Remote Branch"
+msgstr "Cancella ramo remoto"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Da archivio"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:118
+msgid "Remote:"
+msgstr "Remoto:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:133
+msgid "Arbitrary URL:"
+msgstr "URL arbitrario:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Rami"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Elimina solo se"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Fuso in:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Sempre (Non effettuare controlli durante la fusione)"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "Si richiede un ramo per 'Fuso in'."
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Una o più verifiche di fusione sono fallite perché mancano i commit "
+"necessari. Prova prima a prelevarli da %s."
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "Scegliere uno o più rami da cancellare."
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Prelevare rami cancellati è difficile.\n"
+"\n"
+"Cancellare i rami selezionati?"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Cancellazione rami da %s"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "Nessun archivio selezionato."
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "Analisi in corso %s..."
+
+#: lib/remote.tcl:162
+#, tcl-format
+msgid "Fetch from %s..."
+msgstr "Preleva da %s..."
+
+#: lib/remote.tcl:172
+#, tcl-format
+msgid "Prune from %s..."
+msgstr "Effettua potatura da %s..."
+
+#: lib/remote.tcl:206
+#, tcl-format
+msgid "Push to %s..."
+msgstr "Propaga verso %s..."
+
+#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
+msgid "Cannot write script:"
+msgstr "Impossibile scrivere script:"
+
+#: lib/shortcut.tcl:149
+msgid "Cannot write icon:"
+msgstr "Impossibile scrivere icona:"
+
+#: lib/status_bar.tcl:58
+#, tcl-format
+msgid "%s ... %i of %i %s (%2i%%)"
+msgstr "%s ... %i di %i %s (%2i%%)"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Recupero nuove modifiche da %s"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Effettua potatura dei rami in 'tracking' cancellati da %s"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Propagazione modifiche a %s"
+
+#: lib/transport.tcl:68
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Propagazione %s %s a %s"
+
+#: lib/transport.tcl:84
+msgid "Push Branches"
+msgstr "Propaga rami"
+
+#: lib/transport.tcl:98
+msgid "Source Branches"
+msgstr "Rami di origine"
+
+#: lib/transport.tcl:115
+msgid "Destination Repository"
+msgstr "Archivio di destinazione"
+
+#: lib/transport.tcl:153
+msgid "Transfer Options"
+msgstr "Opzioni di trasferimento"
+
+#: lib/transport.tcl:155
+msgid "Use thin pack (for slow network connections)"
+msgstr "Utilizza 'thin pack' (per connessioni lente)"
+
+#: lib/transport.tcl:159
+msgid "Include tags"
+msgstr "Includi etichette"
+
-- 
1.5.3.2.g46909


--8323584-155218187-1188750950=:28586--
