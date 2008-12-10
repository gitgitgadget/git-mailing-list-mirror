From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Update Hungarian translation for 0.12
Date: Wed, 10 Dec 2008 15:03:13 +0100
Message-ID: <20081210140313.GL5691@genesis.frugalware.org>
References: <20081208163628.GG31551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 15:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAPg4-0002gj-PS
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 15:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYLJODS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2008 09:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbYLJODS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 09:03:18 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46759 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbYLJODQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 09:03:16 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D7A9C580D0;
	Wed, 10 Dec 2008 15:03:13 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8BA6F4465E;
	Wed, 10 Dec 2008 15:03:13 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8C78C11B8859; Wed, 10 Dec 2008 15:03:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081208163628.GG31551@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102687>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 po/hu.po |  186 ++++++++++++++++++++++++++++++++----------------------=
--------
 1 files changed, 96 insertions(+), 90 deletions(-)

diff --git a/po/hu.po b/po/hu.po
index 8ec4339..f761b64 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -7,8 +7,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui-i 18n\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-11-16 13:56-0800\n"
-"PO-Revision-Date: 2008-11-17 23:03+0100\n"
+"POT-Creation-Date: 2008-12-08 08:31-0800\n"
+"PO-Revision-Date: 2008-12-10 15:00+0100\n"
 "Last-Translator: Miklos Vajna <vmiklos@frugalware.org>\n"
 "Language-Team: Hungarian\n"
 "MIME-Version: 1.0\n"
@@ -241,25 +241,25 @@ msgstr "Visszavon=C3=A1s"
 msgid "Redo"
 msgstr "M=C3=A9gis"
=20
-#: git-gui.sh:2378 git-gui.sh:2923
+#: git-gui.sh:2378 git-gui.sh:2937
 msgid "Cut"
 msgstr "Kiv=C3=A1g=C3=A1s"
=20
-#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
+#: git-gui.sh:2381 git-gui.sh:2940 git-gui.sh:3014 git-gui.sh:3096
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "M=C3=A1sol=C3=A1s"
=20
-#: git-gui.sh:2384 git-gui.sh:2929
+#: git-gui.sh:2384 git-gui.sh:2943
 msgid "Paste"
 msgstr "Beilleszt=C3=A9s"
=20
-#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2946 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "T=C3=B6rl=C3=A9s"
=20
-#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2950 git-gui.sh:3100 lib/console.tcl:71
 msgid "Select All"
 msgstr "Mindent kiv=C3=A1laszt"
=20
@@ -291,15 +291,15 @@ msgstr "K=C3=A9sz"
 msgid "Commit@@verb"
 msgstr "Commit@@ige"
=20
-#: git-gui.sh:2443 git-gui.sh:2864
+#: git-gui.sh:2443 git-gui.sh:2878
 msgid "New Commit"
 msgstr "=C3=9Aj commit"
=20
-#: git-gui.sh:2451 git-gui.sh:2871
+#: git-gui.sh:2451 git-gui.sh:2885
 msgid "Amend Last Commit"
 msgstr "Utols=C3=B3 commit jav=C3=ADt=C3=A1sa"
=20
-#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2839 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "Keres=C3=A9s =C3=BAjra"
=20
@@ -319,15 +319,15 @@ msgstr "Commitba val=C3=B3 kiv=C3=A1laszt=C3=A1s =
visszavon=C3=A1sa"
 msgid "Revert Changes"
 msgstr "V=C3=A1ltoztat=C3=A1sok vissza=C3=A1ll=C3=ADt=C3=A1sa"
=20
-#: git-gui.sh:2491 git-gui.sh:3069
+#: git-gui.sh:2491 git-gui.sh:3083
 msgid "Show Less Context"
 msgstr "Kevesebb k=C3=B6rnyezet mutat=C3=A1sa"
=20
-#: git-gui.sh:2495 git-gui.sh:3073
+#: git-gui.sh:2495 git-gui.sh:3087
 msgid "Show More Context"
 msgstr "T=C3=B6bb k=C3=B6rnyezet mutat=C3=A1sa"
=20
-#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
+#: git-gui.sh:2502 git-gui.sh:2852 git-gui.sh:2961
 msgid "Sign Off"
 msgstr "Al=C3=A1=C3=ADr"
=20
@@ -361,7 +361,7 @@ msgstr "N=C3=A9vjegy: %s"
 msgid "Preferences..."
 msgstr "Be=C3=A1ll=C3=ADt=C3=A1sok..."
