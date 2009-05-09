From: Fredrik Skolmli <fredrik@frsk.net>
Subject: [PATCH] git-gui: Updates on Norwegian translation
Date: Sat, 9 May 2009 22:39:16 +0200
Message-ID: <20090509203916.GB25443@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 09 22:40:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2tKV-0006TV-1O
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 22:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbZEIUjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2009 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbZEIUjW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 16:39:22 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:60654 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbZEIUjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 16:39:20 -0400
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1M2tKI-0005Yi-Gw; Sat, 09 May 2009 22:39:19 +0200
Received: from fredrik by asterix.frsk.net with local (Exim 4.69)
	(envelope-from <fredrik@frsk.net>)
	id 1M2tKG-0007xh-Qn; Sat, 09 May 2009 22:39:17 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118681>


Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>

---
 po/nb.po |  213 ++++++++++++++++++++++++++++++++----------------------=
--------
 1 files changed, 111 insertions(+), 102 deletions(-)

diff --git a/po/nb.po b/po/nb.po
index 6de93c2..40970c3 100644
--- a/po/nb.po
+++ b/po/nb.po
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: nb\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-11-16 13:56-0800\n"
+"POT-Creation-Date: 2008-12-08 08:31-0800\n"
 "PO-Revision-Date: 2008-12-03 16:05+0100\n"
 "Last-Translator: Fredrik Skolmli <fredrik@frsk.net>\n"
 "Language-Team: Norwegian Bokm=C3=A5l\n"
@@ -188,7 +188,7 @@ msgstr "Utforsk arbeidskopien"
=20
 #: git-gui.sh:2307
 msgid "Browse Current Branch's Files"
-msgstr "Utforsk denne grens filer"
+msgstr "Utforsk denne grenens filer"
=20
 #: git-gui.sh:2311
 msgid "Browse Branch Files..."
@@ -196,7 +196,7 @@ msgstr "Bla igjennom filer p=C3=A5 gren..."
=20
 #: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
-msgstr "Visualiser denne grens historikk"
+msgstr "Visualiser denne grenens historikk"
=20
 #: git-gui.sh:2320
 msgid "Visualize All Branch History"
@@ -218,7 +218,7 @@ msgstr "Databasestatistikk"
=20
 #: git-gui.sh:2337 lib/database.tcl:34
 msgid "Compress Database"
-msgstr "Kompress databasen"
+msgstr "Komprimer databasen"
=20
 #: git-gui.sh:2340
 msgid "Verify Database"
@@ -241,25 +241,25 @@ msgstr "Angre"
 msgid "Redo"
 msgstr "Gj=C3=B8r om"
=20
-#: git-gui.sh:2378 git-gui.sh:2923
+#: git-gui.sh:2378 git-gui.sh:2937
 msgid "Cut"
 msgstr "Klipp ut"
=20
-#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
+#: git-gui.sh:2381 git-gui.sh:2940 git-gui.sh:3014 git-gui.sh:3096
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Kopier"
=20
-#: git-gui.sh:2384 git-gui.sh:2929
+#: git-gui.sh:2384 git-gui.sh:2943
 msgid "Paste"
 msgstr "Lim inn"
=20
-#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2946 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "Slett"
=20
-#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2950 git-gui.sh:3100 lib/console.tcl:71
 msgid "Select All"
 msgstr "Velg alle"
=20
@@ -291,15 +291,15 @@ msgstr "Ferdig"
 msgid "Commit@@verb"
 msgstr "Sjekk inn"
=20
-#: git-gui.sh:2443 git-gui.sh:2864
+#: git-gui.sh:2443 git-gui.sh:2878
 msgid "New Commit"
 msgstr "Ny innsjekking"
=20
-#: git-gui.sh:2451 git-gui.sh:2871
+#: git-gui.sh:2451 git-gui.sh:2885
 msgid "Amend Last Commit"
 msgstr "Legg til forrige innsjekking"
=20
-#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2839 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "S=C3=B8k p=C3=A5 ny"
=20
@@ -319,15 +319,15 @@ msgstr "Fjern fra innsjekkingsk=C3=B8en"
 msgid "Revert Changes"
 msgstr "Tilbakestill endringer"
=20
-#: git-gui.sh:2491 git-gui.sh:3069
+#: git-gui.sh:2491 git-gui.sh:3083
 msgid "Show Less Context"
 msgstr "Vis mindre innhold"
