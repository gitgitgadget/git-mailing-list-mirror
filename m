From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] Update gitk-git Hungarian translation
Date: Mon, 14 Dec 2009 14:12:25 +0100
Message-ID: <24021cc4313329bf6b1add67015880832ed4c191.1260796071.git.vmiklos@frugalware.org>
References: <cover.1260796071.git.vmiklos@frugalware.org>
 <82a93048a7695369c5fd7fead1c47c52c1650177.1260796071.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Laszlo Papp <djszapi2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 14:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKAjF-0005Ll-QK
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 14:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbZLNNMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 08:12:31 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZLNNMa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 08:12:30 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49321 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZLNNM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 08:12:26 -0500
Received: from vmobile.example.net (dsl5401C437.pool.t-online.hu [84.1.196.55])
	by yugo.frugalware.org (Postfix) with ESMTPA id 164472CB42D;
	Mon, 14 Dec 2009 14:12:23 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 74212182034; Mon, 14 Dec 2009 14:12:26 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <82a93048a7695369c5fd7fead1c47c52c1650177.1260796071.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1260796071.git.vmiklos@frugalware.org>
References: <cover.1260796071.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135210>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 gitk-git/po/hu.po |  770 +++++++++++++++++++++++++++++++--------------=
--------
 1 files changed, 458 insertions(+), 312 deletions(-)

diff --git a/gitk-git/po/hu.po b/gitk-git/po/hu.po
index 7a4bdca..1df212e 100755
--- a/gitk-git/po/hu.po
+++ b/gitk-git/po/hu.po
@@ -8,751 +8,841 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2009-05-12 21:55+0200\n"
-"PO-Revision-Date: 2009-12-14 13:28+0100\n"
+"POT-Creation-Date: 2009-12-14 13:33+0100\n"
+"PO-Revision-Date: 2009-12-14 14:04+0100\n"
 "Last-Translator: Laszlo Papp <djszapi@archlinux.us>\n"
 "Language-Team: Hungarian\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: gitk:113
+#: gitk:115
 msgid "Couldn't get list of unmerged files:"
 msgstr "Nem siker=C3=BClt let=C3=B6lteni az unmerged f=C3=A1jl list=C3=
=A1t:"
=20
-#: gitk:268
+#: gitk:271
 msgid "Error parsing revisions:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt =C3=A9rtelmez=C3=A9s k=C3=B6zben:"
=20
-#: gitk:323
+#: gitk:326
 msgid "Error executing --argscmd command:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a v=C3=A9grehajt=C3=A1skor --argscmd pa=
rancs:"
=20
-#: gitk:336
+#: gitk:339
 msgid "No files selected: --merge specified but no files are unmerged.=
"
-msgstr "Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadve, de egyetl=
en f=C3=A1jl sem unmerged."
+msgstr ""
+"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadve, de egyetlen f=C3=
=A1jl sem unmerged."
=20
-#: gitk:339
+#: gitk:342
 msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
 msgstr ""
-"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a f=C3=A1jlon bel=C3=BCl "
-"limit."
+"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a "
+"f=C3=A1jlon bel=C3=BCl limit."
=20
-#: gitk:361 gitk:508
+#: gitk:364 gitk:511
 msgid "Error executing git log:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a git log v=C3=A9grehajt=C3=A1sa k=C3=B6=
zben:"
=20
-#: gitk:379 gitk:524
+#: gitk:382 gitk:527
 msgid "Reading"
 msgstr "Olvas=C3=A1s"
=20
-#: gitk:439 gitk:4061
+#: gitk:442 gitk:4258
 msgid "Reading commits..."
 msgstr "Commitok olvas=C3=A1sa ..."
=20
-#: gitk:442 gitk:1560 gitk:4064
+#: gitk:445 gitk:1575 gitk:4261
 msgid "No commits selected"
 msgstr "Nincsen commit kiv=C3=A1lasztva"
=20
-#: gitk:1436
+#: gitk:1451
 msgid "Can't parse git log output:"
 msgstr "Nem lehet =C3=A9rtelmezni a git log kimenet=C3=A9t:"
=20
-#: gitk:1656
+#: gitk:1671
 msgid "No commit information available"
 msgstr "Nincsen el=C3=A9rhet=C5=91 commit inform=C3=A1ci=C3=B3"
=20
-#: gitk:1791 gitk:1815 gitk:3854 gitk:8714 gitk:10250 gitk:10422
+#: gitk:1813
+msgid "mc"
+msgstr "mc"
+
+#: gitk:1848 gitk:4051 gitk:9029 gitk:10570 gitk:10789
 msgid "OK"
 msgstr "OK"
=20
-#: gitk:1817 gitk:3856 gitk:8311 gitk:8385 gitk:8495 gitk:8544 gitk:87=
16
-#: gitk:10251 gitk:10423
+#: gitk:1850 gitk:4053 gitk:8629 gitk:8703 gitk:8813 gitk:8862 gitk:90=
31
+#: gitk:10571 gitk:10790
 msgid "Cancel"
 msgstr "Visszavon=C3=A1s"
=20
-#: gitk:1917
+#: gitk:1972
 msgid "Update"
 msgstr "Frissit=C3=A9s"
=20
-#: gitk:1918
+#: gitk:1973
 msgid "Reload"
 msgstr "=C3=9Ajrat=C3=B6lt=C3=A9s"
=20
-#: gitk:1919
+#: gitk:1974
 msgid "Reread references"
 msgstr "Referenci=C3=A1k =C3=BAjraolvas=C3=A1sa"
=20
-#: gitk:1920
+#: gitk:1975
 msgid "List references"
 msgstr "Referenci=C3=A1k list=C3=A1z=C3=A1sa"
=20
-#: gitk:1922
+#: gitk:1977
 msgid "Start git gui"
 msgstr "Git gui ind=C3=ADt=C3=A1sa"
=20
-#: gitk:1924
+#: gitk:1979
 msgid "Quit"
 msgstr "Kil=C3=A9p=C3=A9s"
=20
-#: gitk:1916
+#: gitk:1971
 msgid "File"
 msgstr "F=C3=A1jl"
=20
-#: gitk:1928
+#: gitk:1983
 msgid "Preferences"
 msgstr "Be=C3=A1ll=C3=ADt=C3=A1sok"
=20
-#: gitk:1927
+#: gitk:1982
 msgid "Edit"
 msgstr "Szerkeszt=C3=A9s"
=20
-#: gitk:1932
+#: gitk:1987
 msgid "New view..."
 msgstr "=C3=9Aj n=C3=A9zet ..."
=20
-#: gitk:1933
+#: gitk:1988
 msgid "Edit view..."
 msgstr "N=C3=A9zet szerkeszt=C3=A9se ..."
=20
-#: gitk:1934
+#: gitk:1989
 msgid "Delete view"
 msgstr "N=C3=A9zet t=C3=B6rl=C3=A9se"
=20
-#: gitk:1936
+#: gitk:1991
 msgid "All files"
 msgstr "Minden f=C3=A1jl"
=20
-#: gitk:1931 gitk:3666
+#: gitk:1986 gitk:3805
 msgid "View"
 msgstr "N=C3=A9zet"
