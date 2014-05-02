From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Pull is Evil
Date: Fri, 2 May 2014 07:54:33 -0700
Message-ID: <20140502145433.GF28634@odin.tremily.us>
References: <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 16:54:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgErJ-0003gB-3V
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 16:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbaEBOyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 10:54:37 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:50617
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991AbaEBOyg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 10:54:36 -0400
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id x0MP1n0071c6gX85A2ubQd; Fri, 02 May 2014 14:54:35 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id x2uZ1n00i152l3L3j2uaXf; Fri, 02 May 2014 14:54:35 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 4F7A311740DF; Fri,  2 May 2014 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399042473; bh=2N6W1mQQM4pRgmHLqtvHTbQvD3GoDxolS/arEF9YoL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QqMWUKliJ6C4f9cReZZA5wXAorMmtU1YWlbnETpModLuowLGDpKJq2tkfmnpuZr1g
	 dfaGAUISxm48rTijiWSX7tZV3Rv/2C8nvPyuQFGoC8c4q5qIw68Q2IHNkgr+j8jeLx
	 RsJykVWwmiDIek6LUxMDcbfEbm+Fv7rGag82wpDo=
Content-Disposition: inline
In-Reply-To: <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399042475;
	bh=q5ELVqBwDPKImbQsa/xYZllPvFf4RVdhAIjGcn/9s2Q=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=qA1omB+PzWhT8dm7v9/oUxvCibXH0rZdgGuTyg/aRSh7WrE14QG8Capozz8zwQdTO
	 eWIiF+r3Ib+oWXehX9LAZnbB/euhMQlYbFq8v+rsyLy17IIZDIH3aoqfNgNg0ZHNUD
	 7HiAEU8Zyf51Phlz1A6fMcgDKs/0yqQ/mLpyivP/D8I5YkRIyRaiwKwfXKugl1JmFj
	 0/k+ftDh+A5ZXDP2sC7xu5UApvNyG5gSkMW11ihtY17oaEvL7F5XhHu9+SNrwa2dex
	 tVnNv9uwl2BbikvKopSOdrOMCJUwqxilM8znH1VXWHCo+Bv8RQ5Zk08xt9mAIJOeQZ
	 SCkvtXN98ZnbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247937>


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > My proposed --prompt behavior is for folks who think =E2=80=9CI often r=
un
> > this command without thinking it through all the way.  I'm also
> > not used to reading Git's output and using 'reset --hard' with the
> > reflog to reverse changes.  Instead of trusting me to only say
> > what I mean or leaving me to recover from mistakes, please tell me
> > what's about to change and let me opt out if I've changed my
> > mind.=E2=80=9D
>=20
> Unfortunately those folks by definition wouldn't know about the
> --prompt option.

But once such folks are identified, you just have to convince them
(once) to set the pull.prompt config.  That's a lot easier than
convincing them (for every pull) to set the appropriate ff flag.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY7GnAAoJEKKfehoaNkbtiFcP/RHwITMR7fNAgRLZZaiMbI/j
PPy/PvN2rIZB7jjYsdHZw8JzMK5sO/YlACfmXDxjET8tUjIThn+dUkmiRke2UUgG
R2jHiMHiUF4xfbAy6bPkOMtRGOpCqjZgivXY165BoDobvijaZ6hLlwTX0m/viobN
TPp8FkhDjpMc5RJJCrOOqxi3cvofArKmg8q5Gp2qepko4keGaP3GdV/rvMrEUOvc
5eNkOy8iDeGgZTXXQeKr1pT4jF2uBsrNsWdmLRT03hDY5oFBhjaUfIocYhV+vFq1
PVITIlarFGkZKKigFtOmZdl3AzNwtkFUoRTRFIXwiS3Gps3ZFY59vpGePEA7JSFW
fV8FHvQ8oReCTioW5wwQtuynaFKm/0x0Eew7zHttQMaTFznpWebT4BrD9uG0dyD0
RSG3bV61A1epwfOK6Mf1gkPyK6VZqybMBMA0g+p+3aYn21UXWnLIOu8cdZczN5pu
tKBFvJq55WcA1tOtJxrgDKXg6PIvbhq9MfP5ayY8Ks8ddzxG4NZr/nq4Z+PfFIRO
mFX7IJ9cyX6NogODC+RuqULUiwQLCI2Fni7n6Dq9LckZp34qfbMc1H4aW3khtzur
nZClLzyfQvEsk3qfClAixT//dle9P3gz2ekuip4+4/Kjt2NklKQUzKGENyOfMlZZ
012/xveAxobMgkbCEEav
=Ygqn
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
