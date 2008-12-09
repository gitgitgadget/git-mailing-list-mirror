From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-gui: Update Japanese translation for 0.12
Date: Tue, 9 Dec 2008 12:42:17 +0900
Message-ID: <20081209124217.6117@nanako3.lavabit.com>
References: <20081208163628.GG31551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 04:44:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9tVz-0007PG-H4
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 04:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbYLIDmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 22:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYLIDmp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 22:42:45 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56118 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbYLIDmp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 22:42:45 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 306A7C8967;
	Mon,  8 Dec 2008 21:42:44 -0600 (CST)
Received: from 2793.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 1VVBTI09CVKA; Mon, 08 Dec 2008 21:42:44 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JTpOijsutF5h+tfJVcP6ywg1Pxi+spjJuBtx/urlmtCnGqUndIjzxUvh+Znga5n3r79V6JlphRvDKIoIK8VBjAtKpLYL9+nwup4swIT6IB87OR2fCU75mepIRMGmnyiPSz1rxymThsCWtsdFzpaYfpdaFv14OzNj9AdX42CbX14=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20081208163628.GG31551@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102595>

Adds translation for one new message string.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 po/ja.po |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 8ba6417..09d60be 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -8,8 +8,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-11-16 13:56-0800\n"
-"PO-Revision-Date: 2008-11-26 19:17+0900\n"
+"POT-Creation-Date: 2008-12-08 08:31-0800\n"
+"PO-Revision-Date: 2008-12-09 06:27+0900\n"
 "Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@lavabit.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
@@ -2501,7 +2501,12 @@
 msgid "Pushing changes to %s"
 msgstr "%s =E3=81=B8=E5=A4=89=E6=9B=B4=E3=82=92=E3=83=97=E3=83=83=E3=82=
=B7=E3=83=A5=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/transport.tcl:72
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "%s =E3=81=B8=E3=83=9F=E3=83=A9=E3=83=BC=E3=81=97=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
+
+#: lib/transport.tcl:82
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "%3$s =E3=81=B8 %1$s %2$s =E3=82=92=E3=83=97=E3=83=83=E3=82=B7=E3=
=83=A5=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"


--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
