From: Fredrik Skolmli <fredrik@frsk.net>
Subject: [PATCH] gitk: Starting translation for Norwegian
Date: Wed, 3 Dec 2008 23:54:11 +0100
Message-ID: <20081203225411.GA12563@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:55:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80dD-0005B9-QO
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 23:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYLCWy0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2008 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbYLCWy0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:54:26 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:37158 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbYLCWyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:54:22 -0500
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1L80bp-00088U-Hp; Wed, 03 Dec 2008 23:54:19 +0100
Received: from fredrik by asterix.frsk.net with local (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1L80bj-0004x4-Mx; Wed, 03 Dec 2008 23:54:11 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102298>


This file have been used locally for some time, and is near completion.=
 Will
put an effort into completing it later on, or just leave it as an excer=
cise for
other Norwegians.

Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>
---

If there are any issues with character encoding etc and you'd like it a=
s an
attachment, please let me know.

 git-gui/po/nb.po | 2484 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 2484 insertions(+), 0 deletions(-)
 create mode 100644 git-gui/po/nb.po

diff --git a/git-gui/po/nb.po b/git-gui/po/nb.po
new file mode 100644
index 0000000..6099543
--- /dev/null
+++ b/git-gui/po/nb.po
@@ -0,0 +1,2484 @@
+# Norwegian (Bokm=E5l) translation of git-gui.
+# Copyright (C) 2007-2008 Shawn Pearce, et al.
+# This file is distributed under the same license as the git-gui packa=
ge.
+#
+# Fredrik Skolmli <fredrik@frsk.net>, 2008.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: nb\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2008-11-16 13:56-0800\n"
+"PO-Revision-Date: 2008-12-03 16:05+0100\n"
+"Last-Translator: Fredrik Skolmli <fredrik@frsk.net>\n"
+"Language-Team: Norwegian Bokm=E5l\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
+msgid "git-gui: fatal error"
+msgstr "git-gui: Kritisk feil"
+
+#: git-gui.sh:689
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "Ugyldig font spesifisert i %s:"
+
+#: git-gui.sh:723
+msgid "Main Font"
+msgstr "Hovedskrifttype"
+
+#: git-gui.sh:724
+msgid "Diff/Console Font"
+msgstr "Diff-/Konsollskrifttype"
+
+#: git-gui.sh:738
+msgid "Cannot find git in PATH."
+msgstr "Kan ikke finne git i PATH"
+
+#: git-gui.sh:765
+msgid "Cannot parse Git version string:"
+msgstr "Kan ikke tyde Git's oppgitte versjon:"
+
+#: git-gui.sh:783
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
+"Kan ikke avgj=F8re hvilken Git-versjon du har.\n"
+"\n"
+"%s sier versjonen er '%s'.\n"
+"\n"
+"%s krever Git versjon 1.5.0 eller nyere.\n"
+"\n"
+"Anta at '%s' er versjon 1.5.0?\n"
+
+#: git-gui.sh:1062
+msgid "Git directory not found:"
+msgstr "Git-katalog ikke funnet:"
+
+#: git-gui.sh:1069
+msgid "Cannot move to top of working directory:"
+msgstr "Kan ikke g=E5 til toppen av arbeidskatalogen:"
+
+#: git-gui.sh:1076
+msgid "Cannot use funny .git directory:"
+msgstr ""
+
+#: git-gui.sh:1081
+msgid "No working directory"
+msgstr "Ingen arbeidskatalog"
+
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
+msgid "Refreshing file status..."
+msgstr "Oppdaterer filstatus..."
+
+#: git-gui.sh:1303
+msgid "Scanning for modified files ..."
+msgstr "S=F8ker etter endrede filer..."
+
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr ""
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr ""
+
+#: git-gui.sh:1542 lib/browser.tcl:246
+msgid "Ready."
+msgstr "Klar."
+
+#: git-gui.sh:1819
+msgid "Unmodified"
+msgstr "Uendret"
+
+#: git-gui.sh:1821
+msgid "Modified, not staged"
+msgstr "Endret, ikke k=F8et"
+
+#: git-gui.sh:1822 git-gui.sh:1830
+msgid "Staged for commit"
+msgstr "K=F8et for innsjekking"
+
+#: git-gui.sh:1823 git-gui.sh:1831
+msgid "Portions staged for commit"
+msgstr "Delvis k=F8et for innsjekking"
+
+#: git-gui.sh:1824 git-gui.sh:1832
+msgid "Staged for commit, missing"
+msgstr "Klar for innsjekking, manglende"
+
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "Filtype endret, ikke k=F8et"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "Filtype endret, k=F8et"
+
+#: git-gui.sh:1829
+msgid "Untracked, not staged"
+msgstr "Usporet, ikke k=F8et"
+
+#: git-gui.sh:1834
+msgid "Missing"
+msgstr "Manglende"
+
+#: git-gui.sh:1835
+msgid "Staged for removal"
+msgstr "K=F8et for fjerning"
+
+#: git-gui.sh:1836
+msgid "Staged for removal, still present"
+msgstr "K=F8et for fjerning, fortsatt tilstede"
+
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
+msgid "Requires merge resolution"
+msgstr "Sammensl=E5ingen krever konflikth=E5ndtering"
+
+#: git-gui.sh:1878
+msgid "Starting gitk... please wait..."
+msgstr "Starter gitk... Vennligst vent..."
+
+#: git-gui.sh:1887
+msgid "Couldn't find gitk in PATH"
+msgstr "Kunne ikke finne gitk i PATH"
+
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
+msgid "Repository"
+msgstr "Arkiv"
+
+#: git-gui.sh:2281
+msgid "Edit"
+msgstr "Redigere"
+
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
+msgid "Branch"
+msgstr "Gren"
+
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
+msgid "Commit@@noun"
+msgstr "Innsjekking"
+
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+msgid "Merge"
+msgstr "Sammensl=E5ing"
+
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
+msgid "Remote"
+msgstr "Fjernarkiv"
+
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "Verkt=F8y"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "Utforsk arbeidskopien"
+
+#: git-gui.sh:2307
+msgid "Browse Current Branch's Files"
+msgstr "Utforsk denne grens filer"
+
+#: git-gui.sh:2311
+msgid "Browse Branch Files..."
+msgstr "Bla igjennom filer p=E5 gren..."
+
+#: git-gui.sh:2316
+msgid "Visualize Current Branch's History"
+msgstr "Visualiser denne grens historikk"
+
+#: git-gui.sh:2320
+msgid "Visualize All Branch History"
+msgstr "Visualiser alle greners historikk"
+
+#: git-gui.sh:2327
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Bla i filene til %s"
+
+#: git-gui.sh:2329
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Visualiser historien til %s"
+
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Databasestatistikk"
+
+#: git-gui.sh:2337 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Kompress databasen"
+
+#: git-gui.sh:2340
+msgid "Verify Database"
+msgstr "Verifiser databasen"
+
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
+msgid "Create Desktop Icon"
+msgstr "Lag skrivebordsikon"
+
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
+msgid "Quit"
+msgstr "Avslutt"
+
+#: git-gui.sh:2371
+msgid "Undo"
+msgstr "Angre"
+
+#: git-gui.sh:2374
+msgid "Redo"
+msgstr "Gj=F8r om"
+
+#: git-gui.sh:2378 git-gui.sh:2923
+msgid "Cut"
+msgstr "Klipp ut"
+
+#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Kopier"
+
+#: git-gui.sh:2384 git-gui.sh:2929
+msgid "Paste"
+msgstr "Lim inn"
+
+#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Slett"
+
+#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
+msgid "Select All"
+msgstr "Velg alle"
+
+#: git-gui.sh:2400
+msgid "Create..."
+msgstr "Opprett..."
+
+#: git-gui.sh:2406
+msgid "Checkout..."
+msgstr "Sjekk ut..."
+
+#: git-gui.sh:2412
+msgid "Rename..."
+msgstr "Endre navn..."
+
+#: git-gui.sh:2417
+msgid "Delete..."
+msgstr "Slett..."
+
+#: git-gui.sh:2422
+msgid "Reset..."
+msgstr "Tilbakestill..."
+
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "Ferdig"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "Sjekk inn"
+
+#: git-gui.sh:2443 git-gui.sh:2864
+msgid "New Commit"
+msgstr "Ny innsjekking"
+
+#: git-gui.sh:2451 git-gui.sh:2871
+msgid "Amend Last Commit"
+msgstr "Legg til forrige innsjekking"
+
+#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "S=F8k p=E5 ny"
+
+#: git-gui.sh:2467
+msgid "Stage To Commit"
+msgstr "Legg til i innsjekkingsk=F8en"
+
+#: git-gui.sh:2473
+msgid "Stage Changed Files To Commit"
+msgstr "Legg til endrede filer i innsjekkingsk=F8en"
+
+#: git-gui.sh:2479
+msgid "Unstage From Commit"
+msgstr "Fjern fra innsjekkingsk=F8en"
+
+#: git-gui.sh:2484 lib/index.tcl:410
+msgid "Revert Changes"
+msgstr "Tilbakestill endringer"
+
+#: git-gui.sh:2491 git-gui.sh:3069
+msgid "Show Less Context"
+msgstr "Vis mindre innhold"
+
+#: git-gui.sh:2495 git-gui.sh:3073
+msgid "Show More Context"
+msgstr "Vis mer innhold"
+
+#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
+msgid "Sign Off"
+msgstr "Sign=E9r"
+
+#: git-gui.sh:2518
+msgid "Local Merge..."
+msgstr "Lokal sammensl=E5ing..."
+
+#: git-gui.sh:2523
+msgid "Abort Merge..."
+msgstr "Avbryt sammensl=E5ing..."
+
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "Legg til..."
+
+#: git-gui.sh:2539
+msgid "Push..."
+msgstr "Send..."
+
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "Fjern gren..."
+
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "Om %s"
+
+#: git-gui.sh:2557
+msgid "Preferences..."
+msgstr "Innstillinger..."
+
+#: git-gui.sh:2565 git-gui.sh:3115
+msgid "Options..."
+msgstr "Alternativer..."
+
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "Fjern..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
+msgid "Help"
+msgstr "Hjelp"
+
+#: git-gui.sh:2611
+msgid "Online Documentation"
+msgstr "Online dokumentasjon"
+
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "Vis SSH-n=F8kkel"
+
+#: git-gui.sh:2707
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr ""
+"kritisk: kunne ikke finne status for sti %s: Ingen slik fil eller kat=
alog"
+
+#: git-gui.sh:2740
+msgid "Current Branch:"
+msgstr "N=E5v=E6rende gren:"
+
+#: git-gui.sh:2761
+msgid "Staged Changes (Will Commit)"
+msgstr "K=F8ede endringer (til innsjekking)"
+
+#: git-gui.sh:2781
+msgid "Unstaged Changes"
+msgstr "Uk=F8ede endringer"
+
+#: git-gui.sh:2831
+msgid "Stage Changed"
+msgstr "K=F8 endret"
+
+#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
+msgid "Push"
+msgstr "Send"
+
+#: git-gui.sh:2885
+msgid "Initial Commit Message:"
+msgstr "Innledende innsjekkingsmelding:"
+
+#: git-gui.sh:2886
+msgid "Amended Commit Message:"
+msgstr "Utdypt innsjekkingsmelding"
+
+#: git-gui.sh:2887
+msgid "Amended Initial Commit Message:"
+msgstr "Utdypt innledende innsjekkingsmelding:"
+
+#: git-gui.sh:2888
+msgid "Amended Merge Commit Message:"
+msgstr "Utdypt innsjekkingsmelding for sammensl=E5ing:"
+
+#: git-gui.sh:2889
+msgid "Merge Commit Message:"
+msgstr "Revisjonsmelding for sammensl=E5ing:"
+
+#: git-gui.sh:2890
+msgid "Commit Message:"
+msgstr "Revisjonsmelding:"
+
+#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Kopier alle"
+
+#: git-gui.sh:2963 lib/blame.tcl:104
+msgid "File:"
+msgstr "Fil:"
+
+#: git-gui.sh:3078
+msgid "Refresh"
+msgstr "Oppdater"
+
+#: git-gui.sh:3099
+msgid "Decrease Font Size"
+msgstr "Gj=F8r teksten mindre"
+
+#: git-gui.sh:3103
+msgid "Increase Font Size"
+msgstr "Gj=F8r teksten st=F8rre"
+
+#: git-gui.sh:3111 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "Tekstkoding"
+
+#: git-gui.sh:3122
+msgid "Apply/Reverse Hunk"
+msgstr "Bruk/tilbakestill del"
+
+#: git-gui.sh:3127
+msgid "Apply/Reverse Line"
+msgstr "Bruk/tilbakestill linje"
+
+#: git-gui.sh:3137
+msgid "Run Merge Tool"
+msgstr "Start sammensl=E5ingsprosess"
+
+#: git-gui.sh:3142
+msgid "Use Remote Version"
+msgstr "Bruk versjon fra fjernarkiv"
+
+#: git-gui.sh:3146
+msgid "Use Local Version"
+msgstr "Bruk lokal versjon"
+
+#: git-gui.sh:3150
+msgid "Revert To Base"
+msgstr "Tilbakestill til baseversjonen"
+
+#: git-gui.sh:3169
+msgid "Unstage Hunk From Commit"
+msgstr "Fjern delen fra innsjekkingsk=F8en"
+
+#: git-gui.sh:3170
+msgid "Unstage Line From Commit"
+msgstr "Fjern linjen fra innsjekkingsk=F8en"
+
+#: git-gui.sh:3172
+msgid "Stage Hunk For Commit"
+msgstr "Legg del i innsjekkingsk=F8en"
+
+#: git-gui.sh:3173
+msgid "Stage Line For Commit"
+msgstr "Legg til linje i innsjekkingsk=F8en"
+
+#: git-gui.sh:3196
+msgid "Initializing..."
+msgstr "Initsialiserer..."
+
+#: git-gui.sh:3301
+#, tcl-format
+msgid ""
+"Possible environment issues exist.\n"
+"\n"
+"The following environment variables are probably\n"
+"going to be ignored by any Git subprocess run\n"
+"by %s:\n"
+"\n"
+msgstr ""
+
+#: git-gui.sh:3331
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+
+#: git-gui.sh:3336
+#, tcl-format
+msgid ""
+"\n"
+"\n"
+"A good replacement for %s\n"
+"is placing values for the user.name and\n"
+"user.email settings into your personal\n"
+"~/.gitconfig file.\n"
+msgstr ""
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - Et grafisk brukergrensesnitt for Git."
+
+#: lib/blame.tcl:72
+msgid "File Viewer"
+msgstr "Filviser"
+
+#: lib/blame.tcl:78
+msgid "Commit:"
+msgstr "Innsjekking:"
+
+#: lib/blame.tcl:271
+msgid "Copy Commit"
+msgstr "Kopier innsjekking"
+
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "S=F8k etter tekst..."
+
+#: lib/blame.tcl:284
+msgid "Do Full Copy Detection"
+msgstr "Gjennomf=F8r full deteksjon av kopieringer"
+
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "Vis historikkens innhold"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr ""
+
+#: lib/blame.tcl:450
+#, tcl-format
+msgid "Reading %s..."
+msgstr "Leser %s..."
+
+#: lib/blame.tcl:557
+msgid "Loading copy/move tracking annotations..."
+msgstr "Leser merknader for kopiering/flytting..."
+
+#: lib/blame.tcl:577
+msgid "lines annotated"
+msgstr "rader merket"
+
+#: lib/blame.tcl:769
+msgid "Loading original location annotations..."
+msgstr "Leser inn merknader fra opprinnelig lokasjon..."
+
+#: lib/blame.tcl:772
+msgid "Annotation complete."
+msgstr "Linjemarkering fullf=F8rt."
+
+#: lib/blame.tcl:802
+msgid "Busy"
+msgstr "Opptatt"
+
+#: lib/blame.tcl:803
+msgid "Annotation process is already running."
+msgstr "Linjemarkeringsprosessen kj=F8rer allerede."
+
+#: lib/blame.tcl:842
+msgid "Running thorough copy detection..."
+msgstr "Kj=F8rer kopidetektering..."
+
+#: lib/blame.tcl:910
+msgid "Loading annotation..."
+msgstr "Laster inn bemerkninger..."
+
+#: lib/blame.tcl:964
+msgid "Author:"
+msgstr "Forfatter:"
+
+#: lib/blame.tcl:968
+msgid "Committer:"
+msgstr "Innsjekker:"
+
+#: lib/blame.tcl:973
+msgid "Original File:"
+msgstr "Opprinnelig fil:"
+
+#: lib/blame.tcl:1021
+msgid "Cannot find HEAD commit:"
+msgstr "Finner ikke HEAD's innsjekking:"
+
+#: lib/blame.tcl:1076
+msgid "Cannot find parent commit:"
+msgstr "Kan ikke finne innsjekkingens forelder:"
+
+#: lib/blame.tcl:1091
+msgid "Unable to display parent"
+msgstr "Kan ikke vise forelder"
+
+#: lib/blame.tcl:1092 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "Feil ved innlasting av forskjell:"
+
+#: lib/blame.tcl:1232
+msgid "Originally By:"
+msgstr "Opprinnelig av:"
+
+#: lib/blame.tcl:1238
+msgid "In File:"
+msgstr "I fil:"
+
+#: lib/blame.tcl:1243
+msgid "Copied Or Moved Here By:"
+msgstr "Kopiert eller flyttet hit av:"
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Sjekk ut gren"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Utsjekking"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:97
+msgid "Cancel"
+msgstr "Avbryt"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
+msgid "Revision"
+msgstr "Revisjon"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
+msgid "Options"
+msgstr "Valg"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Hent sporet gren"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Koble bort lokal gren"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Opprett gren"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Opprett ny gren"
+
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
+msgid "Create"
+msgstr "Opprett"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Navn p=E5 gren"
+
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+msgid "Name:"
+msgstr "Navn:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Bruk navn p=E5 sporet gren"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Starter revisjon"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Oppdater eksisterende gren:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Nei"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Kun hurtigfremspoling"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
+msgid "Reset"
+msgstr "Tilbakestill"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Sjekk ut etter oppretting"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Velg en gren som skal f=F8lges."
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Den fulgte grenen %s er ikke en gren i fjernarkivet."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Angi et navn for grenen."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' kan ikke brukes som navn p=E5 en gren."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Fjern gren"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Fjern lokal gren"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Lokale grener"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "Fjern kun ved sammensl=E5ing"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr "Alltid (Ikke utf=F8r sammensl=E5ingstest.)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "F=F8lgende grener er ikke fullstendig sl=E5tt sammen med %s:"
+
+#: lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult. \n"
+"\n"
+" Delete the selected branches?"
+msgstr ""
+"Gjenoppretting av fjernede grener er vanskelig. \n"
+"\n"
+" Fjern valgte grener?"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Kunne ikke fjerne grener:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Gi gren nytt navn"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Endre navn"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Gren:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Nytt navn:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Vennligst velg grenen du vil endre navn p=E5."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Grenen '%s' eksisterer allerede."
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Kunne ikke endre navnet '%s'."
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Starter..."
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "Utforsker"
+
+#: lib/browser.tcl:126 lib/browser.tcl:143
+#, tcl-format
+msgid "Loading %s..."
+msgstr "Laster %s..."
+
+#: lib/browser.tcl:187
+msgid "[Up To Parent]"
+msgstr "[Opp til forelder]"
+
+#: lib/browser.tcl:267 lib/browser.tcl:273
+msgid "Browse Branch Files"
+msgstr "Bla igjennom grenens filer"
+
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
+msgid "Browse"
+msgstr "Bla igjennom"
+
+#: lib/checkout_op.tcl:84
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Henter %s fra %s"
+
+#: lib/checkout_op.tcl:132
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "kritisk: Kan ikke =E5pne %s"
+
+#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
+msgid "Close"
+msgstr "Lukk"
+
+#: lib/checkout_op.tcl:174
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Grenen '%s' eksisterer ikke."
+
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Kunne ikke konfigurere forenklet git-pull for '%s'."
+
+#: lib/checkout_op.tcl:228
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"Grenen '%s' eksisterer allerede.\n"
+"\n"
+"Den kan ikke hurtigfremspoles til %s.\n"
+"En sammensl=E5ing er p=E5krevd."
+
+#: lib/checkout_op.tcl:242
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "Sammensl=E5ingsstrategien '%s' er ikke st=F8ttet."
+
+#: lib/checkout_op.tcl:261
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Kunne ikke oppdatere '%s'."
+
+#: lib/checkout_op.tcl:273
+msgid "Staging area (index) is already locked."
+msgstr "K=F8omr=E5det (index) er allerede l=E5st."
+
+#: lib/checkout_op.tcl:288
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/checkout_op.tcl:344
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "Oppdaterer arbeidskatalogen til '%s'..."
+
+#: lib/checkout_op.tcl:345
+msgid "files checked out"
+msgstr "filer sjekket ut"
+
+#: lib/checkout_op.tcl:375
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "Avbr=F8t utsjekkingen av '%s' (sammensl=E5ing p=E5 filniv=E5 k=
reves)."
+
+#: lib/checkout_op.tcl:376
+msgid "File level merge required."
+msgstr "Sammensl=E5ing p=E5 filniv=E5 kreves"
+
+#: lib/checkout_op.tcl:380
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Blir st=E5ende p=E5 grenen '%s'."
+
+#: lib/checkout_op.tcl:451
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This D=
etached "
+"Checkout'."
+msgstr ""
+
+#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "Sjekket ut '%s'."
+
+#: lib/checkout_op.tcl:500
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr ""
+"Tilbakestilling av '%s' til '%s' vil medf=F8re tap av f=F8lgende inns=
jekkinger:"
+
+#: lib/checkout_op.tcl:522
+msgid "Recovering lost commits may not be easy."
+msgstr ""
+"Det vil kanskje ikke v=E6re s=E5 enkelt =E5 gjenopprette en tapt inns=
jekking."
+
+#: lib/checkout_op.tcl:527
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "Tilbakestill '%s'?"
+
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+msgid "Visualize"
+msgstr "Visualiser"
+
+#: lib/checkout_op.tcl:600
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully u=
pdated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+
+#: lib/choose_font.tcl:39
+msgid "Select"
+msgstr "Velg"
+
+#: lib/choose_font.tcl:53
+msgid "Font Family"
+msgstr "Skrifttype-familie"
+
+#: lib/choose_font.tcl:74
+msgid "Font Size"
+msgstr "Skriftst=F8rrelse"
+
+#: lib/choose_font.tcl:91
+msgid "Font Example"
+msgstr "Skrifteksempel"
+
+#: lib/choose_font.tcl:103
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Dette er en eksempeltekst.\n"
+"Hvis du liker hvordan teksten ser ut, kan du velge dette som din skri=
fttype."
+
+#: lib/choose_repository.tcl:28
+msgid "Git Gui"
+msgstr "Git Gui"
+
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
+msgid "Create New Repository"
+msgstr "Opprett nytt arkiv"
+
+#: lib/choose_repository.tcl:93
+msgid "New..."
+msgstr "Ny..."
+
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
+msgid "Clone Existing Repository"
+msgstr "Klon eksistererende arkiv"
+
+#: lib/choose_repository.tcl:106
+msgid "Clone..."
+msgstr "Klon..."
+
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
+msgid "Open Existing Repository"
+msgstr "=C5pne eksistererende arkiv"
+
+#: lib/choose_repository.tcl:119
+msgid "Open..."
+msgstr "=C5pne..."
+
+#: lib/choose_repository.tcl:132
+msgid "Recent Repositories"
+msgstr "Nylig brukte arkiv"
+
+#: lib/choose_repository.tcl:138
+msgid "Open Recent Repository:"
+msgstr "=C5pne nylig brukt arkiv:"
+
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Kunne ikke opprette arkivet %s:"
+
+#: lib/choose_repository.tcl:387
+msgid "Directory:"
+msgstr "Mappe:"
+
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
+msgid "Git Repository"
+msgstr "Git arkiv"
+
+#: lib/choose_repository.tcl:442
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "Mappen %s eksisterer allerede."
+
+#: lib/choose_repository.tcl:446
+#, tcl-format
+msgid "File %s already exists."
+msgstr "Filen %s eksisterer allerede."
+
+#: lib/choose_repository.tcl:460
+msgid "Clone"
+msgstr "Klon"
+
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "Kildeplassering:"
+
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "Destinasjonsmappe:"
+
+#: lib/choose_repository.tcl:496
+msgid "Clone Type:"
+msgstr "Klontype:"
+
+#: lib/choose_repository.tcl:502
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Standard (rask, delvis redundant, hardlinker)"
+
+#: lib/choose_repository.tcl:508
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Full kopi (tregere, redundant sikkerhetskopi)"
+
+#: lib/choose_repository.tcl:514
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Delt (raskest, ikke anbefalt, ingen sikkerhetskopiering)"
+
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Ikke et Git-arkiv: %s"
+
+#: lib/choose_repository.tcl:586
+msgid "Standard only available for local repository."
+msgstr "Standard er kun tilgjengelig for lokalt arkiv."
+
+#: lib/choose_repository.tcl:590
+msgid "Shared only available for local repository."
+msgstr "Delt er kun tilgjengelig for lokalt arkiv."
+
+#: lib/choose_repository.tcl:611
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "Stedet %s eksisterer allerede."
+
+#: lib/choose_repository.tcl:622
+msgid "Failed to configure origin"
+msgstr "Kunne ikke konfigurere kildeoppf=F8ring"
+
+#: lib/choose_repository.tcl:634
+msgid "Counting objects"
+msgstr "Teller objekter"
+
+#: lib/choose_repository.tcl:635
+msgid "buckets"
+msgstr "b=F8tter"
+
+#: lib/choose_repository.tcl:659
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "Kunne ikke kopiere objekter/informasjon/alternativt: %s"
+
+#: lib/choose_repository.tcl:695
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "Ingenting =E5 klone fra %s."
+
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
+msgid "The 'master' branch has not been initialized."
+msgstr "Grenen 'master' har ikke blitt initsialisert."
+
+#: lib/choose_repository.tcl:710
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Harde linker er utilgjengelig. G=E5r tilbake til kopiering."
+
+#: lib/choose_repository.tcl:722
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Kloner fra %s"
+
+#: lib/choose_repository.tcl:753
+msgid "Copying objects"
+msgstr "Kopierer objekter"
+
+#: lib/choose_repository.tcl:754
+msgid "KiB"
+msgstr "kB"
+
+#: lib/choose_repository.tcl:778
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "Kunne ikke kopiere objekt: %s"
+
+#: lib/choose_repository.tcl:788
+msgid "Linking objects"
+msgstr "Lenker objekter"
+
+#: lib/choose_repository.tcl:789
+msgid "objects"
+msgstr "objekter"
+
+#: lib/choose_repository.tcl:797
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "Kunne ikke opprette hardlink med objektet: %s"
+
+#: lib/choose_repository.tcl:852
+msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
+msgstr "Kunne ikke hente grener og objekter. Se utdata i konsoll for d=
etaljer."
+
+#: lib/choose_repository.tcl:863
+msgid "Cannot fetch tags.  See console output for details."
+msgstr "Kunne ikke hente tagger. Se utdata i konsoll for detaljer."
+
+#: lib/choose_repository.tcl:887
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr "Kan ikke bestemme HEAD. Se utdata i konsoll for detaljer."
+
+#: lib/choose_repository.tcl:896
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "Kunne ikke rydde opp %s"
+
+#: lib/choose_repository.tcl:902
+msgid "Clone failed."
+msgstr "Kloning feilet."
+
+#: lib/choose_repository.tcl:909
+msgid "No default branch obtained."
+msgstr "Ingen standardgren hentet."
+
+#: lib/choose_repository.tcl:920
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "Kan ikke finne %s som en innsjekking."
+
+#: lib/choose_repository.tcl:932
+msgid "Creating working directory"
+msgstr "Oppretter arbeidskatalog"
+
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
+msgid "files"
+msgstr "filer"
+
+#: lib/choose_repository.tcl:962
+msgid "Initial file checkout failed."
+msgstr "Initsialiserende utsjekking feilet."
+
+#: lib/choose_repository.tcl:978
+msgid "Open"
+msgstr "=C5pne"
+
+#: lib/choose_repository.tcl:988
+msgid "Repository:"
+msgstr "Arkiv:"
+
+#: lib/choose_repository.tcl:1037
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Kunne ikke =E5pne arkivet %s:"
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr "Denne frakoblede utsjekkingen"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Revisjonsuttrykk:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "Lokal gren"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "Sporet gren"
+
+#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+msgid "Tag"
+msgstr "Tag"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Ugyldig revisjon: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "Ingen revisjoner valgt."
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "Revisjonsuttrykk er tomt."
+
+#: lib/choose_rev.tcl:531
+msgid "Updated"
+msgstr "Oppdatert"
+
+#: lib/choose_rev.tcl:559
+msgid "URL"
+msgstr "URL"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit befor=
e this "
+"to amend.\n"
+msgstr ""
+"Det er ingenting =E5 legge til.\n"
+"\n"
+"Du er i ferd med =E5 lage den initsialiserende revisjonen. Det er ing=
en "
+"tidligere revisjoner =E5 tilf=F8ye.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort =
the "
+"current merge activity.\n"
+msgstr ""
+"Kan ikke tilf=F8ye under sammensl=E5ing.\n"
+"\n"
+"Du er for =F8yeblikket under en p=E5g=E5ende sammensl=E5ing som ikke =
er fullf=F8rt. Du "
+"kan ikke tilf=F8ye en tidligere revisjon med mindre du f=F8rst avbryt=
er denne "
+"sammensl=E5ingen.\n"
+
+#: lib/commit.tcl:49
+msgid "Error loading commit data for amend:"
+msgstr "Feil ved innhenting av revisjonsdata for tilf=F8ying:"
+
+#: lib/commit.tcl:76
+msgid "Unable to obtain your identity:"
+msgstr "Kunne ikke avgj=F8re din identitet:"
+
+#: lib/commit.tcl:81
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Ugyldig GIT_COMMITTER_IDENT:"
+
+#: lib/commit.tcl:133
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/commit.tcl:156
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the fil=
e "
+"before committing.\n"
+msgstr ""
+
+#: lib/commit.tcl:164
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Ukjent filstatus %s er funnet.\n"
+"\n"
+"Filen %s kan ikke sjekkes inn av dette programmet.\n"
+
+#: lib/commit.tcl:172
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Ingen endringer =E5 sjekke inn.\n"
+"\n"
+"Du m=E5 k=F8e minst en fil f=F8r du kan sjekke inn noe.\n"
+
+#: lib/commit.tcl:187
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Vennligst angi en revisjonsmelding.\n"
+"\n"
+"En god melding har f=F8lgende format:\n"
+"\n"
+"- F=F8rste linje: En beskrivelse av hva du har gjort i =E9n setning.\=
n"
+"- Andre linje: Blank\n"
+"- Resterende linjer: Forklar hvorfor denne endringen er bra.\n"
+
+#: lib/commit.tcl:211
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "advarsel: Tcl st=F8tter ikke denne tegnkodingen '%s'."
+
+#: lib/commit.tcl:227
+msgid "Calling pre-commit hook..."
+msgstr ""
+
+#: lib/commit.tcl:242
+msgid "Commit declined by pre-commit hook."
+msgstr ""
+
+#: lib/commit.tcl:265
+msgid "Calling commit-msg hook..."
+msgstr ""
+
+#: lib/commit.tcl:280
+msgid "Commit declined by commit-msg hook."
+msgstr ""
+
+#: lib/commit.tcl:293
+msgid "Committing changes..."
+msgstr "Sjekker inn endringer..."
+
+#: lib/commit.tcl:309
+msgid "write-tree failed:"
+msgstr "Skriving til tre feilet:"
+
+#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
+msgid "Commit failed."
+msgstr "Innsjekking feilet."
+
+#: lib/commit.tcl:327
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Revisjon %s ser ut til =E5 v=E6re korrupt"
+
+#: lib/commit.tcl:332
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\=
n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Ingen endringer til innsjekking.\n"
+"\n"
+"Ingen filer ble endret av denne revisjonen, og det var ikke en revisj=
on fra "
+"en sammensl=E5ing.\n"
+"\n"
+"Et nytt s=F8k vil bli startet automatisk.\n"
+
+#: lib/commit.tcl:339
+msgid "No changes to commit."
+msgstr "Ingen endringer til innsekking."
+
+#: lib/commit.tcl:353
+msgid "commit-tree failed:"
+msgstr "commit-tree feilet:"
+
+#: lib/commit.tcl:373
+msgid "update-ref failed:"
+msgstr "update-ref feilet:"
+
+#: lib/commit.tcl:461
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Opprettet innsjekking %s: %s"
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "Jobber... Vennligst vent..."
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Suksess"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Feil: Kommandoen feilet"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "Antall l=F8se objekter"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "Diskplass brukt av l=F8se objekter"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "Antall pakkede objekter"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "Antall pakker"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "Diskplass brukt av pakkede objekter"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "Pakkede objekter som avventer fjerning"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "Avfallsfiler"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Komprimerer objektdatabasen"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Verifiserer objektdatabasen med fsck-objects"
+
+#: lib/database.tcl:108
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress "
+"the database when more than %i loose objects exist.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Dette arkivet inneholder omtrent %i 'l=F8se' objekter.\n"
+"\n"
+"For =E5 sikre en optimal ytelse er det sterkt anbefalt at du komprime=
rer "
+"databasen n=E5r det er flere enn %i 'l=F8se' objekter i den.\n"
+"\n"
+"Komprimere databasen n=E5?"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Ugyldig dato fra Git: %s"
+
+#: lib/diff.tcl:59
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application=
, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may =
have "
+"the same state."
+msgstr ""
+"Ingen forandringer funnet.\n"
+"\n"
+"%s har ingen endringer.\n"
+"\n"
+"Tidsstempelet for endring p=E5 denne filen ble oppdatert av en annen =
"
+" applikasjon, men innholdet er uendret.\n"
+"\n"
+"En gjennoms=F8king vil n=E5 starte automatisk for =E5 se om andre fil=
er har "
+"status."
+
+#: lib/diff.tcl:99
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Laster inn forskjellene av %s..."
+
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr "LOKAL: slettet\n"
+"FJERN:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr "FJERN: slettet\n"
+"LOKAL:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "LOKAL:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "FJERN:\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Kan ikke vise %s"
+
+#: lib/diff.tcl:198
+msgid "Error loading file:"
+msgstr "Feil ved lesing av fil: %s"
+
+#: lib/diff.tcl:205
+msgid "Git Repository (subproject)"
+msgstr "Git-arkiv (underprosjekt)"
+
+#: lib/diff.tcl:217
+msgid "* Binary file (not showing content)."
+msgstr "* Bin=E6rfil (viser ikke innhold)"
+
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Usporet fil er %d bytes.\n"
+"* Viser bare %d f=F8rste bytes.\n"
+
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Usporede filer klippet her av %s.\n"
+"* For =E5 se hele filen, bruk et eksternt redigeringsverkt=F8y.\n"
+
+#: lib/diff.tcl:436
+msgid "Failed to unstage selected hunk."
+msgstr "Kunne ikke fjerne den valgte delen fra innsjekkingsk=F8en."
+
+#: lib/diff.tcl:443
+msgid "Failed to stage selected hunk."
+msgstr "Kunne ikke legge til den valgte delen i innsjekkingsk=F8en."
+
+#: lib/diff.tcl:509
+msgid "Failed to unstage selected line."
+msgstr "Kunne ikke fjerne den valgte linjen fra innsjekkingsk=F8en."
+
+#: lib/diff.tcl:517
+msgid "Failed to stage selected line."
+msgstr "Kunne ikke legge til den valgte linjen i innsjekkingsk=F8en."
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Standard"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Systemets (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Andre"
+
+#: lib/error.tcl:20 lib/error.tcl:114
+msgid "error"
+msgstr "feil"
+
+#: lib/error.tcl:36
+msgid "warning"
+msgstr "advarsel"
+
+#: lib/error.tcl:94
+msgid "You must correct the above errors before committing."
+msgstr "Du m=E5 rette de ovenst=E5ende feilene f=F8r innsjekking."
+
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Kunne ikke l=E5se opp indexen."
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "Feil p=E5 index"
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"Oppdatering av Git's index mislyktes. Et nytt s=F8k vil bli startet f=
or =E5 "
+"resynkronisere git-gui."
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr "Fortsett"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "L=E5s opp index"
+
+#: lib/index.tcl:287
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "Fjerner %s fra innsjekkingsk=F8en"
+
+#: lib/index.tcl:326
+msgid "Ready to commit."
+msgstr "Klar til innsjekking."
+
+#: lib/index.tcl:339
+#, tcl-format
+msgid "Adding %s"
+msgstr "Legger til %s"
+
+#: lib/index.tcl:396
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Reverter endringene i filen %s?"
+
+#: lib/index.tcl:398
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Reverter endringene i disse %i filene?"
+
+#: lib/index.tcl:406
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr "Endringer som ikke ligger i innsjekkingsk=F8en vil bli tapt av=
 denne "