=20
-#: gitk:1941 gitk:1951 gitk:2650
+#: gitk:1996 gitk:2006 gitk:2777
 msgid "About gitk"
 msgstr "Gitk n=C3=A9vjegy"
=20
-#: gitk:1942 gitk:1956
+#: gitk:1997 gitk:2011
 msgid "Key bindings"
 msgstr "Billenty=C5=B1kombin=C3=A1ci=C3=B3"
=20
-#: gitk:1940 gitk:1955
+#: gitk:1995 gitk:2010
 msgid "Help"
 msgstr "Seg=C3=ADts=C3=A9g"
=20
-#: gitk:2016
+#: gitk:2088
 msgid "SHA1 ID: "
 msgstr "SHA1 ID: "
=20
-#: gitk:2047
+#: gitk:2119
 msgid "Row"
 msgstr "Sor"
=20
-#: gitk:2078
+#: gitk:2157
 msgid "Find"
 msgstr "Keres=C3=A9s"
=20
-#: gitk:2079
+#: gitk:2158
 msgid "next"
 msgstr "k=C3=B6vetkez=C5=91"
=20
-#: gitk:2080
+#: gitk:2159
 msgid "prev"
 msgstr "el=C5=91z=C5=91"
=20
-#: gitk:2081
+#: gitk:2160
 msgid "commit"
 msgstr "commit"
=20
-#: gitk:2084 gitk:2086 gitk:4222 gitk:4245 gitk:4269 gitk:6210 gitk:62=
82
-#: gitk:6366
+#: gitk:2163 gitk:2165 gitk:4419 gitk:4442 gitk:4466 gitk:6407 gitk:64=
79
+#: gitk:6563
 msgid "containing:"
 msgstr "tartalmaz=C3=A1s:"
=20
-#: gitk:2087 gitk:3158 gitk:3163 gitk:4297
+#: gitk:2166 gitk:3287 gitk:3292 gitk:4494
 msgid "touching paths:"
 msgstr "=C3=A9rintend=C5=91 =C3=BAtvonalak:"
=20
-#: gitk:2088 gitk:4302
+#: gitk:2167 gitk:4499
 msgid "adding/removing string:"
 msgstr "string hozz=C3=A1ad=C3=A1sa/t=C3=B6rl=C3=A9se:"
=20
-#: gitk:2097 gitk:2099
+#: gitk:2176 gitk:2178
 msgid "Exact"
 msgstr "Pontos"
=20
-#: gitk:2099 gitk:4377 gitk:6178
+#: gitk:2178 gitk:4574 gitk:6375
 msgid "IgnCase"
 msgstr "Kis/nagy bet=C5=B1 nem sz=C3=A1m=C3=ADt"
=20
-#: gitk:2099 gitk:4271 gitk:4375 gitk:6174
+#: gitk:2178 gitk:4468 gitk:4572 gitk:6371
 msgid "Regexp"
 msgstr "Regexp"
=20
-#: gitk:2101 gitk:2102 gitk:4396 gitk:4426 gitk:4433 gitk:6302 gitk:63=
70
+#: gitk:2180 gitk:2181 gitk:4593 gitk:4623 gitk:4630 gitk:6499 gitk:65=
67
 msgid "All fields"
 msgstr "Minden mez=C5=91"
=20
-#: gitk:2102 gitk:4394 gitk:4426 gitk:6241
+#: gitk:2181 gitk:4591 gitk:4623 gitk:6438
 msgid "Headline"
 msgstr "F=C5=91c=C3=ADm"
=20
-#: gitk:2103 gitk:4394 gitk:6241 gitk:6370 gitk:6804
+#: gitk:2182 gitk:4591 gitk:6438 gitk:6567 gitk:7000
 msgid "Comments"
 msgstr "Megjegyz=C3=A9sek"
=20
-#: gitk:2103 gitk:4394 gitk:4398 gitk:4433 gitk:6241 gitk:6739 gitk:79=
91
-#: gitk:8006
+#: gitk:2182 gitk:4591 gitk:4595 gitk:4630 gitk:6438 gitk:6935 gitk:82=
80
+#: gitk:8295
 msgid "Author"
 msgstr "Szerz=C5=91"
=20
-#: gitk:2103 gitk:4394 gitk:6241 gitk:6741
+#: gitk:2182 gitk:4591 gitk:6438 gitk:6937
 msgid "Committer"
 msgstr "Commitol=C3=B3"
=20
-#: gitk:2132
+#: gitk:2213
 msgid "Search"
 msgstr "Keres=C3=A9s"
=20
-#: gitk:2139
+#: gitk:2221
 msgid "Diff"
 msgstr "Diff"
=20
-#: gitk:2141
+#: gitk:2223
 msgid "Old version"
 msgstr "R=C3=A9gi verzi=C3=B3"
=20
-#: gitk:2143
+#: gitk:2225
 msgid "New version"
 msgstr "=C3=9Aj verzi=C3=B3"
=20
-#: gitk:2145
+#: gitk:2227
 msgid "Lines of context"
 msgstr "Tartalmi sorok"
=20
-#: gitk:2155
+#: gitk:2237
 msgid "Ignore space change"
 msgstr "Space v=C3=A1lt=C3=A1s mell=C5=91z=C3=A9se"
=20
-#: gitk:2213
+#: gitk:2296
 msgid "Patch"
 msgstr "Patch"
=20
-#: gitk:2215
+#: gitk:2298
 msgid "Tree"
 msgstr "Tree"
=20
-#: gitk:2359 gitk:2376
+#: gitk:2453 gitk:2470
 msgid "Diff this -> selected"
 msgstr "Diff ezeket -> kiv=C3=A1lasztott"
=20
-#: gitk:2360 gitk:2377
+#: gitk:2454 gitk:2471
 msgid "Diff selected -> this"
 msgstr "Diff kiv=C3=A1lasztottakat -> ezt"
=20
-#: gitk:2361 gitk:2378
+#: gitk:2455 gitk:2472
 msgid "Make patch"
 msgstr "Patch k=C3=A9sz=C3=ADt=C3=A9se"
=20
-#: gitk:2362 gitk:8369
+#: gitk:2456 gitk:8687
 msgid "Create tag"
 msgstr "Tag k=C3=A9sz=C3=ADt=C3=A9se"
=20
-#: gitk:2363 gitk:8475
+#: gitk:2457 gitk:8793
 msgid "Write commit to file"
 msgstr "Commit f=C3=A1ljba =C3=ADr=C3=A1sa"
=20
-#: gitk:2364 gitk:8532
+#: gitk:2458 gitk:8850
 msgid "Create new branch"
 msgstr "=C3=9Aj branch k=C3=A9sz=C3=ADt=C3=A9se"
=20
-#: gitk:2365
+#: gitk:2459
 msgid "Cherry-pick this commit"
 msgstr "Cherry-pick erre a commitra"
=20
-#: gitk:2366
+#: gitk:2460
 msgid "Reset HEAD branch to here"
 msgstr "HEAD branch =C3=BAjraind=C3=ADt=C3=A1sa ide"
=20
-#: gitk:2367
+#: gitk:2461
 msgid "Mark this commit"
 msgstr "Ezen commit megjel=C3=B6l=C3=A9se"
