From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] gitk: spelling fixes in russian translation
Date: Mon, 17 Jan 2011 22:23:12 +0100
Message-ID: <20110117212312.GA8506@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Skip <bsvskip@rambler.ru>
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jan 17 22:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PewY3-0003KG-K9
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 22:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1AQVXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 16:23:33 -0500
Received: from mout2.freenet.de ([195.4.92.92]:37955 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab1AQVXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 16:23:22 -0500
Received: from [195.4.92.13] (helo=3.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1PewXi-0007E9-1w; Mon, 17 Jan 2011 22:23:14 +0100
Received: from krlh-5f7212ec.pool.mediaways.net ([95.114.18.236]:53462 helo=tigra.home)
	by 3.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1PewXh-0003UD-Ql; Mon, 17 Jan 2011 22:23:14 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id 9A7C69FE26;
	Mon, 17 Jan 2011 22:23:12 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 613E336D28; Mon, 17 Jan 2011 22:23:12 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165185>

=46rom: Skip <bsvskip@rambler.ru>

Signed-off-by: Skip <bsvskip@rambler.ru>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I applied the patch to the gitk-git in git main repository.
I hope it still applies to your repository, Paul.

 po/ru.po |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index c3d0285..5987303 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -24,7 +24,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=
=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=
=80=D0=B5 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8:"
=20
 #: gitk:323
 msgid "Error executing --argscmd command:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=
=8B =D0=B7=D0=B0=D0=B4=D0=B0=D0=BD=D0=BE=D0=B9 --argscmd:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=
=8B =D0=B7=D0=B0=D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 --argscmd:"
=20
 #: gitk:336
 msgid "No files selected: --merge specified but no files are unmerged.=
"
@@ -37,7 +37,7 @@ msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
 msgstr ""
-"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge, =D0=BD=D0=
=BE =D0=B2 =D1=80=D0=B0=D0=BC=D0=BA=D0=B0=D1=85 =D1=83=D0=BA=D0=B0=D0=B7=
=D0=B0=D0=BD=D0=BE=D0=B3=D0=BE "
+"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge, =D0=BD=D0=
=BE =D0=B2 =D1=80=D0=B0=D0=BC=D0=BA=D0=B0=D1=85 =D1=83=D0=BA=D0=B0=D0=B7=
=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE "
 "=D0=BE=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BD=D0=B0 =D0=B8=D0=BC=D0=B5=D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=
=D0=B2 =D0=BD=D0=B5=D1=82 =D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=
=BE "
 "=D0=B3=D0=B4=D0=B5 =D1=8D=D1=82=D0=B0 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=
=86=D0=B8=D1=8F =D0=B4=D0=BE=D0=BB=D0=B6=D0=BD=D0=B0 =D0=B1=D1=8B=D1=82=
=D1=8C =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
=20
@@ -246,11 +246,11 @@ msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B"
=20
 #: gitk:2326 gitk:2339
 msgid "Diff this -> selected"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=
=D1=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D1=8B=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=
=D1=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
=20
 #: gitk:2327 gitk:2340
 msgid "Diff selected -> this"
-msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=D0=BC=
 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=
=D0=BC =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
=20
 #: gitk:2328 gitk:2341
 msgid "Make patch"
@@ -440,11 +440,11 @@ msgstr "<%s-F>\t\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
 #: gitk:2666
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
-msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2667
 msgid "<Return>\tMove to next find hit"
-msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2668
 msgid "/\t\tFocus the search box"
@@ -452,7 +452,7 @@ msgstr "/\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=
=B8 =D0=BA =D0=BF=D0=BE=D0=BB=D1=8E =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=B0=
"
=20
 #: gitk:2669
 msgid "?\t\tMove to previous find hit"
-msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2670
 msgid "f\t\tScroll diff view to next file"
@@ -466,7 +466,7 @@ msgstr "<%s-S>\t\t=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=
=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=B8=D1=81=D0=BA =D0=B2 =D1=81=
=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD
 #: gitk:2672
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
-msgstr "<%s-R>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=
=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+msgstr "<%s-R>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=
=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=82=D0=B5=D0=BA=D1=
=81=D1=82=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
=20
 #: gitk:2673
 #, tcl-format
@@ -855,7 +855,7 @@ msgstr "=D0=9B=D1=91=D0=B3=D0=BA=D0=B8=D0=B9: =D0=BE=
=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=
=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=B8 =D0=B8=D0=
=BD=D0=B4=D0=B5
 #: gitk:8472
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr ""
-"=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BD=D1=8B=D0=B9: =D0=BE=D1=81=D1=82=D0=
=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =
=D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5=D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC, =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=
=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
+"=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9: =D0=BE=D1=81=D1=
=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=
=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5=D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC, =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=
=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: gitk:8475
 msgid ""
@@ -962,7 +962,7 @@ msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=
=B0=D1=82=D1=8C =D0=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D0=B5 =D0=BC=D0=B5=
=D1=82=D0=BA=D0=B8"
=20
 #: gitk:10126
 msgid "Limit diffs to listed paths"
-msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D0=
=BF=D0=BE=D0=BA=D0=B0=D0=B7 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9 =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D1=8B=D0=BC=D0=B8 =D1=84=
=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC=D0=B8"
+msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D0=
=BF=D0=BE=D0=BA=D0=B0=D0=B7 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9 =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC=D0=B8"
=20
 #: gitk:10129
 msgid "Support per-file encodings"
@@ -1022,11 +1022,11 @@ msgstr "=D0=B7=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=
=B2=D0=BE=D0=BA =D0=B1=D0=BB=D0=BE=D0=BA=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
=20
 #: gitk:10169
 msgid "Marked line bg"
-msgstr "=D0=A4=D0=BE=D0=BD =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D0=
=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8"
+msgstr "=D0=A4=D0=BE=D0=BD =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D0=
=BE=D0=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8"
=20
 #: gitk:10171
 msgid "marked line background"
-msgstr "=D1=84=D0=BE=D0=BD =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D0=
=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8"
+msgstr "=D1=84=D0=BE=D0=BD =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D0=
=BE=D0=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8"
=20
 #: gitk:10175
 msgid "Select bg"
--=20
1.7.3.4.643.g8fb2b
