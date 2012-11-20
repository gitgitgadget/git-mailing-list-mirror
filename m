From: "W. Trevor King" <wking@tremily.us>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 20 Nov 2012 07:04:37 -0500
Message-ID: <20121120120437.GB7096@odin.tremily.us>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
 <201006080912.31448.johan@herland.net> <4C0E6A8A.70608@web.de>
 <7vbpblruj8.fsf@alter.siamese.dyndns.org> <4C0F3FA9.7000800@web.de>
 <4C0FB50F.3020403@xiplink.com>
 <AANLkTiknGcteTjrHWM02H2KOMMDPZKHY1w0ZOIswddFn@mail.gmail.com>
 <1353410195055-7571610.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=jq0ap7NbKX2Kqbes
Cc: git@vger.kernel.org
To: nottrobin <robin@robinwinslow.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 20 13:05:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TamZi-0007rj-34
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 13:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab2KTME4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 07:04:56 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:26211 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab2KTMEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 07:04:55 -0500
Received: from odin.tremily.us ([unknown] [72.68.98.228])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDS00KVYC7PB290@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 20 Nov 2012 06:04:38 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B36E16984A9; Tue,
 20 Nov 2012 07:04:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353413077; bh=92/YjPUHME38I62j5rj/ySQa7P2YGu3ohpMAp3InUoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VYUdVgw8/yaeRKoT+wEGChFCnxsWZCOJ+nrvLLM3fxDzDEQZ32YbRNWD+OA4bPa0c
 7H50cxsmN7mk7+prH4IFOBU/lJ0KNrCODZea6OUE7P6bE8VPGKuaJtct6IET2RcJAT
 gHhP3PHsMxf8kFf96ug2B4ZhwKqbwdCdFdNGgU1Q=
Content-disposition: inline
In-reply-to: <1353410195055-7571610.post@n2.nabble.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210096>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 03:16:35AM -0800, nottrobin wrote:
> Did any of this ever find its way into the submodule core? I'd like
> to have a submodule that tracks a branch.

In progress.  See:

  http://thread.gmane.org/gmane.comp.version-control.git/208254

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQq3HTAAoJEEUbTsx0l5OMcVoP/irdeNBl/ejs4haopBk+Q/8e
4rJLDyEjXUsleVesMv50Pj2k0xWwyvEesWhkfY/BMrLpRQ8YuCDnPDgSO48RjtSb
gPUloviCAzLRPffp3C9Y26/DUA0jRMmgqyvOLByGLEfvbMbUdk0rrT+/pzcTWKPK
1jCkQz7gqD+M2zKCECVIa+xiepQLwjUxdVEmP8xUZspmGpYWGFuYZrr7QyeJt7N/
ImKj9DmlYXsMAb58wPbIKyI1kbF9jxDW/oTmVWK3jl0mVOp4w3zP1EBUMyYs2sG9
XRl298bqh1GQh02GOTCzfsAD9JWhZgI/dUYci5ZpzeW9I2Y12TImS+Y3MXkgb8rP
YSxNsJvvZVJFXGmzom642NuzjZGio515kuMdUdczrwdHRQZhQdyQ/3wy/cZ3SGhn
ASzaSq/mdvFK7uJLTQMNAdK3BbalAlYwwM8EcPIAnGSLH0HDP9yeMU6arR3BYvnw
AtvbBOhU9GhYNd8C9vZpy/DmNiuKeQLyiuPDAzpZVC5hPVgsPBrAeQkxH5bq0elv
vQ6YmBZ/jNG7Bl/0xEbID1/3aAmVxNYCm3mPuceXKDnonilW/V7VkEXwb/O8l6O/
SGwpcbaK7M/GX5KyCGhIVJZToCaPhM2Bf4wcgGqvnpjNzjlsn82Ii4m/Xc6nB7XA
++QbI5b10BJjvKAa8t0X
=gWOF
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
