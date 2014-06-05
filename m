From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Submodules with feature branches
Date: Thu, 5 Jun 2014 12:00:33 -0700
Message-ID: <20140605190033.GV21803@odin.tremily.us>
References: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
 <20140605151549.GQ21803@odin.tremily.us>
 <CAHd499Dc7_fob2-X1KZ77sdx20r+erQ_9JbDc7y4G0RUxG65eg@mail.gmail.com>
 <20140605162333.GR21803@odin.tremily.us>
 <CAHd499CBAQHG4rdojb8pdjymUCaZNYSnKb-ksmsLesq73OWTyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v7CWsE/Dy737oYst"
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:34:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wscu1-0007JZ-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 21:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbaFETAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 15:00:37 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:48037
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221AbaFETAg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 15:00:36 -0400
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id Af6N1o0030bG4ec5Ej0cYs; Thu, 05 Jun 2014 19:00:36 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id Aj0a1o00C152l3L3Pj0bNR; Thu, 05 Jun 2014 19:00:36 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 0C616120A6B8; Thu,  5 Jun 2014 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1401994834; bh=9n+HlsAlheY6ZPB2Jjr6V0Uwz9X328Bvhum809F5yZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAfvomAzXeMQY8IXTbsgyu5pGvAR3UTFu3q9NIxG/I+5Djo+cy+CVTQ/U42UHuPlC
	 C6oI1keGqfd0lRnxduIDYgw11x9JCvYzLA7snW97BGE0K8NjrjklrPAVv+eLINTSMa
	 9p4iJs+k+XlPyDKVxTSxhHbEIKxKP3Ac3nf6IPvI=
Content-Disposition: inline
In-Reply-To: <CAHd499CBAQHG4rdojb8pdjymUCaZNYSnKb-ksmsLesq73OWTyA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401994836;
	bh=IoG32ZCUt6i+LFHT68/zlyuSWAllkRcEf/4VTd8jB8U=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=F7Gphtlu35Yt8Mzh6MTUzxqJ8a0XmG9+QdxWyrQccFUdjkHboRAVtY9AIDfDet2Sr
	 YT3IqijK38Te8GeH2zjKRNkksKRfln7aY7mdm0J+D5kFXefqStM2DEO+5tEOD/Cp9c
	 cIUIVjyfhgY89L4AwMySWmGF42VXVBqtvl2Sk8B8xVGBxKUzBeB+E93xpH82R96tfJ
	 OO2khN72YgvbohUbd6tKXa4pQgGB/kYuN0+Ys3oWmdw8rG5k9vWNhIRQtQpuOo2pM1
	 0DXHsXmB6zlmVDyjZu5PsQmJBn6Mh9+xrGSqjtTdCdzxKdfn5pwD2Gu23T3xA8NnLW
	 s7jZfPtaU5RFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250858>


--v7CWsE/Dy737oYst
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 01:31:39PM -0500, Robert Dailey wrote:
> On Thu, Jun 5, 2014 at 11:23 AM, W. Trevor King wrote:
> > 3rd party libraries sound loosely-coupled to me ;).  In one of my more
> > mature projects I did a similar thing, and just used relative URLs [1]
> > and sibling mirrors/forks [2,3,4].
> >
> > Cheers,
> > Trevor
> >
> > [1]: https://github.com/wking/pygrader/blob/master/.gitmodules
> > [2]: https://github.com/wking/pgp-mime
> > [3]: https://github.com/wking/pyassuan
> > [4]: https://github.com/wking/jinja2
>=20
> I guess I'm still confused on how relative URLs help here.

If you want to add a feature to pygrader that needs tweaks to
pgp-mime, you can put your public repositories somewhere as siblings,
and:

  $ git clone --recursive git://you.net/pygrader.git

