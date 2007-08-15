From: Jan Hudec <bulb@ucw.cz>
Subject: Re: call external editor from git-gui?
Date: Wed, 15 Aug 2007 20:22:28 +0200
Message-ID: <20070815182228.GA3419@efreet.light.src>
References: <20070810153008.GA31759@diana.vm.bytemark.co.uk> <20070814045511.GF27913@spearce.org> <20070814070000.GA12052@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILNc0-0001qf-8K
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 20:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbXHOS2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbXHOS2x
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 14:28:53 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:54222 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbXHOS2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 14:28:52 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id F113D572B0;
	Wed, 15 Aug 2007 20:28:50 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id bz0pVG6HBNes; Wed, 15 Aug 2007 20:28:49 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1B0A4572B2;
	Wed, 15 Aug 2007 20:28:47 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ILNVk-00011V-9s; Wed, 15 Aug 2007 20:22:28 +0200
Content-Disposition: inline
In-Reply-To: <20070814070000.GA12052@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55933>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2007 at 09:00:00 +0200, Karl Hasselstr=C3=B6m wrote:
> On 2007-08-14 00:55:11 -0400, Shawn O. Pearce wrote:
> > Spawning the user's preferred editor would be a nice way to get some
> > of that.
>=20
> Mmm. I wouldn't call it a _nice_ way: popping up an external program
> just to get the right text editing behavior. More like the _only_ way,
> if the user is picky enough.

It might actually have a rather serious twist. Often the editor for
git-commit would use the terminal git-commit runs on. But for git-gui you m=
ay
not have any terminal (running git-gui from context menu of some file
manager) and even if you do, the user does not expect it to be used. So the
user may -- and quite often will -- want different editors for running from
git-gui and git-commit.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGw0RkRel1vVwhjGURAmZfAKDAx6hILBHroya6jneWkJ3uk1JQYACgkwZg
ZPK1uiE2iCIetRaysdgO+N0=
=WMv3
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
