From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Thu, 18 Jan 2007 15:03:45 +0100
Message-ID: <45AF7E41.6060706@fs.ei.tum.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD7E19BA17FAAD1DAF5A0B00"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 15:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Xrt-0005Dw-G8
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXARODv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXARODv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:03:51 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:44021 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXARODu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:03:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 966ED28162;
	Thu, 18 Jan 2007 15:03:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id d66C7AsfXM4U; Thu, 18 Jan 2007 15:03:49 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-232.dynamic.mnet-online.de [62.216.203.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 3D8AE28120;
	Thu, 18 Jan 2007 15:03:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37091>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD7E19BA17FAAD1DAF5A0B00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>>> Why not teach the revision machinery to output in reverse with "--rev=
erse"?
>> I'm more in favour of "small is beautiful".  Also from looking at the =
code,
>> this seems to be a bit complicated.
> I'm more in favour of "less shell dependecy is beautiful". And from wha=
t I=20
> can tell, it should be relatively easy:

fair enough.  looks good!

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigBD7E19BA17FAAD1DAF5A0B00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFr35Er5S+dk6z85oRAulLAJ9oY355r52RBZte09JyQbct5d7lTQCfZ9Kg
EMbooA21qLShs/0Sc8Y/xJQ=
=673H
-----END PGP SIGNATURE-----

--------------enigBD7E19BA17FAAD1DAF5A0B00--