will work fine (drawing from git://you.net/pgp-mime.git, etc.).

> Won't the capping commits (A and C in your first email) still be
> needed? Or is there a way I can modify the local
> "../third-party.git" submodule repo instead? Can you explain?

Anyone reviewing your changes locally will need a way to get your
submodule commits as well as your superproject commits.  In both
cases, they can use the usual:

  $ git add remote you git://you.net/=E2=80=A6.git
  $ git fetch

or other tweaks like GitHub's refs/pull/*/head namespace [1].  Even a
shared central repository, if that's how your team rolls.

> Unfortunately, the reason why I feel third party in a submodule
> creates tight coupling is because:
>=20
> * You can't make changes to third party libs for your feature branch
> without breaking the trunk

You can in a branch.  Maybe I'm missing something here.  In any case,
edits to third party libs are best upstreamed ;).

> * Merge conflicts are insane to resolve and involve two clones if
> trunk maintainers modify third party binaries and you do as well.

You resolve the merge conflicts in the submodule, and then amend the
superproject merge commit to point to the resolved submodule commit.
That is one --amend away from what you're doing without submodules.

> * Feature branching requires those capping / meta commits to simply
> setup your branch to be a feature branch.

With relative URLs (or shared centralized repository, or a
refs/pull/*/head namespace) it's easy to share the commits themselves.
Unless you're using 'git submodule update --remote =E2=80=A6', you don't ne=
ed
to care where the gitlinked commits live, you just need to get them
into the submodule repository somehow.  That seems fairly orthogonal
to feature branching to me.

> Instead of just creating my branch and starting to make commits, I
> now have to setup my submodule branch first. Also pull requests
> won't show the changes to the third party libraries unless I do a
> second pull request for the third party repo.

That I agree with ;).  However, if you're treating the third-party
library as a separate repo, I think it makes sense that you need to be
making branches and pull requests in the submodule independently from
your branches and pull requests in the superproject.  If you feel that
the minimal (branch + PR for changes) overhead of managing the
projects independently is too high, you're probably better off with
the single repository or subtree approach.

Cheers,
Trevor

[1]: https://help.github.com/articles/checking-out-pull-requests-locally

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--v7CWsE/Dy737oYst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkL5RAAoJEG8/JgBt8ol8VuoP/2GqMFeBnp9ZfAvDp/133/NB
yjCm7/wLeXTCjGAcohRqx2PzI1S6cBzZow9MMMT7ieF0TiL2Xxxl4l0njQydZmPh
n37TN69edw1wBM8FSyfxJ2l4XJ86+qyZepN+isIKc5PvxM/yU4fWefgRxH0aSrDm
LNEdDS6II7goQRdsBuIK7Mwp6r2QXVmbnFtBpSORlPF4PUs4GuZ3ZXuAJrgMCqx1
07FYHBHDdBZcNLowOl5iqEehhwn59FAWIJ2baZfmJcLIHCbk9ixQQ6YXYTHnaoq9
X/gHqiCJFMnYXXc+fnc4onlU9aY8oOtcmeSgG+Ye5ZLG0HqU0VZMiyemjntrWquz
/VTWm5r0rjEWWxjfQ/szweOXaddPEsTKCfo3ET332Ff+jJMiSAlo5tWTnrtqMi7B
7psFRMOFS4j9GAr8VkMhoINe98PXiJX0z3LorNiXgPi8q7hACWTnWlgjyRFSMTQf
ogie/EpGJETodHzZZCpChKtURqszqM58VdI2KjBRRpoHMUXytor5oV8V+cAiqp8D
ih5H8mlVQHy7+K9VnbV2HS/gWg059yitYqC0CffsYGQPd874pkEQ7g9nxMO3miSX
wDtOpdiP8zoBEc+r0Egcu30s0UgEsAbRgrgWlYlUCs52mZ/jLforNPUPZN/cgChl
NmobSRe8G44UM3ssPJgK
=F604
-----END PGP SIGNATURE-----

--v7CWsE/Dy737oYst--