=20
-#: git-gui.sh:2565 git-gui.sh:3115
+#: git-gui.sh:2565 git-gui.sh:3129
 msgid "Options..."
 msgstr "Opci=C3=B3k..."
=20
@@ -381,125 +381,125 @@ msgstr "Online dokument=C3=A1ci=C3=B3"
 msgid "Show SSH Key"
 msgstr "SSH kulcs mutat=C3=A1sa"
=20
-#: git-gui.sh:2707
+#: git-gui.sh:2721
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "v=C3=A9gzetes hiba: nem =C3=A9rhet=C5=91 el a(z) %s =C3=BAtvonal: Nin=
cs ilyen f=C3=A1jl vagy k=C3=B6nyvt=C3=A1r"
=20
-#: git-gui.sh:2740
+#: git-gui.sh:2754
 msgid "Current Branch:"
 msgstr "Jelenlegi branch:"
=20
-#: git-gui.sh:2761
+#: git-gui.sh:2775
 msgid "Staged Changes (Will Commit)"
 msgstr "Kiv=C3=A1lasztott v=C3=A1ltoztat=C3=A1sok (commitolva lesz)"
=20
-#: git-gui.sh:2781
+#: git-gui.sh:2795
 msgid "Unstaged Changes"
 msgstr "Kiv=C3=A1lasztatlan v=C3=A1ltoztat=C3=A1sok"
=20
-#: git-gui.sh:2831
+#: git-gui.sh:2845
 msgid "Stage Changed"
 msgstr "V=C3=A1ltoztat=C3=A1sok kiv=C3=A1laszt=C3=A1sa"
=20
-#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2864 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "Push"
=20
-#: git-gui.sh:2885
+#: git-gui.sh:2899
 msgid "Initial Commit Message:"
 msgstr "Kezdeti commit =C3=BCzenet:"
=20
-#: git-gui.sh:2886
+#: git-gui.sh:2900
 msgid "Amended Commit Message:"
 msgstr "Jav=C3=ADt=C3=B3 commit =C3=BCzenet:"
=20
-#: git-gui.sh:2887
+#: git-gui.sh:2901
 msgid "Amended Initial Commit Message:"
 msgstr "Kezdeti jav=C3=ADt=C3=B3 commit =C3=BCzenet:"
=20
-#: git-gui.sh:2888
+#: git-gui.sh:2902
 msgid "Amended Merge Commit Message:"
 msgstr "Jav=C3=ADt=C3=B3 merge commit =C3=BCzenet:"
=20
-#: git-gui.sh:2889
+#: git-gui.sh:2903
 msgid "Merge Commit Message:"
 msgstr "Merge commit =C3=BCzenet:"
=20
-#: git-gui.sh:2890
+#: git-gui.sh:2904
 msgid "Commit Message:"
 msgstr "Commit =C3=BCzenet:"
=20
-#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
+#: git-gui.sh:2953 git-gui.sh:3104 lib/console.tcl:73
 msgid "Copy All"
 msgstr "=C3=96sszes m=C3=A1sol=C3=A1sa"
=20
-#: git-gui.sh:2963 lib/blame.tcl:104
+#: git-gui.sh:2977 lib/blame.tcl:104
 msgid "File:"
 msgstr "F=C3=A1jl:"
=20
-#: git-gui.sh:3078
+#: git-gui.sh:3092
 msgid "Refresh"
 msgstr "Friss=C3=ADt=C3=A9s"
=20
-#: git-gui.sh:3099
+#: git-gui.sh:3113
 msgid "Decrease Font Size"
 msgstr "Font m=C3=A9ret cs=C3=B6kkent=C3=A9se"
=20
-#: git-gui.sh:3103
+#: git-gui.sh:3117
 msgid "Increase Font Size"
 msgstr "F=C3=B6nt m=C3=A9ret n=C3=B6vel=C3=A9se"
=20
-#: git-gui.sh:3111 lib/blame.tcl:281
+#: git-gui.sh:3125 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "K=C3=B3dol=C3=A1s"
=20
-#: git-gui.sh:3122
+#: git-gui.sh:3136
 msgid "Apply/Reverse Hunk"
 msgstr "Hunk alkalmaz=C3=A1sa/vissza=C3=A1ll=C3=ADt=C3=A1sa"
=20
-#: git-gui.sh:3127
+#: git-gui.sh:3141
 msgid "Apply/Reverse Line"
 msgstr "Sor alkalmaz=C3=A1sa/vissza=C3=A1ll=C3=ADt=C3=A1sa"
