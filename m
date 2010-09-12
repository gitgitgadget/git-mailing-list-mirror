From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] gitk: Update Swedish translation (290t).
Date: Sun, 12 Sep 2010 21:17:05 +0100
Message-ID: <20100912202119.A5A782FC00@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Sep 12 22:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Out3L-0000tk-NG
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab0ILUVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 16:21:24 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43691 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579Ab0ILUVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:21:21 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8N005S5HVKQ740@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 12 Sep 2010 22:21:20 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7210217990A7_C8D3640B	for <git@vger.kernel.org>; Sun,
 12 Sep 2010 20:21:20 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 258A31796529_C8D3640F	for <git@vger.kernel.org>; Sun,
 12 Sep 2010 20:21:20 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8N00JGMHVJ8U30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 12 Sep 2010 22:21:20 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id A5A782FC00; Sun,
 12 Sep 2010 22:21:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156053>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 po/sv.po |  601 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 files changed, 303 insertions(+), 298 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index 386763a..2f07a2e 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1,5 +1,5 @@
 # Swedish translation for gitk
-# Copyright (C) 2005-2009 Paul Mackerras
+# Copyright (C) 2005-2010 Paul Mackerras
 # This file is distributed under the same license as the gitk package.
 #
 # Peter Krefting <peter@softwolves.pp.se>, 2008-2010.
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: sv\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-28 13:16+0100\n"
-"PO-Revision-Date: 2010-01-28 13:48+0100\n"
+"POT-Creation-Date: 2010-09-12 21:14+0100\n"
+"PO-Revision-Date: 2010-09-12 21:16+0100\n"
 "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
 "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
 "MIME-Version: 1.0\n"
@@ -24,17 +24,17 @@ msgstr "Kunde inte h=C3=A4mta lista =C3=B6ver ej sa=
mmanslagna filer:"
 msgid "Error parsing revisions:"
 msgstr "Fel vid tolkning av revisioner:"
=20
-#: gitk:329
+#: gitk:330
 msgid "Error executing --argscmd command:"
 msgstr "Fel vid k=C3=B6rning av --argscmd-kommando:"
=20
-#: gitk:342
+#: gitk:343
 msgid "No files selected: --merge specified but no files are unmerged.=
"
 msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer som inte h=
ar "
 "slagits samman."
=20
-#: gitk:345
+#: gitk:346
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
@@ -42,600 +42,605 @@ msgstr ""
 "Inga filer valdes: --merge angavs men det finns inga filer inom "
 "filbegr=C3=A4nsningen."
=20
-#: gitk:367 gitk:514
+#: gitk:368 gitk:516
 msgid "Error executing git log:"
 msgstr "Fel vid k=C3=B6rning av git log:"
=20
-#: gitk:385 gitk:530
+#: gitk:386 gitk:532
 msgid "Reading"
 msgstr "L=C3=A4ser"
=20
-#: gitk:445 gitk:4261
+#: gitk:446 gitk:4271
 msgid "Reading commits..."
 msgstr "L=C3=A4ser incheckningar..."
=20
-#: gitk:448 gitk:1578 gitk:4264
+#: gitk:449 gitk:1580 gitk:4274
 msgid "No commits selected"
 msgstr "Inga incheckningar markerade"
=20
-#: gitk:1454
+#: gitk:1456
 msgid "Can't parse git log output:"
 msgstr "Kan inte tolka utdata fr=C3=A5n git log:"
=20
-#: gitk:1674
+#: gitk:1676
 msgid "No commit information available"
 msgstr "Ingen incheckningsinformation =C3=A4r tillg=C3=A4nglig"
=20
-#: gitk:1816
+#: gitk:1818
 msgid "mc"
 msgstr "mc"
=20
-#: gitk:1851 gitk:4054 gitk:9044 gitk:10585 gitk:10804
+#: gitk:1853 gitk:4064 gitk:9067 gitk:10607 gitk:10817
 msgid "OK"
 msgstr "OK"
=20
-#: gitk:1853 gitk:4056 gitk:8634 gitk:8713 gitk:8828 gitk:8877 gitk:90=
46
-#: gitk:10586 gitk:10805
+#: gitk:1855 gitk:4066 gitk:8657 gitk:8736 gitk:8851 gitk:8900 gitk:90=
69
+#: gitk:10608 gitk:10818
 msgid "Cancel"
 msgstr "Avbryt"
=20
-#: gitk:1975
+#: gitk:1980
 msgid "Update"
 msgstr "Uppdatera"
=20
-#: gitk:1976
+#: gitk:1981
 msgid "Reload"
 msgstr "Ladda om"
=20
-#: gitk:1977
+#: gitk:1982
 msgid "Reread references"
 msgstr "L=C3=A4s om referenser"
=20
-#: gitk:1978
+#: gitk:1983
 msgid "List references"
 msgstr "Visa referenser"
=20
-#: gitk:1980
+#: gitk:1985
 msgid "Start git gui"
 msgstr "Starta git gui"
=20
-#: gitk:1982
+#: gitk:1987
 msgid "Quit"
 msgstr "Avsluta"
=20
-#: gitk:1974
+#: gitk:1979
 msgid "File"
 msgstr "Arkiv"
=20
-#: gitk:1986
+#: gitk:1991
 msgid "Preferences"
 msgstr "Inst=C3=A4llningar"
=20
-#: gitk:1985
+#: gitk:1990
 msgid "Edit"
 msgstr "Redigera"
=20
-#: gitk:1990
+#: gitk:1995
 msgid "New view..."
 msgstr "Ny vy..."
=20
-#: gitk:1991
+#: gitk:1996
 msgid "Edit view..."
 msgstr "=C3=84ndra vy..."
=20
-#: gitk:1992
+#: gitk:1997
 msgid "Delete view"
 msgstr "Ta bort vy"
