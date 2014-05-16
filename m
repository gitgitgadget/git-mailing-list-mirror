From: William Giokas <1007380@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 16 May 2014 03:59:29 -0500
Message-ID: <20140516085929.GA546@wst420>
References: <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
 <5373fc12bc5e4_7411589304eb@nysa.notmuch>
 <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
 <5375c7934ccc6_7e7b772f8d5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 11:02:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlE2A-0000sw-6d
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 11:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbaEPJCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 05:02:22 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:63185 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488AbaEPJBx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 05:01:53 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so2678604oag.30
        for <git@vger.kernel.org>; Fri, 16 May 2014 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bfDgzwhEuHlkmhMSNsKT060p+8ZrVP+INo80agIfT+Y=;
        b=PnlSMEnXdUGLsj9pW2eraHdKSZzXVru1oxn0EeQbea9YNfNIwEwuwNgDmCyDpV7UaT
         VN0U3koEWXenNi1dSCUdc9Et8yTL08DqqP6nMtniu51kcLYJ9XjF4cg1hTOL//gsMCxF
         7f6s4eOSc0QpKuF9jImfypra7/6wD5hTwSbrBvgKl2y9OO7VB7P95K/+/H3xErBqhXjc
         BJL9nyOjNF25WmDEe0XyNaP/qF9FDetmiFCqz+eN7r+K/6jiqZr5cSj8Yii/B8dZ4gFq
         aGd1hXjSLkCcuEVz0nQRQ7ao8KiH96EfCStzEhsNWEG7vjD5buoTOxQZvm0Ay75BjnBk
         ffTg==
X-Received: by 10.182.125.161 with SMTP id mr1mr15575684obb.47.1400230912911;
        Fri, 16 May 2014 02:01:52 -0700 (PDT)
Received: from localhost (cpe-173-175-117-154.satx.res.rr.com. [173.175.117.154])
        by mx.google.com with ESMTPSA id ko3sm2882765oeb.1.2014.05.16.02.01.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 02:01:50 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5375c7934ccc6_7e7b772f8d5@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249284>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 03:08:51AM -0500, Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>=20
> > > =3D=3D contrib vs. core =3D=3D
> > >
> > > This is the only point relevant to contrib vs. core:
> > >=20
> > > >  - We may be painted in a hard place if remote-hg or remote-bzr take
> > > >    us to a position where the Git as a whole is blocked while it is
> > > >    incompatible with the other side.
> > >
> > > It will never happen. I already argued against it[1], multiple times.
> > > Essentially making the tests optional removes any possibility of
> > > blockage (pluse many more arguments).
> >=20
> > I already said that your "It will never happen" is a handwaving, and
> > I already saw you "argued against it".
>=20
> This is a red herring. Ignore the fact that it will never happen (which
> it won't), the next point remains a FACT, and you conveniently ignore
> it.

It may not block git being released, but as we can see from the recent
patches that were needed to enable hg 3.0 support it can break and would
have to follow *both* mercurial and git upstreams, not just git's. After
thinking about this for a while, I would have to agree with Junio That
it's better if a bridge between to actively developed applications not
be coupled to one.

This does not mean that I think git-remote-hg is not of a quality to be
in the git.git tree, but it is simply a fact of development and
stability. If git's remote-helper stuff changes but mercurial doesn't,
we're fine because, having seen the speed of your fixes, we would have a
fix before the next release without a doubt. However, if mercurial
changes, like it just did, then git itself would need to make a release
to have it actually work with the newest release.

Having the tool out of tree allows the maintainer to fix things on both
ends and release independently so that both situations above can be
solved without any real hassle on git or mercurial's side.

This goes for bzr, too, but it looks to be changing less quickly.

tl;dr: This may not block a release, but it will make releases a lot
more dependent on outside forces.

Thanks,

--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTddNxAAoJEGkCBthzzQnPxogP/Rw74vH48u5ldr87pTsUzM7e
GkGzVSAS0DSXS11HuN1tQZDZ3EWgg3C9d5R2j2WWfvBJ0BW8pC1/5ycei0n/j9/R
arTK8GQVwZ1uQm5gs+a8VH8acTMv7nLs8t7ftl8PKCku5Plf/mVqxwooe+Kv71rF
/1Ofb4zFXZf9Jksu7UwPFxIl8/BvN34+QxdGkXbPuR6q5uK3qpoPso6oFvAbdwSR
/TjtOaYjDuUKHEDp4wY90iewClLG++u4OmC2gU41IgnPUG5xYTXZYZrA2tLP8C1j
mYExNBJVr/z1x8RgCjOnCkRq3tcBco70SHuHzRymOW2jFgdZIgDgPEMn+zTS3Hs2
vvMwLl1tcLnkFc3ODoIYkRkvZBcN4YzCMkP7wadYQpnsXGr3vqE761i6KQtHjXBg
2YUuhQUIamQtCjRrgpEqE6EDtoAJYkztyj9EcVVX/YbVEodXvbEtJWprZuZeVH0l
mCM7GSSR6RMZs3gSSt0gkUqHZ9GehPubO4eWUt4Hd0PEXv38+3LUU7AxMgxhHsdu
Epqf3Oyv6IiK+tN39hFfReyp1/tmUCbS60hNeX/HiwCy3kahxuPk5NSibawyGGuM
yMXdMHD+ndlxC21vs0odBROrwY8go+iRvq+G2bNPsvv7AhnagZ0Ku43NME7YWYhq
5Yq8jLDMCWBnO0jXYjVU
=NFqv
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