=20
-#: git-gui.sh:3137
+#: git-gui.sh:3151
 msgid "Run Merge Tool"
 msgstr "Merge eszk=C3=B6z futtat=C3=A1sa"
=20
-#: git-gui.sh:3142
+#: git-gui.sh:3156
 msgid "Use Remote Version"
 msgstr "T=C3=A1voli verzi=C3=B3 haszn=C3=A1lata"
=20
-#: git-gui.sh:3146
+#: git-gui.sh:3160
 msgid "Use Local Version"
 msgstr "Helyi verzi=C3=B3 haszn=C3=A1lata"
=20
-#: git-gui.sh:3150
+#: git-gui.sh:3164
 msgid "Revert To Base"
 msgstr "Vissza=C3=A1ll=C3=ADt=C3=A1s az alaphoz"
=20
-#: git-gui.sh:3169
+#: git-gui.sh:3183
 msgid "Unstage Hunk From Commit"
 msgstr "Hunk t=C3=B6rl=C3=A9se commitb=C3=B3l"
=20
-#: git-gui.sh:3170
+#: git-gui.sh:3184
 msgid "Unstage Line From Commit"
 msgstr "A sor kiv=C3=A1laszt=C3=A1s=C3=A1nak t=C3=B6rl=C3=A9se"
=20
-#: git-gui.sh:3172
+#: git-gui.sh:3186
 msgid "Stage Hunk For Commit"
 msgstr "Hunk kiv=C3=A1laszt=C3=A1sa commitba"
=20
-#: git-gui.sh:3173
+#: git-gui.sh:3187
 msgid "Stage Line For Commit"
 msgstr "Sor kiv=C3=A1laszt=C3=A1sa commitba"
=20
-#: git-gui.sh:3196
+#: git-gui.sh:3210
 msgid "Initializing..."
 msgstr "Inicializ=C3=A1l=C3=A1s..."
=20
-#: git-gui.sh:3301
+#: git-gui.sh:3315
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -516,7 +516,7 @@ msgstr ""
 "ind=C3=ADtott folyamatok =C3=A1ltal:\n"
 "\n"
=20
-#: git-gui.sh:3331
+#: git-gui.sh:3345
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -526,7 +526,7 @@ msgstr ""
 "Ez a Cygwin =C3=A1ltal terjesztett Tcl bin=C3=A1risban\n"
 "l=C3=A9v=C5=91 ismert hiba miatt van."
=20
-#: git-gui.sh:3336
+#: git-gui.sh:3350
 #, tcl-format
 msgid ""
 "\n"
@@ -612,43 +612,43 @@ msgstr "Futtat=C3=A1s m=C3=A1sol=C3=A1s-=C3=A9rz=C3=
=A9kel=C3=A9sen kereszt=C3=BCl..."
 msgid "Loading annotation..."
 msgstr "Az annot=C3=A1ci=C3=B3 bet=C3=B6lt=C3=A9se..."
=20
-#: lib/blame.tcl:964
+#: lib/blame.tcl:963
 msgid "Author:"
 msgstr "Szerz=C5=91:"
=20
-#: lib/blame.tcl:968
+#: lib/blame.tcl:967
 msgid "Committer:"
 msgstr "Commiter:"
=20
-#: lib/blame.tcl:973
+#: lib/blame.tcl:972
 msgid "Original File:"
 msgstr "Eredeti f=C3=A1jl:"
=20
-#: lib/blame.tcl:1021
+#: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
 msgstr "Nem tal=C3=A1lhat=C3=B3 a HEAD commit:"
=20
-#: lib/blame.tcl:1076
+#: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
 msgstr "Nem tal=C3=A1lhat=C3=B3 a sz=C3=BCl=C5=91 commit:"
=20
-#: lib/blame.tcl:1091
+#: lib/blame.tcl:1090
 msgid "Unable to display parent"
 msgstr "Nem lehet megjelen=C3=ADteni a sz=C3=BCl=C5=91t"
=20
-#: lib/blame.tcl:1092 lib/diff.tcl:297
+#: lib/blame.tcl:1091 lib/diff.tcl:297
 msgid "Error loading diff:"
 msgstr "Hiba a diff bet=C3=B6lt=C3=A9se k=C3=B6zben:"
=20
-#: lib/blame.tcl:1232
+#: lib/blame.tcl:1231
 msgid "Originally By:"
 msgstr "Eredeti szerz=C5=91:"