=20
-#: gitk:1994
+#: gitk:1999
 msgid "All files"
 msgstr "Alla filer"
=20
-#: gitk:1989 gitk:3808
+#: gitk:1994 gitk:3817
 msgid "View"
 msgstr "Visa"
=20
-#: gitk:1999 gitk:2009 gitk:2780
+#: gitk:2004 gitk:2014 gitk:2787
 msgid "About gitk"
 msgstr "Om gitk"
=20
-#: gitk:2000 gitk:2014
+#: gitk:2005 gitk:2019
 msgid "Key bindings"
 msgstr "Tangentbordsbindningar"
=20
-#: gitk:1998 gitk:2013
+#: gitk:2003 gitk:2018
 msgid "Help"
 msgstr "Hj=C3=A4lp"
=20
-#: gitk:2091 gitk:8110
+#: gitk:2096 gitk:8132
 msgid "SHA1 ID:"
 msgstr "SHA1-id:"
=20
-#: gitk:2122
+#: gitk:2127
 msgid "Row"
 msgstr "Rad"
=20
-#: gitk:2160
+#: gitk:2165
 msgid "Find"
 msgstr "S=C3=B6k"
=20
-#: gitk:2161
+#: gitk:2166
 msgid "next"
 msgstr "n=C3=A4sta"
=20
-#: gitk:2162
+#: gitk:2167
 msgid "prev"
 msgstr "f=C3=B6reg"
=20
-#: gitk:2163
+#: gitk:2168
 msgid "commit"
 msgstr "incheckning"
=20
-#: gitk:2166 gitk:2168 gitk:4422 gitk:4445 gitk:4469 gitk:6410 gitk:64=
82
-#: gitk:6566
+#: gitk:2171 gitk:2173 gitk:4432 gitk:4455 gitk:4479 gitk:6420 gitk:64=
92
+#: gitk:6576
 msgid "containing:"
 msgstr "som inneh=C3=A5ller:"
=20
-#: gitk:2169 gitk:3290 gitk:3295 gitk:4497
+#: gitk:2174 gitk:3298 gitk:3303 gitk:4507
 msgid "touching paths:"
 msgstr "som r=C3=B6r s=C3=B6kv=C3=A4g:"
=20
-#: gitk:2170 gitk:4502
+#: gitk:2175 gitk:4512
 msgid "adding/removing string:"
 msgstr "som l=C3=A4gger/till tar bort str=C3=A4ng:"
=20
-#: gitk:2179 gitk:2181
+#: gitk:2184 gitk:2186
 msgid "Exact"
 msgstr "Exakt"
=20
-#: gitk:2181 gitk:4577 gitk:6378
+#: gitk:2186 gitk:4587 gitk:6388
 msgid "IgnCase"
 msgstr "IgnVersaler"
=20
-#: gitk:2181 gitk:4471 gitk:4575 gitk:6374
+#: gitk:2186 gitk:4481 gitk:4585 gitk:6384
 msgid "Regexp"
 msgstr "Reg.uttr."
=20
-#: gitk:2183 gitk:2184 gitk:4596 gitk:4626 gitk:4633 gitk:6502 gitk:65=
70
+#: gitk:2188 gitk:2189 gitk:4606 gitk:4636 gitk:4643 gitk:6512 gitk:65=
80
 msgid "All fields"
 msgstr "Alla f=C3=A4lt"
=20
-#: gitk:2184 gitk:4594 gitk:4626 gitk:6441
+#: gitk:2189 gitk:4604 gitk:4636 gitk:6451
 msgid "Headline"
 msgstr "Rubrik"
=20
-#: gitk:2185 gitk:4594 gitk:6441 gitk:6570 gitk:7003
+#: gitk:2190 gitk:4604 gitk:6451 gitk:6580 gitk:7013
 msgid "Comments"
 msgstr "Kommentarer"
=20
-#: gitk:2185 gitk:4594 gitk:4598 gitk:4633 gitk:6441 gitk:6938 gitk:82=
85
-#: gitk:8300
+#: gitk:2190 gitk:4604 gitk:4608 gitk:4643 gitk:6451 gitk:6948 gitk:83=
07
+#: gitk:8322
 msgid "Author"
 msgstr "F=C3=B6rfattare"
=20
-#: gitk:2185 gitk:4594 gitk:6441 gitk:6940
+#: gitk:2190 gitk:4604 gitk:6451 gitk:6950
 msgid "Committer"
 msgstr "Incheckare"
=20
-#: gitk:2216
+#: gitk:2221
 msgid "Search"
 msgstr "S=C3=B6k"
=20
-#: gitk:2224
+#: gitk:2229
 msgid "Diff"
 msgstr "Diff"
=20
-#: gitk:2226
+#: gitk:2231
 msgid "Old version"
 msgstr "Gammal version"
=20
-#: gitk:2228
+#: gitk:2233
 msgid "New version"
 msgstr "Ny version"
=20
-#: gitk:2230
+#: gitk:2235
 msgid "Lines of context"
 msgstr "Rader sammanhang"
=20
-#: gitk:2240
+#: gitk:2245
 msgid "Ignore space change"
 msgstr "Ignorera =C3=A4ndringar i blanksteg"
=20
-#: gitk:2299
+#: gitk:2304
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:2301
+#: gitk:2306
 msgid "Tree"
 msgstr "Tr=C3=A4d"
=20
-#: gitk:2456 gitk:2473
+#: gitk:2463 gitk:2480
 msgid "Diff this -> selected"
 msgstr "Diff denna -> markerad"
=20
-#: gitk:2457 gitk:2474
+#: gitk:2464 gitk:2481
 msgid "Diff selected -> this"
 msgstr "Diff markerad -> denna"
