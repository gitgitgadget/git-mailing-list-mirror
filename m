From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Another update of Russian translation
Date: Tue, 28 Apr 2009 18:04:48 +0200
Message-ID: <20090428160448.GA11875@blimp.localdomain>
References: <20090426132139.GA30825@blimp.localdomain> <20090427091047.GC15723@dpotapov.dyndns.org> <20090427175828.GB16202@blimp.localdomain> <bb6f213e0904280222m23cb28ddn56f7d633c98df639@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 18:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lypnp-0003Yz-LJ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 18:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbZD1QE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760130AbZD1QE5
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 12:04:57 -0400
Received: from mout3.freenet.de ([195.4.92.93]:35042 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbZD1QEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 12:04:55 -0400
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1Lypnh-0004QZ-3k; Tue, 28 Apr 2009 18:04:53 +0200
Received: from x77f9.x.pppool.de ([89.59.119.249]:58378 helo=tigra.home)
	by 9.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1Lypng-00068x-LZ; Tue, 28 Apr 2009 18:04:53 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id E1612277D8;
	Tue, 28 Apr 2009 18:04:48 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 73DAE36D28; Tue, 28 Apr 2009 18:04:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bb6f213e0904280222m23cb28ddn56f7d633c98df639@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117796>

Thanks to Alexander Gavrilov

Signed-off-by: Alex Riesen <raa@blimp.localdomain>
---

Alexander Gavrilov, Tue, Apr 28, 2009 11:22:36 +0200:
> 2009/4/27 Alex Riesen <raa.lkml@gmail.com>:
> > -#: git-gui.sh:1879
> > +#: git-gui.sh:2293
> > +msgid "Tools"
> > +msgstr "=D0=92=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=
=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=
=D0=B8"
>=20
> I believe that the obvious way to translate Tools is "=D0=98=D0=BD=D1=
=81=D1=82=D1=80=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=8B"
> (used e.g. by Firefox)

That's a good measure, but...

> In my personal opinion, multi-word menu items are a bit strange.

try translating "Use Merge Tool" or "Add New Tool Command".

> > +msgid "Show History Context"
> > +msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=
=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D0=B8"
>=20
> =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=82=D0=
=BE=D1=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8=D0=B9 =D0=BA=D0=BE=D0=BD=D1=
=82=D0=B5=D0=BA=D1=81=D1=82
>=20
> Since I implemented this feature in the first place, one might call i=
t
> the official name :)

Yes, that's better. I'll change and resend.

> > +"=D0=A0=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=D1=82 =D0=BC=D0=BE=
=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D1=91=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BF=D0=B5=D1=80=
=D0=B5=D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=BC =D0=BE=D0=BF=D0=B5=
=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F=
=2E"
>=20
> =D0=AD=D1=82=D0=BE =D0=B4=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D0=B5 =D0=
=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=
=8C =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D0=B7=
=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=
=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.

Like this, too.

> > +"=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B =D1=83=D0=B4=
=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=BB=D0=B8 =D1=81=D0=B2=D1=
=8F=D0=B7=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BC=D0=BE=
=D0=B3=D1=83=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D1=88=D0=B5=D0=
=BD=D1=8B =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=
=81=D0=BA=D0=B8"
>=20
> =D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BE=D0=B1=D1=80=D0=B0=D0=B1=
=D0=B0=D1=82=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=
=D0=B8=D0=BA=D1=82=D1=8B =D1=81 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=
=B8=D0=B5=D0=BC =D0=B8=D0=BB=D0=B8 =D1=83=D1=87=D0=B0=D1=81=D1=82=D0=B8=
=D0=B5=D0=BC =D1=81=D1=81=D1=8B=D0=BB=D0=BE=D0=BA.

And this.

