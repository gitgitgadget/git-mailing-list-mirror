From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 0/9] User manual updates
Date: Tue, 19 Feb 2013 04:34:29 -0500
Message-ID: <20130219093429.GA4024@odin.tremily.us>
References: <20130218122750.GE8388@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=7JfCtLOvnd9MIVvH
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:35:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jbK-00050Y-UI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab3BSJeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:34:37 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:33276 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358Ab3BSJef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:34:35 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00EQ9NXIWQ90@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 03:34:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E701A8AB914; Tue,
 19 Feb 2013 04:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361266469; bh=LPi5g43Hj3RIE/QJjh1qnP7UFhrM4PcJLfcbHENhRdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jQ/9xgeBTBhIthqv4f3uiENJf37oPoI1ooyN9AojsarLF1A2hrI6Ey+YIv7QM7VQH
 f06SQDQYKQyCSyvof3LYgnNl1916Jnar96oygtAQftlYp7UJd5XXNw384VUAtjR7EH
 4GSjOXT6UvJOGZfXkV7f7xt0y28f3KKDBKZ/HobY=
Content-disposition: inline
In-reply-to: <20130218122750.GE8388@odin.tremily.us>
 <20130210223632.GF8377@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216582>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2013 at 07:27:50AM -0500, W. Trevor King wrote:
> On Mon, Feb 18, 2013 at 12:56:07AM -0800, Junio C Hamano wrote:
> > I've taken the following to 'maint'=E2=80=A6
>=20
> Should I rebase v4 onto maint so I don't accidentally collide with any
> of the previous patches which have already been merged there?

I tried this, but the backtick patch shouldn't move to maint due to:

On Sun, Feb 10, 2013 at 05:36:32PM -0500, W. Trevor King wrote:
> I based my changes on `master` to avoid colliding with 2de9b711
> (Documentation: the name of the system is 'Git', not 'git',
> 2013-01-21), but if you shifted them already I suppose you've fixed
> any conflicts ;).

I'll drop it for now, and revive it after the next release syncs
master and maint.  I've rebased the remaining patches onto `maint`.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRI0ckAAoJEEUbTsx0l5OMSnkP/2z6RLt80XeaUW7xprY3dKxL
UP7NyJXEhuaCgaApmt8NSKkmpUchx2rCyabmEG5nHwRBjbeTx8xM/6HB+93q8WoY
FK6kteVyUn81hpUAdCMJi/EXfKNbk4MsxrRnEvE+uWdhs+CRccIGnpzuKE6ui7nm
FD/PA391kYyOZHt+mGQsLzpriOkjDbNRTAZ+N9FstqRpJrjn7fT1NEOqBFpj36r9
qit2x3rwglGsag1nOogxy88covkn7eGEHwDSa+az8Jx5TW8DIciUsbROTA/r6u+I
DY1BZfv8sI4yyIug65G0YJMM1NbXNjAyHWa9zXnrWYdMTM+3fFkItZ7NbbXe/oTU
c8s3QJwjlaa1ZMWu202OyyvtnjH6JyM7h12um3jo6DtecnfaDYjdWkFqHpzE3d1H
EdUZCHYSrfx5+Lfm/hbhvpGIAZgXkBMuxcA+w2Btve7FgFCddKwIq7MdGrauzWJJ
S94RXn6kZ5zR4VKox8mz4ENBInjAv3b6mEmdeZXEeG97KO3MvkuQs0nWEHHCHVzt
FCAGq3uxasAZQyRL9zuv4Ct+yMNXGy/ffXWcoP66yCC4Zf4HgVwJ/DH4/aqLp4iD
C8yxgPjgYK4Z9D82XFlLE7RKmG1LkncMIren51TRr6sU/VLHYkNeBjN1jN0wybUE
XZFN4Zlo1aGbRgD0obaM
=wt1h
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
