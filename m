From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 19:31:31 +0000
Message-ID: <20140214193131.GI4582@vauxhall.crustytoothpaste.net>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RUqJLqMNe5u4kDWT"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:31:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOU9-0008KQ-8K
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbaBNTbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:31:35 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51911 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599AbaBNTbf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:31:35 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:485c:27a1:8772:5ef8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 665342807A;
	Fri, 14 Feb 2014 19:31:34 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242126>


--RUqJLqMNe5u4kDWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2014 at 01:59:41PM -0800, Junio C Hamano wrote:
> * bc/gpg-sign-everywhere (2014-02-11) 9 commits
>  - pull: add the --gpg-sign option.
>  - rebase: add the --gpg-sign option
>  - rebase: parse options in stuck-long mode
>  - rebase: don't try to match -M option
>  - rebase: remove useless arguments check
>  - am: add the --gpg-sign option
>  - am: parse options in stuck-long mode
>  - git-sh-setup.sh: add variable to use the stuck-long mode
>  - cherry-pick, revert: add the --gpg-sign option
>=20
>  Teach "--gpg-sign" option to many commands that create commits.
>=20
>  Changes to some scripted Porcelains use unsafe variable
>  substitutions and still need to be tightened.
>=20
>  Will merge to 'next'.

Junio, did you want a reroll with that fixed commit message, or will you
fix it up yourself?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--RUqJLqMNe5u4kDWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS/m8SAAoJEL9TXYEfUvaLmUQQALGt+xIn8S5RQABHer747vHe
/bNtSY64kKGEyKZxTvpMS2gB35MCitMMR6x3FLYKiA9aVIgf8yOh5Q4XNPIN7D/F
h5pfMqOWmLVj8PIsgD96FQMp9CL6s4CMNJ+W5c3tRage0X+mhtsCB3u/uPHT/JGN
TNmcpmUhYmXBta5dK2Gs3RvtHp9FWOLmTxJNZix+C962sslbARoaSjkHQQjrmOH/
25iJsVs1PYX2VvKyIonXif4B1B9FVOnVd8igq772VHYkd0qwgh940TKkg88U1KYm
UK6KBsigK2zTb/eIeOI15e7debmDO4Pdz5dXJ0A27S+b83S6xmYmlptgC78OJisE
1p2jFbfEZG/97f9ahrQMFWzGO21dEB4ZDfXtVvEcsvac+AJu/A9LwwAQ2JaE+q9m
vWlECDzSEC0RUHSj6qVpmlZAK1fdS+lOZCWmTpLbLHAF66HsPqK1p/ulV5aLV/tq
ATaEFIAx19ESOsBco9OnPnQ+en80z5KFpSAYh3InURT6Vd+OMXypgZIwn4E1q9fc
YRd4QZtlsYLZoaCediC575l/KkHjlrYWOcuHiSvYS4F2VN9+i2X5oxFPXdUb3+Nm
oLLR71QTc/XigwJ/rgn2ikT3YBmVgqNonCv5y7xRfMq3RKuU6MhZkbPbgujUk/qA
wnGSkHJ5rR1gGuJ3fRrA
=ZblZ
-----END PGP SIGNATURE-----

--RUqJLqMNe5u4kDWT--
