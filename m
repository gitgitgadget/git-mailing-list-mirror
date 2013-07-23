From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Tue, 23 Jul 2013 11:07:00 +0200
Message-ID: <20130723090659.GB9639@suse.cz>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
 <CALkWK0kmcQ1ws143H7O6q9kRmdBxMDVYBWVBKp+0Hy0acpn7VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 11:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1YYs-00020J-NE
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 11:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab3GWJHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 05:07:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59518 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab3GWJHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 05:07:07 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A6AE0A41E0;
	Tue, 23 Jul 2013 11:07:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kmcQ1ws143H7O6q9kRmdBxMDVYBWVBKp+0Hy0acpn7VA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231031>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 23, 2013 at 12:53:25PM +0530, Ramkumar Ramachandra <artagnon@gm=
ail.com> wrote:
> Junio C Hamano wrote:
> > * mv/merge-ff-tristate (2013-07-02) 1 commit
> >   (merged to 'next' on 2013-07-09 at c32b95d)
> >  + merge: handle --ff/--no-ff/--ff-only as a tri-state option
>=20
> Sorry I didn't notice sooner, but I was confused by the second test
> title this added:
>=20
> test_expect_success 'option --ff-only overwrites merge.ff=3Donly config' '
> 	git reset --hard c0 &&
> 	test_config merge.ff only &&
> 	git merge --no-ff c1
> '
>=20
> How is --ff-only overwriting merge.ff=3Donly here?  Was it a typo?

Yes, it's a typo in the test name. Thanks for spotting that!

Miklos

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlHuR7MACgkQe81tAgORUJZuZQCgn98wx3ikJ6ngKO0pSQ/7Q9/I
bAcAnjE4io3KhlIzXFEJBwmYoEaVZvfQ
=AZQk
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
