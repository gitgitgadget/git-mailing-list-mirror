From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [GSoC][PATCH v2] log: forbid log --graph --no-walk
Date: Sun, 15 Mar 2015 00:04:41 +0000
Message-ID: <20150315000440.GB612775@vauxhall.crustytoothpaste.net>
References: <md5:Tyvg1g0l6oUcTR3FnSDstw==>
 <5504C533.7060304@norn.io>
 <20150314234718.GA612775@vauxhall.crustytoothpaste.net>
 <5504CA70.2030602@norn.io>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Cc: git@vger.kernel.org, me@ikke.info, gitster@pobox.com, peff@peff.net
To: epilys <epilys@norn.io>
X-From: git-owner@vger.kernel.org Sun Mar 15 01:04:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWw34-0007mV-8B
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 01:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbCOAEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 20:04:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50206 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752415AbbCOAEp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 20:04:45 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:8dad:5aaf:e3cd:b210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 648CF2808F;
	Sun, 15 Mar 2015 00:04:44 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	epilys <epilys@norn.io>, git@vger.kernel.org, me@ikke.info,
	gitster@pobox.com, peff@peff.net
Content-Disposition: inline
In-Reply-To: <5504CA70.2030602@norn.io>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265469>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2015 at 01:55:28AM +0200, epilys wrote:
> On 03/15/2015 01:47 AM, brian m. carlson wrote:
> > It looks like you indented here with four spaces instead of a tab.=20
> > We prefer tabs in Git.
>=20
> Messed that up. Do you think I should resubmit a v3 or am I hogging
> the mailing list too much?

You're going to want to submit a v3.  While you're at it, you probably
want to drop the [GSoC] from the patch header, as it will be part of the
commit message when applied, and we don't want that.  Finally, you
probably want to use your full name in the From: line, as that will be
used to create the commit, and we prefer full names over aliases as well.

It can be helpful to try formatting the patch with git format-patch and
then checking over it with less and applying it with git am to see how
it will look to other Git developers.

This is a small patch, so it's not as big a deal, but for larger series
I generally try to wait two or three days (at least one of which is a
weekday) before posting a new version so that people have time to read,
test, and comment on it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVBMyYAAoJEL9TXYEfUvaLQCQP/indr0RH/o9E0btrCZBWwZ27
6iAOTcyOHNbOyiBhHG8WrNgo0wcA74hGVeq3cJdINRWAEh0K1i8FjC49YxzYgEv/
vZE10ggs2tB5w5pGXkTrQM70oVTtN63pJ0A1TQv9EbORJh3jjbKnw0qMOXmVtRcW
oPO4KSvNYMM8ovZET6dXvyOnWfnhwFEhH1L862+5E64HnPdSWe9S9rZjqrEkSdWC
BM0zlDOk+klptybK3ZU5L3eTc2257HQKgEb2JNI5FLMKVeFGMUKkXm7cHoxLt6di
ZNWmeVEXoF2a75a6N63sIv7IbamaOBktI3SYn3tq8YzJA7U6G0GGnoQEJ0DI1Hd2
yRBR8J8j/65/WkODdDQ7QMQDXGygKflB4Obfb6sggPtKxTqsHx4TIvGPyTSaLyJC
Bu4+Iv0M5AvX4wNEPUNoUTKj9RcJyjHzhIPS6upmDiNPcOekLYr5GbkS+bP68Urg
wKoCv8tOLMVFfXlGa+e3rzBoV0yX9U1USOjlTpsZNdWhIPbNyIY3TeeaGF2P9eIp
HnUJDkjsMiXj57WTo1r/FX1OWcaSykjx0SyxTzA/UpKH1iFj2tfwEbjIETryRpO4
fOK9s11RpkRoeWOJC14XaIYrGYMXxhase2D0/ajuSDvO30qZ56G4wRme7N6AXdq5
FxbcC+18YcJCS3g7vbQs
=cVWE
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