=20
-#: git-gui.sh:2495 git-gui.sh:3073
+#: git-gui.sh:2495 git-gui.sh:3087
 msgid "Show More Context"
 msgstr "Vis mer innhold"
=20
-#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
+#: git-gui.sh:2502 git-gui.sh:2852 git-gui.sh:2961
 msgid "Sign Off"
 msgstr "Sign=C3=A9r"
=20
@@ -361,7 +361,7 @@ msgstr "Om %s"
 msgid "Preferences..."
 msgstr "Innstillinger..."
=20
-#: git-gui.sh:2565 git-gui.sh:3115
+#: git-gui.sh:2565 git-gui.sh:3129
 msgid "Options..."
 msgstr "Alternativer..."
=20
@@ -381,125 +381,125 @@ msgstr "Online dokumentasjon"
 msgid "Show SSH Key"
 msgstr "Vis SSH-n=C3=B8kkel"
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2721
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "kritisk: kunne ikke finne status for sti %s: Ingen slik fil eller kat=
alog"
=20
-#: git-gui.sh:2740
+#: git-gui.sh:2754
 msgid "Current Branch:"
 msgstr "N=C3=A5v=C3=A6rende gren:"
=20
-#: git-gui.sh:2761
+#: git-gui.sh:2775
 msgid "Staged Changes (Will Commit)"
 msgstr "K=C3=B8ede endringer (til innsjekking)"
=20
-#: git-gui.sh:2781
+#: git-gui.sh:2795
 msgid "Unstaged Changes"
 msgstr "Uk=C3=B8ede endringer"
=20
-#: git-gui.sh:2831
+#: git-gui.sh:2845
 msgid "Stage Changed"
 msgstr "K=C3=B8 endret"
=20
-#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2864 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "Send"
=20
-#: git-gui.sh:2885
+#: git-gui.sh:2899
 msgid "Initial Commit Message:"
 msgstr "Innledende innsjekkingsmelding:"
=20
-#: git-gui.sh:2886
+#: git-gui.sh:2900
 msgid "Amended Commit Message:"
 msgstr "Utdypt innsjekkingsmelding"
=20
-#: git-gui.sh:2887
+#: git-gui.sh:2901
 msgid "Amended Initial Commit Message:"
 msgstr "Utdypt innledende innsjekkingsmelding:"
=20
-#: git-gui.sh:2888
+#: git-gui.sh:2902
 msgid "Amended Merge Commit Message:"
 msgstr "Utdypt innsjekkingsmelding for sammensl=C3=A5ing:"
=20
-#: git-gui.sh:2889
+#: git-gui.sh:2903
 msgid "Merge Commit Message:"
 msgstr "Revisjonsmelding for sammensl=C3=A5ing:"
=20
-#: git-gui.sh:2890
+#: git-gui.sh:2904
 msgid "Commit Message:"
 msgstr "Revisjonsmelding:"
=20
-#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
+#: git-gui.sh:2953 git-gui.sh:3104 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Kopier alle"
=20
-#: git-gui.sh:2963 lib/blame.tcl:104
+#: git-gui.sh:2977 lib/blame.tcl:104
 msgid "File:"
 msgstr "Fil:"
=20
-#: git-gui.sh:3078
+#: git-gui.sh:3092
 msgid "Refresh"
 msgstr "Oppdater"
=20
-#: git-gui.sh:3099
+#: git-gui.sh:3113
 msgid "Decrease Font Size"
 msgstr "Gj=C3=B8r teksten mindre"
=20
-#: git-gui.sh:3103
+#: git-gui.sh:3117
 msgid "Increase Font Size"
 msgstr "Gj=C3=B8r teksten st=C3=B8rre"
=20
-#: git-gui.sh:3111 lib/blame.tcl:281
+#: git-gui.sh:3125 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "Tekstkoding"
=20
-#: git-gui.sh:3122
+#: git-gui.sh:3136
 msgid "Apply/Reverse Hunk"
 msgstr "Bruk/tilbakestill del"
=20
-#: git-gui.sh:3127
+#: git-gui.sh:3141
 msgid "Apply/Reverse Line"
 msgstr "Bruk/tilbakestill linje"
=20
-#: git-gui.sh:3137
+#: git-gui.sh:3151
 msgid "Run Merge Tool"
 msgstr "Start sammensl=C3=A5ingsprosess"
