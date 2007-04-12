From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: rcs import?
Date: Thu, 12 Apr 2007 17:09:05 +0200
Message-ID: <461E4B91.5020602@fs.ei.tum.de>
References: <m3r6qpdfhx.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC79FDBA80E97DDE5B8C80D0B"
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc0vP-0004HR-S7
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 17:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXDLPJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 11:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbXDLPJN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 11:09:13 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:55020 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXDLPJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 11:09:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 2AA0E2849B;
	Thu, 12 Apr 2007 17:09:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zTQgWNqrxttO; Thu, 12 Apr 2007 17:09:09 +0200 (CEST)
Received: from [62.216.208.65] (ppp-62-216-208-65.dynamic.mnet-online.de [62.216.208.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9EE5B2821F;
	Thu, 12 Apr 2007 17:09:09 +0200 (CEST)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <m3r6qpdfhx.fsf@lugabout.jhcloos.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44340>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC79FDBA80E97DDE5B8C80D0B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

James Cloos wrote:
> Has anyone written import support for rcs repos?
>=20
> (I've a few config hierarchies using RCS I'd like to convert.)

you can use my fromcvs importer, which should work with RCS repos as well=
=2E  tell me how it works.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigC79FDBA80E97DDE5B8C80D0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGHkuTr5S+dk6z85oRAuEZAJjK8XNAhcYzePJ+F+uvJ3On4c02AKDpSUSW
DcE4kftrgAgBZpdt3USqVw==
=RhXZ
-----END PGP SIGNATURE-----

--------------enigC79FDBA80E97DDE5B8C80D0B--
