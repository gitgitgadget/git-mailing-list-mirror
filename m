From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 15:02:10 +0200
Message-ID: <20070512130210.GA32764@efreet.light.src>
References: <20070510215515.3084.qmail@science.horizon.com> <81b0412b0705110454w5b18c267x17e82453e736f0b8@mail.gmail.com> <9909dee80705110537j7e6d1426p7723c110c0a2c667@mail.gmail.com> <9909dee80705110541m13c4035tc8338e179d6bec9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Cc: git@vger.kernel.org
To: Eugine Kosenko <eugine.kosenko@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 15:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmrF9-0003IE-G9
	for gcvg-git@gmane.org; Sat, 12 May 2007 15:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXELNCd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 09:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbXELNCd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 09:02:33 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4288 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751739AbXELNCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 09:02:32 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.194975;
	Sat, 12 May 2007 15:02:10 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmrEg-0000EQ-MR; Sat, 12 May 2007 15:02:10 +0200
Content-Disposition: inline
In-Reply-To: <9909dee80705110541m13c4035tc8338e179d6bec9b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47043>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2007 at 15:41:45 +0300, Eugine Kosenko wrote:
> 2007/5/11, Alex Riesen <raa.lkml@gmail.com>:
> >And it is not enough. Authorship information is lost.
>=20
> If one dare to make such super-commit, he would be the author of the
> whole couple of changes.

No, he would not. He would be committer, but the change would still be based
on the work of the original authors and therefore would have to be attribut=
ed
to them (and especially they would still remain copyright holders).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRbrSRel1vVwhjGURAm1uAJ9tGzwVXfNUZDS5+V4GPoydTK+EvgCglEGz
vv6pYyaZ91yCLEd3mqvKGmw=
=B6SM
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