+"reverteringen"
+
+#: lib/index.tcl:409
+msgid "Do Nothing"
+msgstr "Ikke gj=F8r noe"
+
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "Reverterer valgte filer"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "Reverterer %s"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merg=
e.\n"
+msgstr ""
+"Kunne ikke sl=E5 sammen under utvidelse.\n"
+"\n"
+"Du m=E5 f=F8rst fullf=F8re utvidelsen av denne revisjonen f=F8r du ka=
n starte en "
+"sammensl=E5ing.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the cur=
rent "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doin=
g so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+
+#: lib/merge.tcl:107
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s av %s"
+
+#: lib/merge.tcl:120
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "Sl=E5r sammen %s og %s"
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "Vellykket sammensl=E5ing fullf=F8rt."
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Sammensl=E5ing feilet. H=E5ndtering av konflikten kreves."
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Sl=E5 sammen inn i %s"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "Revisjon til sammensl=E5ing"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Kan ikke avbryte under utvidelse av revisjon.\n"
+"\n"
+"Du m=E5 fullf=F8re utvidelsen av denne revisjonen.\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be=
 lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Avbryt sammensl=E5ing?\n"
+"\n"
+"Avbryting av p=E5g=E5ende sammensl=E5ing vil f=F8re til at *alle* end=
ringer som ikke "
+" er sjekket inn, vil g=E5 tapt.\n"
+"\n"
+"Fortsette med =E5 avbryte den p=E5g=E5ende sammensl=E5ingen?"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost=
=2E\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Nullstill endringer?\n"
+"\n"
+"Nullstilling av endringer vil f=F8re til at *alle* endringer som ikke=
 er "