=20
-#: lib/blame.tcl:1238
+#: lib/blame.tcl:1237
 msgid "In File:"
 msgstr "Ebben a f=C3=A1jlban:"
=20
-#: lib/blame.tcl:1243
+#: lib/blame.tcl:1242
 msgid "Copied Or Moved Here By:"
 msgstr "Ide m=C3=A1solta vagy helyezte:"
=20
@@ -665,7 +665,7 @@ msgstr "Checkout"
 #: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
 #: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
 #: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:97
+#: lib/transport.tcl:108
 msgid "Cancel"
 msgstr "M=C3=A9gsem"
=20
@@ -1317,19 +1317,19 @@ msgstr ""
 "A jelenlegi merge m=C3=A9g nem teljesen fejez=C5=91d=C3=B6tt be. Csak=
 akkor jav=C3=ADthat egy "
 "el=C5=91bbi commitot, hogyha megszak=C3=ADtja a jelenlegi merge folya=
matot.\n"
=20
-#: lib/commit.tcl:49
+#: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
 msgstr "Hiba a jav=C3=ADtand=C3=B3 commit adat bet=C3=B6lt=C3=A9se k=C3=
=B6zben:"
=20
-#: lib/commit.tcl:76
+#: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
 msgstr "Nem siker=C3=BClt meg=C3=A1llap=C3=ADtani az azonos=C3=ADt=C3=B3=
t:"
=20
-#: lib/commit.tcl:81
+#: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "=C3=89rv=C3=A9nytelen GIT_COMMITTER_IDENT:"
=20
-#: lib/commit.tcl:133
+#: lib/commit.tcl:132
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1346,7 +1346,7 @@ msgstr ""
 "\n"
 "Az =C3=BAjrakeres=C3=A9s most automatikusan el fog indulni.\n"
=20
-#: lib/commit.tcl:156
+#: lib/commit.tcl:155
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1359,7 +1359,7 @@ msgstr ""
 "A(z) %s f=C3=A1jlban =C3=BCtk=C3=B6z=C3=A9sek vannak. Egyszer azokat =
ki kell jav=C3=ADtani, majd "
 "hozz=C3=A1 ki kell v=C3=A1lasztani a f=C3=A1jlt miel=C5=91tt commitol=
ni lehetne.\n"
=20
-#: lib/commit.tcl:164
+#: lib/commit.tcl:163
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1370,7 +1370,7 @@ msgstr ""
 "\n"
 "A(z) %s f=C3=A1jlt nem tudja ez a program commitolni.\n"
=20
-#: lib/commit.tcl:172
+#: lib/commit.tcl:171
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1380,7 +1380,7 @@ msgstr ""
 "\n"
 "Legal=C3=A1bb egy f=C3=A1jl ki kell v=C3=A1lasztani, hogy commitolni =
lehessen.\n"
=20
-#: lib/commit.tcl:187
+#: lib/commit.tcl:186
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1398,45 +1398,45 @@ msgstr ""
 "- M=C3=A1sodik sor: =C3=9Cres\n"
 "- A t=C3=B6bbi sor: Le=C3=ADrja, hogy mi=C3=A9rt j=C3=B3 ez a v=C3=A1=
ltoztat=C3=A1s.\n"
=20
-#: lib/commit.tcl:211
+#: lib/commit.tcl:210
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "figyelmeztet=C3=A9s: a Tcl nem t=C3=A1mogatja a(z) '%s' k=C3=B3=
dol=C3=A1st."
=20
-#: lib/commit.tcl:227
+#: lib/commit.tcl:226
 msgid "Calling pre-commit hook..."
 msgstr "A pre-commit hurok megh=C3=ADv=C3=A1sa..."
=20
-#: lib/commit.tcl:242
+#: lib/commit.tcl:241
 msgid "Commit declined by pre-commit hook."
 msgstr "A commitot megakad=C3=A1lyozta a pre-commit hurok. "
=20
-#: lib/commit.tcl:265
+#: lib/commit.tcl:264
 msgid "Calling commit-msg hook..."
 msgstr "A commit-msg hurok megh=C3=ADv=C3=A1sa..."
=20
-#: lib/commit.tcl:280
+#: lib/commit.tcl:279
 msgid "Commit declined by commit-msg hook."
 msgstr "A commiot megakad=C3=A1lyozta a commit-msg hurok."
=20
-#: lib/commit.tcl:293
+#: lib/commit.tcl:292
 msgid "Committing changes..."
 msgstr "A v=C3=A1ltoztat=C3=A1sok commitol=C3=A1sa..."
