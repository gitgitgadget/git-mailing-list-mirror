From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Wed, 19 Jan 2011 08:36:32 +0000 (UTC)
Message-ID: <loom.20110119T090252-99@post.gmane.org>
References: <cover.1295295897.git.raa.lkml@gmail.com> <1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com> <20110117210828.GC27029@blimp.localdomain> <loom.20110118T083048-91@post.gmane.org> <20110119000735.GA29212@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 09:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfTXF-000398-4L
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 09:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab1ASIgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jan 2011 03:36:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:45538 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab1ASIgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 03:36:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PfTX4-00031C-FS
	for git@vger.kernel.org; Wed, 19 Jan 2011 09:36:48 +0100
Received: from 212.34.37.3 ([212.34.37.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 09:36:46 +0100
Received: from zapped by 212.34.37.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 09:36:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.34.37.3 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.215 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165245>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

>=20
> On Tue, Jan 18, 2011 at 07:40:05AM +0000, Alexey Shumkin wrote:
> > change this
> > >  #, tcl-format
> > >  msgid "File %s seems to have unresolved conflicts, still stage?"
> > >  msgstr ""
> > +"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=
=8F =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=
=D0=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=
=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B.
> > =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA "
> >  "=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
> > to
> > +"=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=
=D1=8F, =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=
=BE=D0=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=
=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B.
> > =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA "
> >  "=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
> >=20
> > "=D0=9A=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F" - =D0=B2=D0=B2=D0=BE=D0=
=B4=D0=BD=D0=BE=D0=B5 =D1=81=D0=BB=D0=BE=D0=B2=D0=BE, =D0=BE=D0=B1=D0=BE=
=D1=81=D0=BE=D0=B1=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=B7=D0=B0=D0=BF=
=D1=8F=D1=82=D1=8B=D0=BC=D0=B8
>=20
> In the above sentence, '=D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F' i=
s not an introductory word, and thus
> no comma is required. For details, see #2 at
> http://ru.wiktionary.org/wiki/%D0%BA%D0%B0%D0%B6%D0%B5%D1%82%D1%81%D1=
%8F
>=20
> However, such use of '=D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F' is =
more appropriate for colloquial speech
> than for documentation or even computer messages. Also, I have never =
seen
> 'unresolved conflicts' being translated as '=D0=BD=D0=B5=D0=BE=D0=B1=D1=
=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B'.
> IMHO, the standard term is '=D0=BD=D0=B5=D1=80=D0=B0=D0=B7=D1=80=D0=B5=
=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=
=D0=BA=D1=82=D1=8B'. So my suggestion is:
>=20
> =D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D1=81=D0=BE=
=D0=B4=D0=B5=D1=80=D0=B6=D0=B0=D1=82=D1=8C =D0=BD=D0=B5=D1=80=D0=B0=D0=B7=
=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=
=D0=BB=D0=B8=D0=BA=D1=82=D1=8B.
>=20
> Dmitry
>=20

As I understand exact meaning of phrase "File %s seems to have unresolv=
ed=20
conflicts" (note *seems* word here) is a supposition. It is not
an equivalent of "may have" (but "may not have").
So, I agree sentence must rephrased but supposition must be retained.
Something like "=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=BF=D0=BE=D1=85=D0=BE=D0=
=B6=D0=B5, =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=
=D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=
=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B"
or "=D0=A4=D0=B0=D0=B9=D0=BB %s, =D0=B2=D0=B8=D0=B4=D0=B8=D0=BC=D0=BE, =
=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D1=80=D0=B0=
=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=BD=
=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B"
or better "=D0=9F=D1=80=D0=B5=D0=B4=D0=BF=D0=BE=D0=BB=D0=BE=D0=B6=D0=B8=
=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =D1=84=D0=B0=D0=B9=D0=BB %s =D1=81=
=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D1=80=D0=B0=D0=B7=
=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=
=D0=BB=D0=B8=D0=BA=D1=82=D1=8B"
(stay official but supposing)
