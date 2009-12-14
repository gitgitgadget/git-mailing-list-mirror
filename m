From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/2] Fix up gitk-git Hungarian translation
Date: Mon, 14 Dec 2009 14:12:24 +0100
Message-ID: <82a93048a7695369c5fd7fead1c47c52c1650177.1260796071.git.vmiklos@frugalware.org>
References: <cover.1260796071.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Laszlo Papp <djszapi2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 14:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKAiz-0005DG-Ve
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 14:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbZLNNMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 08:12:25 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbZLNNMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 08:12:25 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49316 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZLNNMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 08:12:24 -0500
Received: from vmobile.example.net (dsl5401C437.pool.t-online.hu [84.1.196.55])
	by yugo.frugalware.org (Postfix) with ESMTPA id DA2EA1CBCFB;
	Mon, 14 Dec 2009 14:12:22 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4AC83181D53; Mon, 14 Dec 2009 14:12:26 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <cover.1260796071.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1260796071.git.vmiklos@frugalware.org>
References: <cover.1260796071.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135208>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 gitk-git/po/hu.po |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/gitk-git/po/hu.po b/gitk-git/po/hu.po
index d281e3c..7a4bdca 100755
--- a/gitk-git/po/hu.po
+++ b/gitk-git/po/hu.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2009-05-12 21:55+0200\n"
-"PO-Revision-Date: 2009-05-12 22:18+0200\n"
+"PO-Revision-Date: 2009-12-14 13:28+0100\n"
 "Last-Translator: Laszlo Papp <djszapi@archlinux.us>\n"
 "Language-Team: Hungarian\n"
 "MIME-Version: 1.0\n"
@@ -37,8 +37,7 @@ msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
 msgstr ""
-"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a f=C3=A1jlon
-bel=C3=BCl "
+"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a f=C3=A1jlon bel=C3=BCl "
 "limit."
=20
 #: gitk:361 gitk:508
@@ -662,8 +661,7 @@ msgstr "Nem el=C5=91d"
=20
 #: gitk:4842
 msgid "Local changes checked in to index but not committed"
-msgstr "Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9=
ve az indexbe, de m=C3=A9g
-nincsenek commitolva"
+msgstr "Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9=
ve az indexbe, de m=C3=A9g nincsenek commitolva"
=20
 #: gitk:4878
 msgid "Local uncommitted changes, not checked in to index"
--=20
1.6.5.2