=20
-#: gitk:2368
+#: gitk:2462
 msgid "Return to mark"
 msgstr "Visszat=C3=A9r=C3=A9s a megjel=C3=B6l=C3=A9shez"
=20
-#: gitk:2369
+#: gitk:2463
 msgid "Find descendant of this and mark"
 msgstr "Tal=C3=A1ld meg ezen ut=C3=B3dokat =C3=A9s jel=C3=B6ld meg"
=20
-#: gitk:2370
+#: gitk:2464
 msgid "Compare with marked commit"
 msgstr "=C3=96sszehasonl=C3=ADt=C3=A1s a megjel=C3=B6lt commit-tal"
=20
-#: gitk:2384
+#: gitk:2478
 msgid "Check out this branch"
 msgstr "Check out ezt a branchot"
=20
-#: gitk:2385
+#: gitk:2479
 msgid "Remove this branch"
 msgstr "T=C3=B6r=C3=B6ld ezt a branch-ot"
=20
-#: gitk:2392
+#: gitk:2486
 msgid "Highlight this too"
 msgstr "Emeld ki ezt is"
=20
-#: gitk:2393
+#: gitk:2487
 msgid "Highlight this only"
 msgstr "Csak ezt emeld ki"
=20
-#: gitk:2394
+#: gitk:2488
 msgid "External diff"
 msgstr "K=C3=BCls=C5=91 diff"
=20
-#: gitk:2395
+#: gitk:2489
 msgid "Blame parent commit"
 msgstr "Blame sz=C3=BCl=C5=91 kommitra"
=20
-#: gitk:2402
+#: gitk:2496
 msgid "Show origin of this line"
 msgstr "Mutasd meg ennek a sornak az eredet=C3=A9t"
=20
-#: gitk:2403
+#: gitk:2497
 msgid "Run git gui blame on this line"
 msgstr "Futtasd a git gui blame-t ezen a soron"
=20
-#: gitk:2652
+#: gitk:2779
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"Copyright =C2=A99 2005-2009 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public Licens=
e"
 msgstr ""
 "\n"
 "Gitk - commit n=C3=A9zeget=C5=91 a githez\n"
 "\n"
-"Szerz=C5=91i jog =C2=A9 2005-2008 Paul Mackerras\n"
+"Szerz=C5=91i jog =C2=A99 2005-2009 Paul Mackerras\n"
 "\n"
-"Haszn=C3=A1ld =C3=A9s terjeszd a GNU General Public License felt=C3=A9=
telei mellett "
-"Licensz"
+"Haszn=C3=A1ld =C3=A9s terjeszd a GNU General Public License felt=C3=A9=
telei mellett"
=20
-#: gitk:2660 gitk:2722 gitk:8897
+#: gitk:2787 gitk:2851 gitk:9215
 msgid "Close"
 msgstr "Bez=C3=A1r=C3=A1s"
=20
-#: gitk:2679
+#: gitk:2808
 msgid "Gitk key bindings"
 msgstr "Gitk-billenty=C5=B1 hozz=C3=A1rendel=C3=A9s"
=20
-#: gitk:2682
+#: gitk:2811
 msgid "Gitk key bindings:"
 msgstr "Gitk-billenty=C5=B1 hozza=C3=A1rendel=C3=A9s:"
=20
-#: gitk:2684
+#: gitk:2813
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tKil=C3=A9p=C3=A9s"
=20
-#: gitk:2685
+#: gitk:2814
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Pos1>\t\tEls=C5=91 commithoz"
=20
-#: gitk:2686
+#: gitk:2815
 msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tUtols=C3=B3 commithoz"
=20
-#: gitk:2687
+#: gitk:2816
 msgid "<Up>, p, i\tMove up one commit"
 msgstr "<Hoch>, p, i\tEgy committal feljebb"
=20
-#: gitk:2688
+#: gitk:2817
 msgid "<Down>, n, k\tMove down one commit"
 msgstr "<Runter>, n, k\tEgy committal lejjebb"
=20
-#: gitk:2689
+#: gitk:2818
 msgid "<Left>, z, j\tGo back in history list"
 msgstr "<Links>, z, j\tVissza a history list=C3=A1ba"
=20
-#: gitk:2690
+#: gitk:2819
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Rechts>, x, l\tEl=C5=91re a history list=C3=A1ba"
=20
-#: gitk:2691
+#: gitk:2820
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<BildHoch>\tEgy lappal feljebb a commit list=C3=A1ba"
=20
-#: gitk:2692
+#: gitk:2821
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<BildRunter>\tEgy lappal lejjebb a commit list=C3=A1ba"
=20
-#: gitk:2693
+#: gitk:2822
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Pos1>\tG=C3=B6rget=C3=A9s a commit lista tetej=C3=A9hez"
=20
-#: gitk:2694
+#: gitk:2823
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-Ende>\tG=C3=B6rget=C3=A9s a commit lista alj=C3=A1hoz"
=20
-#: gitk:2695
+#: gitk:2824
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Hoch>\tEgy sorral feljebb g=C3=B6rget=C3=A9s a commit list=
=C3=A1ban"
=20
-#: gitk:2696
+#: gitk:2825
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Runter>\tEgy sorral lejjebb g=C3=B6rget=C3=A9s a commit li=
st=C3=A1ban"
=20
-#: gitk:2697
+#: gitk:2826
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-BildHoch>\tEgy lappal feljebb g=C3=B6rget=C3=A9s a commit =
list=C3=A1ban"
=20
-#: gitk:2698
+#: gitk:2827
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-BildRunter>\tEgy sorral lejjebb g=C3=B6rget=C3=A9s a commi=
t list=C3=A1ban"
=20
-#: gitk:2699
+#: gitk:2828
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Umschalt-Hoch>\tKeres=C3=A9s visszafele (felfele, utols=C3=B3=
 commitok)"
=20
-#: gitk:2700
+#: gitk:2829
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Umschalt-Runter>\tKeres=C3=A9s el=C5=91re (lefel=C3=A9; kor=C3=
=A1bbi commitok)"
=20
-#: gitk:2701
+#: gitk:2830
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Entf>, b\t\tEgy lappal feljebb g=C3=B6rget=C3=A9s a diff n=C3=
=A9zetben"
=20
-#: gitk:2702
+#: gitk:2831
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<L=C3=B6schtaste>\tEgy lappal feljebb g=C3=B6rget=C3=A9s a dif=
f n=C3=A9zetben"
=20
-#: gitk:2703
+#: gitk:2832
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\tEgy lappal lejjebb g=C3=B6rget=C3=A9s a diff n=C3=
=A9zetben"
=20
-#: gitk:2704
+#: gitk:2833
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\t18 sorral felfel=C3=A9 g=C3=B6rget=C3=A9s diff n=C3=A9zet=
ben"
=20
-#: gitk:2705
+#: gitk:2834
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\t18 sorral lejjebb g=C3=B6rget=C3=A9s a diff n=C3=A9zetben=
"
=20
-#: gitk:2706
+#: gitk:2835
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tKeres=C3=A9s"
=20
-#: gitk:2707
+#: gitk:2836
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tK=C3=B6vetkez=C5=91 tal=C3=A1lathoz"
=20
-#: gitk:2708
+#: gitk:2837
 msgid "<Return>\tMove to next find hit"
 msgstr "<Eingabetaste>\tK=C3=B6vetkez=C5=91 tal=C3=A1lathoz"
