From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Pull is Evil
Date: Thu, 1 May 2014 10:56:23 -0700
Message-ID: <20140501175623.GY6227@odin.tremily.us>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSHpc5A+GJc9BHcd"
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu May 01 19:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfvDl-0007dp-6X
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 19:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbaEAR43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 13:56:29 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:48098
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbaEAR42 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 13:56:28 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id wg8k1n00316LCl051hwTwn; Thu, 01 May 2014 17:56:27 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id whwR1n00V152l3L3ShwSSi; Thu, 01 May 2014 17:56:27 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id E5E731173132; Thu,  1 May 2014 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398966983; bh=yHhJ8YVG8De1sBOgRxNd4ih+/7S/LAXb+S49/1DynIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPLPeBzvRcUMnp5vA1IspG39uOSeaSyoDesIGtLNWaefCFT9EE0eqwaopy/6hyVJ9
	 2YjuMRL/8NJ1T/FHA/gs9iln1xY9b5Rn5sLAZkZmwAJWTt7z8wc52iwl9h0S7C9vj/
	 f1Sle8I5d+XWCy7H8mCXlWN11B4WJ8G/Dopxf1hQ=
Content-Disposition: inline
In-Reply-To: <5362664C.8040907@xiplink.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398966987;
	bh=XLKYZ7lL/YzMmVFcme3Ea1bKUbO7XriKPFJJMQQIznw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=OmIkaVdFNnpO3c/NpNF4YKBn3waXmWcISn8SGNWCj4PFLIryk+xt8gcpDCyZL4ViS
	 BsUoOy6iXV9k7PR2SgtMbVdeIQ5cwxhATlc+xjyedDk2ftBJJIkugTwK6g7x7TvKY9
	 MCciMyBA9m0m97+iFU75ehCMJEQ0XYV/bhJiVrHnE96M0gTWYl6oEUcDYFkcEWe84L
	 AsfZWz3hT5X/pUUe2DEYuG+ckyra5N+ZZT8fsVIS+SrASHGM0/3Mf1tv5eBzuPmE8X
	 bY06Ufyps2vVT1lc/eLj+6N2O2qLF8bKNOPghLHbrUr74zqYPN1tA+A1/SzYw4h7Od
	 jjdEGNc6e7YKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247818>


--HSHpc5A+GJc9BHcd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 11:20:44AM -0400, Marc Branchaud wrote:
> On 14-05-01 05:46 AM, brian m. carlson wrote:
> >   git checkout maintenance-branch
> >   # Update our maintenance branch to the latest from the main repo.
> >   git pull --ff-only
> >   git pull --no-ff developer-remote topic-branch
> >   git push main-repo HEAD
>=20
> =E2=80=A6
> What's more, it seems to me that the only real advantage "git pull" provi=
des
> here is a less typing compared to the non-pull equivalent:
>=20
>   git fetch main-repo
>   git checkout main-repo/maintenance-branch
>   git fetch developer-remote
>   git merge --no-ff developer-remote/topic-branch
>   git push main-repo HEAD

You're missing Brian's fast-forward merge here.  It should be:

  git checkout maintenance-branch
  git fetch main-repo
  git merge --ff-only main-repo/maintenance-branch
  git fetch developer-remote
  =E2=80=A6

> Sure, the non-pull approach makes use of Scary Branch Stuff (remotes
> and namespaces and detached HEADs -- oh my!).

No need for detached heads with Brian's local maintenance-branch.  If
you're teaching and just need folks merging the remote's HEAD, you
can avoid namespaces and remotes entirely:

  git fetch git://example.net/main-repo.git
  git merge --ff-only FETCH_HEAD

although I doubt =E2=80=9Cthe remote's HEAD=E2=80=9D will be easier to expl=
ain than
the namespaced, remote-tracking branches it replaces.  It's certainly
not worth the hassle of un-training FETCH_HEAD-merges later on ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--HSHpc5A+GJc9BHcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYorFAAoJEKKfehoaNkbtZ+EP/jF8O6/YzP8C5MrqnHI+ipir
aFc41mG+kdURqMDkcqKvRwred97AgPkCHtKqH3TtmxwsUYjLQ94eXlmJpy0VqLHM
LIkp9eM4SVcHNaFchIHzVvwcHizX92zlB+xe80RU8DG+CnHYefuVw6goUD2FNwxg
ii3MIuql2TQ2P0D+uhSZPlpqmcQCP+o5B+oO18gsymz3GGFmlkM2GNKg2vT1s1Ha
ACnFM0OPo+djMFvSe3eZ1LTjE+L50sBcRnJj0k+YnGZl+cnzGCZU6CeTELUzRPE/
Jo/r/wDFfdkzYXJmcJ6eYp9teRl97sceTfxGfpphdBvvWlJDiyrmwAjMWVy9IPjy
Gz5OKdPNJ4cmtzmZq0wJ/y48QaXdzmRDXlb0rX5B/Gedzz+XFOtJZcwhiZ+Fifzo
cYoRTiwjhPh0vxlTMa77oy5Z6t8ecvu27zKhV7XoDXYUmPofF7t0TKlWFCEQkTKL
gDcTia4tzd+Zwy3XrAjaPakFIsM6yABOnSl9ZaVdETiUWaymkBgEXt96OrnGm9qj
eA1ulE+J1o9xtouw4ZKu8IML1Uuy8BdJVjsxea9wyC2IBi69cAEQ5mqlb7HktzGQ
PsOxIaH+frUwUXKUkMTYo8KXu7z8mouP2ki6RiQR4WvMstQwLBWTd8iKKlA8W/D+
tMYgwWcaEXRdb62d9tAG
=uoMW
-----END PGP SIGNATURE-----

--HSHpc5A+GJc9BHcd--
