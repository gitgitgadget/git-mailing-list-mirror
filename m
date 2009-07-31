From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH v3] Fix typos on pt_BR/gittutorial.txt translation
Date: Fri, 31 Jul 2009 15:55:07 -0300
Message-ID: <20090731185507.GC10800@vespa.holoscopio.com>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com> <20090730145044.GA1727@vespa.holoscopio.com> <4A71C6A7.80008@drmicha.warpmail.net> <b8bf37780907301031iec37ef8i6b3db7a9eb21eb8b@mail.gmail.com> <20090731163341.GB10800@vespa.holoscopio.com> <b8bf37780907311011m232b68b7k2ba63a8ee7fc2322@mail.gmail.com> <7vvdl8puwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Cc: =?utf-8?B?QW5kcsOp?= Goddard Rosa <andre.goddard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWxG9-00022j-Qk
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 20:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZGaSzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbZGaSzL
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 14:55:11 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:41836 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZGaSzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 14:55:10 -0400
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id 1E6F8208022;
	Fri, 31 Jul 2009 16:07:47 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id 44877C412; Fri, 31 Jul 2009 15:55:08 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <7vvdl8puwo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124593>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2009 at 11:30:31AM -0700, Junio C Hamano wrote:
> Andr=C3=A9 Goddard Rosa <andre.goddard@gmail.com> writes:
>=20
> > @@ -230,14 +229,14 @@ $ git commit -a
> >  ------------------------------------------------
> >
> >  neste ponto, os dois ramos divergiram, com diferentes mudan=C3=A7as fe=
itas em
> > -cada um.  Para unificar as mudan=C3=A7as feitas no experimental para o
> > +cada um. Para unificar as mudan=C3=A7as feitas no experimental para o
> >  master, execute
> >
> >  ------------------------------------------------
> >  $ git merge experimental
> >  ------------------------------------------------
> >
> > -Se as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto.  Se existire=
m conflitos,
> > +Se as mudan=C3=A7as n=C3=A3o conflitarem, estar=C3=A1 pronto. Se exist=
irem conflitos,
> >  marcadores ser=C3=A3o deixados nos arquivos problem=C3=A1ticos exibind=
o o
> >  conflito;
> >
>=20
> Hmm, this seems to be different from the below in
>=20
> 	s/conflitam/conflitarem/
>=20
> but I do not speak the language, so....  help?
>=20

This is OK. It matches the change s/est=C3=A1/estar=C3=A1/. I think the ten=
se I've
used is OK. But, then, I've been working much more with English than
with Portuguese for too much long a time. The tense Andr=C3=A9 has used see=
ms
more natural in Portuguese, I guess.

>     >  ------------------------------------------------
>     > @@ -230,14 +229,14 @@ $ git commit -a
>     >  ------------------------------------------------
>     >=20
>     >  neste ponto, os dois ramos divergiram, com diferentes mudan=C3=A7a=
s feitas em
>     > -cada um.  Para unificar as mudan=C3=A7as feitas no experimental pa=
ra o
>     > +cada um. Para unificar as mudan=C3=A7as feitas no experimental par=
a o
>     >  master, execute
>     >=20
>     >  ------------------------------------------------
>     >  $ git merge experimental
>     >  ------------------------------------------------
>     >=20
>     > -Se as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto.  Se exis=
tirem conflitos,
>     > +Caso as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto. Se exi=
stirem conflitos,
>=20
>     I think the time tense here should be changed if we change from "Se" =
to
>     "Caso". I'd rather keep "Se ... conflitam".
>=20

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpzPgsACgkQyTpryRcqtS3ajwCfce0XW3TMSejHCwZ896AjN9us
kW0An2U/IjGBq79FjpEqO0UgVmTUPSde
=FiVt
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