=20
-#: gitk:2709
+#: gitk:2838
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tL=C3=A9pj a keres=C3=A9si mez=C5=91re"
=20
-#: gitk:2710
+#: gitk:2839
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tEl=C5=91z=C5=91 tal=C3=A1lathoz"
=20
-#: gitk:2711
+#: gitk:2840
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tK=C3=B6vetkez=C5=91 f=C3=A1jlra g=C3=B6rget=C3=A9s diff n=
=C3=A9zetben"
=20
-#: gitk:2712
+#: gitk:2841
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tK=C3=B6vetkez=C5=91 tal=C3=A1latra keres=C3=A9s diff=
 n=C3=A9zetben"
=20
-#: gitk:2713
+#: gitk:2842
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tEl=C5=91z=C5=91 tal=C3=A1latra keres=C3=A9s diff n=C3=
=A9zetben"
=20
-#: gitk:2714
+#: gitk:2843
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-Nummerblock-Plus>\tBet=C5=B1m=C3=A9ret n=C3=B6vel=C3=A9se"
=20
-#: gitk:2715
+#: gitk:2844
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-Plus>\tBet=C5=B1m=C3=A9ret n=C3=B6vel=C3=A9se"
=20
-#: gitk:2716
+#: gitk:2845
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-Nummernblock-Minus> Bet=C5=B1m=C3=A9ret cs=C3=B6kkent=C3=A9=
se"
=20
-#: gitk:2717
+#: gitk:2846
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-Minus>\tBet=C5=B1m=C3=A9ret cs=C3=B6kkent=C3=A9se"
=20
-#: gitk:2718
+#: gitk:2847
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tFriss=C3=ADt=C3=A9s"
=20
-#: gitk:3173
-#, tcl-format
-msgid "Error getting \"%s\" from %s:"
-msgstr "Hiba t=C3=B6rt=C3=A9nt \"%s\" let=C3=B6lt=C3=A9se k=C3=B6zben =
%s-r=C5=91l:"
-
-#: gitk:3230 gitk:3239
+#: gitk:3302 gitk:3311
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt az ideiglenes k=C3=B6nyvt=C3=A1r l=C3=A9=
trehoz=C3=A1sa k=C3=B6zben %s:"
=20
-#: gitk:3251
+#: gitk:3324
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Hiba t=C3=B6rt=C3=A9nt \"%s\" let=C3=B6lt=C3=A9se k=C3=B6zben =
%s-r=C5=91l:"
+
+#: gitk:3387
 msgid "command failed:"
 msgstr "parancs hiba:"
=20
-#: gitk:3397
+#: gitk:3536
 msgid "No such commit"
 msgstr "Nincs ilyen commit"
=20
-#: gitk:3411
+#: gitk:3550
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: parancs hiba:"
=20
-#: gitk:3442
+#: gitk:3581
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Nem siker=C3=BClt a Merge head olvas=C3=A1sa: %s"
=20
-#: gitk:3450
+#: gitk:3589
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Hiba t=C3=B6rt=C3=A9nt az index olvas=C3=A1sa k=C3=B6zben: %s"
=20
-#: gitk:3475
+#: gitk:3614
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "Nem siker=C3=BClt a git blame ind=C3=ADt=C3=A1sa: %s"
=20
-#: gitk:3478 gitk:6209
+#: gitk:3617 gitk:6406
 msgid "Searching"
 msgstr "Keres=C3=A9s"
=20
-#: gitk:3510
+#: gitk:3649
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a git blame futtat=C3=A1sa k=C3=B6zben:=
 %s"
=20
-#: gitk:3538
+#: gitk:3677
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr ""
 "A %s commitb=C3=B3l sz=C3=A1rmazik az a sor, amelyik nem tal=C3=A1lha=
t=C3=B3 ebben a n=C3=A9zetben"
=20
-#: gitk:3552
+#: gitk:3691
 msgid "External diff viewer failed:"
 msgstr "K=C3=BCls=C5=91 diff n=C3=A9zeget=C5=91 hiba:"
=20
-#: gitk:3670
+#: gitk:3809
 msgid "Gitk view definition"
 msgstr "Gitk n=C3=A9zet meghat=C3=A1roz=C3=A1sa"
=20
-#: gitk:3674
+#: gitk:3813
 msgid "Remember this view"
 msgstr "Maradj enn=C3=A9l a n=C3=A9zetn=C3=A9l"