+"sjekket inn g=E5r tapt.\n"
+"\n"
+"Fortsette med nullstilling av endringer?"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "Avbryter"
+
+#: lib/merge.tcl:239
+msgid "files reset"
+msgstr "filer tilbakestilt"
+
+#: lib/merge.tcl:267
+msgid "Abort failed."
+msgstr "Avbryting feilet."
+
+#: lib/merge.tcl:269
+msgid "Abort completed.  Ready."
+msgstr "Avbryting fullf=F8rt. Klar."
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Tving h=E5ndtering til opprinnelig versjon?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Tving h=E5ndtering i denne grenen?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Tving h=E5ndtering i den andre grenen?"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"Merk deg at endringsvisningen kun viser motstridende endringer.\n"
+"\n"
+"%s vil bli overskrevet.\n"
+"\n"
+"Denne operasjonen kan kun bli angret ved =E5 starte sammensl=E5ingen =
p=E5 ny."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "Filen %s ser ut til =E5 ha ul=F8ste konflikter, skal filen lik=
evel k=F8es?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "Legger til l=F8sninge p=E5 konflikt for %s"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr ""
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "Konfliktfil eksisterer ikke"
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr ""
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr ""
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr ""
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Kunne ikke hente versjoner:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr ""
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr ""
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr ""
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr ""
+
+#: lib/option.tcl:117
+msgid "Restore Defaults"
+msgstr "Gjennopprett standardverdier"
+
+#: lib/option.tcl:121
+msgid "Save"
+msgstr "Lagre"
+
+#: lib/option.tcl:131
+#, tcl-format
+msgid "%s Repository"
+msgstr "%s arkiv"
+
+#: lib/option.tcl:132
+msgid "Global (All Repositories)"
+msgstr "Globalt (alle arkiv)"
+
+#: lib/option.tcl:138
+msgid "User Name"
+msgstr "Navn"
+
+#: lib/option.tcl:139
+msgid "Email Address"
+msgstr "Epost-adresse"
+
+#: lib/option.tcl:141
+msgid "Summarize Merge Commits"
+msgstr "Oppsummer innsjekkinger fra sammensl=E5inger"
+
+#: lib/option.tcl:142
+msgid "Merge Verbosity"
+msgstr "Detaljeniv=E5 p=E5 sammensl=E5ing"
+
+#: lib/option.tcl:143
+msgid "Show Diffstat After Merge"
+msgstr "Vis endringsstatistikk etter sammensl=E5ing"
+
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "Bruk sammensl=E5ingsverkt=F8y"
+
+#: lib/option.tcl:146
+msgid "Trust File Modification Timestamps"
+msgstr "Stol p=E5 filers tid for endring"
+
+#: lib/option.tcl:147
+msgid "Prune Tracking Branches During Fetch"
+msgstr ""
+
+#: lib/option.tcl:148
+msgid "Match Tracking Branches"
+msgstr ""
+
+#: lib/option.tcl:149
+msgid "Blame Copy Only On Changed Files"
+msgstr ""
+
+#: lib/option.tcl:150
+msgid "Minimum Letters To Blame Copy On"
+msgstr ""
+
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr ""
+
+#: lib/option.tcl:152
+msgid "Number of Diff Context Lines"
+msgstr "Antall linjer sammenhengende endringer"
+
+#: lib/option.tcl:153
+msgid "Commit Message Text Width"
+msgstr "Tekstbredde for vindu til innsjekkingsmeldinger"
+
+#: lib/option.tcl:154
+msgid "New Branch Name Template"
+msgstr "Mal for navn p=E5 nye grener"
+
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Standard tekstenkoding for innhold i filer"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "Endre"
+
+#: lib/option.tcl:230
+msgid "Spelling Dictionary:"
+msgstr "Stavebokordlister:"
+
+#: lib/option.tcl:254
+msgid "Change Font"
+msgstr "Endre skrifttype"
+
+#: lib/option.tcl:258
+#, tcl-format
+msgid "Choose %s"
+msgstr "Velg %s"
+
+#: lib/option.tcl:264
+msgid "pt."
+msgstr "pt."
+
+#: lib/option.tcl:278
+msgid "Preferences"
+msgstr "Egenskaper"
+
+#: lib/option.tcl:314
+msgid "Failed to completely save options:"
+msgstr "Kunne ikke lagre alternativ:"
+
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Fjern fjernarkiv"
+
+#: lib/remote.tcl:168
+msgid "Prune from"
+msgstr "Fjern fra"
+
+#: lib/remote.tcl:173
+msgid "Fetch from"
+msgstr "Hent fra"
+
+#: lib/remote.tcl:215
+msgid "Push to"
+msgstr "Send til"
+
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "Legg til fjernarkiv"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "Legg til nytt fjernarkiv"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "Legg til"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "Detaljer for fjernarkiv"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Lokasjon:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "Videre handling"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "Hent umiddelbart"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "Initsialiser og send til fjernarkiv"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "Ikke gj=F8r mer n=E5"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "Vennligst angi et navn for fjernarkivet."
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' er ikke et tillatt navn for et fjernarkiv."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Kunne ikke legge til fjernarkivet '%s' p=E5 '%s'."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "hent %s"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "Henter %s"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Vet ikke hvordan arkiv p=E5 '%s' skal opprettes."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "send %s"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Initsialiserer %s (p=E5 %s)"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Fjern gren fra fjernarkiv"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Fra arkiv"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+msgid "Remote:"
+msgstr "Fjernarkiv:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
+msgid "Arbitrary Location:"
+msgstr "Vilk=E5rlig lokasjon:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Grener"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Slett kun hvis"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Sl=E5tt sammen i:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Alltid (Ikke utf=F8r sammensl=E5ingskontroll)"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "En gren kreves for 'sammensl=E5ing i'."
+
+#: lib/remote_branch_delete.tcl:184
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"F=F8lgende grener er ikke fullestendig sammensl=E5tt med %s:\n"
+"\n"
+" - %s"
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched th=
e "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"En eller flere av testene som blir kj=F8rt under sammensl=E5ing feile=
t fordi du"
+"ikke har hentet inn de n=F8dvendige innsjekkingene. Pr=F8v =E5 hent d=
isse fra %s"
+"f=F8rst"
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "Velg en eller flere grener som skal fjernes."
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Gjenoppretting av fjernede grener er vanskelig.\n"
+"\n"
+"Fjern den merkede grenen?"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Fjerner grenene fra %s"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "Ingen arkiv valgt."
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "S=F8ker %s..."
+
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "Finn:"
+
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "Neste"
+
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "Forrige"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "Skiller p=E5 store og sm=E5 bokstaver"
+
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
+msgstr "Kan ikke opprette snarvei:"
+
+#: lib/shortcut.tcl:136
+msgid "Cannot write icon:"
+msgstr "Kan ikke opprette ikon:"
+
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Stavekontrolleren er ikke st=F8ttet"
+
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Stavekontroll er ikke tilgjengelig"
+
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Ugyldig stavekontroll-konfigurasjon"
+
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "Reverterer ordbok til %s."
+
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "Stavekontrollen feilet stille under oppstart"
+
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Stavekontrolleren er ukjent"
+
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Ingen forslag"
+
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "Uventet slutt p=E5 filen fra stavekontrollen"
+
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Stavekontroll mislyktes"
+
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "Ingen n=F8kler funnet."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Funnet en offentlig n=F8kkel i: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "Generer n=F8kkel"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "Kopier til utklippstavlen"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "Din offentlige OpenSSH-n=F8kkel"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "Genererer..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Kunne ikke starte ssh-keygen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "Generering feilet."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "Generering vellykket, men ingen n=F8kler er funnet."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "N=F8kkelen din ligger i: %s"
+
+#: lib/status_bar.tcl:83
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i av %*i %s (%3i%%)"
+
+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "=C5 kj=F8re %s krever at en fil er valgt"
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Er du sikker p=E5 at du vil kj=F8re %s?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Verkt=F8y: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "Kj=F8rer: %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "Verkt=F8yet ble fullf=F8rt med suksess: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Verkt=F8y feilet: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "Legg til verkt=F8y"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Legg til ny verkt=F8ykommando"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "Legg til globalt"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "Verkt=F8ydetaljer"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Bruk '/'-separator for =E5 lage undermenyer:"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Kommando:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Vis en dialog f=F8r start"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Sp=F8r brukeren om =E5 velge en revisjon (setter $REVISION)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Sp=F8r brukeren for ytterligere paramtere (setter $ARGS)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "Ikke vis kommandoens utdata i vinduet"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Kj=F8r kun om forskjellene er markert ($FILENAME er ikke tom)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Vennligst angi et navn for dette verkt=F8yet."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Verkt=F8yet '%s' eksisterer allerede."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Kunne ikke legge til verkt=F8yet:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Fjern verkt=F8yet"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Fjern verkt=F8yskommandoen"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Fjern"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Blue angir lokale verkt=F8y til arkivet)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Kj=F8r kommando: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Argumenter"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Henter nye endringer fra %s"
+
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "slett fjernarkiv %s"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Fjrner sporing av grener slettet fra %s"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Sender endringer til %s"
+
+#: lib/transport.tcl:72
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Sender %s %s til %s"
+
+#: lib/transport.tcl:89
+msgid "Push Branches"
+msgstr "Send grener"
+
+#: lib/transport.tcl:103
+msgid "Source Branches"
+msgstr "Kildegrener"
+
+#: lib/transport.tcl:120
+msgid "Destination Repository"
+msgstr "Destinasjonsarkiv"
+
+#: lib/transport.tcl:158
+msgid "Transfer Options"
+msgstr "Overf=F8ringsalternativer"
+
+#: lib/transport.tcl:160
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "Tving overskrivning av eksisterende gren (kan forkaste endring=
er)"
+
+#: lib/transport.tcl:164
+msgid "Use thin pack (for slow network connections)"
+msgstr "Bruk tynne pakker (for tregere nettverkstilkoblinger)"
+
+#: lib/transport.tcl:168
+msgid "Include tags"
+msgstr "Inkluder tagger"
--=20
1.6.1.rc1


--=20
Kind regards,
=46redrik Skolmli
