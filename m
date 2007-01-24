From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 15:28:57 +0100
Message-ID: <45B76D29.3090207@fs.ei.tum.de>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com> <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com> <7vps94fweq.fsf@assigned-by-dhcp.cox.net> <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701241456230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04BA023D988AA69C5260CF90"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 15:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9j7g-0003YG-Ip
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXAXO3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXAXO3J
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:29:09 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:57084 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXAXO3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:29:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id C1FDC281B6;
	Wed, 24 Jan 2007 15:29:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zXfz4nviewz0; Wed, 24 Jan 2007 15:29:03 +0100 (CET)
Received: from [62.216.208.170] (ppp-62-216-208-170.dynamic.mnet-online.de [62.216.208.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 0A8F2281AA;
	Wed, 24 Jan 2007 15:29:02 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0701241456230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37643>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04BA023D988AA69C5260CF90
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>> This should be obvious to people who know git, but the above
>> does not mean we can remove gXXXX part from the describe output,
>> becauses there could be infinite number of commits that are 256
>> commits away from v2.6.20-rc5 tag.
> This is only completely true if "infinite" is smaller than 2^160...

actually not.  you can have more, but then even the hash isn't unique any=
more.  oh no!

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig04BA023D988AA69C5260CF90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFt20sr5S+dk6z85oRAo7yAKDAdpGleq2pxPCfikMQgJCrrNodQQCeP/rH
gslad+7/aAhqCQypsJOSzj8=
=LryI
-----END PGP SIGNATURE-----

--------------enig04BA023D988AA69C5260CF90--
