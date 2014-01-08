From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 17:05:04 -0800
Message-ID: <20140108010504.GE26583@odin.tremily.us>
References: <20140106003314.GL3156@odin.tremily.us>
 <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de>
 <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
 <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 02:05:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ha9-0000YY-VO
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 02:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbaAHBFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 20:05:13 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:58091
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754415AbaAHBFL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 20:05:11 -0500
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id BC161n0020QuhwU5AD59KJ; Wed, 08 Jan 2014 01:05:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id BD581n00H152l3L3ND58Ey; Wed, 08 Jan 2014 01:05:09 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 49CB3EABB0E; Tue,  7 Jan 2014 17:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389143106; bh=p2c9k6GWl7lWPE40ei54V4akUpQmi9oHQIBn1Jx83SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIsd2U9giius7q/Sy5isxK714N9lU3NYsI/s3Wgl0Tp3XM0UF//49wmZJ7g06DrnO
	 twJql3z7FarU7sJnbJckEHEftIxZ+HHJhmNcWG0gFVmva9jUODNvD0eGSplrObO6tZ
	 xdqmPXaMk8mxnH8XgWaeCxBqkT1/EgM1EpxyeM90=
Content-Disposition: inline
In-Reply-To: <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389143109;
	bh=dCxfrREZxk1PHh1u/sM4lXLE8yQxcA4tQS811KIYRB8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=pI1fYSmKB17U9YbDoo5ry55AsWW9eknBTtwftadCKhcVnWQfs4/rf43GEWrU1dGmG
	 w10x2YcaBgklFbANdr9ONdTBzk+OJy0nHi7Vl6z1ijxdLZ7/vNrPBEzaprV4rpUSvy
	 UMuY5io+RDZb6J0e7dLE2Y5gm7W+LMKQrHruwaeEPcbK8nDcjOoSM+dIhM+XhgAPxF
	 hlQhdiEvN2izHDPx+3TcpNNtbwrBddeZcB6BAllEfFiQUZZXH7VETgTUcQq09zYz+0
	 XX9UroQV95gQiFhV8WDn3rK4rZDqv1FPm182VD30VpNScJ9Xf6x1+ZQWX9zlb5DMx8
	 4zaNoF7XY15qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240190>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 01:17:49AM +0100, Francesco Pretto wrote:
> # Attach the submodule HEAD to <branch>.
> # Also set ".git/config" 'submodule.<module>.branch' to <branch>
> $ git submodule head -b <branch> --attach <module>

I prefer submodule.<name>.local-branch for the submodule's local
branch name.  I also prefer 'checkout' to 'head', because 'checkout'
already exists in non-submodule Git for switching between local
branches.

> # Attach the submodule HEAD to 'submodule.<module>.branch'.
> # If it does not exists defaults to <remote>/master
> $ git submodule head --attach <module>

Defaulting to the configured local branch is fine, but I think it
should default to 'master' if no local branch is configured.  This
should not have anything to do with remote-tracking branches (that's
what 'submodule update' already handles).  I don't understand why
remote-tracking-branch integration keeps getting mixed up with
local-branch checkout.

> # Unset  ".git/config" 'submodule.<module>.branch'
> # Also attach or detach the HEAD according to what is in ".gitmodules":
> # with Trevor's patch 'submodule.<module>.branch' set means attached,
> # unset means detached
> $ git submodule head --reset <module>

To me this reads =E2=80=9Calways detach HEAD=E2=80=9D (because it unsets
submodule.<name>.branch, and submodule.<name>.branch unset means
detached).  Note that I've moved away from =E2=80=9Csubmodule.<name>.branch
set means attached=E2=80=9D towards =E2=80=9Cwe should set per-superproject=
-branch
submodule.<name>.local-branch explicitly=E2=80=9D [1].

> NOTE: feature branch part!
>=20
> # Set ".gitmodules" 'submodule.<module>.branch' to <branch>
> $ git submodule head -b <branch> --attach --index <module>
>=20
> # Unset ".gitmodules" 'submodule.<module>.branch'
> $ git submodule head --reset --index <module>
> ---------------------------------------------------------------------

These are just manipulating .gitmodules.  I think we also need
per-superproject-branch configs under the superproject's .git/ for
developer overrides.

> What do you think? Better?

I don't think so.  To elaborate the idea I sketched out here [2], say
you want:

  Superproject branch  Submodule branch  Upstream branch
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
  master               master            master
  super-feature        master            master
  my-feature           my-feature        master
  other-feature        other-feature     other-feature

That's only going to work with per-superproject-branch configs for
both the local and remote branches.  Using the same name for both
local and remote branches does not work.

Let me motivate each of the combinations in the above table:

* master, master, master: The stable trunk.
* super-feature, master, master: A superproject feature that works
  with the stock submodule.
* my-feature, my-feature, master: A superproject feature that needs an
  improved submodule, but wants to integrate upstream master changes
  during development.
* other-feature, other-feature, other-feature: A superproject feature
  that needs an improved submodule, and wants to integrate
  other-feature changes that are also being developed upstream.

The deal-breaker for recycling submodule.<name>.branch to also mean
the local branch name is the {my-feature, my-feature, master} case.
Do we want to force submodule developers to always match the upstream
name of the feature branch they'd like to integrate with?  What if
there is no upstream my-feature branch (and the superproject developer
pushes submodule branches upstream via email)?  Making the local
branch name independently configurable avoids these issues with a
minimal increase in complexity.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240177
[2]: http://article.gmane.org/gmane.comp.version-control.git/240180

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzKQ+AAoJEKKfehoaNkbtGCAP/2XAJm29lUFkXRqhUxsbSz8G
ZHSySAoB752dwJiuDIPrEpKbfUckkGHUewlD+PB0aNvxzRx8L4aw1jmhLBbYuCSU
shXUhGjaUdGoaUDulWE2xUWU9rhFGBkqWPe1wZpZP1wT1zYZPxTYp9+xL5ap15p/
hu9c1/3Szok0o27f/2SD12OqQT/74lzcz9d/RDUB/u2FTGsrBa7RxzrI2lsZkjtK
t5U5Z8Psv5HcNTxQtwpMIgH3VXOAcCurqt2NxZTAODNdKE+gaspGQ9fudo4toQmQ
604e1x4zLy61Rv8PaTjfPZt6Qz2AxguJS6ZQc6fts7I/PvsOOcxzJ0uPe0cDdj8r
fZG8Er6NNwd+Rcczg5uOz36ywlFoD9rDmzs4gZ29ikke2xDsA2JwSO83QbQviOG2
TZpIu+8vSmQAe0239R/ppd8j9U82R7sMFpjTA7e8keLk0MfoYrJeervv2H7L2bmX
6fUOdBYRQxPwXDzBS+2W+xQEccCH/MyA7mxNRMpedOLK2tnu8VdvuUNVYUxwwmBn
TFUr9jaCDKsHCvwBiSNWxvg9LPHVzKjbGTn2QvijoIL8VpV/RFH06qhoXI23Fz9k
X5d3q8ql6QWQWxT+Qun/1ae1qdJkMxaQ8mnnfBAM04UwDb4cxekSd1I2QCo2ZfIC
Yp4TkGDMtbQBV9yP/42q
=M0y+
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
