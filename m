From: Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?= 
	<alejandro.riveira@gmail.com>
Subject: Re: [PATCH]     git gui spanish translation.
Date: Wed, 03 Feb 2010 21:37:54 +0100
Message-ID: <1265229474.23299.15.camel@varda>
References: <4b69946c.0f67f10a.25e8.03e1@mx.google.com>
	 <F0288AB4-A1C8-4D72-BA2F-B35B0FDE4180@wincent.com>
Reply-To: alejandro.riveira@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-i5yEZyztwHJR4bNJpEI4"
Cc: git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nclz8-0007F7-4S
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738Ab0BCUh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:37:57 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:35054 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0BCUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:37:56 -0500
Received: by ewy28 with SMTP id 28so1923963ewy.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer;
        bh=WeG+wHT43ssoIgX28Q061ht+5Kqy/8v0vYLwTAaEE0s=;
        b=BicmXhRqxgJangfHazJz6yvleKau0ljiTIJQ7pW90/X9i6+bhLlBaGNI/0obzhVTet
         bTpGE3n/DHzslQHzNxcyZ0HvBsN4IUI0Yjw5jQQSTvqr4cWchzykXdS72C+5q+Sg9Wrx
         jUxe4zmYVXy7fscGWUaFSZA7NNqq/KkZrsqG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer;
        b=KMER+rcXDQP2vmUqPUaDknsPkjUbS5GotFYXgoHLe5SShjDtvEb6AbNrXmBodYC2PZ
         h6tC6g3qCwx+fvgsSsx805YcaYCHmW7BMknzz2Ws1C9ewJ9KgYTwN8UQvlqmuZawIR9f
         E50WPqJqcTaew/hA+sVDtbrNsjxurM4/17MKE=
Received: by 10.213.109.74 with SMTP id i10mr35160ebp.61.1265229474720;
        Wed, 03 Feb 2010 12:37:54 -0800 (PST)
Received: from ?10.0.0.2? (121.Red-88-24-214.staticIP.rima-tde.net [88.24.214.121])
        by mx.google.com with ESMTPS id 16sm148272ewy.14.2010.02.03.12.37.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 12:37:53 -0800 (PST)
In-Reply-To: <F0288AB4-A1C8-4D72-BA2F-B35B0FDE4180@wincent.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138888>


--=-i5yEZyztwHJR4bNJpEI4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 03-02-2010 a las 20:13 +0100, Wincent Colaiuta escribi=C3=B3:

Comments

>=20
> > +#: lib/branch_create.tcl:80
> > +msgid "Fast Forward Only"
> > +msgstr "Solo Fast Forward"
>=20
> Solo -> S=C3=B3lo

You only have to use s=C3=B3lo in case there is the posibility of
missanderstand it. Does not aply here or anywhere else in the
patch


>=20
> > +#: lib/browser.tcl:267 lib/browser.tcl:273
> > +msgid "Browse Branch Files"
> > +msgstr "Explora los ficheros de la rama"
>=20
> Explora -> Explorar
>=20
> You need to use the infinitive consistently for command verbs. You are =20
> doing it in some places but not in others.

Changed my mind during the translation about using one of the other ...



>=20
> Style issue here... Do you think "obtener" might be a better =20
> translation than "traer" here (and in the other places where you are =20
> translating "fetch")?


 I'm open to sugestions. the same problem with "commit" (either verb or
noun) tracking branch, push ( propagar is ok? ) etc...=20

 Those terms do not have a clear translation to spanish so we are
inventing language here


>=20
> Traer is closer to "bring", imo.

 Ok will ponder

