From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [PATCH] Documentation: fix git-config.xml generation
Date: Wed, 23 May 2007 23:55:27 -0500
Message-ID: <1179982527.3682.21.camel@lt21223.campus.dmacc.edu>
References: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com>
	 <1179979802.3682.12.camel@lt21223.campus.dmacc.edu>
	 <7vhcq2zw7y.fsf@assigned-by-dhcp.cox.net>
	 <1179981812.3682.16.camel@lt21223.campus.dmacc.edu>
	 <20070524044736.GH28023@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wutvlGmkUXS4H2RRrcrn"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 06:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr5LG-0005WA-H7
	for gcvg-git@gmane.org; Thu, 24 May 2007 06:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321AbXEXEyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 00:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758874AbXEXEyX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 00:54:23 -0400
Received: from homer.isunet.net ([63.175.164.9]:43377 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758321AbXEXEyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 00:54:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 3C12F3881E8
	for <git@vger.kernel.org>; Wed, 23 May 2007 23:01:25 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 18941-07 for <git@vger.kernel.org>; Wed, 23 May 2007 23:01:24 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 7264B38806A
	for <git@vger.kernel.org>; Wed, 23 May 2007 23:01:24 -0500 (CDT)
Received: from [172.16.0.186]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1Hr5LJ-0005WO-Lv
	for git@vger.kernel.org; Wed, 23 May 2007 23:54:29 -0500
In-Reply-To: <20070524044736.GH28023@spearce.org>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48221>


--=-wutvlGmkUXS4H2RRrcrn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-24 at 00:47 -0400, Shawn O. Pearce wrote:
>=20
> kernel.org has mirroring lags.  When Junio pushes to kernel.org
> he also pushes to repo.or.cz/alt-git.git.  That's usually where
> I fetch from, as there's no mirroring lag at all.
>=20
> Note that repo.or.cz also has a git.git, which is a mirror of
> kernel.org's mirrors, so its uh, way way behind sometimes.  ;-)

Yes, I looked at all three, but didn't see it.  It's not a big deal, as
I've applied the patch locally.

Jeff

--=-wutvlGmkUXS4H2RRrcrn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGVRq6rtk7xyyIQRERAlhMAKCDTlJIGzD2GmLfbpCRkHfB3DRSVgCfbx8E
qZ09Q3SPW2psX3tW5B6c2AU=
=Bol3
-----END PGP SIGNATURE-----

--=-wutvlGmkUXS4H2RRrcrn--
