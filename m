From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Pull is Evil
Date: Fri, 2 May 2014 14:13:05 -0700
Message-ID: <20140502211305.GN28634@odin.tremily.us>
References: <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FX+Db2fp7WJhXKrW"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:13:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKle-0006Fn-5N
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbaEBVNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:13:11 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:41384
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726AbaEBVNJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 17:13:09 -0400
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id x8mH1n00C1YDfWL5C9D8mE; Fri, 02 May 2014 21:13:08 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id x9D61n00g152l3L3g9D7Kp; Fri, 02 May 2014 21:13:08 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id E9C13117480C; Fri,  2 May 2014 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399065185; bh=3u9T7QB8dDvfKB3WHSyLWYU2UC77upHAW+slLSzx73A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mkHjO8Q/SNSZSO10r1HG2xc7yy+b4JNx8NjscgMmytc2Fo1N/CMgPtchT2d4Jbvf0
	 R74Bu4Wwd2/QzAsWMkn19C3tuQfjwrCRLnYbFSCyrDC09Mt5JJzg4fLiUisBrcyJlA
	 ABCWVnDADAJ8VpyAsCEh6I3hYDeTuQv2n37Ylkhc=
Content-Disposition: inline
In-Reply-To: <5364015a94900_135215292ec28@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399065188;
	bh=BpUhFompATAlm9Ub5FiqcQL7DwuiD2yt0pNNE6/7KTc=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=hz1qgEEybGHM1XFJ9cnBoCZnOqVM1N9Cy0ZhEEK2hpLD5EVpyj8CS/V2bDUAKMrvM
	 bwLX0LmNUsOI9ygRt7iZfF4vylI1Lvd8yI0LF9doZNkXEbUzaY1vIGV4Dd/mqGhlOA
	 lPX8LCvEkpxS9f4u5c33DRlgUzTY6rmK0WFFSz4YhWFGGMlXS34FJIIBiO0N4+JLk3
	 qEtf82Fk9nhWavmt1Ob0BhaUNOtK9yH9aQ+Yd/9fc+FO8AL2yQoW7Sz9hPlOEMHEHv
	 5xnXkU/HtZLAnqRrLzZPhjfa/tEoJOO1Uae1sYb2vFM1enfpFkEwMprry3kGhQeEaf
	 ACAHHETjREP8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247984>


--FX+Db2fp7WJhXKrW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 03:34:34PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > On Fri, May 02, 2014 at 02:13:25PM -0500, Felipe Contreras wrote:
> > > It would matter almost exactly zero.
> >=20
> > Some folks have explicit merge policies, and deciding how much
> > that matters is probably best left up to the projects themselves
> > and not decided in Git code.
>=20
> Let's make some fake numbers to see around how much this would matter.

The point isn't that this is a huge flaw, the point is that we should
be able to configure Git to match sane workflows.  Saying =E2=80=9Cthat's
unlikely to happen=E2=80=9D doesn't solve the problem that some newcomers h=
ave
trouble matching their project's desired workflow.

> So no, for all intents and purposes it doesn't matter. I would rather
> concentrate on the issue more than 90% of the users face.

You don't have to concentrate on it, because I'm willing to write up
the patch, I'm just trying to find a consensus spec before writing the
patch.  If you don't have strong feelings about a pull.prompt
proposal, I won't mind ;).  I just don't want to write it up and
*then* hear =E2=80=9Cthat's a terrible idea, you should have just done $x.=
=E2=80=9D.

> > > And just as they can do pull.promot =3D true, they can do pull.mode =
=3D
> > > fetch-only.
> >=20
> > Why would you run a fetch-only pull instead of running 'git fetch'?  I
> > think it would make more sense to have 'pull.mode =3D none' with which
> > 'git pull =E2=80=A6' turns into a no-op suggesting an explicit
> > fetch/{merge|rebase}.  Having something like that available would
> > help with the training issue that pull.prompt was addressing.
>=20
> I fail to see how training them to do this:
>=20
>   % git config --global pull.mode none
>   % git pull
>   % git fetch
>   % git merge --no-ff
>=20
> Is preferable than training them to do:
>=20
>   % git pull --no-ff

The goal is to train them to do:

>   % git config --global pull.mode none
>   % git fetch
>   % git merge --no-ff

The 'git pull' (with 'none' mode) explainer just helps retrain folks
that are already using the current 'git pull' incorrectly.

The benefit is that the repeated pair of commands (fetch/merge) takes
longer to type, which gives them longer to realize that they should
think about what they're doing and abort.  That's all a pull.prompt
would be doing anyway.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--FX+Db2fp7WJhXKrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZApfAAoJEKKfehoaNkbtJHMQAJoo79JWrYYecKduCwnmbfZZ
I7J5faC1ne5nAV4VY3MOynO7TwCXEedsJdwmYXZa7xpn+8KuU0TQE3OTU7pnxBWa
mzkcfgBTMatu3tC5u7Vxe9GS6WYDDog3Uqtj/pMDH+2IK5hk3NvO9tOQx26rUjNh
cXd3anlpPrcfbJ8mUVycHmOw0C9kg3slcFuu+3Ta6JsQ2XC8HBGztKFaHbQI5CMr
Mv30g4F+Nf3ICiVIAP5tRRz/jhoKTYfC3Ria5MaH73jzltNNDG3hMKtuldflpCGy
TCdOy6mCBItqKauKQL1aKH1BFtMxGS3G4cezwqBwSF/U9BLGMoCUS8LhIk4jfWWY
GvmEmTu+3TYyhUy7CACNdYLzkG7/EbZOwnnsBhFcxTZ2MAK8NrqWuLAEoDUodd5p
QsqQ768pftIn7pecrMfOBpwTiVxIaUefMM/CkIOL7BJmC6DWbg3vqQpBfFtjxvk1
a8DS8d6aNdLSQWHGCp+z5A3cKzhMPtfEAzeD/wd96fB+sOSqfTGp1ao3hDHBXs0V
G+85WhI9gyxOYqp+oDS+MM/viHOVeyx1RcDVHpPL5u1+U/IueSuWRjqy4eUqlu8e
Y+rpbMr3cvFfiP1bQkPtyhS2YYcFcc3b41oSpfa8BPVK6SL1sNEHCsWDusKhYwO3
u0VxOYkH1cKLyWTa751x
=ORuO
-----END PGP SIGNATURE-----

--FX+Db2fp7WJhXKrW--