=20
-#: gitk:2458 gitk:2475
+#: gitk:2465 gitk:2482
 msgid "Make patch"
 msgstr "Skapa patch"
=20
-#: gitk:2459 gitk:8692
+#: gitk:2466 gitk:8715
 msgid "Create tag"
 msgstr "Skapa tagg"
=20
-#: gitk:2460 gitk:8808
+#: gitk:2467 gitk:8831
 msgid "Write commit to file"
 msgstr "Skriv incheckning till fil"
=20
-#: gitk:2461 gitk:8865
+#: gitk:2468 gitk:8888
 msgid "Create new branch"
 msgstr "Skapa ny gren"
=20
-#: gitk:2462
+#: gitk:2469
 msgid "Cherry-pick this commit"
 msgstr "Plocka denna incheckning"
=20
-#: gitk:2463
+#: gitk:2470
 msgid "Reset HEAD branch to here"
 msgstr "=C3=85terst=C3=A4ll HEAD-grenen hit"
=20
-#: gitk:2464
+#: gitk:2471
 msgid "Mark this commit"
 msgstr "Markera denna incheckning"
=20
-#: gitk:2465
+#: gitk:2472
 msgid "Return to mark"
 msgstr "=C3=85terg=C3=A5 till markering"
=20
-#: gitk:2466
+#: gitk:2473
 msgid "Find descendant of this and mark"
 msgstr "Hitta efterf=C3=B6ljare till denna och markera"
=20
-#: gitk:2467
+#: gitk:2474
 msgid "Compare with marked commit"
 msgstr "J=C3=A4mf=C3=B6r med markerad incheckning"
=20
-#: gitk:2481
+#: gitk:2488
 msgid "Check out this branch"
 msgstr "Checka ut denna gren"
=20
-#: gitk:2482
+#: gitk:2489
 msgid "Remove this branch"
 msgstr "Ta bort denna gren"
=20
-#: gitk:2489
+#: gitk:2496
 msgid "Highlight this too"
 msgstr "Markera =C3=A4ven detta"
=20
-#: gitk:2490
+#: gitk:2497
 msgid "Highlight this only"
 msgstr "Markera bara detta"
=20
-#: gitk:2491
+#: gitk:2498
 msgid "External diff"
 msgstr "Extern diff"
=20
-#: gitk:2492
+#: gitk:2499
 msgid "Blame parent commit"
 msgstr "Klandra f=C3=B6r=C3=A4ldraincheckning"
=20
-#: gitk:2499
+#: gitk:2506
 msgid "Show origin of this line"
 msgstr "Visa ursprunget f=C3=B6r den h=C3=A4r raden"
=20
-#: gitk:2500
+#: gitk:2507
 msgid "Run git gui blame on this line"
 msgstr "K=C3=B6r git gui blame p=C3=A5 den h=C3=A4r raden"
=20
-#: gitk:2782
+#: gitk:2789
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
+"Copyright =C2=A99 2005-2010 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - en incheckningsvisare f=C3=B6r git\n"
 "\n"
-"Copyright \\u00a9 2005-2010 Paul Mackerras\n"
+"Copyright =C2=A99 2005-2010 Paul Mackerras\n"
 "\n"
 "Anv=C3=A4nd och vidaref=C3=B6rmedla enligt villkoren i GNU General Pu=
blic License"
=20
-#: gitk:2790 gitk:2854 gitk:9230
+#: gitk:2797 gitk:2862 gitk:9253
 msgid "Close"
 msgstr "St=C3=A4ng"
=20
-#: gitk:2811
+#: gitk:2818
 msgid "Gitk key bindings"
 msgstr "Tangentbordsbindningar f=C3=B6r Gitk"
=20
-#: gitk:2814
+#: gitk:2821
 msgid "Gitk key bindings:"
 msgstr "Tangentbordsbindningar f=C3=B6r Gitk:"
=20
-#: gitk:2816
+#: gitk:2823
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tAvsluta"
=20
-#: gitk:2817
+#: gitk:2824
+#, tcl-format
+msgid "<%s-W>\t\tClose window"
+msgstr "<%s-W>\t\tSt=C3=A4ng f=C3=B6nster"
+
+#: gitk:2825
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tG=C3=A5 till f=C3=B6rsta incheckning"
=20
-#: gitk:2818
+#: gitk:2826
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tG=C3=A5 till sista incheckning"
=20
-#: gitk:2819
+#: gitk:2827
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Upp>, p, i\tG=C3=A5 en incheckning upp"
=20
-#: gitk:2820
+#: gitk:2828
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Ned>, n, k\tG=C3=A5 en incheckning ned"
=20
-#: gitk:2821
+#: gitk:2829
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<V=C3=A4nster>, z, j\tG=C3=A5 bak=C3=A5t i historiken"
=20
-#: gitk:2822
+#: gitk:2830
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<H=C3=B6ger>, x, l\tG=C3=A5 fram=C3=A5t i historiken"
=20
-#: gitk:2823
+#: gitk:2831
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tG=C3=A5 upp en sida i incheckningslistan"
=20
-#: gitk:2824
+#: gitk:2832
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tG=C3=A5 ned en sida i incheckningslistan"
=20
-#: gitk:2825
+#: gitk:2833
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tRulla till b=C3=B6rjan av incheckningslistan"
=20
-#: gitk:2826
+#: gitk:2834
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tRulla till slutet av incheckningslistan"
=20
-#: gitk:2827
+#: gitk:2835
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Upp>\tRulla incheckningslistan upp ett steg"
=20
-#: gitk:2828
+#: gitk:2836
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Ned>\tRulla incheckningslistan ned ett steg"
=20
-#: gitk:2829
+#: gitk:2837
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tRulla incheckningslistan upp en sida"
=20
-#: gitk:2830
+#: gitk:2838
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tRulla incheckningslistan ned en sida"
=20
-#: gitk:2831
+#: gitk:2839
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Skift-Upp>\tS=C3=B6k bak=C3=A5t (upp=C3=A5t, senare incheckni=
ngar)"
=20
-#: gitk:2832
+#: gitk:2840
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Skift-Ned>\tS=C3=B6k fram=C3=A5t (ned=C3=A5t, tidigare inchec=
kningar)"
=20
-#: gitk:2833
+#: gitk:2841
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tRulla diffvisningen upp en sida"
=20
-#: gitk:2834
+#: gitk:2842
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Baksteg>\tRulla diffvisningen upp en sida"
=20
-#: gitk:2835
+#: gitk:2843
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Blanksteg>\tRulla diffvisningen ned en sida"
=20
-#: gitk:2836
+#: gitk:2844
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tRulla diffvisningen upp 18 rader"
=20
-#: gitk:2837
+#: gitk:2845
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tRulla diffvisningen ned 18 rader"
=20
-#: gitk:2838
+#: gitk:2846
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tS=C3=B6k"
=20
-#: gitk:2839
+#: gitk:2847
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2840
+#: gitk:2848
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2841
+#: gitk:2849
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tFokusera s=C3=B6krutan"
=20
-#: gitk:2842
+#: gitk:2850
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tG=C3=A5 till f=C3=B6reg=C3=A5ende s=C3=B6ktr=C3=A4ff"
=20
-#: gitk:2843
+#: gitk:2851
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tRulla diffvisningen till n=C3=A4sta fil"
=20
-#: gitk:2844
+#: gitk:2852
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tG=C3=A5 till n=C3=A4sta s=C3=B6ktr=C3=A4ff i diffvis=
ningen"
=20
-#: gitk:2845
+#: gitk:2853
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tG=C3=A5 till f=C3=B6reg=C3=A5ende s=C3=B6ktr=C3=A4ff=
 i diffvisningen"
