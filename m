From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for v3.8
Date: Mon, 17 Dec 2012 14:25:00 +0000
Message-ID: <20121217142500.GG4985@opensource.wolfsonmicro.com>
References: <20121217131410.GB4985@opensource.wolfsonmicro.com>
 <s5hy5gwwz1d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>,
	git@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 15:25:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkbdE-0001s5-DD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 15:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2LQOZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 09:25:04 -0500
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57435 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935Ab2LQOZC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 09:25:02 -0500
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id A9792110487;
	Mon, 17 Dec 2012 14:25:01 +0000 (GMT)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
	(envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1Tkbcr-00027A-0b; Mon, 17 Dec 2012 14:25:01 +0000
Content-Disposition: inline
In-Reply-To: <s5hy5gwwz1d.wl%tiwai@suse.de>
X-Cookie: Your domestic life may be harmonious.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211686>


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2012 at 03:09:34PM +0100, Takashi Iwai wrote:
> At Mon, 17 Dec 2012 22:14:10 +0900,
> Mark Brown wrote:
> >=20
> > The following changes since commit 29594404d7fe73cd80eaa4ee8c43dcc53970=
c60e:
> >=20
> >   Linux 3.7 (2012-12-10 19:30:57 -0800)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-n=
ext

> No signed tag?

Oh, ffs.  There's a tag asoc-3.8p1 which should have been there for days
but git's doing it's usual thing and silently substituting in a branch
for a tag.  This is monumentally unhelpful, especially since it doesn't
even print a warning but rather just silently substitutes.

You can tell there's a signed tag from the way the message from the tag
is included in the pull request.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzys2AAoJELSic+t+oim9bEIP/RxgesGR/rPgRVeVQ1dPFezT
mExXGGdFR3A50DP1Z9Eb8NWXggn0oUNZXbET0dEapVAhPTQ2ZZDnCUF4GteYE0sb
TO3obj9bGh65JF2zD3ob1hBPOkSOIdjAycfWa+RXk0vqks4mXRlYH3MJrc4cKwKf
/djLMlEGATjAUE7qkRhekV1vHe6CcSM2lB4UZvLsQfI1K6YGXGO7GARFDIiQxB1i
G2cur/f/Oau6bZKMc7gOpBr6sdsuX/QAVC7GTBBio2/3HiZn9ZrdheHO14662iwF
x2QipGMofNw11LUbsT2cFEwRvG0AeZ/zjBWzCl4EEnF0RrFDvCBwKz6TkmBn/FNW
WI3KcLE9Gd19WfQUwnw82CfaJkAC4IzgMT8v3rxmTPctxbU0+8FM5DF5J61oIxtj
zxxumWW5KwZzNv4W9kHqDftBWjHyFIBElMhBcEhXZK6ae5caGHoCY5TmJFMQ/h/7
hcuTes/9lyGCVwYPoS7MQRq5wCxKiR2zJnEm/2MJhiqLPyL8rY+MMhlGdJvchlRX
UemIpWPqMRPpM1MmZbLd0C6ONS0W3sMe0S9AUFO5EHylb5kzvMhpCBGaZJQoX8L9
DK5BeIBL8lsY5BTFSq2cpOLBXysOGmNLag5yCMnM1m1+aLut9ADoZU524v5bvGUR
goGivfoR50kWtKTDymSi
=qJ74
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