> > +#: lib/merge.tcl:55
> > +#, tcl-format
> > +msgid ""
> > +"You are in the middle of a change.\n"
> > +"\n"
> > +"File %s is modified.\n"
> > +"\n"
> > +"You should complete the current commit before starting a merge.  =20
> > Doing so "
> > +"will help you abort a failed merge, should the need arise.\n"
> > +msgstr ""
> > +"Esta en el medio de un cambio.\n"
> > +"\n"
> > +"El fichero %s ha sido modificado.\n"
> > +"\n"
> > +"Deber=C3=ADa completar la revisi=C3=B3n actual antes de comenzar la f=
usi=C3=B3n.\n"
> > +"Hacer eso le ayudar=C3=A1 a cancelar una fusi=C3=B3n fallida si surgi=
ese la =20
> > \n"
> > +"necesidad.\n"
>=20
> Esta -> Est=C3=A1
>=20
> fallida -> fallada

They are equivalent=20




>=20
> > +#: lib/remote_branch_delete.tcl:189
> > +#, tcl-format
> > +msgid ""
> > +"One or more of the merge tests failed because you have not fetched =20
> > the "
> > +"necessary commits.  Try fetching from %s first."
> > +msgstr ""
> > +"Una o mas de las comprobaciones de fusi=C3=B3n fallaron porque no se =
=20
> > trajeron las\n"
> > +"revisones necesarias. Intente trayendolas de %s primero."
>=20
> Don't you think:
>=20
>    trayendolas -> traerlas

Ok



> > +#: lib/spellcheck.tcl:388
> > +msgid "Unexpected EOF from spell checker"
> > +msgstr "EOF inesperado desde el corrector ortogr=C3=A1fico"
>=20
> I'm not sure what the standard translation of EOF is, but seeing as it =20
> stands for "End Of File" it wouldn't surprise me if there is something =20
> similar in Spanish like "FDA" (Fin De Archivo) or something similar...?

 I think people use the EOF just like they use NULL or cd-rom or many
other neologism


> > +#: lib/transport.tcl:175
> > +msgid "Use thin pack (for slow network connections)"
> > +msgstr "Usar paquete ligero (thin pack) (para conexiones de red =20
> > lentas)"
>=20
> Don't think you need "thin pack" here.

Well believe my first translation had many other terms in both
English and Spanish. I feared to just create confusion translating
everything (because there are no docs in spanish)

>=20
> Cheers,
> Wincent
>=20
>=20
>=20


--=-i5yEZyztwHJR4bNJpEI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esto es una parte de mensaje firmado digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABAgAGBQJLad6hAAoJEDO4iEReSTB2aJoQAIsiff8B01Y/7ZRl6DzEUAsy
skwuyVlZEbJIyvhGLUXLcRbh7PnN3azRqcm8pCAqKuQ/3Oh7P9ixkUNFAU9cAXLo
OKM9PP0YzJ7E2JJL70koattxZou2eqHTjyOxiEVetQCEye+8Uae82buAuAySwrIp
Wj2uQJbgJ37nEfaWU4MwxT/mQ8Lqli3CHu/3GkkkAhyU+uhw9x3/4gI+yQuZ8tSn
S1bCvABOsNB6heQLqNVVZsYdRU1ICsNkL0jmhdvctLWbbyaWSVtW4q5C6UXDsnlA
O9dbKGzgYXzawS0WvC6rZOuoy5jhZN5tQxnwIS1dL2sMLFxB5G22QxW6m8903SKQ
81qsmTb9lst7tkxMHx+etuHK2ympRxxrjVQr0i+jRZDTAsf7swsli+12y5Tg8KEY
g4pNeol/lqTmYhiznhEOZp04cqN/rw2dFwrMtb8oWqfe/srSALmuPspqULDtZr6o
pHtLRWe58zTWTnYiYLCDDhtp0XJHBcMAehEFKqGzFYoL25Vz/Uu1wn2fnYLHYl7T
XnVQsGHvJREV62EdjbWh2Xrj9q7j8YMwhQwC9PAk4jAkdzw00HD5eShZnGgOMKXi
3dw8gGFL8LxW44t0ntTDK6+5ocLrIRAESXM4qsfmNq81I27zjFmYKJJ+I7sCoRU/
nmoiAmdW2Wu0Id/Uk1Wl
=wz2s
-----END PGP SIGNATURE-----

--=-i5yEZyztwHJR4bNJpEI4--