=20
-#: git-gui.sh:3142
+#: git-gui.sh:3156
 msgid "Use Remote Version"
 msgstr "Bruk versjon fra fjernarkiv"
=20
-#: git-gui.sh:3146
+#: git-gui.sh:3160
 msgid "Use Local Version"
 msgstr "Bruk lokal versjon"
=20
-#: git-gui.sh:3150
+#: git-gui.sh:3164
 msgid "Revert To Base"
 msgstr "Tilbakestill til baseversjonen"
=20
-#: git-gui.sh:3169
+#: git-gui.sh:3183
 msgid "Unstage Hunk From Commit"
 msgstr "Fjern delen fra innsjekkingsk=C3=B8en"
=20
-#: git-gui.sh:3170
+#: git-gui.sh:3184
 msgid "Unstage Line From Commit"
 msgstr "Fjern linjen fra innsjekkingsk=C3=B8en"
=20
-#: git-gui.sh:3172
+#: git-gui.sh:3186
 msgid "Stage Hunk For Commit"
 msgstr "Legg del i innsjekkingsk=C3=B8en"
=20
-#: git-gui.sh:3173
+#: git-gui.sh:3187
 msgid "Stage Line For Commit"
 msgstr "Legg til linje i innsjekkingsk=C3=B8en"
=20
-#: git-gui.sh:3196
+#: git-gui.sh:3210
 msgid "Initializing..."
 msgstr "Initsialiserer..."
=20
-#: git-gui.sh:3301
+#: git-gui.sh:3315
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -510,14 +510,14 @@ msgid ""
 "\n"
 msgstr ""
=20
-#: git-gui.sh:3331
+#: git-gui.sh:3345
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
=20
-#: git-gui.sh:3336
+#: git-gui.sh:3350
 #, tcl-format
 msgid ""
 "\n"
@@ -597,43 +597,43 @@ msgstr "Kj=C3=B8rer kopidetektering..."
 msgid "Loading annotation..."
 msgstr ""
=20
-#: lib/blame.tcl:964
+#: lib/blame.tcl:963
 msgid "Author:"
 msgstr "Forfatter:"
=20
-#: lib/blame.tcl:968
+#: lib/blame.tcl:967
 msgid "Committer:"
 msgstr "Innsjekker:"
=20
-#: lib/blame.tcl:973
+#: lib/blame.tcl:972
 msgid "Original File:"
 msgstr "Opprinnelig fil:"
=20
-#: lib/blame.tcl:1021
+#: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
 msgstr "Finner ikke HEAD's innsjekking:"
=20
-#: lib/blame.tcl:1076
+#: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
 msgstr "Kan ikke finne innsjekkingens forelder:"
=20
-#: lib/blame.tcl:1091
+#: lib/blame.tcl:1090
 msgid "Unable to display parent"
 msgstr "Kan ikke vise forelder"
=20
-#: lib/blame.tcl:1092 lib/diff.tcl:297
+#: lib/blame.tcl:1091 lib/diff.tcl:297
 msgid "Error loading diff:"
 msgstr "Feil ved innlasting av forskjell:"
=20
-#: lib/blame.tcl:1232
+#: lib/blame.tcl:1231
 msgid "Originally By:"
 msgstr "Opprinnelig av:"
=20
-#: lib/blame.tcl:1238
+#: lib/blame.tcl:1237
 msgid "In File:"
 msgstr "I fil:"
=20
-#: lib/blame.tcl:1243
+#: lib/blame.tcl:1242
 msgid "Copied Or Moved Here By:"
 msgstr "Kopiert eller flyttet hit av:"
=20
@@ -650,7 +650,7 @@ msgstr "Utsjekking"
 #: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
 #: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
 #: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:97
+#: lib/transport.tcl:108
 msgid "Cancel"
 msgstr "Avbryt"
=20
@@ -1274,19 +1274,19 @@ msgstr ""
 "kan ikke tilf=C3=B8ye en tidligere revisjon med mindre du f=C3=B8rst =
avbryter denne "
 "sammensl=C3=A5ingen.\n"
=20
-#: lib/commit.tcl:49
+#: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
 msgstr "Feil ved innhenting av revisjonsdata for tilf=C3=B8ying:"
=20
-#: lib/commit.tcl:76
+#: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
 msgstr "Kunne ikke avgj=C3=B8re din identitet:"
