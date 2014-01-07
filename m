From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 7 Jan 2014 11:27:13 -0800
Message-ID: <20140107192713.GG11060@odin.tremily.us>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
 <20140106140627.GA27265@t2784.greatnet.de>
 <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
 <87ppo4zzkb.fsf@engster.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Cc: Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: David Engster <deng@randomsample.de>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:27:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cJ9-0007k8-IE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbaAGT1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:27:20 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:34037
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766AbaAGT1S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 14:27:18 -0500
Received: from omta17.westchester.pa.mail.comcast.net ([76.96.62.89])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id B1b41n00A1vXlb8537THFZ; Tue, 07 Jan 2014 19:27:17 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta17.westchester.pa.mail.comcast.net with comcast
	id B7TG1n00C152l3L3d7TG2A; Tue, 07 Jan 2014 19:27:17 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 9EA80EA966F; Tue,  7 Jan 2014 11:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389122833; bh=kmOoYT1AlJQTj5nshRP43uZ1pXUzokWHioNiOeZwZfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=prjSlym7dqmlOteqK7VnED5I68rt2g7nldsYCVx/q5Qfd5USKIWQBqh6IeTyqrXLX
	 cQem7bD2tFBX3NHGP3IdSijMnRQ62LS46pXt+DuDhfTI4QXImvawijVplMnJfo5K6w
	 xXVJJZ2dYefYd0dKZ+zb+mUXXBrs6T/KcX3lufkw=
Content-Disposition: inline
In-Reply-To: <87ppo4zzkb.fsf@engster.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389122837;
	bh=aS8Mm9U+MJq0tV4C2gzBhY6kB3irP1x6xNtWtXnUVfE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=dUroKqTYS7zFEr3sCmTyOKaAVlsCliUNTnLViChesaHNzrH/pJkV3JITpTaeJlIw5
	 NrAdVarekwRoBh+FVuD09RpFRyEM7weDFic5MDG4JGEb3DT0292xkWAk+UBPYT+WYo
	 4H2I7ReEd9oPe6IfIuKY3CXHUlGgV6YOfVaDt5Xp4yKbd1PsIVxluEifuaQmMZdlKN
	 iWOil/ix8OXXYPJT8b5mf/idPUiEcQA6sk2YW05Z5sxlcNMT6lc0BAqHxW/23N/cbJ
	 UYMzE+ED/Y3RQeCa6hti1Rc/B2XldSAzxoCOXR6BlEx7LXYgNguyNcNYizpKYUDVnY
	 7PA06sdX/83eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240134>


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 08:21:24PM +0100, David Engster wrote:
>              +-----------+
>              |  master   | <--
> +-------+    +-----------+    | Merges to/from master
> | CEDET |                     | done only by CEDET developers
> +-------+                     |=20
>              +-----------+    |
>              |  stable   | <--  <--------
>              +-----------+               |
>                                          |
>                                          |
>                                          | Any Emacs developer
>                                          | can push and commit
>                                          | submodule
> +--------+    +----------------------+   |
> | Emacs  | -- | lisp/cedet submodule | <-
> +--------+    +----------------------+

This looks reasonable, and except for the detached-HEAD after the
initial update-clone, I think Git already supports everything you
need.  If you set submodule.cedet.update to 'rebase' (or 'merge') you
can easily integrate your local master changes with cedet/master
(e.g. if a CEDET dev updates cedet/master before the Emacs dev has a
chance to push their fix).  With the non-checkout update mode, you'll
also stay on your checked-out master branch during 'submodule update'
calls.

> AFAICS the main problem with this approach is that one always has to
> think of committing the new SHA1 of the submodule.
> =E2=80=A6
> However, as Heiko notes, the history must be preserved to be able to
> go back to earlier revisions, so there must be some kind of commit
> for the submodule when 'stable' changes; maybe that could be
> automated somehow?

If an Emacs dev in the submodule makes the CEDET change, you could use
a post-commit hook (in the CEDET submodule) to also commit the change
to the Emacs superproject).  However, commiting only the submodule
bump may not be what you want.  Maybe there are other superproject
changes that should be committed alongside the submodule bump.  Maybe
there is stuff in the superprojects's staging area that should *not*
be committed alongside the submodule bump.  This ambiguity makes it
tricky for Git to automatically do =E2=80=9Cthe right thing=E2=80=9D.

If cedet/master is updated independently by the CEDET devs, there's no
way for the local Emacs repo to know about the change, so it's
impossible to automatically update Emacs (without polling for CEDET
updates or some other transgression ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzFUPAAoJEKKfehoaNkbt6+UP/16/j8+g+HvIRqhHBTrOcxQL
v8xMHi0mZp5JdOUsUVD4hPYe7PBH4FDDxai5w52Rqa3A8gRgz8N34fZ8RQLt0n+D
xYhnV4FxAm9OOFxhraj4MPeEuSre9ufPvyhVScEyBZu47e3BkIVUKZM0ejOX8DyE
DuYZTlDSdCAycjzAd36w3Ez46eB/7oexPUAkajEh/7nOrXaCIQDcFBPy4ruTqj3J
bJsCx478hiA5qchDJq2YFrNvlNu+T7rDS3Hl7m2vUk0cyUqD1wYpjDefbyV9sboM
McgUDw2xTiXeJ7LmCn37sqOPdihrVXhou4D45UI+J2EXrWqsLeKqAUUwRPo95Nap
N/kkL+OovQa1h85MUs5pjIex9Vw9dlBw0H24Fek2hawxX4cJzvZMfbesqA2z96Nr
AcksIWDLZgbbvqe/siQv6fRupFeJ1ko85Y9DzrOScYsuaSBoP1suZlUo03A4F8oY
Tq1sMVRfQhsmfFwZnxJdmZ3EGeaf4G27nb5/UxzRi7W/I/npxQ/Bo9ZVIEoz66zR
oMflynpPHxoa6zB3CmTMmt/kaFfISjiGEB8GcOv5gW8PPInW3QBKqLi3hzalgWrS
QrK4t4eHFdP2yyJ+ytHlncFa9RKVq0ZnoIPxy7PNyozwSMp3sn+L5I27yPM6M487
5sb9wztXplDXKomYQiG7
=6Crp
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
