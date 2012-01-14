From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git-upload-archive help was not shown correctly
Date: Sat, 14 Jan 2012 16:46:33 +0100
Message-ID: <20120114154633.GA3444@beez.lab.cmartin.tk>
References: <1326548416.5992.1.camel@devendra-Linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: git@vger.kernel.org
To: devendra <dev@savarinetworks.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 16:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm5og-0001nO-Ho
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 16:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab2ANPqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 10:46:37 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:49210 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035Ab2ANPqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 10:46:36 -0500
Received: from beez.lab.cmartin.tk (dslb-188-103-127-226.pools.arcor-ip.net [188.103.127.226])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5BEF5461BE;
	Sat, 14 Jan 2012 16:46:22 +0100 (CET)
Received: (nullmailer pid 27466 invoked by uid 1000);
	Sat, 14 Jan 2012 15:46:33 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	devendra <dev@savarinetworks.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1326548416.5992.1.camel@devendra-Linux>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188573>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2012 at 07:10:16PM +0530, devendra wrote:
> Hi git folks,
>=20
> the command git-upload-archive is not properly showing usage info when
> ran barely with out any args.

git-upload-package is not for human use. It's what gets run on the
remote end when you run e.g. 'git archive --remote=3Dorigin HEAD'

>=20
> it shows some kind of unwanted garbage instead of showing a nice help
> message.

It's trying to talk to git. What you see is the "Git Smart
Protocol". What were you trying to do?

   cmn

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPEaNZAAoJEHKRP1jG7ZzTbggH/iM1r8+XOfEA4nmydlP/K+fC
rsFSDXTI/0gQmavmN54YoXqNtjEJHY2X7E8O8drHCSKqDkzBbOBfRNf8P5RZnGDp
3F7exrRJr6wqolBUYwh+2AU8LGioRNYzqsepQQohO/cDkuXKTSbayCC0l0/xSpGP
JlZfWn+GIIBVYvHHrRDURFGPGAn8wHmhhf3NdjuNXy+cMKUVgopMVLTTdMvHa5GG
vOCzTg1PK4gO3OlULCbIa6TMgPXklIV2KROWUv5a0hGnIgo42E1x320HDIJKDJWv
QYn27W25svx4e/s2DCdAO/RUR+4hYWHGlMl5n1dHaLhxRU7hGGs1eyOz9mNYYRA=
=tbd9
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