=20
-#: gitk:2846
+#: gitk:2854
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Num+>\t=C3=96ka teckenstorlek"
=20
-#: gitk:2847
+#: gitk:2855
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\t=C3=96ka teckenstorlek"
=20
-#: gitk:2848
+#: gitk:2856
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Num->\tMinska teckenstorlek"
=20
-#: gitk:2849
+#: gitk:2857
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tMinska teckenstorlek"
=20
-#: gitk:2850
+#: gitk:2858
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tUppdatera"
=20
-#: gitk:3305 gitk:3314
+#: gitk:3313 gitk:3322
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Fel vid skapande av tempor=C3=A4r katalog %s:"
=20
-#: gitk:3327
+#: gitk:3335
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Fel vid h=C3=A4mtning av  \"%s\" fr=C3=A5n %s:"
=20
-#: gitk:3390
+#: gitk:3398
 msgid "command failed:"
 msgstr "kommando misslyckades:"
=20
-#: gitk:3539
+#: gitk:3547
 msgid "No such commit"
 msgstr "Incheckning saknas"
=20
-#: gitk:3553
+#: gitk:3561
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: kommando misslyckades:"
=20
-#: gitk:3584
+#: gitk:3592
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Kunde inte l=C3=A4sa sammanslagningshuvud: %s"
=20
-#: gitk:3592
+#: gitk:3600
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Fel vid l=C3=A4sning av index: %s"
=20
-#: gitk:3617
+#: gitk:3625
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "Kunde inte starta git blame: %s"
=20
-#: gitk:3620 gitk:6409
+#: gitk:3628 gitk:6419
 msgid "Searching"
 msgstr "S=C3=B6ker"
=20
-#: gitk:3652
+#: gitk:3660
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Fel vid k=C3=B6rning av git blame: %s"
=20
-#: gitk:3680
+#: gitk:3688
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "Raden kommer fr=C3=A5n incheckningen %s, som inte finns i denn=
a vy"
=20
-#: gitk:3694
+#: gitk:3702
 msgid "External diff viewer failed:"
 msgstr "Externt diff-verktyg misslyckades:"
=20
-#: gitk:3812
+#: gitk:3820
 msgid "Gitk view definition"
 msgstr "Definition av Gitk-vy"
=20
-#: gitk:3816
+#: gitk:3824
 msgid "Remember this view"
 msgstr "Spara denna vy"
=20
-#: gitk:3817
+#: gitk:3825
 msgid "References (space separated list):"
 msgstr "Referenser (blankstegsavdelad lista):"
=20
-#: gitk:3818
+#: gitk:3826
 msgid "Branches & tags:"
 msgstr "Grenar & taggar:"
=20
-#: gitk:3819
+#: gitk:3827
 msgid "All refs"
 msgstr "Alla referenser"
=20
-#: gitk:3820
+#: gitk:3828
 msgid "All (local) branches"
 msgstr "Alla (lokala) grenar"
=20
-#: gitk:3821
+#: gitk:3829
 msgid "All tags"
 msgstr "Alla taggar"
=20
-#: gitk:3822
+#: gitk:3830
 msgid "All remote-tracking branches"
 msgstr "Alla fj=C3=A4rrsp=C3=A5rande grenar"
=20
-#: gitk:3823
+#: gitk:3831
 msgid "Commit Info (regular expressions):"
 msgstr "Incheckningsinfo (regulj=C3=A4ra uttryck):"
=20
-#: gitk:3824
+#: gitk:3832
 msgid "Author:"
 msgstr "F=C3=B6rfattare:"
=20
-#: gitk:3825
+#: gitk:3833
 msgid "Committer:"
 msgstr "Incheckare:"
=20
-#: gitk:3826
+#: gitk:3834
 msgid "Commit Message:"
 msgstr "Incheckningsmeddelande:"
=20
-#: gitk:3827
+#: gitk:3835
 msgid "Matches all Commit Info criteria"
 msgstr "Motsvarar alla kriterier f=C3=B6r incheckningsinfo"
