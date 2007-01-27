From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 20:12:05 +0100
Message-ID: <45BBA405.6050409@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.63.0701271959000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F7EE9C5551B6A0470AF47DC"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:12:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAsyF-00047s-K0
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXA0TMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXA0TMM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:12:12 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:41135 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXA0TML (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:12:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 858A22810F;
	Sat, 27 Jan 2007 20:12:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8aSYpH5bL3GM; Sat, 27 Jan 2007 20:12:09 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 2E71928108;
	Sat, 27 Jan 2007 20:12:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <Pine.LNX.4.63.0701271959000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37984>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F7EE9C5551B6A0470AF47DC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>> Okay, let's try to assume for now that nobody said "git blame". =20
>> Instead let's say:
>>
>> git rev-list and git log (with or without -p) perform poorly when=20
>> invoked with a pathspec.
>=20
> So what? You _will_ be interested in the _newest_ changes _99%_ of the =

> time. And for these you don't need to wait 1:18, but 0:00.01 or so.

not if you are interested which commit introduced/changed a particular li=
ne.

>> This particular file has 64 revisions.  However there are ~ 375000=20
>> revisions in the converted repo.
>=20
> "file version" trap! "file version" trap! "file version" trap!

call it path and retry.

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig8F7EE9C5551B6A0470AF47DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu6QIr5S+dk6z85oRAuUMAKC04dG4Jnzvs92cVY4kzh2inmDPDwCeIbCV
B34jBYrnrl/0cZP7nWTofxo=
=txZk
-----END PGP SIGNATURE-----

--------------enig8F7EE9C5551B6A0470AF47DC--
