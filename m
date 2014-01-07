From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 6 Jan 2014 20:10:04 -0800
Message-ID: <20140107041004.GA11060@odin.tremily.us>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com>
 <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
 <20140106140627.GA27265@t2784.greatnet.de>
 <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 05:10:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Nze-0006W0-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 05:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbaAGEKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 23:10:12 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:55925
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102AbaAGEKK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 23:10:10 -0500
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id As6e1n0051ap0As54sA9Wy; Tue, 07 Jan 2014 04:10:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id AsA71n003152l3L3isA7ge; Tue, 07 Jan 2014 04:10:09 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 246EFEA3400; Mon,  6 Jan 2014 20:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389067805; bh=Gvh7t4MrRwfABvWXIKgtA07tD053qeAzNbYZugfz/EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tdgq0+GssLITEIlwmD3Jwp8rWS+qjRxZOmfgJXiAjB02hLLJ4PcxFEls3ZWPJUpe+
	 1+g8hCT4R8ulOi1IgtV8jOOwxua5X+5XKlLy7tRugSNvp3hfuzEAhpTyVI1JP/lqcS
	 IpMVaaM6rr2XMbyoiF324cZlgTN/jJcPeIBF2KfM=
Content-Disposition: inline
In-Reply-To: <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389067809;
	bh=UCa++QafDHBrwR/wQ7jwILhXFGXqU1ro9QbtFYv8nwc=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=gklmGQV7FGQZA3DP878plcmzVEDWJ8vfArAcXqEDrMDSZyGTH914Tv7m9vLpNAb4a
	 lxwTAZEOpa5iyvDHe+JvgGr8DOZPa4VyvTKuoMDctO/74hphZvT+nBm2Y4SJ3gJQi/
	 0DKeJdJNojU9ZgCI+kQuftagfc2Gk6+yR4g7nVOtfbs6WSGhqdozH3metHK9LLctEh
	 CzsegOIXqUTTytFY8AQhIyFTGtxTF5nF9TtCq3fVZ5T/kRRLS+WK9hugMPcssawlGo
	 marGsvpDPl2mVajIDDpXyIY5fuuvYRpKobNe3nD/G5II9FvW1LAdMgV3aXcZYrHbZn
	 xn4QvixSTcavg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240097>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 06:47:58PM +0100, Francesco Pretto wrote:
> I'm really sorry, I thought this was already clear from the first
> patch iteration. I will go more in depth:

For me anyway, this extra detail is very helpful.  Thanks :).

> Maintainer of "project1" also prepares a branch
> "project1-staging-featureA" on "common" and set ".gitmodules" of
> "project1" to point to "project1-staging-featureA". Developers of
> featureA would like to do this:
>=20
> $ git pull
> $ git checkout staging-featureA
> $ git submodule update      # clones an attached HEAD of common on the br=
anch
>                             # 'submodule.common.project1.staging-featureA'
> $ .... start coding in common seamlessly as they where in project1 ....

So the checked-out branch switches depending on the local superproject
branch.  That sounds nice, but I'm not sure where the
superproject-branch-to-local-submodule-branch mapping would be stored.
We currently do this for remote-tracking submodule branches with an
in-tree .gitmodules (which can differ between submodule branches) with
local overides in a single out-of-tree .git/config (which is
independent of the checked out branch).  Ideally we'd have a way to
add local overrides on a per-superproject-branch basis, but I don't
know what that would look like.

> Also developers do frequently rebase:
> $ git pull --rebase
> $ git submodule update
>=20
> Or maybe a shortcut of this: "git submodule update" should be given
> the possibility to go "--remote" by default.

