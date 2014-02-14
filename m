From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Download of the latest release of git 1.8.5.5 does not work
Date: Fri, 14 Feb 2014 19:24:59 +0000
Message-ID: <20140214192458.GH4582@vauxhall.crustytoothpaste.net>
References: <trinity-0bf03514-306b-4d2b-a3fa-f34ef84f4e66-1392369695708@3capp-1and1-bs01>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Cc: git@vger.kernel.org
To: Peter Marx <marx.tholey@online.de>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEONr-0001wy-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbaBNTZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:25:05 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51909 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751938AbaBNTZE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:25:04 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:485c:27a1:8772:5ef8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BD7452807A;
	Fri, 14 Feb 2014 19:25:02 +0000 (UTC)
Mail-Followup-To: Peter Marx <marx.tholey@online.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <trinity-0bf03514-306b-4d2b-a3fa-f34ef84f4e66-1392369695708@3capp-1and1-bs01>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242125>


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2014 at 10:21:35AM +0100, Peter Marx wrote:
> Hello,
>
> On your web-side  http://git-scm.com I see following information
> Latest stable release
> 1.8.5.5
> Release Notes (2014-02-13)
>
> When I click on the link Download for Windows the page "http://git-scm.co=
m/download/win" is opened
> and the download of file "Git-1.8.5.2-preview20131230.exe" started.
>
> I would like to download the latest release 1.8.5.5 but this is not possi=
ble.
>
> Could you check your web-side and add the latest release to it.

The version number is the version of the latest source release.  On
systems where code is not generally built directly from source (Mac OS X
and Windows), independent groups of people build these versions and then
upload them.  You can always attempt to build the latest source
yourself, though.

Also, the git-scm.com site isn't maintained by the Git project; it's
maintained at https://github.com/git/git-scm.com.  What you're seeing
appears to be issue #268 at that project:
https://github.com/git/git-scm.com/issues/268.  That's probably the
most appropriate place to go.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS/m2KAAoJEL9TXYEfUvaLcJsQAJvmJS0fNC81z+d387oOEihm
XeKt765+E1HTfQZ4SZHVzSV1+k0QUjaJH7Q3DnKtRVSUiJJZzRZWMjRhSW0sc2jH
5cVZMpIhXYTCt8m3YvjVqxPKRP6G4vxtUV5APy2SJhZP2AWB2cLnilLquO/P6h0c
/i4Fp3jDtaF2B3XZKdJ+NfbUmW60B1PK7+D9lk/LRIKsfGui5kM/KyVIvS6yXQ01
iKimGg7IDA+ctbH48OE6w8N5GeV3w5s1VJZeQQ6swnG6vSO6ML4vODNQEXiQrxwk
nSkJslSq4o/mwqoBJyt4lvvHyGBnB/PLIDyPBNx1u3ncZqVyZNk94N/oXbefjVmT
ia7GA24wpBehqcqQ7SBiWywbTjTCbgKJualNM4Fo4CY1R8bqnnEUJggYXLPDQQMe
Pum2XmdejBiEIMZ2Kg7t2k1ozl/Iaj5RCzR995Ki1UHxnkOE0kFoJHnhI1zqW3M/
6DrWPo91gLTHRhp3Hr6Jp/A6Q0ks/tVLEJdgZ+SY/BHEHzFHxUf6eXujI4tbBdqq
UWImc6/K7WMzazZ9LqHN/lL1vJhyPM4e1VhKcVApHzXvELhY1mBnlm9gw+lUzrq4
k894mhflxQnnO0hJ8TP7zrpe4crXT5CcXsBD9PMAI6rnGWup/+zvzc+pwxaE3SsY
J6Qfv9RrGger3ZtkQ88b
=0eXW
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