=20
-#: gitk:3675
-msgid "Commits to include (arguments to git log):"
-msgstr "Bele=C3=A9rtend=C5=91 commitok (Argumentok a git log-hoz):"
+#: gitk:3814
+msgid "References (space separated list):"
+msgstr "Referenci=C3=A1k (sz=C3=B3k=C3=B6zzel tagolt lista"
=20
-#: gitk:3676
-msgid "Use all refs"
-msgstr "Haszn=C3=A1ld az =C3=B6sszes referenci=C3=A1t"
+#: gitk:3815
+msgid "Branches & tags:"
+msgstr "Branch-ek & tagek:"
=20
-#: gitk:3677
-msgid "Strictly sort by date"
-msgstr "Szigor=C3=BA rendez=C3=A1s d=C3=A1tum alapj=C3=A1n"
+#: gitk:3816
+msgid "All refs"
+msgstr "Minden ref"
=20
-#: gitk:3678
-msgid "Mark branch sides"
-msgstr "Jel=C3=B6lje meg az =C3=A1gakat"
+#: gitk:3817
+msgid "All (local) branches"
+msgstr "Minden (helyi) branch"
=20
-#: gitk:3679
-msgid "Since date:"
+#: gitk:3818
+msgid "All tags"
+msgstr "Minden tag"
+
+#: gitk:3819
+msgid "All remote-tracking branches"
+msgstr "Minden t=C3=A1voli k=C3=B6vet=C5=91 branch"
+
+#: gitk:3820
+msgid "Commit Info (regular expressions):"
+msgstr "Commit Inf=C3=B3 (regul=C3=A1ris kifejez=C3=A9s):"
+
+#: gitk:3821
+msgid "Author:"
+msgstr "Szerz=C5=91:"
+
+#: gitk:3822
+msgid "Committer:"
+msgstr "Commitol=C3=B3:"
+
+#: gitk:3823
+msgid "Commit Message:"
+msgstr "Commit =C3=BCzenet:"
+
+#: gitk:3824
+msgid "Matches all Commit Info criteria"
+msgstr "Egyezik minen Commit Inf=C3=B3 felt=C3=A9tellel"
+
+#: gitk:3825
+msgid "Changes to Files:"
+msgstr "F=C3=A1jl v=C3=A1ltoz=C3=A1sok:"
+
+#: gitk:3826
+msgid "Fixed String"
+msgstr "Fix String"
+
+#: gitk:3827
+msgid "Regular Expression"
+msgstr "Regul=C3=A1ris kifejez=C3=A9s"
+
+#: gitk:3828
+msgid "Search string:"
+msgstr "Keres=C3=A9s sz=C3=B6veg:"
+
+#: gitk:3829
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Commit D=C3=A1tumok (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"Marc=
h 17, 2009 "
+"15:27:38\"):"
+
+#: gitk:3830
+msgid "Since:"
 msgstr "Ett=C5=91l:"
=20
-#: gitk:3680
-msgid "Until date:"
+#: gitk:3831
+msgid "Until:"
 msgstr "Eddig:"
=20
-#: gitk:3681
-msgid "Max count:"
-msgstr "Max. sz=C3=A1m:"
+#: gitk:3832
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Limit=C3=A1lva =C3=A9s/vagy kihagyva egy adott sz=C3=A1m=C3=BA=
 rev=C3=ADzi=C3=B3t (pozit=C3=ADv eg=C3=A9sz):"
+
+#: gitk:3833
+msgid "Number to show:"
+msgstr "Mutatand=C3=B3 sz=C3=A1m:"
=20
-#: gitk:3682
-msgid "Skip:"
-msgstr "Kihagy:"
+#: gitk:3834
+msgid "Number to skip:"
+msgstr "Kihagyand=C3=B3 sz=C3=A1m:"
=20
-#: gitk:3683
+#: gitk:3835
+msgid "Miscellaneous options:"
+msgstr "K=C3=BCl=C3=B6nf=C3=A9le opci=C3=B3k:"
+
+#: gitk:3836
+msgid "Strictly sort by date"
+msgstr "Szigor=C3=BA rendez=C3=A1s d=C3=A1tum alapj=C3=A1n"
+
+#: gitk:3837
+msgid "Mark branch sides"
+msgstr "Jel=C3=B6lje meg az =C3=A1gakat"
+
+#: gitk:3838
 msgid "Limit to first parent"
 msgstr "Korl=C3=A1toz=C3=A1s az els=C5=91 sz=C3=BCl=C5=91re"
=20
-#: gitk:3684
+#: gitk:3839
+msgid "Simple history"
+msgstr "Egyszer=C5=B1 history"
+
+#: gitk:3840
+msgid "Additional arguments to git log:"
+msgstr "Tov=C3=A1bbi argumentok a git log-hoz:"
+
+#: gitk:3841
+msgid "Enter files and directories to include, one per line:"
+msgstr "F=C3=A1jlok =C3=A9s k=C3=B6nyvt=C3=A1rak bejegyz=C3=A9se amike=
t tartalmaz, soronk=C3=A9nt:"
+
+#: gitk:3842
 msgid "Command to generate more commits to include:"
 msgstr "Parancs t=C3=B6bb tartalmaz=C3=B3 commit gener=C3=A1l=C3=A1s=C3=
=A1ra:"
=20
-#: gitk:3780
+#: gitk:3964
 msgid "Gitk: edit view"
 msgstr "Gitk: szerkeszt=C3=A9s n=C3=A9zet"
=20
-#: gitk:3793
-msgid "Name"
-msgstr "N=C3=A9v"
+#: gitk:3972
+msgid "-- criteria for selecting revisions"
+msgstr "-- krit=C3=A9riumok a rev=C3=ADzi=C3=B3k kiv=C3=A1laszt=C3=A1s=
=C3=A1hoz"
=20
-#: gitk:3841
-msgid "Enter files and directories to include, one per line:"
-msgstr "F=C3=A1jlok =C3=A9s k=C3=B6nyvt=C3=A1rak bejegyz=C3=A9se amike=
t tartalmaz, soronk=C3=A9nt:"
+#: gitk:3977
+msgid "View Name"
+msgstr "N=C3=A9zet neve"
=20
-#: gitk:3855
+#: gitk:4052
 msgid "Apply (F5)"
 msgstr "Alkalmaz (F5)"
=20
-#: gitk:3893
+#: gitk:4090
 msgid "Error in commit selection arguments:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a commit argumentumok kiv=C3=A1laszt=C3=
=A1sa k=C3=B6zben:"
=20
-#: gitk:3946 gitk:3998 gitk:4446 gitk:4460 gitk:5721 gitk:11114 gitk:1=
1115
+#: gitk:4143 gitk:4195 gitk:4643 gitk:4657 gitk:5918 gitk:11519 gitk:1=
1520
 msgid "None"
 msgstr "Keine"
=20
-#: gitk:4394 gitk:6241 gitk:7993 gitk:8008
+#: gitk:4591 gitk:6438 gitk:8282 gitk:8297
 msgid "Date"
 msgstr "D=C3=A1tum"
=20
-#: gitk:4394 gitk:6241
+#: gitk:4591 gitk:6438
 msgid "CDate"
 msgstr "D=C3=A1tum"
=20
-#: gitk:4543 gitk:4548
+#: gitk:4740 gitk:4745
 msgid "Descendant"
 msgstr "Lesz=C3=A1rmazott"
=20
-#: gitk:4544
+#: gitk:4741
 msgid "Not descendant"
 msgstr "Nem lesz=C3=A1rmazott"
=20
-#: gitk:4551 gitk:4556
+#: gitk:4748 gitk:4753
 msgid "Ancestor"
 msgstr "El=C5=91d"
=20
-#: gitk:4552
+#: gitk:4749
 msgid "Not ancestor"
 msgstr "Nem el=C5=91d"
=20
-#: gitk:4842
+#: gitk:5039
 msgid "Local changes checked in to index but not committed"
-msgstr "Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9=
ve az indexbe, de m=C3=A9g nincsenek commitolva"
+msgstr ""
+"Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9ve az i=
ndexbe, de m=C3=A9g nincsenek "
+"commitolva"
=20
-#: gitk:4878
+#: gitk:5075
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Lok=C3=A1lis nem commitolt v=C3=A1ltoz=C3=A1sok, nincsenek bet=
=C3=A9ve az indexbe"
=20
-#: gitk:6559
+#: gitk:6756
 msgid "many"
 msgstr "sok"
=20
-#: gitk:6743
+#: gitk:6939
 msgid "Tags:"
 msgstr "Tagek:"
=20
-#: gitk:6760 gitk:6766 gitk:7986
+#: gitk:6956 gitk:6962 gitk:8275
 msgid "Parent"
 msgstr "Eltern"
=20
-#: gitk:6771
+#: gitk:6967
 msgid "Child"
 msgstr "Gyerek"
=20
-#: gitk:6780
+#: gitk:6976
 msgid "Branch"
 msgstr "=C3=81g"
=20
-#: gitk:6783
+#: gitk:6979
 msgid "Follows"
 msgstr "K=C3=B6vetkez=C5=91k"
=20
-#: gitk:6786
+#: gitk:6982
 msgid "Precedes"
 msgstr "Megel=C5=91z=C5=91k"
=20
-#: gitk:7279
+#: gitk:7519
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a diff-ek let=C3=B6lt=C3=A9se k=C3=B6zb=
en: %s"
=20
-#: gitk:7819
+#: gitk:8103
 msgid "Goto:"
 msgstr "Menj:"
=20
-#: gitk:7821
+#: gitk:8105
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
=20
-#: gitk:7840
+#: gitk:8124
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "R=C3=B6vid SHA1 id %s f=C3=A9lre=C3=A9rthet=C5=91"
=20
-#: gitk:7852
+#: gitk:8131
+msgid "Revision %s is not known"
+msgstr "A(z) %s rev=C3=ADzi=C3=B3 nem ismert"
+
+#: gitk:8141
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1 id %s nem ismert"
=20
-#: gitk:7854
+#: gitk:8143
 #, tcl-format
-msgid "Tag/Head %s is not known"
-msgstr "Tag/Head %s nem ismert"
+msgid "Revision %s is not in the current view"
+msgstr "A(z) %s rev=C3=ADzi=C3=B3 nincs a jelenlegi n=C3=A9zetben"
=20
-#: gitk:7996
+#: gitk:8285
 msgid "Children"
 msgstr "Gyerekek"
=20
-#: gitk:8053
+#: gitk:8343
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "=C3=81ll=C3=ADtsd vissza a %s branch-ot ide"
=20
-#: gitk:8055
+#: gitk:8345
 msgid "Detached head: can't reset"
 msgstr "Elk=C3=BCl=C3=B6n=C3=ADtett head: nem lehet vissza=C3=A1ll=C3=AD=
tani"
=20
-#: gitk:8164 gitk:8170
+#: gitk:8454 gitk:8460
 msgid "Skipping merge commit "
 msgstr "Merge commit kihagy=C3=A1sa "
=20
-#: gitk:8179 gitk:8184
+#: gitk:8469 gitk:8474
 msgid "Error getting patch ID for "
 msgstr "Hiba t=C3=B6rt=C3=A9nt a patch ID megszerz=C3=A9se k=C3=B6zben=
 a k=C3=B6vetkez=C5=91n=C3=A9l "
=20
-#: gitk:8180 gitk:8185
+#: gitk:8470 gitk:8475
 msgid " - stopping\n"
 msgstr " - abbahagy=C3=A1s\n"
=20
-#: gitk:8190 gitk:8193 gitk:8201 gitk:8211 gitk:8220
+#: gitk:8480 gitk:8483 gitk:8491 gitk:8505 gitk:8514
 msgid "Commit "
 msgstr "Commit "
=20
-#: gitk:8194
+#: gitk:8484
 msgid ""
 " is the same patch as\n"
 "       "
@@ -760,7 +850,7 @@ msgstr ""
 " Ugyanaz a patch mint\n"
 "       "
=20
-#: gitk:8202
+#: gitk:8492
 msgid ""
 " differs from\n"
 "       "
@@ -768,126 +858,139 @@ msgstr ""
 " k=C3=BCl=C3=B6nb=C3=B6zik innent=C5=91l\n"
 "       "
=20
-#: gitk:8204
-msgid "- stopping\n"
-msgstr "- abbahagy=C3=A1s.\n"
+#: gitk:8494
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr ""
+"A commitok diffje:\n"
+"\n"
=20
-#: gitk:8212 gitk:8221
+#: gitk:8506 gitk:8515
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " %s gyereke van. abbahagy=C3=A1s\n"
=20
-#: gitk:8252
+#: gitk:8534
+msgid "Error writing commit to file: %s"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a commit f=C3=A1jlba =C3=ADr=C3=A1sa k=C3=
=B6zben: %s"
+
+#: gitk:8540
+msgid "Error diffing commits: %s"
+msgstr "Hiba t=C3=B6rt=C3=A9nt a commitok diffel=C3=A9se k=C3=B6zben: =
%s"
+
+#: gitk:8570
 msgid "Top"
 msgstr "Teteje"
=20
-#: gitk:8253
+#: gitk:8571
 msgid "From"
 msgstr "Innen"
=20
-#: gitk:8258
+#: gitk:8576
 msgid "To"
 msgstr "Ide"
=20
-#: gitk:8282
+#: gitk:8600
 msgid "Generate patch"
 msgstr "Patch gener=C3=A1l=C3=A1sa"
=20
-#: gitk:8284
+#: gitk:8602
 msgid "From:"
 msgstr "Innen:"
=20
-#: gitk:8293
+#: gitk:8611
 msgid "To:"
 msgstr "Ide:"
=20
-#: gitk:8302
+#: gitk:8620
 msgid "Reverse"
 msgstr "Visszafele"
=20
-#: gitk:8304 gitk:8489
+#: gitk:8622 gitk:8807
 msgid "Output file:"
 msgstr "Kimeneti f=C3=A1jl:"
=20
-#: gitk:8310
+#: gitk:8628
 msgid "Generate"
 msgstr "Gener=C3=A1l=C3=A1s"
=20
-#: gitk:8348
+#: gitk:8666
 msgid "Error creating patch:"
 msgstr "Hiba t=C3=B6rt=C3=A9t a patch k=C3=A9sz=C3=ADt=C3=A9se k=C3=B6=
zben:"
=20
-#: gitk:8371 gitk:8477 gitk:8534
+#: gitk:8689 gitk:8795 gitk:8852
 msgid "ID:"
 msgstr "ID:"
=20
-#: gitk:8380
+#: gitk:8698
 msgid "Tag name:"
 msgstr "Tag n=C3=A9v:"
=20
-#: gitk:8384 gitk:8543
+#: gitk:8702 gitk:8861
 msgid "Create"
 msgstr "L=C3=A9trehoz=C3=A1s"
=20
-#: gitk:8401
+#: gitk:8719
 msgid "No tag name specified"
 msgstr "A tag neve nincsen megadva"
=20
-#: gitk:8405
+#: gitk:8723
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "%s Tag m=C3=A1r l=C3=A9tezik"
=20
-#: gitk:8411
+#: gitk:8729
 msgid "Error creating tag:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a tag l=C3=A9trehoz=C3=A1sa k=C3=B6zben=
:"
=20
-#: gitk:8486
+#: gitk:8804
 msgid "Command:"
 msgstr "Parancs:"
=20
-#: gitk:8494
+#: gitk:8812
 msgid "Write"
 msgstr "=C3=8Dr=C3=A1s"
=20
-#: gitk:8512
+#: gitk:8830
 msgid "Error writing commit:"
 msgstr "Hiba t=C3=B6rt=C3=A9nt a commit =C3=ADr=C3=A1sa k=C3=B6zben:"
=20
-#: gitk:8539
+#: gitk:8857
 msgid "Name:"
 msgstr "N=C3=A9v:"
=20
-#: gitk:8562
+#: gitk:8880
 msgid "Please specify a name for the new branch"
 msgstr "K=C3=A9rem adja meg a nev=C3=A9t az =C3=BAj branchhoz"
=20
-#: gitk:8567
+#: gitk:8885
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "%s branch m=C3=A1r l=C3=A9tezik. Fel=C3=BCl=C3=ADrja?"
=20
-#: gitk:8633
+#: gitk:8951
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
 msgstr ""
 "%s commit m=C3=A1r benne van a %s branchban -- biztos hogy =C3=BAjra =
csin=C3=A1lja ?"
 "eintragen?"
=20
-#: gitk:8638
+#: gitk:8956
 msgid "Cherry-picking"
 msgstr "Cherry-picking"
=20
-#: gitk:8647
+#: gitk:8965
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
 "Please commit, reset or stash your changes and try again."
 msgstr ""
 "Cherry-pick hiba t=C3=B6rt=C3=A9nt lok=C3=A1lis v=C3=A1ltot=C3=A1sok =
miatt a '%s' f=C3=A1jlban.\n"
-"K=C3=A9rem commitolja, ind=C3=ADtsa =C3=BAjra vagy rejtse el a v=C3=A1=
ltoztat=C3=A1sait =C3=A9s pr=C3=B3b=C3=A1lja =C3=BAjra."
+"K=C3=A9rem commitolja, ind=C3=ADtsa =C3=BAjra vagy rejtse el a v=C3=A1=
ltoztat=C3=A1sait =C3=A9s pr=C3=B3b=C3=A1lja "
+"=C3=BAjra."
=20
-#: gitk:8653
+#: gitk:8971
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -895,33 +998,32 @@ msgstr ""
 "Cherry-pick hiba t=C3=B6rt=C3=A9nt merge konfliktus miatt.\n"
 "K=C3=ADv=C3=A1nja futtatni a git citool-t a probl=C3=A9ma megold=C3=A1=
s=C3=A1hoz?"
=20
-#: gitk:8669
+#: gitk:8987
 msgid "No changes committed"
 msgstr "Nincsen v=C3=A1ltoz=C3=A1s commitolva"
=20
-#: gitk:8695
+#: gitk:9013
 msgid "Confirm reset"
 msgstr "=C3=9Ajraind=C3=ADt=C3=A1s meger=C5=91s=C3=ADt=C3=A9se"
=20
-#: gitk:8697
+#: gitk:9015
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "=C3=9Ajraind=C3=ADtja a %s branchot %s-ig?"
=20
-#: gitk:8701
+#: gitk:9017
 msgid "Reset type:"
 msgstr "=C3=9Ajraind=C3=ADt=C3=A1s t=C3=ADpusa:"
=20
-#: gitk:8705
+#: gitk:9020
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Soft: Hagyd a working tree-t =C3=A9s az indexet =C3=A9rintetle=
n=C3=BCl"
=20
-#: gitk:8708
+#: gitk:9023
 msgid "Mixed: Leave working tree untouched, reset index"
-msgstr ""
-"Kevert: Hagyd a working tree-t =C3=A9rintetlen=C3=BCl, t=C3=B6r=C3=B6=
ld az indexet"
+msgstr "Kevert: Hagyd a working tree-t =C3=A9rintetlen=C3=BCl, t=C3=B6=
r=C3=B6ld az indexet"
=20
-#: gitk:8711
+#: gitk:9026
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
@@ -929,20 +1031,19 @@ msgstr ""
 "Hard: Ind=C3=ADtsd =C3=BAjra a working tree-t =C3=A9s az indexet\n"
 "(MINDEN lok=C3=A1lis v=C3=A1ltoz=C3=A1s eldob=C3=A1sa)"
=20
-#: gitk:8728
+#: gitk:9043
 msgid "Resetting"
 msgstr "=C3=9Ajraind=C3=ADt=C3=A1s"
=20
-#: gitk:8785
+#: gitk:9103
 msgid "Checking out"
 msgstr "Kivesz"
=20
-#: gitk:8838
+#: gitk:9156
 msgid "Cannot delete the currently checked-out branch"
-msgstr ""
-"Nem lehet a jelenleg kivett branch-ot t=C3=B6r=C3=B6lni"
+msgstr "Nem lehet a jelenleg kivett branch-ot t=C3=B6r=C3=B6lni"
=20
-#: gitk:8844
+#: gitk:9162
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -951,199 +1052,244 @@ msgstr ""
 "A %s branchon tal=C3=A1lhat=C3=B3 commit nem tal=C3=A1lhat=C3=B3 meg =
semelyik m=C3=A1sik branchon.\n"
 "T=C3=A9nyleg t=C3=B6rli a %s branchot?"
=20
-#: gitk:8875
+#: gitk:9193
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Tagek =C3=A9s headek: %s"
=20
-#: gitk:8890
+#: gitk:9208
 msgid "Filter"
 msgstr "Sz=C5=B1r=C5=91"
=20
-#: gitk:9185
+#: gitk:9503
 msgid ""
 "Error reading commit topology information; branch and preceding/follo=
wing "
 "tag information will be incomplete."
 msgstr ""
-"Hiba t=C3=B6rt=C3=A9nt a commit topol=C3=B3giai inform=C3=A1ci=C3=B3 =
olvas=C3=A1sa k=C3=B6zben; branch =C3=A9s"
-"a megel=C5=91z=C5=91/k=C3=B6vetkez=C5=91 inform=C3=A1ci=C3=B3 nem les=
z teljes."
+"Hiba t=C3=B6rt=C3=A9nt a commit topol=C3=B3giai inform=C3=A1ci=C3=B3 =
olvas=C3=A1sa k=C3=B6zben; branch =C3=A9sa "
+"megel=C5=91z=C5=91/k=C3=B6vetkez=C5=91 inform=C3=A1ci=C3=B3 nem lesz =
teljes."
=20
-#: gitk:10171
+#: gitk:10489
 msgid "Tag"
 msgstr "Tag"
=20
-#: gitk:10171
+#: gitk:10489
 msgid "Id"
 msgstr "Id"
=20
-#: gitk:10219
+#: gitk:10539
 msgid "Gitk font chooser"
 msgstr "Gitk-bet=C5=B1 kiv=C3=A1laszt=C3=B3"
=20
-#: gitk:10236
+#: gitk:10556
 msgid "B"
 msgstr "F"
=20
-#: gitk:10239
+#: gitk:10559
 msgid "I"
 msgstr "K"
=20
-#: gitk:10334
+#: gitk:10677
 msgid "Gitk preferences"
 msgstr "Gitk be=C3=A1ll=C3=ADt=C3=A1sok"
=20
-#: gitk:10336
+#: gitk:10679
 msgid "Commit list display options"
 msgstr "Commit lista kijelz=C3=A9si opci=C3=B3k"
=20
-#: gitk:10339
+#: gitk:10682
 msgid "Maximum graph width (lines)"
 msgstr "Maxim=C3=A1lis grafikon sz=C3=A9less=C3=A9g (sorok)"
=20
-#: gitk:10343
+#: gitk:10685
 #, tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Maxim=C3=A1lis grafikon sz=C3=A9less=C3=A9g (t=C3=A1ble %-je)"
=20
-#: gitk:10347
+#: gitk:10688
 msgid "Show local changes"
 msgstr "Mutasd a lok=C3=A1lis v=C3=A1ltoztat=C3=A1sokat"
=20
-#: gitk:10350
+#: gitk:10691
 msgid "Auto-select SHA1"
 msgstr "SHA1 Automatikus kiv=C3=A1laszt=C3=A1sa"
=20
-#: gitk:10354
+#: gitk:10694
+msgid "Hide remote refs"
+msgstr "A t=C3=A1voli refek elrejt=C3=A9se"
+
+#: gitk:10698
 msgid "Diff display options"
 msgstr "Diff kijelz=C5=91 opci=C3=B3k"
=20
-#: gitk:10356
+#: gitk:10700
 msgid "Tab spacing"
 msgstr "Tab sork=C3=B6z"
=20
-#: gitk:10359
+#: gitk:10703
 msgid "Display nearby tags"
 msgstr "Szomsz=C3=A9dos tagek kijelz=C3=A9se"
=20
-#: gitk:10362
+#: gitk:10706
 msgid "Limit diffs to listed paths"
 msgstr "Korl=C3=A1tozott diffek a kilist=C3=A1zott =C3=BAtvonalakhoz"
=20
-#: gitk:10365
+#: gitk:10709
 msgid "Support per-file encodings"
 msgstr "F=C3=A1jlonk=C3=A9nti k=C3=B3dol=C3=A1s t=C3=A1mgat=C3=A1sa"
=20
-#: gitk:10371 gitk:10436
+#: gitk:10715 gitk:10804
 msgid "External diff tool"
 msgstr "K=C3=BCls=C5=91 diff alkalmaz=C3=A1s"
=20
-#: gitk:10373
+#: gitk:10716
 msgid "Choose..."
 msgstr "V=C3=A1laszd ..."
=20
-#: gitk:10378
+#: gitk:10721
+msgid "General options"
+msgstr "=C3=81ltal=C3=A1nos opci=C3=B3k"
+
+#: gitk:10724
+msgid "Use themed widgets"
+msgstr "T=C3=A9m=C3=A1zott vez=C3=A9rl=C5=91k haszn=C3=A1lata"
+
+#: gitk:10726
+msgid "(change requires restart)"
+msgstr "(a v=C3=A1ltoz=C3=A1s =C3=BAjraind=C3=ADt=C3=A1st ig=C3=A9nyel=
)"
+
+#: gitk:10728
+msgid "(currently unavailable)"
+msgstr "(jelenleg nem el=C3=A9rhet=C5=91)"
+
+#: gitk:10732
 msgid "Colors: press to choose"
 msgstr "Sz=C3=ADnek: nyomja meg a kiv=C3=A1laszt=C3=A1shoz"