=20
-#: gitk:3828
+#: gitk:3836
 msgid "Changes to Files:"
 msgstr "=C3=84ndringar av filer:"
=20
-#: gitk:3829
+#: gitk:3837
 msgid "Fixed String"
 msgstr "Fast str=C3=A4ng"
=20
-#: gitk:3830
+#: gitk:3838
 msgid "Regular Expression"
 msgstr "Regulj=C3=A4rt uttryck"
=20
-#: gitk:3831
+#: gitk:3839
 msgid "Search string:"
 msgstr "S=C3=B6kstr=C3=A4ng:"
=20
-#: gitk:3832
+#: gitk:3840
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
 "15:27:38\"):"
@@ -643,201 +648,201 @@ msgstr ""
 "Incheckingsdatum (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 1=
7, 2009 "
 "15:27:38\"):"
=20
-#: gitk:3833
+#: gitk:3841
 msgid "Since:"
 msgstr "Fr=C3=A5n:"
=20
-#: gitk:3834
+#: gitk:3842
 msgid "Until:"
 msgstr "Till:"
=20
-#: gitk:3835
+#: gitk:3843
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr "Begr=C3=A4nsa och/eller hoppa =C3=B6ver ett antal revisioner (=
positivt heltal):"
=20
-#: gitk:3836
+#: gitk:3844
 msgid "Number to show:"
 msgstr "Antal att visa:"
=20
-#: gitk:3837
+#: gitk:3845
 msgid "Number to skip:"
 msgstr "Antal att hoppa =C3=B6ver:"
=20
-#: gitk:3838
+#: gitk:3846
 msgid "Miscellaneous options:"
 msgstr "Diverse alternativ:"
=20
-#: gitk:3839
+#: gitk:3847
 msgid "Strictly sort by date"
 msgstr "Strikt datumsortering"
=20
-#: gitk:3840
+#: gitk:3848
 msgid "Mark branch sides"
 msgstr "Markera sidogrenar"
=20
-#: gitk:3841
+#: gitk:3849
 msgid "Limit to first parent"
 msgstr "Begr=C3=A4nsa till f=C3=B6rsta f=C3=B6r=C3=A4lder"
=20
-#: gitk:3842
+#: gitk:3850
 msgid "Simple history"
 msgstr "Enkel historik"
=20
-#: gitk:3843
+#: gitk:3851
 msgid "Additional arguments to git log:"
 msgstr "Ytterligare argument till git log:"
=20
-#: gitk:3844
+#: gitk:3852
 msgid "Enter files and directories to include, one per line:"
 msgstr "Ange filer och kataloger att ta med, en per rad:"
=20
-#: gitk:3845
+#: gitk:3853
 msgid "Command to generate more commits to include:"
 msgstr "Kommando f=C3=B6r att generera fler incheckningar att ta med:"
=20
-#: gitk:3967
+#: gitk:3977
 msgid "Gitk: edit view"
 msgstr "Gitk: redigera vy"
=20
-#: gitk:3975
+#: gitk:3985
 msgid "-- criteria for selecting revisions"
 msgstr " - kriterier f=C3=B6r val av revisioner"
=20
-#: gitk:3980
+#: gitk:3990
 msgid "View Name"
 msgstr "Namn p=C3=A5 vy"
=20
-#: gitk:4055
+#: gitk:4065
 msgid "Apply (F5)"
 msgstr "Anv=C3=A4nd (F5)"
=20
-#: gitk:4093
+#: gitk:4103
 msgid "Error in commit selection arguments:"
 msgstr "Fel i argument f=C3=B6r val av incheckningar:"
=20
-#: gitk:4146 gitk:4198 gitk:4646 gitk:4660 gitk:5921 gitk:11534 gitk:1=
1535
+#: gitk:4156 gitk:4208 gitk:4656 gitk:4670 gitk:5931 gitk:11551 gitk:1=
1552
 msgid "None"
 msgstr "Inget"
=20
-#: gitk:4594 gitk:6441 gitk:8287 gitk:8302
+#: gitk:4604 gitk:6451 gitk:8309 gitk:8324
 msgid "Date"
 msgstr "Datum"
=20
-#: gitk:4594 gitk:6441
+#: gitk:4604 gitk:6451
 msgid "CDate"
 msgstr "Skapat datum"
=20
-#: gitk:4743 gitk:4748
+#: gitk:4753 gitk:4758
 msgid "Descendant"
 msgstr "Avkomling"
=20
-#: gitk:4744
+#: gitk:4754
 msgid "Not descendant"
 msgstr "Inte avkomling"
=20
-#: gitk:4751 gitk:4756
+#: gitk:4761 gitk:4766
 msgid "Ancestor"
 msgstr "F=C3=B6rfader"
=20
-#: gitk:4752
+#: gitk:4762
 msgid "Not ancestor"
 msgstr "Inte f=C3=B6rfader"
=20
-#: gitk:5042
+#: gitk:5052
 msgid "Local changes checked in to index but not committed"
 msgstr "Lokala =C3=A4ndringar sparade i indexet men inte incheckade"
=20
-#: gitk:5078
+#: gitk:5088
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lokala =C3=A4ndringar, ej sparade i indexet"
=20
-#: gitk:6759
+#: gitk:6769
 msgid "many"
 msgstr "m=C3=A5nga"
=20
-#: gitk:6942
+#: gitk:6952
 msgid "Tags:"
 msgstr "Taggar:"
=20
-#: gitk:6959 gitk:6965 gitk:8280
+#: gitk:6969 gitk:6975 gitk:8302
 msgid "Parent"
 msgstr "F=C3=B6r=C3=A4lder"
=20
-#: gitk:6970
+#: gitk:6980
 msgid "Child"
 msgstr "Barn"
