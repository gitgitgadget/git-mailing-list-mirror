From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git-gui: update russian translation
Date: Wed, 19 Jan 2011 22:01:32 +0100
Message-ID: <20110119210131.GA8184@blimp.localdomain>
References: <20110119104856.GA5473@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 22:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PffA3-00079N-5o
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 22:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab1ASVBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jan 2011 16:01:40 -0500
Received: from mout1.freenet.de ([195.4.92.91]:50263 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab1ASVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 16:01:39 -0500
Received: from [195.4.92.14] (helo=4.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Pff9r-0003ZC-8r; Wed, 19 Jan 2011 22:01:35 +0100
Received: from krlh-4d036237.pool.mediaways.net ([77.3.98.55]:37387 helo=tigra.home)
	by 4.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Pff9r-0004XQ-4o; Wed, 19 Jan 2011 22:01:35 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id AF6CBA04B1;
	Wed, 19 Jan 2011 22:01:32 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 2F01736D28; Wed, 19 Jan 2011 22:01:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110119104856.GA5473@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165294>

Improve the translation of warning given by mergetool when staging file=
s with
conflict markers.

Suggested-by: Alexey Shumkin <zapped@mail.ru>
Tipping-vote-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

On Wed, 19 Jan 2011 13:48:56 +0300, Dmitry Potapov wrote:
> On Wed, Jan 19, 2011 at 08:36:32AM +0000, Alexey Shumkin wrote:
>> So, I agree sentence must rephrased but supposition must be retained=
=2E
>> Something like "=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=BF=D0=BE=D1=85=D0=BE=
=D0=B6=D0=B5, =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=
=B5=D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=
=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B"
>
> I like this one.

So be it.

Please, apply on top of the previously sent patches.

 po/ru.po |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 7071a8c..30f4b77 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1926,7 +1926,7 @@ msgstr ""
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
 msgstr ""
-"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F=
 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=
=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. =D0=9F=D1=80=D0=BE=D0=B4=
=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=
=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA "
+"=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=BF=D0=BE=D1=85=D0=BE=D0=B6=D0=B5, =D1=
=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=B1=D1=
=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=
=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BA=D1=83 =D0=BA "
 "=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
=20
 #: lib/mergetool.tcl:60
--=20
1.7.4.rc2.25.g62eb