=20
-#: lib/commit.tcl:309
+#: lib/commit.tcl:308
 msgid "write-tree failed:"
 msgstr "a write-tree sikertelen:"
=20
-#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
+#: lib/commit.tcl:309 lib/commit.tcl:353 lib/commit.tcl:373
 msgid "Commit failed."
 msgstr "A commit nem siker=C3=BClt."
=20
-#: lib/commit.tcl:327
+#: lib/commit.tcl:326
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "A(z) %s commit s=C3=A9r=C3=BCltnek t=C5=B1nik"
=20
-#: lib/commit.tcl:332
+#: lib/commit.tcl:331
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1450,19 +1450,19 @@ msgstr ""
 "\n"
 "Az =C3=BAjrakeres=C3=A9s most automatikusan el fog indulni.\n"
=20
-#: lib/commit.tcl:339
+#: lib/commit.tcl:338
 msgid "No changes to commit."
 msgstr "Nincs commitoland=C3=B3 v=C3=A1ltoztat=C3=A1s."
=20
-#: lib/commit.tcl:353
+#: lib/commit.tcl:352
 msgid "commit-tree failed:"
 msgstr "a commit-tree sikertelen:"
=20
-#: lib/commit.tcl:373
+#: lib/commit.tcl:372
 msgid "update-ref failed:"
 msgstr "az update-ref sikertelen:"
=20
-#: lib/commit.tcl:461
+#: lib/commit.tcl:460
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "L=C3=A9trej=C3=B6tt a %s commit: %s"
@@ -2168,7 +2168,8 @@ msgstr "A(z) %s let=C3=B6lt=C3=A9se"
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "Nem tudni, hogy hogy kell a(z) '%s' helyen rep=C3=B3t iniciali=
z=C3=A1lni."
=20
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
 #, tcl-format
 msgid "push %s"
 msgstr "%s push-ol=C3=A1sa"
@@ -2186,11 +2187,11 @@ msgstr "T=C3=A1voli Branch t=C3=B6rl=C3=A9se"
 msgid "From Repository"
 msgstr "Forr=C3=A1s rep=C3=B3"
=20
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "T=C3=A1voli:"
=20
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
 msgid "Arbitrary Location:"
 msgstr "=C3=96nk=C3=A9nyes hely:"
=20
@@ -2519,38 +2520,43 @@ msgstr "A %s rep=C3=B3b=C3=B3l t=C3=B6r=C3=B6lt=
 k=C3=B6vet=C5=91 branchek t=C3=B6rl=C3=A9se"
 msgid "Pushing changes to %s"
 msgstr "V=C3=A1ltoz=C3=A1sok pushol=C3=A1sa ide: %s"
=20
-#: lib/transport.tcl:72
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "T=C3=BCkr=C3=B6z=C3=A9s a k=C3=B6vetkez=C5=91 helyre: %s"
+
+#: lib/transport.tcl:82
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "Pushol=C3=A1s: %s %s, ide: %s"
=20
-#: lib/transport.tcl:89
+#: lib/transport.tcl:100
 msgid "Push Branches"
 msgstr "Branchek pushol=C3=A1sa"
=20
-#: lib/transport.tcl:103
+#: lib/transport.tcl:114
 msgid "Source Branches"
 msgstr "Forr=C3=A1s branchek"
=20
-#: lib/transport.tcl:120
+#: lib/transport.tcl:131
 msgid "Destination Repository"
 msgstr "C=C3=A9l rep=C3=B3"
=20
-#: lib/transport.tcl:158
+#: lib/transport.tcl:169
 msgid "Transfer Options"
 msgstr "=C3=81tviteli opci=C3=B3k"
=20
-#: lib/transport.tcl:160
+#: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""
 "L=C3=A9tez=C5=91 branch fel=C3=BCl=C3=ADr=C3=A1s=C3=A1nak er=C5=91lte=
t=C3=A9se (lehet, hogy el fog dobni "
 "v=C3=A1ltoztat=C3=A1sokat)"
=20
-#: lib/transport.tcl:164
+#: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
 msgstr "V=C3=A9kony csomagok haszn=C3=A1lata (lass=C3=BA h=C3=A1l=C3=B3=
zati kapcsolatok sz=C3=A1m=C3=A1ra)"
=20
-#: lib/transport.tcl:168
+#: lib/transport.tcl:179
 msgid "Include tags"
 msgstr "Tageket is"
=20
--=20
1.6.0.3
