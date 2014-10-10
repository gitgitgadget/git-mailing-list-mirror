From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-log documentation formatting
Date: Fri, 10 Oct 2014 21:20:30 +0000
Message-ID: <20141010212030.GA110761@vauxhall.crustytoothpaste.net>
References: <54382A67.4070601@rpi.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 23:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XchcA-0006Go-Md
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 23:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaJJVUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 17:20:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49193 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbaJJVUi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2014 17:20:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 75F062808F
	for <git@vger.kernel.org>; Fri, 10 Oct 2014 21:20:35 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <54382A67.4070601@rpi.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2014 at 02:50:15PM -0400, Cameron Smith wrote:
> The git-log documentation page
> http://git-scm.com/docs/git-log
> enters into a quoted block for the description of the "format:<string>"
> option and never exits.

Thanks for the report.  Someone noticed that a few days ago and I sent a
patch, which should be forthcoming in a future release of Git.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUOE2eAAoJEL9TXYEfUvaLC/cQAJfbmMCxg8Pcq7TR5Js3zweJ
QfQjYeuxF8NA7IVbTylW6ab4y/QBOErhQCZhXVjCP1IwXmokkzJ5UHFGv+WPjt55
kHbbajhRd5H+iXLszjJOfm8kgpKduwUqyBPpc03JCuyx+/hm52LydtHyzMRT4Jhj
DXkePsD3cWpdjd0KYfoHMYO8HEguDtdrcOfAhpouJikT5+R3hw06ZKsX7xfOFEpv
FkpsylGjOCESEkMw62udttoRut2A7iDNfL8ydKQVNaS8S0eEhY/8FdUdAtx/JXoS
gBX50s07ebw6GO9/FXpl04EWelnQ2vk7r8fKcTzUs2kXoBEzH3tbptehDkrqhQZx
SP2NXw8K3bRaBSmCO0BuG1ta1l5JndHnBItSWZWEQHdbNCObPA20AAJZTx32MSjN
lCWlFQRwRv6YS7yHvvsFIAsH52ZbX0IzT2Dbv+wSmHjKIZ9ikJ9iNOTg+gL678KY
woiIZ3R66TlMawSrBSC/ydRDPwcpcMC9JyFKG76Qg1YQmc83ZJP4s3CFZpmJQsbx
te/jaBVaakW0QA/h/GjAyj3kr0Iy8jYV/bbLxNQ4Y4NQeltZd3JdaFgF3wI4CDM1
F4eQrLqlU6ywwrNm2YWrUaPbB9gRY9N0LXlQ2Hc4liIZJFRmJQHhcGQpP1oRdbEl
SSfGTaU1Lew+AYOIorlH
=pnnC
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
