From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: git-daemon enabled on kernel.org
Date: Wed, 19 Oct 2005 10:40:56 +0200
Message-ID: <20051019084056.GL22986@schottelius.org>
References: <43554D4F.7040403@zytor.com> <20051019083542.GA31526@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HLsZ5Z1opAQvdr2J"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 10:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9Vh-0005fm-8f
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVJSIlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVJSIlR
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:41:17 -0400
Received: from wg.technophil.ch ([213.189.149.230]:24254 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932471AbVJSIlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:41:17 -0400
Received: (qmail 24134 invoked by uid 1000); 19 Oct 2005 08:40:56 -0000
To: Erik Mouw <erik@harddisk-recovery.com>
Content-Disposition: inline
In-Reply-To: <20051019083542.GA31526@harddisk-recovery.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10275>


--HLsZ5Z1opAQvdr2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Erik Mouw [Wed, Oct 19, 2005 at 10:35:42AM +0200]:
> On Tue, Oct 18, 2005 at 12:30:23PM -0700, H. Peter Anvin wrote:
> > After getting gitweb behind mod_cache, the load on kernel.org has gotte=
n=20
> > down into the tolerable range, so I have enabled git-daemon in an=20
> > attempt to fix that :)
> >=20
> > The URL, obviously, is git://git.kernel.org/pub/scm/...
> >=20
> > (or, to specify a specific server, git1.kernel.org or git2.kernel.org.)
>=20
> How do I tell git to change the default repository to pull from?

Do you mean cg-branch-add perhaps? Afaik there is no real 'default' reposit=
ory, but
the branches you specified. So adding a new branch will fix what you want.

Nico
--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--HLsZ5Z1opAQvdr2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1YGl7OTBMvCUbrlAQJj9xAAk/g9uEGWcW0Qb/5GBxFdjHwi+IhXD8V9
nHiypXFzhgId9A8K+rvzbJKeI9XYcpSAiKga/IHA4uluf5od20g3rYDdsvuP1bg+
ExbvkGwtL8xSahYZmPc3E0PVkHSdsAHfj3sWzYRzbxTruIX/YAYzEWcLQPX78aL8
esymM0gd2hiDrIk0oQl1bByoVAct6fJuUo5BQaFCv+PZe9JXbRnM/HfIgM4FPM4h
790+q++8R8cVfFfEXAIr41sW+Auy5Gz3Ayiqh6O29AtnCW1siI7ECj9qxlas/20c
cieR8W/v8xeZLxAkWu8z/xRyP4MXTwaifSyFy62Zbyn/P+5x6RnYT/CgFqArwCKx
8yXc/NXDmaVtmrwDn25co/Om3h0mUVDZshsLinC1CIZ7V7zevf3mUmZACpLwIy73
LLy+A84tC98l1wXx7PX9C5Wrf05KUQKclvJrv45cuYCWDEEt4A4tBb4iKpmeHBg2
FntG6zJYGps7MNhCwYfc21swzFxu6TER9qt1m96Sk27XA5vPq3zphLb6tOH7XVy6
2SA8V763OG4VDrXxJtgGdradn7lXLbzXKymRs1pMge5m3dtonhE0nMOkqGGPYIvV
dIwLUn1ewMZiLyFhBqPnbeRiCLjEE65rE9+0MNYV5b0rZYmtp6gG1N4OWea+JItI
AzeyZvarQ68=
=TJlj
-----END PGP SIGNATURE-----

--HLsZ5Z1opAQvdr2J--
