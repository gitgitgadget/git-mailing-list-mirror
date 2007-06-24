From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 18:25:59 +0200
Message-ID: <20070624162559.GC6979@efreet.light.src>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com> <20070624065008.GA6979@efreet.light.src> <200706241314.46238.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 18:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Uud-0006G1-CE
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 18:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXFXQ0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXFXQ0F
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 12:26:05 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58213 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXFXQ0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 12:26:04 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8F30557295;
	Sun, 24 Jun 2007 18:26:01 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I2UuV-0000Nc-LM; Sun, 24 Jun 2007 18:25:59 +0200
Content-Disposition: inline
In-Reply-To: <200706241314.46238.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50801>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 24, 2007 at 13:14:45 +0200, Robin Rosenberg wrote:
> s=C3=B6ndag 24 juni 2007 skrev Jan Hudec:
> > IMHO it should be the default even for email format. Most projects that=
 use
> > non-ascii filenames probably have all members using same locale. And for
> > such group, it will just work. Also usually the file names, content and
> > commit messages will usually be in the same (though project-specific)
> > encoding, so if charset in content-type is set to that, people with=20
> different
> > locale able to represent the same characters will still see the names
> > correctly. For other people, the MUA will probably print some escape an=
yway
> > (it will not screw up the terminal -- it usually knows what it can safe=
ly
> > pass to it).
>=20
> I can't talk about "most" here, only local conditions, i.e. northern Euro=
pe=20
> where both the legacy ISO encodings are very common with a steady increas=
e in=20
> UTF-8 usage, in the Linux community. People using OSS in windows almost=
=20
> exclusively get the windows-1252 (for most practical purposes the same as=
=20
> ISO-8859-1).
>=20
> Even a *very* small set of random people you will wind up with people hav=
ing=20
> different locales.

A small set of *random* people will likely have different locales. But
a project that would use non-ascii filenames would probably use some
particular language and thus be run by people that all speak that language =
--
which means they are not random at all and probably will use the same local=
e.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGfpsXRel1vVwhjGURAthoAJ9GG3zfIyqre2djVQCYogPJ04Hc/gCfTA/8
tRqfueCbM+V2shTKVbO4wAg=
=rT9m
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
