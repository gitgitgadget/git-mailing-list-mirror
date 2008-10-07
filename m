From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 6/6] gitk: Add menu accelerators for Swedish translation
Date: Tue,  7 Oct 2008 23:56:49 +0200
Message-ID: <1223416609-18864-7-git-send-email-robin.rosenberg@dewire.com>
References: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-3-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-4-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-5-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 08 00:00:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKbC-0003He-Md
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 00:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbYJGV6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:24 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755583AbYJGV6X
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:23 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:43712 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbYJGV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:09 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id C377137E99; Tue,  7 Oct 2008 23:58:07 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 703B238425; Tue,  7 Oct 2008 23:58:07 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 44FFF37E43;
	Tue,  7 Oct 2008 23:58:07 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223416609-18864-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97751>

---
 po/sv.po |   60 ++++++++++++++++++++++++++++++------------------------=
------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index c1c3ed2..af3da51 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -69,67 +69,67 @@ msgstr "Avbryt"
=20
 #: gitk:1798
 msgid "&File"
-msgstr "Arkiv"
+msgstr "&Arkiv"
=20
 #: gitk:1800
 msgid "&Update"
-msgstr "Uppdatera"
+msgstr "&Uppdatera"
=20
 #: gitk:1801
 msgid "&Reload"
-msgstr "Ladda om"
+msgstr "&Ladda om"
=20
 #: gitk:1802
 msgid "R&eread references"
-msgstr "L=C3=A4s om referenser"
+msgstr "L&=C3=A4s om referenser"
=20
 #: gitk:1803
 msgid "&List references"
-msgstr "Visa referenser"
+msgstr "&Visa referenser"
=20
 #: gitk:1804
 msgid "&Quit"
-msgstr "Avsluta"
+msgstr "&Avsluta"
=20
 #: gitk:1806
 msgid "&Edit"
-msgstr "Redigera"
+msgstr "&Redigera"
=20
 #: gitk:1807
 msgid "&Preferences"
-msgstr "Inst=C3=A4llningar"
+msgstr "&Inst=C3=A4llningar"
=20
 #: gitk:1810
 msgid "&View"
-msgstr "Visa"
+msgstr "&Visa"
=20
 #: gitk:1811
 msgid "&New view..."
-msgstr "Ny vy..."
+msgstr "&Ny vy..."
=20
 #: gitk:1812
 msgid "&Edit view..."
-msgstr "=C3=84ndra vy..."
+msgstr "&=C3=84ndra vy..."
=20
 #: gitk:1814
 msgid "&Delete view"
-msgstr "Ta bort vy"
+msgstr "&Ta bort vy"
=20
 #: gitk:1816
 msgid "&All files"
-msgstr "Alla filer"
+msgstr "&Alla filer"
=20
 #: gitk:1820
 msgid "&Help"
-msgstr "Hj=C3=A4lp"
+msgstr "&Hj=C3=A4lp"
=20
 #: gitk:1821
 msgid "&About gitk"
-msgstr "Om gitk"
+msgstr "&Om gitk"
=20
 #: gitk:1822
 msgid "&Key bindings"
-msgstr "Tangentbordsbindningar"
+msgstr "&Tangentbordsbindningar"
=20
 #: gitk:1879
 msgid "SHA1 ID: "
@@ -234,59 +234,59 @@ msgstr "Tr=C3=A4d"
=20
 #: gitk:2204 gitk:2219
 msgid "Diff &this -> selected"
-msgstr "Diff denna -> markerad"
+msgstr "Diff &denna -> markerad"
=20
 #: gitk:2206 gitk:2221
 msgid "Diff &selected -> this"
-msgstr "Diff markerad -> denna"
+msgstr "Diff &markerad -> denna"
=20
 #: gitk:2208 gitk:2223
 msgid "&Make patch"
-msgstr "Skapa patch"
+msgstr "Skapa &patch"
=20
 #: gitk:2209
 msgid "Create ta&g"
-msgstr "Skapa tagg"
+msgstr "Skapa &tagg"
=20
 #: gitk:2210
 msgid "&Write commit to file"
-msgstr "Skriv incheckning till fil"
+msgstr "Skriv incheckning till &fil"
=20
 #: gitk:2211
 msgid "Create new &branch"
-msgstr "Skapa ny gren"
+msgstr "Skapa ny &gren"
=20
 #: gitk:2212
 msgid "C&herry-pick this commit"
-msgstr "Plocka denna incheckning"
+msgstr "P&locka denna incheckning"
=20
 #: gitk:2214
 msgid "&Reset HEAD branch to here"
-msgstr "=C3=85terst=C3=A4ll HEAD-grenen hit"
+msgstr "&=C3=85terst=C3=A4ll HEAD-grenen hit"
=20
 #: gitk:2230
 msgid "Check &out this branch"
-msgstr "Checka ut denna gren"
+msgstr "&Checka ut denna gren"
=20
 #: gitk:2232
 msgid "Re&move this branch"
-msgstr "Ta bort denna gren"
+msgstr "Ta &bort denna gren"
=20
 #: gitk:2238
 msgid "Highlight this &too"
-msgstr "Markera =C3=A4ven detta"
+msgstr "Markera &=C3=A4ven detta"
=20
 #: gitk:2240
 msgid "Highlight this &only"
-msgstr "Markera bara detta"
+msgstr "Markera &bara detta"
=20
 #: gitk:2242
 msgid "E&xternal diff"
-msgstr "Extern diff"
+msgstr "&Extern diff"
=20
 #: gitk:2244
 msgid "&Blame parent commit"
-msgstr ""
+msgstr "&Kommentera mot incheckningens f=C3=B6r=C3=A4ldrer"
=20
 #: gitk:2484
 msgid "About gitk"
--=20
1.6.0.2.308.gef4a