=20
-#: gitk:6979
+#: gitk:6989
 msgid "Branch"
 msgstr "Gren"
=20
-#: gitk:6982
+#: gitk:6992
 msgid "Follows"
 msgstr "F=C3=B6ljer"
=20
-#: gitk:6985
+#: gitk:6995
 msgid "Precedes"
 msgstr "F=C3=B6reg=C3=A5r"
=20
-#: gitk:7522
+#: gitk:7532
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Fel vid h=C3=A4mtning av diff: %s"
=20
-#: gitk:8108
+#: gitk:8130
 msgid "Goto:"
 msgstr "G=C3=A5 till:"
=20
-#: gitk:8129
+#: gitk:8151
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "F=C3=B6rkortat SHA1-id %s =C3=A4r tvetydigt"
=20
-#: gitk:8136
+#: gitk:8158
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Revisionen %s =C3=A4r inte k=C3=A4nd"
=20
-#: gitk:8146
+#: gitk:8168
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA-id:t %s =C3=A4r inte k=C3=A4nt"
=20
-#: gitk:8148
+#: gitk:8170
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Revisionen %s finns inte i den nuvarande vyn"
=20
-#: gitk:8290
+#: gitk:8312
 msgid "Children"
 msgstr "Barn"
=20
-#: gitk:8348
+#: gitk:8370
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "=C3=85terst=C3=A4ll grenen %s hit"
=20
-#: gitk:8350
+#: gitk:8372
 msgid "Detached head: can't reset"
 msgstr "Fr=C3=A5nkopplad head: kan inte =C3=A5terst=C3=A4lla"
=20
-#: gitk:8459 gitk:8465
+#: gitk:8481 gitk:8487
 msgid "Skipping merge commit "
 msgstr "Hoppar =C3=B6ver sammanslagningsincheckning "
=20
-#: gitk:8474 gitk:8479
+#: gitk:8496 gitk:8501
 msgid "Error getting patch ID for "
 msgstr "Fel vid h=C3=A4mtning av patch-id f=C3=B6r "
=20
-#: gitk:8475 gitk:8480
+#: gitk:8497 gitk:8502
 msgid " - stopping\n"
 msgstr " - stannar\n"
=20
-#: gitk:8485 gitk:8488 gitk:8496 gitk:8510 gitk:8519
+#: gitk:8507 gitk:8510 gitk:8518 gitk:8532 gitk:8541
 msgid "Commit "
 msgstr "Incheckning "
=20
-#: gitk:8489
+#: gitk:8511
 msgid ""
 " is the same patch as\n"
 "       "
@@ -845,7 +850,7 @@ msgstr ""
 " =C3=A4r samma patch som\n"
 "       "
=20
-#: gitk:8497
+#: gitk:8519
 msgid ""
 " differs from\n"
 "       "
@@ -853,139 +858,139 @@ msgstr ""
 " skiljer sig fr=C3=A5n\n"
 "       "
=20
-#: gitk:8499
+#: gitk:8521
 msgid ""
 "Diff of commits:\n"
 "\n"
-msgstr "Skillnad mellan incheckningar:\n"
+msgstr ""
+"Skillnad mellan incheckningar:\n"
 "\n"
-""
=20
-#: gitk:8511 gitk:8520
+#: gitk:8533 gitk:8542
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " har %s barn - stannar\n"
=20
-#: gitk:8539
+#: gitk:8561
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Fel vid skrivning av incheckning till fil: %s"
=20
-#: gitk:8545
+#: gitk:8567
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Fel vid j=C3=A4mf=C3=B6relse av incheckningar: %s"
=20
-#: gitk:8575
+#: gitk:8598
 msgid "Top"
 msgstr "Topp"
=20
-#: gitk:8576
+#: gitk:8599
 msgid "From"
 msgstr "Fr=C3=A5n"
=20
-#: gitk:8581
+#: gitk:8604
 msgid "To"
 msgstr "Till"
=20
-#: gitk:8605
+#: gitk:8628
 msgid "Generate patch"
 msgstr "Generera patch"
=20
-#: gitk:8607
+#: gitk:8630
 msgid "From:"
 msgstr "Fr=C3=A5n:"
=20
-#: gitk:8616
+#: gitk:8639
 msgid "To:"
 msgstr "Till:"
=20
-#: gitk:8625
+#: gitk:8648
 msgid "Reverse"
 msgstr "V=C3=A4nd"
=20
-#: gitk:8627 gitk:8822
+#: gitk:8650 gitk:8845
 msgid "Output file:"
 msgstr "Utdatafil:"
=20
-#: gitk:8633
+#: gitk:8656
 msgid "Generate"
 msgstr "Generera"
=20
-#: gitk:8671
+#: gitk:8694
 msgid "Error creating patch:"
 msgstr "Fel vid generering av patch:"
=20
-#: gitk:8694 gitk:8810 gitk:8867
+#: gitk:8717 gitk:8833 gitk:8890
 msgid "ID:"
 msgstr "Id:"
=20
-#: gitk:8703
+#: gitk:8726
 msgid "Tag name:"
 msgstr "Taggnamn:"
=20
-#: gitk:8706
+#: gitk:8729
 msgid "Tag message is optional"
 msgstr "Taggmeddelandet =C3=A4r valfritt"
=20
-#: gitk:8708
+#: gitk:8731
 msgid "Tag message:"
 msgstr "Taggmeddelande:"
=20
-#: gitk:8712 gitk:8876
+#: gitk:8735 gitk:8899
 msgid "Create"
 msgstr "Skapa"
=20
-#: gitk:8730
+#: gitk:8753
 msgid "No tag name specified"
 msgstr "Inget taggnamn angavs"
