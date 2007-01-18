From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Use standard -t option for touch.
Date: Thu, 18 Jan 2007 12:48:06 +0100
Message-ID: <45AF5E76.7020503@fs.ei.tum.de>
References: <20070118102814.0C32FA914@diphong.localdomain> <Pine.LNX.4.63.0701181147500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0694228606F6B9B30C690C01"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 12:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Vki-00024g-C7
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 12:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbXARLsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 06:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXARLsN
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 06:48:13 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:33046 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXARLsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 06:48:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 763A12815D;
	Thu, 18 Jan 2007 12:48:10 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CKkuRFKbIYAt; Thu, 18 Jan 2007 12:48:10 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-232.dynamic.mnet-online.de [62.216.203.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 1E17828133;
	Thu, 18 Jan 2007 12:48:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701181147500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37081>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0694228606F6B9B30C690C01
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> Simon, please don't use "undisclosed recipients". After all, this is=20
> _open_ source, and you make it really inconvenient to reply.

oh, sorry.  i just feed git-format-patch into sendmail. i'll need to teac=
h git-send-email to accept - for stdin.

>> Non-GNU touch do not have the -d option to take free form
>> date strings.  The POSIX -t option should be more widespread.
>> For this to work, date needs to output YYYYMMDDHHMM.SS date strings.
> I just checked on an SGI machine, and it has "-t". In related news, it =

> also has /usr/bin/printf.

thanks for checking!

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig0694228606F6B9B30C690C01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFr155r5S+dk6z85oRAtFXAJ9CRspMwyxMXdW8dtcPRliwEd8QPwCfVxF/
sDraMR/eX61Lrn8eSub4edA=
=1HlS
-----END PGP SIGNATURE-----

--------------enig0694228606F6B9B30C690C01--
