From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] git-submodule update: Add --commit option
Date: Thu, 29 Nov 2012 11:21:54 -0500
Message-ID: <20121129162154.GA27409@odin.tremily.us>
References: <20121127185142.GB4185@book.hvoigt.net>
 <cover.1354130656.git.wking@tremily.us>
 <20121129161216.GB23580@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=M9NhX3UHpAaciwkO
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:22:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te6ss-0003rc-87
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab2K2QW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:22:27 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:23751 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2K2QWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:22:25 -0500
Received: from odin.tremily.us ([unknown] [72.68.105.242])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME900HR3C4ISW90@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 29 Nov 2012 10:22:06 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7048D6E23AB; Thu,
 29 Nov 2012 11:21:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354206114; bh=ZQEvZOyKgeQOTmTN+0mP3U2ktOIKmFJj1EsrSZCZ7W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8rYS5JP4/+JtQuu5n3Itd6/aaH70a8BiKFmntRHrRRpk8OHgHDLZyuIvP3tYZ/q+
 d4B0vqWrSlpXh7ib9+Hcgcrh7RGCck+eK6gSQCEo+/qzXeMQYLAu+WMLv+nYzJQZlt
 HqFDGgw/6Y1Rq8OBDw6zV1MQda/j2vY9r+/PJnFc=
Content-disposition: inline
In-reply-to: <20121129161216.GB23580@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210841>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2012 at 11:12:16AM -0500, W. Trevor King wrote:
> +  test "a" =3D "b"

This kills the test (with --immediate) so you can look at the
generated commit.  If you actually want the test to pass (e.g. if this
becomes a PATCH and not an RFC), this line should be removed.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQt4uhAAoJEEUbTsx0l5OMHIwP/1bAP0uJvEsNFpEK145f6tAd
ur8+zal9Mmn4+OGBSSZvJxi5N+Yw8eahMfGvshQcldf9too/m5rboYh7jCHBl+kJ
AbRn8cbeWUBnCRLwE+2nKWioA8SrhuFZb33DzSyyf+r/B7Tgd1LWuZGrBGVh8Uqi
BH6+nnlueWNg6lGAgB4vkubvcUPQFZ1NvNS6FhrXSR3cBUHGK1AHkmXOzZKLJgvu
lF8YQfa3FZfo2VQQuKGUHWoKkXS7Jcg3tjRHDjOahZmg8zjl21tO7FO+X1h0xhC1
dKuEP0jwBNAzM0HA/mdC9Vyi9/TKR/EwEqmGuXhET9j7vxf0YMgqIdMGxuGSGACm
qNY+tLM1bxmp41t9JQWEJHf/WEzqVHWvt5vT05W//POcCItv2gSWe695EQcasE6R
q3S2j2hcj2tXH7skM6EXjEa0AWM1dzRl2H2dtKeA7cg8PXBeTk+5DIhRyyorZgVb
uJ5lHeM4hox/nQ9vFNcgMucTaaj6vYYP72Eu1Med2PQCl15QOuRWpFwayu/uLoVu
E0Z3L5ibtLD6+dLYeN1YFh5Cl/GHn5NU5sVgMmnCVu5uCqC6XvevFmNRpV58BoBO
CAN1rNFQNJKO80D4MWrRpIew0FcBH5JlmDprGDsJuueVMIZ1MOaGRtKLp0oZlP47
k37CFGGYTLuw3v8RDC1V
=oo19
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
