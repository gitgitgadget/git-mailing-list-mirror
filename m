From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git push (mis ?)behavior
Date: Thu, 27 Sep 2007 17:28:55 +0200
Message-ID: <AB062710-F4F6-4B84-BF8A-676154656CCB@lrde.epita.fr>
References: <20070927130447.GH10289@artemis.corp> <0CAD1C47-A396-46AA-9DC0-96BBD41EE4E4@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--1145573"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 17:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IavIt-0003Uv-Fi
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 17:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbXI0P3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 11:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754354AbXI0P3U
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 11:29:20 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:42820 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbXI0P3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 11:29:19 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IavIj-0005QA-Ep; Thu, 27 Sep 2007 17:29:17 +0200
In-Reply-To: <0CAD1C47-A396-46AA-9DC0-96BBD41EE4E4@wincent.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59302>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--1145573
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Sep 27, 2007, at 3:30 PM, Wincent Colaiuta wrote:

> El 27/9/2007, a las 15:04, Pierre Habouzit escribi=F3:
>
>>   There is a behavior of git-push that is the most annoying thing =20
>> while
>> working with a central-repository: `git push` without any arguments
>> insists on pushing every local refspec that match one in origin.
>
> I kind of agree. Without reading the git-push man page I would =20
> intuitively expect "git push" with no arguments to push only the =20
> branch I currently have checked out, and "git push --all" to push all.

Same thing here, got bitten the same way.

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-5--1145573
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG+8w3wwE67wC8PUkRAu5bAJ4v+ZSNBgLTYVx49ortBlbCkJD3tACgolIr
aLy1zvWUmDy3oqlUj81nmV8=
=GGz+
-----END PGP SIGNATURE-----

--Apple-Mail-5--1145573--
