From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 01:07:31 +0100
Message-ID: <20071128000731.GD9174@efreet.light.src>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWk=?= Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxATB-0008TC-Os
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 01:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbXK1AHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbXK1AHm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 19:07:42 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:41092 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbXK1AHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 19:07:41 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A15B2572C4;
	Wed, 28 Nov 2007 01:07:40 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id XGeYNlDl8C1D; Wed, 28 Nov 2007 01:07:37 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 637D657336;
	Wed, 28 Nov 2007 01:07:36 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IxASh-0003RI-UN; Wed, 28 Nov 2007 01:07:31 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711271617350.27959@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66277>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2007 at 16:18:01 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 27 Nov 2007, Nguy=E1=BB=85n Th=C3=A1i Ngoc Duy wrote:
>=20
> >  Both configure and make-only ways should work now
>=20
> I thought your plan was to put the non-porcelain into the libexecdir only?

I had the impression that deprecating the dash notation for /all/ use was
approved some time ago. Though I don't want to search through the list
archives this late in the night to check it.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTLFDRel1vVwhjGURAm4rAJ9KqHl0WbbsaxrpbdXzoQVoHi4VYQCgv+Cp
EPSqtKdvhehZuKChTabFP94=
=IFWu
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