=20
-#: lib/commit.tcl:81
+#: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "Ugyldig GIT_COMMITTER_IDENT:"
=20
-#: lib/commit.tcl:133
+#: lib/commit.tcl:132
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1296,7 +1296,7 @@ msgid ""
 "The rescan will be automatically started now.\n"
 msgstr ""
=20
-#: lib/commit.tcl:156
+#: lib/commit.tcl:155
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1305,7 +1305,7 @@ msgid ""
 "before committing.\n"
 msgstr ""
=20
-#: lib/commit.tcl:164
+#: lib/commit.tcl:163
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1316,7 +1316,7 @@ msgstr ""
 "\n"
 "Filen %s kan ikke sjekkes inn av dette programmet.\n"
=20
-#: lib/commit.tcl:172
+#: lib/commit.tcl:171
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1326,7 +1326,7 @@ msgstr ""
 "\n"
 "Du m=C3=A5 k=C3=B8e minst en fil f=C3=B8r du kan sjekke inn noe.\n"
=20
-#: lib/commit.tcl:187
+#: lib/commit.tcl:186
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1344,45 +1344,45 @@ msgstr ""
 "- Andre linje: Blank\n"
 "- Resterende linjer: Forklar hvorfor denne endringen er bra.\n"
=20
-#: lib/commit.tcl:211
+#: lib/commit.tcl:210
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "advarsel: Tcl st=C3=B8tter ikke denne tegnkodingen '%s'."
=20
-#: lib/commit.tcl:227
+#: lib/commit.tcl:226
 msgid "Calling pre-commit hook..."
 msgstr ""
=20
-#: lib/commit.tcl:242
+#: lib/commit.tcl:241
 msgid "Commit declined by pre-commit hook."
 msgstr ""
=20
-#: lib/commit.tcl:265
+#: lib/commit.tcl:264
 msgid "Calling commit-msg hook..."
 msgstr ""
=20
-#: lib/commit.tcl:280
+#: lib/commit.tcl:279
 msgid "Commit declined by commit-msg hook."
 msgstr ""
=20
-#: lib/commit.tcl:293
+#: lib/commit.tcl:292
 msgid "Committing changes..."
 msgstr "Sjekker inn endringer..."
=20
-#: lib/commit.tcl:309
+#: lib/commit.tcl:308
 msgid "write-tree failed:"
 msgstr "Skriving til tre feilet:"
=20
-#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
+#: lib/commit.tcl:309 lib/commit.tcl:353 lib/commit.tcl:373
 msgid "Commit failed."
 msgstr "Innsjekking feilet."
=20
-#: lib/commit.tcl:327
+#: lib/commit.tcl:326
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "Revisjon %s ser ut til =C3=A5 v=C3=A6re korrupt"
=20
-#: lib/commit.tcl:332
+#: lib/commit.tcl:331
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1397,19 +1397,19 @@ msgstr ""
 "\n"
 "Et nytt s=C3=B8k vil bli startet automatisk.\n"
=20
-#: lib/commit.tcl:339
+#: lib/commit.tcl:338
 msgid "No changes to commit."
 msgstr "Ingen endringer til innsekking."
=20
-#: lib/commit.tcl:353
+#: lib/commit.tcl:352
 msgid "commit-tree failed:"
 msgstr "commit-tree feilet:"
=20
-#: lib/commit.tcl:373
+#: lib/commit.tcl:372
 msgid "update-ref failed:"
 msgstr "update-ref feilet:"
=20
-#: lib/commit.tcl:461
+#: lib/commit.tcl:460
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "Opprettet innsjekking %s: %s"
@@ -1501,10 +1501,10 @@ msgstr ""
 "\n"
 "%s har ingen endringer.\n"
 "\n"
-"Tidsstempelet for endring p=C3=A5 denne filen ble oppdatert av en ann=
en "
-" applikasjon, men innholdet er uendret.\n"
+"Tidsstempelet for endring p=C3=A5 denne filen ble oppdatert av en ann=
en  "
+"applikasjon, men innholdet er uendret.\n"
 "\n"
-"En gjennoms=C3=B8king vil n=C3=A5 starte automatisk for =C3=A5 se om =
andre filer har "
+"En gjennoms=C3=B8king vil n=C3=A5 starte automatisk for =C3=A5 se om =
andre filer har samme "
 "status."
=20
 #: lib/diff.tcl:99
@@ -1516,14 +1516,16 @@ msgstr "Laster inn forskjellene av %s..."
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
-msgstr "LOKAL: slettet\n"
+msgstr ""
+"LOKAL: slettet\n"
 "FJERN:\n"