=20
-#: gitk:10381
+#: gitk:10735
+msgid "Interface"
+msgstr "Interf=C3=A9sz"
+
+#: gitk:10736
+msgid "interface"
+msgstr "interf=C3=A9sz"
+
+#: gitk:10739
 msgid "Background"
 msgstr "H=C3=A1tt=C3=A9r"
=20
-#: gitk:10382 gitk:10412
+#: gitk:10740 gitk:10770
 msgid "background"
 msgstr "h=C3=A1tt=C3=A9r"
=20
-#: gitk:10385
+#: gitk:10743
 msgid "Foreground"
 msgstr "El=C5=91t=C3=A9r"
=20
-#: gitk:10386
+#: gitk:10744
 msgid "foreground"
 msgstr "el=C5=91t=C3=A9r"
=20
-#: gitk:10389
+#: gitk:10747
 msgid "Diff: old lines"
 msgstr "Diff: r=C3=A9gi sorok"
=20
-#: gitk:10390
+#: gitk:10748
 msgid "diff old lines"
 msgstr "diff r=C3=A9gi sorok"
=20
-#: gitk:10394
+#: gitk:10752
 msgid "Diff: new lines"
 msgstr "Diff: =C3=BAj sorok"
=20
-#: gitk:10395
+#: gitk:10753
 msgid "diff new lines"
 msgstr "diff - =C3=BAj sorok"
