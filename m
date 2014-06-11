From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/11] Zsh prompt tests
Date: Wed, 11 Jun 2014 23:46:21 +0000
Message-ID: <20140611234620.GC368384@vauxhall.crustytoothpaste.net>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
 <53976563.5020905@web.de>
 <53976A7E.8010001@bbn.com>
 <20140611011617.GB368384@vauxhall.crustytoothpaste.net>
 <5398755B.4050601@bbn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WusDw-0004gW-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 01:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbaFKXq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 19:46:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48270 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbaFKXq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 19:46:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:897d:9e98:725a:bcd7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A96DA2808E;
	Wed, 11 Jun 2014 23:46:26 +0000 (UTC)
Mail-Followup-To: Richard Hansen <rhansen@bbn.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5398755B.4050601@bbn.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251392>


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2014 at 11:27:23AM -0400, Richard Hansen wrote:
> On 2014-06-10 21:16, brian m. carlson wrote:
> > Skipping them on older versions (maybe using is-at-least) would be
> > fine by me.
>=20
> I don't think we'll need to skip the tests on old zsh versions --
> running 'zsh -c' should still work even if 'emulate zsh -c' doesn't.

Okay.  I honestly don't support CentOS 5 in my personal projects because
it's very old, so I didn't want you to have to do a lot of extra work if
you felt that the age didn't justify it.  Most git users on CentOS 5
already deal with some minor reduced functionality anyways.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTmOpMAAoJEL9TXYEfUvaL7NgP/icuLpMVix3uxksYjdRM4qa1
h+thUwimJst8xFLwegr2a7qTG40NqNujAD/I7g1napXKzuI1QSmCM/WOJAc6synG
5790l9G2TcKZ104VTTj4faiCP/2IvdTFNA3HgXhEtQqKTuhLqSXaBCamYvmu147P
sMuadmdCGaPfQUUytmwKLXfI3bqwBY9h29FugbKqraCLXW0JN/fRyOlijINXMA9/
emWIWvN01Zo0RlMbvJwTyKHVANyfFdnij4Ai99fWlqMqm9F6p5mMOlzOscbIA0rG
pkgI2Do89VwEuER8FInL58HIvexxRideUBawYlfwuU4kDkR6wypJ6AUbr5A3bte3
RIWd9AjRNpugbistyBKs2EL1qFnE5dr7lPF4A1s3ct+ZtWwJJKlIBENvNWVvybpd
HUu8QfyyijftGrq98zXf8LApmF/ia6YV0Ph7zwBLP5GMawsC/yhE+k9XgETXY1fL
9+MF52G96db2NWoXukJoOA2u2Xj+TdV/Pxq4Lfyl1iByLHR6i6JvBdPDKTQuRuO5
cjUF7rrXs5QBaVMVgIdcS0mvwxxO2maHg78m3EbjZ1pbvb7bBWIIBKdU7xZTkyJa
/a4oBy4XNGj7k74aMokyVdcBEbhqQDORM1dRhDvHPwupw8vxLBC5lGxGktJwDOwF
xBfXTf2M/l0HzH8qqFPP
=qvDA
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
