From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Pull is Evil
Date: Thu, 1 May 2014 11:30:08 -0700
Message-ID: <20140501183008.GZ6227@odin.tremily.us>
References: <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
 <20140501175623.GY6227@odin.tremily.us>
 <53628CB1.8010302@xiplink.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1zSJVlfBL7BTggM"
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu May 01 21:49:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfwz3-00019o-9A
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaEATt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:49:26 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:51292
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbaEATtZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 15:49:25 -0400
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id wieY1n0030Fqzac5CjpQnY; Thu, 01 May 2014 19:49:24 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id wjpP1n003152l3L3UjpPGc; Thu, 01 May 2014 19:49:24 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id A7D9A1173258; Thu,  1 May 2014 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398969008; bh=t1B+fGOoKo0a2afG1lKlPaHH7/Gwp/DPR2UeIS/89eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rD+cWWKr1GAzfLCzlh+JZzutl6FzyGQ9dmqWBTHGSucigN9zqirLHLgY9GNaZvrLj
	 O62HipqZlg6IzdmkeMUV5BRLwc36Ydccf6hdYf52K6yXhOa627oMZEQXN7mjfWNFck
	 naYGAD1PSOyUkaWssqopRlHm8rx4VxgB+20O0SCI=
Content-Disposition: inline
In-Reply-To: <53628CB1.8010302@xiplink.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398973764;
	bh=iJlkQbBsETvdbBe8iqB+LpnM4diHVJU/hyOL135M0QI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=t71pYimQQN/bYa/WRLKaR774t3Yf7ofwDgxdCk5/5MtoDMKCcZrDv4uKqg9iGir2F
	 WIPcgQqQp3ZLlEjLdmvHB2TjjMXThQAFf5PjetvMC2Rr7NQedi5tkWKfE9IOllnPdx
	 blvesBfhJbeOdQoFy7IHIldmafeZCK9bS4xuwUxDPKAVQip7DDZsCnrCMsOhR8ax/o
	 vf5jQH4KO9bTXd/8jHWdTWThQSe7XVpKN1ROP726FkTWlwLL4vYNvrPXzqoB+fMmi/
	 lm7riWANMKzLgUXOjOnsWlgJKiyTuWV8KlyHVDNZkx6fDdLCmllo7gWO0dltJCtiXe
	 vK0j2qRoS0Z5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247834>


--p1zSJVlfBL7BTggM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 02:04:33PM -0400, Marc Branchaud wrote:
> On 14-05-01 01:56 PM, W. Trevor King wrote:
> > On Thu, May 01, 2014 at 11:20:44AM -0400, Marc Branchaud wrote:
> >> On 14-05-01 05:46 AM, brian m. carlson wrote:
> >>>   git checkout maintenance-branch
> >>>   # Update our maintenance branch to the latest from the main repo.
> >>>   git pull --ff-only
> >>>   git pull --no-ff developer-remote topic-branch
> >>>   git push main-repo HEAD
> >>
> >> =E2=80=A6
> >> What's more, it seems to me that the only real advantage "git
> >> pull" provides here is a less typing compared to the non-pull
> >> equivalent:
> >>
> >>   git fetch main-repo
> >>   git checkout main-repo/maintenance-branch
> >>   git fetch developer-remote
> >>   git merge --no-ff developer-remote/topic-branch
> >>   git push main-repo HEAD
> >=20
> > You're missing Brian's fast-forward merge here.  It should be:
> >=20
> >   git checkout maintenance-branch
> >   git fetch main-repo
> >   git merge --ff-only main-repo/maintenance-branch
> >   git fetch developer-remote
> >   =E2=80=A6
>=20
> I think you're mistaken -- I checked out
> "main-repo/maintenance-branch" directly, so there's no need to
> fast-forward a local branch.

I find a local branch useful to mark the amount of the upstream branch
that I've reviewed.  The reflog helps a bit, but I may go several
fetches between reviews.  For newbies, I recommend avoiding detached
HEADs, where possible, so they don't have to rely on the reflog if
they accidentally commit and then checkout something else (ignoring
Git's warning).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--p1zSJVlfBL7BTggM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYpKuAAoJEKKfehoaNkbtgOIP/07K4oWWpiOWPlBa4NjGlqjl
M+HMVbscXLi+Rx5nyf1wFJSeUOm3QGHZx6QluVYqpRWbAZf2ntVRV4cA6vfFibTJ
wTgdnRyW/iiQPegHkshJP73yzV0fBYhRjKAOXMaeDQFmdEyo+cPAJQQ/pvtwL0Y9
LK1n91pOdCj5wZXmbOpFuFZ77Ah68MaIqKC29qGKsk/0smxelHUuAxDZv9owtCMS
PJQ24iJIWf8fY9gIpmhRdY6YYt+ezzAiOPV0s5axOx5dNCukR+h5As22RfqOWcmF
Xc5UNKE+TEcWvluJYVMzK+HVrhWKyfWqc34P2aPcdbqzz4EKDGZtgYetA6sWyxmf
dXJUl0kU8SKtzoInUv7l+sswaN1DMS50ETJMbnkW05gsZBljA5HCQFKZyvIDX22Q
W9bqkqRNNIkzr1LaVmhhX9rNPn+c0dsWP67JjUMnQGQTzucNLSjwb7ScIPWL2kFX
QpM/c+LaHcERczLW+PGiaBZbaXe2NL1QW/JznKckXagSlFOJda/oMPCt4rhoJ1dr
WKfIJp5rUzdGisfWvi7008DEA0AoyQWpGNLqTVDNU7OIZRPgmJXyS7TK2HZAq3nI
bL46JQxwqRLyJQAzVq90CPVozhUb04BPJaVrS/GdJcKCPkYw0QSrE/tHMQXxFaOB
uvlGyOGpaa3Bi9tMycy5
=i+MH
-----END PGP SIGNATURE-----

--p1zSJVlfBL7BTggM--
