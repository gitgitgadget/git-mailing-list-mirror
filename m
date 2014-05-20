From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/5] t4041, t4205, t6006, t7102: Don't hardcode tested
 encoding value
Date: Tue, 20 May 2014 01:49:31 +0000
Message-ID: <20140520014931.GF180798@vauxhall.crustytoothpaste.net>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
 <cover.1400513063.git.Alex.Crezoff@gmail.com>
 <b7914b89c94560d61e2cd3369d6e1402710457ee.1400513063.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:03:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmZBY-0003Ub-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 03:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbaETBtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 21:49:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47838 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751275AbaETBtj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2014 21:49:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9d23:25b3:8261:f09a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0167128087;
	Tue, 20 May 2014 01:49:37 +0000 (UTC)
Mail-Followup-To: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <b7914b89c94560d61e2cd3369d6e1402710457ee.1400513063.git.Alex.Crezoff@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249644>


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 07:28:17PM +0400, Alexey Shumkin wrote:
> The tested encoding is always available in a variable. Use it instead of
> hardcoding. Also, to be in line with other tests use ISO8859-1
> (uppercase) rather then iso8895-1.

You wrote "iso8895" when I think you meant "iso8859".

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTerSrAAoJEL9TXYEfUvaLnqoQALVo4LlctHGa+v4kWZymqisk
Je6rjOfCO8qpToscXsAKdCrWNHLFF0fsbvvPNmPmz6n4QRQMicZtQdZlyWIMmK6M
UveqAIaNA4ZWIPWLFBWjAVZn0g/MzqA/ekvPdRwgOSmUDjInFC0UmftzyC1V0PaP
a62A5PfykT8yhLE2208zpFum8ahp6Fgcns/cxdfU4REWRYApGRodbW5IgEp8LyrB
JkROrN04OxcvG/BcsZMZDyyfPCrgB6S1wWNkfIxIYw6EM12wCod8ry1vDOl3IxP2
6z3Zb82QspAX4YBv66MMTwcR2AckqMXIdKbgAc/w/aa7UprIa+ACtLM6V8HEA/tY
EGrZXzXU1hQ+8TX99vEspsUm8QYgS1qVp3AXh1A4pD+Na31xx/CnWFTb1on/9r1b
A1uMaUktlOkXakor0gaqqYhseNvvkLQV/qovzR403up3GZAgh4J8N0kXzHjkoxgm
n60euBRRwNBzccELvGMlPSAyv9y6rYhOZ+VHUJS0OrJb80Ae+6OXQpr0TCsbg7V7
9dLni7ls0harRWrf7CssDeaCj13ukmkFUFvgEIERyQZQ1Nb2pvn5F0NLmeq8imF3
OTVxoWSWXdiEABaF2mluWrWlYwrw1nyhyLsrq/O1ww5FDfqHz6Yo3hVG8/Rvl5vO
/9WzI1XptQoI6t1jWHKS
=RJpe
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