=20
-#: gitk:10399
+#: gitk:10757
 msgid "Diff: hunk header"
 msgstr "Diff: nagy header=C3=B6k"
=20
-#: gitk:10401
+#: gitk:10759
 msgid "diff hunk header"
 msgstr "diff - nagy header=C3=B6k"
=20
-#: gitk:10405
+#: gitk:10763
 msgid "Marked line bg"
 msgstr "Megjel=C3=B6lt sor h=C3=A1tt=C3=A9r"
=20
-#: gitk:10407
+#: gitk:10765
 msgid "marked line background"
 msgstr "megjel=C3=B6lt sor h=C3=A1tt=C3=A9r"
=20
-#: gitk:10411
+#: gitk:10769
 msgid "Select bg"
 msgstr "V=C3=A1lasszon h=C3=A1tteret"
=20
-#: gitk:10415
+#: gitk:10773
 msgid "Fonts: press to choose"
 msgstr "Bet=C5=B1: nyomja meg a kiv=C3=A1laszt=C3=A1shoz"
=20
-#: gitk:10417
+#: gitk:10775
 msgid "Main font"
 msgstr "F=C5=91 bet=C5=B1"
=20
-#: gitk:10418
+#: gitk:10776
 msgid "Diff display font"
 msgstr "Diff kijelz=C5=91 bet=C5=B1"