=20
-#: gitk:8734
+#: gitk:8757
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Taggen \"%s\" finns redan"
=20
-#: gitk:8744
+#: gitk:8767
 msgid "Error creating tag:"
 msgstr "Fel vid skapande av tagg:"
=20
-#: gitk:8819
+#: gitk:8842
 msgid "Command:"
 msgstr "Kommando:"
=20
-#: gitk:8827
+#: gitk:8850
 msgid "Write"
 msgstr "Skriv"
=20
-#: gitk:8845
+#: gitk:8868
 msgid "Error writing commit:"
 msgstr "Fel vid skrivning av incheckning:"
=20
-#: gitk:8872
+#: gitk:8895
 msgid "Name:"
 msgstr "Namn:"
=20
-#: gitk:8895
+#: gitk:8918
 msgid "Please specify a name for the new branch"
 msgstr "Ange ett namn f=C3=B6r den nya grenen"
=20
-#: gitk:8900
+#: gitk:8923
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Grenen \"%s\" finns redan. Skriva =C3=B6ver?"
=20
-#: gitk:8966
+#: gitk:8989
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "Incheckningen %s finns redan p=C3=A5 grenen %s -- skall den verkligen=
 appliceras "
 "p=C3=A5 nytt?"
=20
-#: gitk:8971
+#: gitk:8994
 msgid "Cherry-picking"
 msgstr "Plockar"
=20
-#: gitk:8980
+#: gitk:9003
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -995,7 +1000,7 @@ msgstr ""
 "Checka in, =C3=A5terst=C3=A4ll eller spara undan (stash) dina =C3=A4n=
dringar och f=C3=B6rs=C3=B6k "
 "igen."
=20
-#: gitk:8986
+#: gitk:9009
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1003,32 +1008,32 @@ msgstr ""
 "Cherry-pick misslyckades p=C3=A5 grund av en sammanslagningskonflikt.=
\n"
 "Vill du k=C3=B6ra git citool f=C3=B6r att l=C3=B6sa den?"
=20
-#: gitk:9002
+#: gitk:9025
 msgid "No changes committed"
 msgstr "Inga =C3=A4ndringar incheckade"
=20
-#: gitk:9028
+#: gitk:9051
 msgid "Confirm reset"
 msgstr "Bekr=C3=A4fta =C3=A5terst=C3=A4llning"
=20
-#: gitk:9030
+#: gitk:9053
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "=C3=85terst=C3=A4lla grenen %s till %s?"
=20
-#: gitk:9032
+#: gitk:9055
 msgid "Reset type:"
 msgstr "Typ av =C3=A5terst=C3=A4llning:"
=20
-#: gitk:9035
+#: gitk:9058
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Mjuk: R=C3=B6r inte utcheckning och index"
=20
-#: gitk:9038
+#: gitk:9061
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Blandad: R=C3=B6r inte utcheckning, =C3=A5terst=C3=A4ll index"
=20
-#: gitk:9041
+#: gitk:9064
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -1036,19 +1041,19 @@ msgstr ""
 "H=C3=A5rd: =C3=85terst=C3=A4ll utcheckning och index\n"
 "(f=C3=B6rkastar ALLA lokala =C3=A4ndringar)"
=20
-#: gitk:9058
+#: gitk:9081
 msgid "Resetting"
 msgstr "=C3=85terst=C3=A4ller"
=20
-#: gitk:9118
+#: gitk:9141
 msgid "Checking out"
 msgstr "Checkar ut"
=20
-#: gitk:9171
+#: gitk:9194
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Kan inte ta bort den just nu utcheckade grenen"
=20
-#: gitk:9177
+#: gitk:9200
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1057,16 +1062,16 @@ msgstr ""
 "Incheckningarna p=C3=A5 grenen %s existerar inte p=C3=A5 n=C3=A5gon a=
nnan gren.\n"
 "Vill du verkligen ta bort grenen %s?"
=20
-#: gitk:9208
+#: gitk:9231
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Taggar och huvuden: %s"
=20
-#: gitk:9223
+#: gitk:9246
 msgid "Filter"
 msgstr "Filter"
=20
-#: gitk:9518
+#: gitk:9541
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
@@ -1074,203 +1079,203 @@ msgstr ""
 "Fel vid l=C3=A4sning av information om incheckningstopologi; informat=
ion om "
 "grenar och f=C3=B6reg=C3=A5ende/senare taggar kommer inte vara komple=
tt."
=20
-#: gitk:10504
+#: gitk:10527
 msgid "Tag"
 msgstr "Tagg"
=20
-#: gitk:10504
+#: gitk:10527
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:10554
+#: gitk:10576
 msgid "Gitk font chooser"
 msgstr "Teckensnittsv=C3=A4ljare f=C3=B6r Gitk"
=20
-#: gitk:10571
+#: gitk:10593
 msgid "B"
 msgstr "F"
=20
-#: gitk:10574
+#: gitk:10596
 msgid "I"
 msgstr "K"
=20
-#: gitk:10692
+#: gitk:10714
 msgid "Gitk preferences"
 msgstr "Inst=C3=A4llningar f=C3=B6r Gitk"
=20
-#: gitk:10694
+#: gitk:10716
 msgid "Commit list display options"
 msgstr "Alternativ f=C3=B6r incheckningslistvy"
=20
-#: gitk:10697
+#: gitk:10719
 msgid "Maximum graph width (lines)"
 msgstr "Maximal grafbredd (rader)"
=20
-#: gitk:10700
+#: gitk:10722
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maximal grafbredd (% av ruta)"
=20
-#: gitk:10703
+#: gitk:10725
 msgid "Show local changes"
 msgstr "Visa lokala =C3=A4ndringar"
=20
-#: gitk:10706
+#: gitk:10728
 msgid "Auto-select SHA1"
 msgstr "V=C3=A4lj SHA1 automatiskt"
