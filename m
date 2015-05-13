From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Wed, 13 May 2015 22:22:56 +0000
Message-ID: <20150513222256.GB425227@vauxhall.crustytoothpaste.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <xmqqk2wdcfbb.fsf@gitster.dls.corp.google.com>
 <20150513034553.GA25025@peff.net>
 <xmqq8uctcd1u.fsf@gitster.dls.corp.google.com>
 <20150513043609.GA6038@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 00:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysf3W-0007HZ-CS
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 00:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965390AbbEMWXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 18:23:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38304 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965006AbbEMWXD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2015 18:23:03 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:307e:6849:ffff:3e6f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B0D9A2808F;
	Wed, 13 May 2015 22:23:00 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150513043609.GA6038@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269011>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 12:36:09AM -0400, Jeff King wrote:
> On Tue, May 12, 2015 at 09:32:45PM -0700, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > >> It obviously is not a title underline as the lengths are vastly
> > >> different.
> > >
> > > Yes, but Python Asciidoc allows the lengths to differ.
> >=20
> > Hmmm, I thought the title underline was a bit more strict. I do
> > recall having to fix manual pages for many commands, but we do not
> > add new commands these days anymore, so perhaps things have changed
> > since then.
>=20
> I think it is loose in AsciiDoc and strict in AsciiDoctor, so we have
> been slowly making sure they are all consistent. And we missed one,
> which will be in the series I'll send in a moment. :)
>=20
> I suspect the potential ambiguity is one of the reasons that AsciiDoctor
> went with the stricter rule.

The Python implementation allows a difference of =C2=B12, while Asciidoctor
only allows =C2=B11.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVU87AAAoJEL9TXYEfUvaLW94P/AmsbMiD3BEh4d7is88yoes7
36jZ3J/Ka3GgWMzFHPgLEJp4ps0GdkiIPbU6OE48Nm26FzFEm6KCaO2A+yW00PC7
CYPxoywNCNnp5eJXh9a81x1TFgpK7beCHf+MRgT1kR/bC3B94k0YF5y1IzwKWKHA
kvPiz8049kgf65H15CsweZiD7duLkw5aohqgQFyNn+fS+J7kK0VRqNURye2k3kWq
+K3ebiriM633gBkVRvOSf6Xd9YIvBuaiLrjqPP4z8E/oI8XyEuN0WABkV9plcLLl
M6kTTCE8K6JIOobO4EyJLEvx3ikZ9mwPew3coc0yaySO9NCNcrElVLr7wsGf2uMR
mRWZpf+uj1ivVDAN07+iw3O/7qNKC/M5SDn+i1roExMIS+mbkQLpQb+STfC7lz4k
AqQcCv6ts+xyf+YFoBmBNcFdjBUsdQxLZFLFCf9+MK024EqYh43ihnmNab70wqkq
ZmxKO9SFsPau5Ijfa4XigLS56ZeRMWbCO64QaPtxzCa52UInN29aYf5zwVfVay/u
rEvd/1C/Te1kMfcPuG4zvPbJVhDa75xs/b0OTepDN/uC0O0Vpqh1203W9Ss0OLRF
wFWWzeP3xEY6Aiv+6rONU8iSd/J/Ns7cmo/SHdSOgooq5P0nYUbyc4lbMeu6U4m3
0q15i+FsAIbFpHAPB03Y
=3jAy
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
