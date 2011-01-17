From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/3] fix git-gui russian translation typos
Date: Mon, 17 Jan 2011 22:08:24 +0100
Message-ID: <20110117210824.GB27029@blimp.localdomain>
References: <cover.1295295897.git.raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 17 22:08:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PewJj-0002nC-F9
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 22:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1AQVIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 16:08:31 -0500
Received: from mout9.freenet.de ([195.4.92.99]:55109 "EHLO mout9.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab1AQVIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 16:08:30 -0500
Received: from [195.4.92.18] (helo=8.mx.freenet.de)
	by mout9.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1PewJP-0000u1-6J; Mon, 17 Jan 2011 22:08:27 +0100
Received: from krlh-5f7212ec.pool.mediaways.net ([95.114.18.236]:53333 helo=tigra.home)
	by 8.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1PewJP-0007fr-0W; Mon, 17 Jan 2011 22:08:27 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id C74C29FE26;
	Mon, 17 Jan 2011 22:08:24 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id B4BEB36D28; Mon, 17 Jan 2011 22:08:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1295295897.git.raa.lkml@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165181>

=46rom: Serge Ziryukin <ftrvxmtrx@gmail.com>

Signed-off-by: Serge Ziryukin <ftrvxmtrx@gmail.com>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I rebased your patch onto current git-gui. Hope you don't mind.

 po/ru.po |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 364c074..c15bdfa 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -2292,11 +2292,11 @@ msgstr "=D0=A1=D0=BB=D0=BE=D0=B2=D0=B0=D1=80=D1=
=8C =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82 =D0=BA %s."
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BC=D0=BE=
=D0=B3=D0=BB=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=81=
=D1=8F"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BC=D0=BE=
=D0=B3=D0=BB=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C=
=D1=81=D1=8F"
=20
 #: lib/spellcheck.tcl:80
 msgid "Unrecognized spell checker"
-msgstr "=D0=9D=D0=B5=D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D0=
=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =
=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=9D=D0=B5=D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D0=
=BD=D0=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=
=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=
=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
=20
 #: lib/spellcheck.tcl:186
 msgid "No Suggestions"
--=20
1.7.3.4.643.g8fb2b