> > +msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B5 =D0=B2 =D0=BA=D0=BE=D0=
=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F: '%s'"
>=20
> =D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=B4=D0=
=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F
>=20
> (anyway, not '=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B5', that's a typo)

=46ixed.

> > +#: lib/option.tcl:151
> > +msgid "Blame History Context Radius (days)"
> > +msgstr "=D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BA=D0=BE=D0=BD=D1=
=82=D0=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=B8=
=D1=81=D0=BA=D0=B5 =D1=83=D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=B8=D0=BA=D0=BE=
=D0=B2 =D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82=D0=B0 (=D0=B4=D0=BD=D0=B5=D0=
=B9)"
>=20
> =D0=A0=D0=B0=D0=B4=D0=B8=D1=83=D1=81 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0 (=D0=B2 =D0=B4=D0=BD=D1=8F=D1=85)
>=20
> This option should use the same words as the Show History Context
> command that it controls, otherwise the relation is not discoverable.
> The 'Blame' prefix is not important.

Grudgingly ("radius" and "history" in the same statement?) agree (I
don't like my own translation at all).

> > +#: lib/tools_dlg.tcl:236
> > +msgid "(Blue denotes repository-local tools)"
> > +msgstr "(=D0=A1=D0=B8=D0=BD=D0=B8=D0=B9 =D1=83=D0=BA=D0=B0=D0=B7=D1=
=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=BC=D1=8B =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=80=D0=
=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F)"
>=20
> =D0=A1=D0=B8=D0=BD=D0=B8=D0=BC =D0=B2=D1=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=
=BD=D1=8B =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =D0=BB=
=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=
=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8E

"=D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D1=80=D0=B5=D0=
=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8E"? Hmmm... Do people=
 write that?
But I'll take it anyway.

 po/ru.po |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 50a2b11..0ffc4a4 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -567,7 +567,7 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=81=D1=82=D0=
=B8 =D0=BF=D0=BE=D0=BB=D0=BD=D1=8B=D0=B9 =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=
 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B9"
=20
 #: lib/blame.tcl:288
 msgid "Show History Context"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=
=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D0=
=B8"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8=D0=B9 =D0=BA=D0=BE=D0=
=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82"
=20
 #: lib/blame.tcl:291
 msgid "Blame Parent Commit"
@@ -1882,7 +1882,7 @@ msgstr ""
 "\n"
 "%s =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BD.\n"
 "\n"
-"=D0=A0=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=D1=82 =D0=BC=D0=BE=D0=
=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D1=91=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BF=D0=B5=D1=80=D0=
=B5=D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=BC =D0=BE=D0=BF=D0=B5=D1=
=80=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.=
"
+"=D0=AD=D1=82=D0=BE =D0=B4=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D0=B5 =D0=
=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=
=8C =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D0=B7=
=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=BC =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=
=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F."
=20
 #: lib/mergetool.tcl:45
 #, tcl-format
@@ -1899,7 +1899,7 @@ msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D1=8F=
=D1=8E =D1=80=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=D1=82 =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =
%s"
 #: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
 msgstr ""
-"=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B =D1=83=D0=B4=D0=
=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=BB=D0=B8 =D1=81=D0=B2=D1=8F=
=D0=B7=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BC=D0=BE=D0=
=B3=D1=83=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D1=88=D0=B5=D0=BD=
=D1=8B =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=
=D0=BA=D0=B8"
+"=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D1=81=D0=BB=D0=
=B8=D1=8F=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BE=D0=B1=D1=80=D0=B0=D0=B1=
=D0=B0=D1=82=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=
=D0=B8=D0=BA=D1=82=D1=8B =D1=81 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=
=B8=D0=B5=D0=BC =D0=B8=D0=BB=D0=B8 =D1=83=D1=87=D0=B0=D1=81=D1=82=D0=B8=
=D0=B5=D0=BC =D1=81=D1=81=D1=8B=D0=BB=D0=BE=D0=BA"
=20
 #: lib/mergetool.tcl:146
 msgid "Conflict file does not exist"
@@ -1955,7 +1955,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=
 =D0=B3=D0=BB=D0=BE=D0=B1=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=83=D1=
=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BA=D0=B5 =D0=BA=D0=BE=D0=B4=D0=B8=D1=
=80=D0=BE=D0=B2=D0=BA
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B5 =D0=B2 =D0=BA=D0=BE=D0=B4=
=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F: '%s'"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=
=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F: '%s'"
=20
 #: lib/option.tcl:117
 msgid "Restore Defaults"
@@ -2020,7 +2020,7 @@ msgstr "=D0=9C=D0=B8=D0=BD=D0=B8=D0=BC=D0=B0=D0=BB=
=D1=8C=D0=BD=D0=BE=D0=B5 =D0=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=
=D0=B2=D0=BE =D1=81=D0=B8=D0=BC=D0=B2=D0=BE=D0=BB=D0=BE=D0=B2 =D0=B4=D0=
=BB=D1=8F =D0=BF=D0=BE
=20
 #: lib/option.tcl:151
 msgid "Blame History Context Radius (days)"
-msgstr "=D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=B8=D1=81=
=D0=BA=D0=B5 =D1=83=D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=B8=D0=BA=D0=BE=D0=B2=
 =D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82=D0=B0 (=D0=B4=D0=BD=D0=B5=D0=B9)"
+msgstr "=D0=A0=D0=B0=D0=B4=D0=B8=D1=83=D1=81 =D0=B8=D1=81=D1=82=D0=BE=D1=
=80=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=BA=D0=BE=D0=BD=D1=
=82=D0=B5=D0=BA=D1=81=D1=82=D0=B0 (=D0=B2 =D0=B4=D0=BD=D1=8F=D1=85)"
=20
 #: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
@@ -2465,7 +2465,7 @@ msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C=
"
=20
 #: lib/tools_dlg.tcl:236
 msgid "(Blue denotes repository-local tools)"
-msgstr "(=D0=A1=D0=B8=D0=BD=D0=B8=D0=B9 =D1=83=D0=BA=D0=B0=D0=B7=D1=8B=
=D0=B2=D0=B0=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F)"
+msgstr "(=D0=A1=D0=B8=D0=BD=D0=B8=D0=BC =D0=B2=D1=8B=D0=B4=D0=B5=D0=BB=
=D0=B5=D0=BD=D1=8B =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B=
 =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D1=80=D0=B5=D0=
=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8E)"
=20
 #: lib/tools_dlg.tcl:297
 #, tcl-format
--=20
1.6.3.rc2.39.g2ffea