=20
 #: lib/diff.tcl:125
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
-msgstr "FJERN: slettet\n"
+msgstr ""
+"FJERN: slettet\n"
 "LOKAL:\n"
=20
 #: lib/diff.tcl:132
@@ -1662,7 +1664,8 @@ msgstr "Reverter endringene i disse %i filene?"
=20
 #: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr "Endringer som ikke ligger i innsjekkingsk=C3=B8en vil bli tapt=
 av denne "
+msgstr ""
+"Endringer som ikke ligger i innsjekkingsk=C3=B8en vil bli tapt av den=
ne "
 "reverteringen"
=20
 #: lib/index.tcl:409
@@ -1768,8 +1771,8 @@ msgid ""
 msgstr ""
 "Avbryt sammensl=C3=A5ing?\n"
 "\n"
-"Avbryting av p=C3=A5g=C3=A5ende sammensl=C3=A5ing vil f=C3=B8re til a=
t *alle* endringer som ikke "
-" er sjekket inn, vil g=C3=A5 tapt.\n"
+"Avbryting av p=C3=A5g=C3=A5ende sammensl=C3=A5ing vil f=C3=B8re til a=
t *alle* endringer som "
+"ikke er sjekket inn, vil g=C3=A5 tapt.\n"
 "\n"
 "Fortsette med =C3=A5 avbryte den p=C3=A5g=C3=A5ende sammensl=C3=A5ing=
en?"
=20
@@ -2089,7 +2092,8 @@ msgstr "Henter %s"
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "Vet ikke hvordan arkiv p=C3=A5 '%s' skal opprettes."
=20
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
 #, tcl-format
 msgid "push %s"
 msgstr "send %s"
@@ -2107,11 +2111,11 @@ msgstr "Fjern gren fra fjernarkiv"
 msgid "From Repository"
 msgstr "Fra arkiv"
=20
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "Fjernarkiv:"
=20
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
 msgid "Arbitrary Location:"
 msgstr "Vilk=C3=A5rlig lokasjon:"
=20
@@ -2152,8 +2156,8 @@ msgid ""
 "One or more of the merge tests failed because you have not fetched th=
e "
 "necessary commits.  Try fetching from %s first."
 msgstr ""
-"En eller flere av testene som blir kj=C3=B8rt under sammensl=C3=A5ing=
 feilet fordi du"
-"ikke har hentet inn de n=C3=B8dvendige innsjekkingene. Pr=C3=B8v =C3=A5=
 hent disse fra %s"
+"En eller flere av testene som blir kj=C3=B8rt under sammensl=C3=A5ing=
 feilet fordi "
+"du ikke har hentet inn de n=C3=B8dvendige innsjekkingene. Pr=C3=B8v =C3=
=A5 hent disse fra %s"
 "f=C3=B8rst"
=20
 #: lib/remote_branch_delete.tcl:207
@@ -2440,35 +2444,40 @@ msgstr "Fjrner sporing av grener slettet fra %s=
"
 msgid "Pushing changes to %s"
 msgstr "Sender endringer til %s"
=20
-#: lib/transport.tcl:72
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Speiler til %s"
+
+#: lib/transport.tcl:82
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "Sender %s %s til %s"
=20
-#: lib/transport.tcl:89
+#: lib/transport.tcl:100
 msgid "Push Branches"
 msgstr "Send grener"
=20
-#: lib/transport.tcl:103
+#: lib/transport.tcl:114
 msgid "Source Branches"
 msgstr "Kildegrener"
=20
-#: lib/transport.tcl:120
+#: lib/transport.tcl:131
 msgid "Destination Repository"
 msgstr "Destinasjonsarkiv"
=20
-#: lib/transport.tcl:158
+#: lib/transport.tcl:169
 msgid "Transfer Options"
 msgstr "Overf=C3=B8ringsalternativer"
=20
-#: lib/transport.tcl:160
+#: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr "Tving overskrivning av eksisterende gren (kan forkaste endring=
er)"
=20
-#: lib/transport.tcl:164
+#: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
 msgstr "Bruk tynne pakker (for tregere nettverkstilkoblinger)"
=20
-#: lib/transport.tcl:168
+#: lib/transport.tcl:179
 msgid "Include tags"
 msgstr "Inkluder tagger"
--=20
1.6.3.97.geb1c7


--=20
=46redrik Skolmli
