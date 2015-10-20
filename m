From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] gitk: Add accelerators to Japanese locale
Date: Tue, 20 Oct 2015 14:33:03 +0200
Message-ID: <1445344384-12762-4-git-send-email-tiwai@suse.de>
References: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 14:34:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoW6Z-0006P3-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 14:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbJTMdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2015 08:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:35271 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbbJTMdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 08:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C24DFACA8;
	Tue, 20 Oct 2015 12:33:16 +0000 (UTC)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279911>

Just follow the English accelerator keys.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 gitk-git/po/ja.po | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/gitk-git/po/ja.po b/gitk-git/po/ja.po
index 9bbbadd3b427..59e42a89fd7e 100644
--- a/gitk-git/po/ja.po
+++ b/gitk-git/po/ja.po
@@ -91,71 +91,71 @@ msgstr "=E3=82=AD=E3=83=A3=E3=83=B3=E3=82=BB=E3=83=AB=
"
=20
 #: gitk:2069
 msgid "&Update"
-msgstr "=E6=9B=B4=E6=96=B0"
+msgstr "=E6=9B=B4=E6=96=B0(&U)"
=20
 #: gitk:2070
 msgid "&Reload"
-msgstr "=E3=83=AA=E3=83=AD=E3=83=BC=E3=83=89"
+msgstr "=E3=83=AA=E3=83=AD=E3=83=BC=E3=83=89(&R)"
=20
 #: gitk:2071
 msgid "Reread re&ferences"
-msgstr "=E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9=E3=82=92=
=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
+msgstr "=E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9=E3=82=92=
=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF(&F)"
=20
 #: gitk:2072
 msgid "&List references"
-msgstr "=E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9=E3=83=AA=
=E3=82=B9=E3=83=88=E3=82=92=E8=A1=A8=E7=A4=BA"
+msgstr "=E3=83=AA=E3=83=95=E3=82=A1=E3=83=AC=E3=83=B3=E3=82=B9=E3=83=AA=
=E3=82=B9=E3=83=88=E3=82=92=E8=A1=A8=E7=A4=BA(&L)"
=20
 #: gitk:2074
 msgid "Start git &gui"
-msgstr "git gui =E3=81=AE=E9=96=8B=E5=A7=8B"
+msgstr "git gui =E3=81=AE=E9=96=8B=E5=A7=8B(&G)"
=20
 #: gitk:2076
 msgid "&Quit"
-msgstr "=E7=B5=82=E4=BA=86"
+msgstr "=E7=B5=82=E4=BA=86(&Q)"
=20
 #: gitk:2068
 msgid "&File"
-msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB(&F)"
=20
 #: gitk:2080
 msgid "&Preferences"
-msgstr "=E8=A8=AD=E5=AE=9A"
+msgstr "=E8=A8=AD=E5=AE=9A(&P)"
=20
 #: gitk:2079
 msgid "&Edit"
-msgstr "=E7=B7=A8=E9=9B=86"
+msgstr "=E7=B7=A8=E9=9B=86(&E)"
=20
 #: gitk:2084
 msgid "&New view..."
-msgstr "=E6=96=B0=E8=A6=8F=E3=83=93=E3=83=A5=E3=83=BC..."
+msgstr "=E6=96=B0=E8=A6=8F=E3=83=93=E3=83=A5=E3=83=BC...(&N)"
=20
 #: gitk:2085
 msgid "&Edit view..."
-msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E7=B7=A8=E9=9B=86..."
+msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E7=B7=A8=E9=9B=86...(&E)"
=20
 #: gitk:2086
 msgid "&Delete view"
-msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E5=89=8A=E9=99=A4"
+msgstr "=E3=83=93=E3=83=A5=E3=83=BC=E5=89=8A=E9=99=A4(&D)"
=20
 #: gitk:2088 gitk:4043
 msgid "&All files"
-msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=
"
+msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=
(&A)"
=20
 #: gitk:2083 gitk:4067
 msgid "&View"
-msgstr "=E3=83=93=E3=83=A5=E3=83=BC"
+msgstr "=E3=83=93=E3=83=A5=E3=83=BC(&V)"
=20
 #: gitk:2093 gitk:2103 gitk:3012
 msgid "&About gitk"
-msgstr "gitk =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6"
+msgstr "gitk =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6(&A)"
=20
 #: gitk:2094 gitk:2108
 msgid "&Key bindings"
-msgstr "=E3=82=AD=E3=83=BC=E3=83=90=E3=82=A4=E3=83=B3=E3=83=87=E3=82=A3=
=E3=83=B3=E3=82=B0"
+msgstr "=E3=82=AD=E3=83=BC=E3=83=90=E3=82=A4=E3=83=B3=E3=83=87=E3=82=A3=
=E3=83=B3=E3=82=B0(&K)"
=20
 #: gitk:2092 gitk:2107
 msgid "&Help"
-msgstr "=E3=83=98=E3=83=AB=E3=83=97"
+msgstr "=E3=83=98=E3=83=AB=E3=83=97(&H)"
=20
 #: gitk:2185 gitk:8652
 msgid "SHA1 ID:"
--=20
2.6.1