Rebasing the superproject and then updating the submodules (to the
superproject's gitlinked commits) is not the same as a --remote update
(to the subproject's upstream branch tip).

> Of course if "common" of the developer is in a branch different that
> 'submodule.<name>.branch' "git submodule update" has not to switch
> the branch.

I don't understand what you're saying here.

> >> Maybe who coded submodules at first was thinking that the best
> >> way to contribute to a project is to checkout that repository,
> >> and not work in the submodule. As said, this works well when the
> >> submodule repository is a full project, and not a bunch of shared
> >> code.
> >
> >Why not work in the submodule? See explanation above.
>=20
> Because, as said above, the submodule is not independent. It does
> not have proper code that test it and the best test case is using
> the submodule in the scope of the superproject.

You can cd into the submodule, and develop it as an independent
repository.  When you want to test your changes, just cd back into the
superproject and run your test suite.

> 2014/1/6 Heiko Voigt <hvoigt@hvoigt.net>:
> > I am not so sure. svn:externals was IMO a hack in SVN to bind projects
> > together. It does not record the revision and so has nothing to do
> > with version control. If you simply want to always checkout the
> > development tip of some project you could do something like this:
> >
> >        git submodule foreach 'git fetch && git checkout origin/master'
>=20
> This can be very unconvenient if the reccomended *starting* branch to
> where attach the HEAD is not "master":
> git submodule foreach 'branch=3D"$(git config -f $toplevel/.gitmodules
> submodule.$name.branch)"; git checkout origin/$branch

Which is equivalent to:

  $ git submodule update --remote --checkout

except for branch-vs-detached-HEAD.  If you are doing local
development, I'd recommend setting up submodule.<name>.update to a
non-checkout strategy and using:

  $ git submodule update --remote

which will integrate the upstream changes with any local changes
(updating whichever local submodule branch you had checked out).

> Also with the comit[1] that blocks copying of !command to
> ".git/config" and sets default "none", you made it harder to offer a
> mantainer decided default update behavior like the one I described.

The maintainer can still suggest checkout/pull/rebase, and the
developer can still clear remove the none from .git/config after
initializing the submodule.  You only need to do this once per
submodule.

> I think maintainers should have the option to make developers to
> clone a repository starting with an attached HEAD on the branch
> suggested in submodule.$name.branch;

I agree, and want to use a non-checkout submodule.<name>.update mode
to identify developers who would want this.  My v2 patch switches on
submodule.<name>.branch, but I'll update it in v3 to switch on
submodule.<name>.update.  There's no need to confuse this with
additional attach/detach functionality.

> - "git submodule update" is missing a property to do automatically
> "--remote". I think in the use case I wrote it's really handy to have
> a "git submodule update" to act like this.

You can already add aliases, but a remote/local-gitlink config
variable would be nice too.

Here's an attempted summary of our desires, and my ideal route
forward:

* Preferred local submodule branches for each superproject branch.
  * Not currently supported by Git.
  * Requires some sort of per-superproject-branch .git/config.
  * Fall back to the remote-tracking submodule.<name>.branch?

* Auto checkout of the preferred branch
  * Can do this at clone-update time with my patch.
  * For later submodule branch switches, maybe we want:

      git submodule checkout [-b <branch>] [<paths>=E2=80=A6]

    Then if a user blows off their detached HEAD, at least they'll
    feel a bit sheepish afterwards.

* Configurable (remote or local) default update source (so folks who
  primarily update --remote don't have to have long command lines).
  * New submodule.<name>.source =3D {remote|local} config
  * New 'update [--source=3D{local|remote}]' option
  * Deprecate 'update --remote' with a long phase out.
  However:
  * Maybe they should just setup an alias instead?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy34ZAAoJEKKfehoaNkbtWxMQAJ/OO9ZN36WgC95hO7BtmRPc
OI+WenvAZgaf7Ui5wjSN2PEfLNHNv8ZbG6otBHd+pXLuLZ8AlVeUmXifzTyGHQMx
GDf4Yf6MKOlyOuwYDDKSF0JTyPjxb7w7wqjD70u3diAbdLEZkf0xwJbUmm053bYr
qEwdIfJgf5bBLBBNy9Psv3ZjeavSBt1gTFbqIWqCz/Sv7iNSyDrlQfztte2NVf31
U8Cvr02QAzEyFf3N+f3NbMwM3Q1CeqlOiqUAV3uQCBmajN/6DQtQbHQ2olarZGAP
bGRpaKiQaBaFVmW6N7IEaFPfH7zIRLImdgj3KAPheZqqvfFQzMueuCkrJPieXetx
7tx5MYgeBL7TfqHSCczGGhijJgiNIS393OFlf6wcxHFbO9fiZ9sR/eBTYuBOTVOH
RZ8P95qIcBc9koZbSMpRP8AXOEyIqV45KJTr5DvuUnsIOOO1Og13aXKi+F/5A7XR
c0BtPGO8usk8lKsc7lMuNChUoGrEPUo+KyEFc24DEMgK9rqKja6Hlxf1IvUJUkFa
U02nSJIMIZWLn5KhRNCJ/1m91BWhSdthPL0/301u/+KtchEteQDyu0yCa/UE9jLA
jBVTiD4ymWAPM/AdI4FjLIsHLQf4SnC/4mzXxY94yvRbJ6Q2q+88cJ49/A0h7aZk
t2j8TksA/jhtulUxVg7L
=7J1z
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
