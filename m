From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Use inttypes.h rather than stdint.h.
Date: Fri, 26 Jan 2007 07:55:06 +0100
Message-ID: <45B9A5CA.1020801@fs.ei.tum.de>
References: <24182.1169759500@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD45FD7225A28985670C295EB"
Cc: git@vger.kernel.org
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKzb-0003Vn-9V
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030808AbXAZGzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030801AbXAZGzS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:55:18 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:49984 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030808AbXAZGzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:55:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id B9730281EE;
	Fri, 26 Jan 2007 07:55:14 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zVCXKWG1iGjV; Fri, 26 Jan 2007 07:55:14 +0100 (CET)
Received: from [62.216.203.38] (ppp-62-216-203-38.dynamic.mnet-online.de [62.216.203.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 459E3281ED;
	Fri, 26 Jan 2007 07:55:14 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <24182.1169759500@lotus.CS.Berkeley.EDU>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37808>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD45FD7225A28985670C295EB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Jason Riedy wrote:
> Older Solaris machines lack stdint.h but have inttypes.h.
> The standard has inttypes.h including stdint.h, so at worst
> this pollutes the namespace a bit.

my appologies for not researching enough.  thanks for this correction.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigD45FD7225A28985670C295EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuaXOr5S+dk6z85oRAlRsAKDUdsgjXlQQ2VGfqvtvdg979CYGxwCfeChs
028JAL9Kuha11CAuHZ+zyxY=
=g8wx
-----END PGP SIGNATURE-----

--------------enigD45FD7225A28985670C295EB--