=20
-#: gitk:10419
+#: gitk:10777
 msgid "User interface font"
 msgstr "Felhaszn=C3=A1l=C3=B3i interf=C3=A9sz bet=C5=B1"
=20
-#: gitk:10446
+#: gitk:10814
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: v=C3=A1lasszon sz=C3=ADnt a %s-ra"
=20
-#: gitk:10893
-msgid ""
-"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
-" Gitk requires at least Tcl/Tk 8.4."
-msgstr ""
-"Sajn=C3=A1ljuk, de a gitk nem futtathat=C3=B3 ezzel a Tcl/Tk verzi=C3=
=B3val.\n"
-"Gitk futtat=C3=A1s=C3=A1hoz legal=C3=A1bb Tcl/Tk 8.4 sz=C3=BCks=C3=A9=
ges."
-
-#: gitk:11020
+#: gitk:11418
 msgid "Cannot find a git repository here."
 msgstr "Nem tal=C3=A1lhat=C3=BC git repository itt."
=20
-#: gitk:11024
+#: gitk:11422
 #, tcl-format
 msgid "Cannot find the git directory \"%s\"."
 msgstr "Nem tal=C3=A1lhat=C3=B3 a \"%s\" k=C3=B6nyvt=C3=A1r."
=20
-#: gitk:11071
+#: gitk:11469
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "F=C3=A9lre=C3=A9rthet=C5=91 argumentum '%s': rev=C3=ADzi=C3=B3=
 =C3=A9s f=C3=A1jln=C3=A9v is"
=20
-#: gitk:11083
+#: gitk:11481
 msgid "Bad arguments to gitk:"
 msgstr "Rossz gitk argumentumok:"
=20
-#: gitk:11167
+#: gitk:11572
 msgid "Command line"
 msgstr "Parancs sor"
+
+#~ msgid "Use all refs"
+#~ msgstr "Haszn=C3=A1ld az =C3=B6sszes referenci=C3=A1t"
+
+#~ msgid "Max count:"
+#~ msgstr "Max. sz=C3=A1m:"
+
+#~ msgid "Skip:"
+#~ msgstr "Kihagy:"
+
+#~ msgid "Name"
+#~ msgstr "N=C3=A9v"
+
+#~ msgid "Tag/Head %s is not known"
+#~ msgstr "Tag/Head %s nem ismert"
+
+#~ msgid "- stopping\n"
+#~ msgstr "- abbahagy=C3=A1s.\n"
+
+#~ msgid ""
+#~ "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+#~ " Gitk requires at least Tcl/Tk 8.4."
+#~ msgstr ""
+#~ "Sajn=C3=A1ljuk, de a gitk nem futtathat=C3=B3 ezzel a Tcl/Tk verzi=
=C3=B3val.\n"
+#~ "Gitk futtat=C3=A1s=C3=A1hoz legal=C3=A1bb Tcl/Tk 8.4 sz=C3=BCks=C3=
=A9ges."
--=20
1.6.5.2
