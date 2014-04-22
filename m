From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 02:12:56 +0000
Message-ID: <20140422021256.GC86681@vauxhall.crustytoothpaste.net>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 04:13:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcQCr-0005yp-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 04:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbaDVCND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 22:13:03 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47237 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217AbaDVCNC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Apr 2014 22:13:02 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:39ef:2a55:6e19:355e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E343C28087;
	Tue, 22 Apr 2014 02:12:59 +0000 (UTC)
Mail-Followup-To: Sebastian Schuberth <sschuberth@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53557071.5040500@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246685>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2014 at 09:24:33PM +0200, Sebastian Schuberth wrote:
> BTW, in my experience people tend to stick to predefined aliases instead =
of
> redefining them to something (completely) different. This means that havi=
ng
> default aliases will very likely enable one to use the same short commands
> on one's colleague's PC (instead of you running into issues because the s=
ame
> alias was defined to a different command).
>=20
> If we don't standardize this now people will come up with their own
> definitions [1] [2] (and many others if you just search GitHub) which are
> again likely to differ (slightly), hindering interoperability.

Unfortunately, that's already happened.  Some people alias ci to commit,
and some people alias it to commit -a.  There is literally no choice you
can make there that will make everyone happy.

If you provide default aliases, people will expect them to work
everywhere, and then be confused when they don't.  It's much better to
let people alias what they want on their own.  I understand the
frustration of having to work on others' machines when they don't have
your aliases, because every time I type "git pff"[0] and it fails, it
drives me crazy, but there's just no sane defaults.

[0] Aliased to git pull --ff-only.  I probably run this at least twenty
times a day.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTVdAoAAoJEL9TXYEfUvaLKwAP/0mluE5FnfG9/uhv5j9xvfe1
GeGpzSip8vCJUxwck7Ql42bhyBz9ozoZdtuLSbUUIv+P2WgzxBldIM3bH7+j6MAe
X+W7/ag0zwH1PrmzokbPZS4syXTHk3NEyO8Lm1yoLOsVxgrB5A6K3L8KkcD2BKK7
7N/CLzgrXOouuzoXeYARvs+sAXPnc0ILk5WbMkCiM6PewRMb7KE5nGenJmB0C6on
b8B3xmBp4j3mk7xMjpy2oWkvR9MGL3nVil1SXCKEaloSq5OT6h02OQgwuE7YMG4M
s7jbpBB7jjELA4JbSFpEUZ7FLNVHPCxCenNa4Z7D3VYn565fTeTukgybWpiaF4RF
KamznRfgk1ZvLBZzw83zM5/EbFnJoQw9QKoAlfoBtQeUMZAya9tOei9eG+WiaHAH
LOiTKOYSzfOJvldjWMfx0kz3EF3xOTtx+gJzPmjX7RtlPH3BRCBSaPtrwW+4Zraw
9d65N2DOpXVlHXJRxBZE/b/TbxhzJepaoTYokcfUfVjeerZoNhf1ikeQuwmwBhRi
6AwIZh30gHrazdpA1LRfGW6WwnXwKawEWWZ4RENq1UDTn4JnQ0cnsTQTNCBKy0Zc
y9Ty2wK3AwolraDhdDgTMARjWYdao1gUJvMKZ10s7DG5csI6DmPV18Mj4PlAorQ1
Bl5hXeVh3LwLYu86zvv7
=AitW
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