=20
-#: gitk:10709
+#: gitk:10731
 msgid "Hide remote refs"
 msgstr "D=C3=B6lj fj=C3=A4rr-referenser"
=20
-#: gitk:10713
+#: gitk:10735
 msgid "Diff display options"
 msgstr "Alternativ f=C3=B6r diffvy"
=20
-#: gitk:10715
+#: gitk:10737
 msgid "Tab spacing"
 msgstr "Blanksteg f=C3=B6r tabulatortecken"
=20
-#: gitk:10718
+#: gitk:10740
 msgid "Display nearby tags"
 msgstr "Visa n=C3=A4rliggande taggar"
=20
-#: gitk:10721
+#: gitk:10743
 msgid "Limit diffs to listed paths"
 msgstr "Begr=C3=A4nsa diff till listade s=C3=B6kv=C3=A4gar"
=20
-#: gitk:10724
+#: gitk:10746
 msgid "Support per-file encodings"
 msgstr "St=C3=B6d f=C3=B6r filspecifika teckenkodningar"
=20
-#: gitk:10730 gitk:10819
+#: gitk:10752 gitk:10832
 msgid "External diff tool"
 msgstr "Externt diff-verktyg"
=20
-#: gitk:10731
+#: gitk:10753
 msgid "Choose..."
 msgstr "V=C3=A4lj..."
=20
-#: gitk:10736
+#: gitk:10758
 msgid "General options"
 msgstr "Allm=C3=A4nna inst=C3=A4llningar"
=20
-#: gitk:10739
+#: gitk:10761
 msgid "Use themed widgets"
 msgstr "Anv=C3=A4nd tema p=C3=A5 f=C3=B6nsterelement"
=20
-#: gitk:10741
+#: gitk:10763
 msgid "(change requires restart)"
 msgstr "(=C3=A4ndringen kr=C3=A4ver omstart)"
=20
-#: gitk:10743
+#: gitk:10765
 msgid "(currently unavailable)"
 msgstr "(f=C3=B6r n=C3=A4rvarande inte tillg=C3=A4ngligt)"
=20
-#: gitk:10747
+#: gitk:10769
 msgid "Colors: press to choose"
 msgstr "F=C3=A4rger: tryck f=C3=B6r att v=C3=A4lja"
=20
-#: gitk:10750
+#: gitk:10772
 msgid "Interface"
 msgstr "Gr=C3=A4nssnitt"
=20
-#: gitk:10751
+#: gitk:10773
 msgid "interface"
 msgstr "gr=C3=A4nssnitt"
=20
-#: gitk:10754
+#: gitk:10776
 msgid "Background"
 msgstr "Bakgrund"
=20
-#: gitk:10755 gitk:10785
+#: gitk:10777 gitk:10807
 msgid "background"
 msgstr "bakgrund"
=20
-#: gitk:10758
+#: gitk:10780
 msgid "Foreground"
 msgstr "F=C3=B6rgrund"
=20
-#: gitk:10759
+#: gitk:10781
 msgid "foreground"
 msgstr "f=C3=B6rgrund"
=20
-#: gitk:10762
+#: gitk:10784
 msgid "Diff: old lines"
 msgstr "Diff: gamla rader"
=20
-#: gitk:10763
+#: gitk:10785
 msgid "diff old lines"
 msgstr "diff gamla rader"
=20
-#: gitk:10767
+#: gitk:10789
 msgid "Diff: new lines"
 msgstr "Diff: nya rader"
=20
-#: gitk:10768
+#: gitk:10790
 msgid "diff new lines"
 msgstr "diff nya rader"
=20
-#: gitk:10772
+#: gitk:10794
 msgid "Diff: hunk header"
 msgstr "Diff: delhuvud"
=20
-#: gitk:10774
+#: gitk:10796
 msgid "diff hunk header"
 msgstr "diff delhuvud"
=20
-#: gitk:10778
+#: gitk:10800
 msgid "Marked line bg"
 msgstr "Markerad rad bakgrund"
=20
-#: gitk:10780
+#: gitk:10802
 msgid "marked line background"
 msgstr "markerad rad bakgrund"
=20
-#: gitk:10784
+#: gitk:10806
 msgid "Select bg"
 msgstr "Markerad bakgrund"
=20
-#: gitk:10788
+#: gitk:10810
 msgid "Fonts: press to choose"
 msgstr "Teckensnitt: tryck f=C3=B6r att v=C3=A4lja"
=20
-#: gitk:10790
+#: gitk:10812
 msgid "Main font"
 msgstr "Huvudteckensnitt"
=20
-#: gitk:10791
+#: gitk:10813
 msgid "Diff display font"
 msgstr "Teckensnitt f=C3=B6r diffvisning"
=20
-#: gitk:10792
+#: gitk:10814
 msgid "User interface font"
 msgstr "Teckensnitt f=C3=B6r anv=C3=A4ndargr=C3=A4nssnitt"
=20
-#: gitk:10829
+#: gitk:10842
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: v=C3=A4lj f=C3=A4rg f=C3=B6r %s"
=20
-#: gitk:11433
+#: gitk:11445
 msgid "Cannot find a git repository here."
-msgstr "Hittar inget gitk-arkiv h=C3=A4r."
+msgstr "Hittar inget git-arkiv h=C3=A4r."
=20
-#: gitk:11437
+#: gitk:11449
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Hittar inte git-katalogen \"%s\"."
=20
-#: gitk:11484
+#: gitk:11496
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Tvetydigt argument \"%s\": b=C3=A5de revision och filnamn"
=20
-#: gitk:11496
+#: gitk:11508
 msgid "Bad arguments to gitk:"
 msgstr "Felaktiga argument till gitk:"
=20
-#: gitk:11587
+#: gitk:11604
 msgid "Command line"
 msgstr "Kommandorad"
=20
--=20
1.7.1
